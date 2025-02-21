#!/bin/bash
# Acceptance tests runner script
#
# usage: ./run-acceptance-test [behave-runner-config-name]
#   behave-runner-config-name: name of the runner config to apply


PROJECT=${PROJECT}
TEST_ENV=${TEST_ENV:-es-dev}
PRIORITY=${PRIORITY:-smoke}
FEATURES_FOLDER=${FEATURES_FOLDER:-components}
TAGS=${TAGS:-no_tag}
JIRA_ISSUE=${JIRA_ISSUE:-no_issue}
JIRA_VERSION=${JIRA_VERSION:-no_version}
JIRA_BUILD=${JIRA_BUILD:-Release}
AUTORETRY=${AUTORETRY:-true}
USER_TEST=${USER_TEST:-user_ci_0}
PR_NUMBER=${PR_NUMBER}
DEMO_URL=${DEMO_URL}

print_exec_parameters()
{
    echo
    echo "***************************************************************"
    echo -e "Launching ${PROJECT} test: \n" \
         " - Environment: ${TEST_ENV}\n" \
         " - Priority: ${PRIORITY}\n" \
         " - Features folder: ${FEATURES_FOLDER}\n" \
         " - Tags: ${TAGS}\n" \
         " - Jira Issue: ${JIRA_ISSUE}\n" \
         " - Jira version: ${JIRA_VERSION}\n" \
         " - Jira build: ${JIRA_BUILD}\n" \
         " - Autoretry: ${AUTORETRY}\n" \
         " - Number of the Pull Request: ${PR_NUMBER}\n" \
         " - Demo url: ${DEMO_URL}\n" \
         " - User test line: ${USER_TEST}"

}

concat_tags() {
    local base_tags=$1
    local new_tags=$2

    if [[ ${base_tags} != "no_tag" && -n ${base_tags} ]]; then
        base_tags="${base_tags},${new_tags}"
    else
        base_tags="${new_tags}"
    fi
    echo ${base_tags}
}

# TODO: LAM-7866 Include get not executed

# TODO: LAM-7867 Include get failed

get_jira_issue()
{
    # Check if the expected Jira Issue contains tests
    laqacommons jira-ids-from-issues -p ${FEATURES_FOLDER} -t ${JIRA_ISSUE} > jira_ids.txt;
    new_tags=$(sed -n '2p' jira_ids.txt)

    # Stop execution if there are not tags
    if [[ -z ${new_tags} ]]; then
        echo "No tests found for Jira Issue ${JIRA_ISSUE}"
    fi

    # Include tests tags with and condition to the existing tags
    TAGS=$(concat_tags "${TAGS}" "${new_tags}")
}

generate_behave_runners()
{
    # Include priority as a tag
    if [[ ${PRIORITY} != "regression" ]]; then
        TAGS=$(concat_tags "${TAGS}" @"${PRIORITY}")
    fi

    echo "Start Behave runner generation"
    if [[ ${JIRA_ISSUE} != "no_issue" ]]; then
        get_jira_issue "$*"
    fi

    # Ensure the last character is not ; or ,
    if [[ "${TAGS: -1}" == ";" || "${TAGS: -1}" == "," ]]; then
        TAGS=${TAGS:0:-1}
    fi

    laqacommons runners-generator -f ${FEATURES_FOLDER} -r ${PRIORITY} -e ${TEST_ENV} -jv ${JIRA_VERSION} -ct ${TAGS}
    if [ ! -f "./settings/runners/$TEST_ENV/automatic/$PRIORITY/behave-runner-${TEST_ENV}-${PRIORITY}.json" ]; then
        echo "Error: File $behave_file not found!"
        exit 1
    fi
}

run_acceptance_test()
{
    local jira_params="-D Jira_enabled=true -D Jira_token=$JIRA_TOKEN -D JiraExecution_labels=$PROJECT,ft,$PRIORITY"
    if [ -n "${JIRA_BUILD}" ]; then
        jira_params="${jira_params} -D JiraExecution_Build=$JIRA_BUILD"
    fi

    if [ "${JIRA_VERSION}" != "no_version" ]; then
        jira_params="${jira_params} -D JiraExecution_version=$JIRA_VERSION"
    fi

    local user_params=""
    if [ "${USER_TEST}" != "default" ]; then
        user_params="-D TestExecution_user_test=$USER_TEST"
    fi

    if [ -n "${PR_NUMBER}" ]; then
        test_params="${test_params} -D TestExecution_pr_number=${PR_NUMBER}"
    fi

    if [ -n "${DEMO_URL}" ]; then
        test_params="${test_params} -D TestExecution_demo_url=${DEMO_URL}"
    fi

    local behave_file="./settings/runners/$TEST_ENV/automatic/$PRIORITY/behave-runner-${TEST_ENV}-${PRIORITY}.json"
    toolium behave-runner -f "$behave_file" $test_params $jira_params $user_params -x -D TestExecution_environment=$TEST_ENV

    local result=$?
    return $result
}

find ./_output -type d -exec rm  -rf {} + 2>/dev/null

generate_behave_runners "$*"

print_exec_parameters "$*"

run_acceptance_test "$*"

if [ "${AUTORETRY}" = "true" ]; then
    for ((i=0; i<2; i++)); do
        if [ -e "./_output/results/failed_list.json" ]; then
            TAGS=$(cat ./_output/results/failed_list.json)
            echo "Start retries for ${TAGS}"
            generate_behave_runners "$*"
            rm ./_output/results/failed_list.json
            print_exec_parameters "$*"
            run_acceptance_test "$*"
        fi
    done
fi

if [ -e "./_output/results/failed_list.json" ]; then
    echo "Acceptance Tests execution failed"
    exit 1
else
    echo "Acceptance Tests execution was successful"
fi

echo -e "--------------------------------------------------------------------------------------------"
echo -e "--- To generate report run the following command"
echo -e "allure serve ./_output/allure"
echo -e "--- If you do not have Allure installed, access this link https://docs.qameta.io/allure/#_installing_a_commandline"
echo -e "--- And follow the instructions"
echo -e "--------------------------------------------------------------------------------------------"
