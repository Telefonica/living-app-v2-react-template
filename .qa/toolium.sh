source .venv/bin/activate
export PYTHONPATH=$(pwd)

FEATURE=${FEATURE:-}
WD=${WD:-}
filename=$(basename -- "$FEATURE") 
extension="${filename##*.}"              
filename="${filename%.*}"    

new_filename_ids="${filename}_with-ids.feature"
new_filename_formatted="${filename}_formatted.feature"
new_filepath_ids="$(dirname "$FEATURE")/$new_filename_ids"
new_filepath_formatted="$(dirname "$FEATURE")/$new_filename_formatted"

cd $WD

if [ "$extension" == "feature" ]; then
    toolium jira-upload -p "QALAGLOB" -t QALAGLOB-X -m Xxxxx -f ${FEATURE} -u -i -c
    mv $new_filepath_ids $FEATURE
    laqacommons format-scenario-tags -f ${FEATURE}
    mv $new_filepath_formatted $FEATURE
else
    echo "Unknown extension"
fi