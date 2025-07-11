source .venv/bin/activate
source ~/.zprofile
export PYTHONPATH=$(pwd)

FEATURE=${FEATURE:-}
WD=${WD:-}
filename=$(basename -- "$FEATURE")
extension="${filename##*.}"
filename="${filename%.*}"
TP_NAME=${TP_NAME:-}
COMPONENT_NAME=${COMPONENT_NAME:-}

new_filename_ids="${filename}_with-ids.feature"
new_filename_formatted="${filename}_formatted.feature"
new_filepath_ids="$(dirname "$FEATURE")/$new_filename_ids"
new_filepath_formatted="$(dirname "$FEATURE")/$new_filename_formatted"

cd $WD

if [ "$extension" == "feature" ]; then
    toolium jira-upload -p "QALAGLOB" -t "LA - FT - ${TP_NAME}" -m "${COMPONENT_NAME}" -f ${FEATURE} -u -i -d -c
    mv $new_filepath_ids $FEATURE
    laqacommons format-scenario-tags -f ${FEATURE}
    mv $new_filepath_formatted $FEATURE
else
    echo "Unknown extension"
fi
