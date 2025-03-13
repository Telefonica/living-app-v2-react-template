source .venv/bin/activate
export PYTHONPATH=$(pwd)
source ~/.zprofile
source tests/acceptance/.env.local

WD=${WD:-}
USER=${USER:-la_shop_user_0}
ENV=${ENV:-dev}

# Extract data from JSON file
SDF_MOCK_PROPERTIES="$WD/tests/acceptance/settings/common-sdf-mock.json"
USER_DATA=$(jq -r ".\"sdf-mock\".lines.\"${USER}\"" "${SDF_MOCK_PROPERTIES}")

# Check if DATA is null
if [ "$USER_DATA" == "null" ]; then
    echo "Error: User data does not exist."
    exit 1
fi

NUMBER=$(echo $USER_DATA | jq -r '.phone_number')
USER_ID=$(echo $USER_DATA | jq -r '.user_id')

cd $WD

python .venv/lib/python3.11/site-packages/laqacommons/tools/management/management.py \
    --reserve \
    --phone "${NUMBER}" \
    --user-id "${USER_ID}" \
    --environment "${ENV:-dev}" \
    --admin_code 28100005612416
