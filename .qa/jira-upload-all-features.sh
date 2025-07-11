source .venv/bin/activate
source ~/.zprofile
export PYTHONPATH=$(pwd)

TP_NAME=${TP_NAME:-}
COMPONENT_NAME=${COMPONENT_NAME:-}
PATH_FEATURES=${PATH_FEATURES:-}
WD=${WD:-}
features=()

PATH_FEATURES="${PATH_FEATURES%/}"

if [[ ! -d "$PATH_FEATURES" ]]; then
    echo "La ruta proporcionada no es un directorio válido."
    exit 1
fi

cd $WD

while IFS= read -r feature; do
    features+=("$feature")
done < <(find "$PATH_FEATURES" -type f -name "*.feature" ! -name "local*.feature")

if [ ${#features[@]} -eq 0 ]; then
    echo "No se encontraron archivos con extensión '.feature' en la ruta '$PATH_FEATURES'."
    exit 1
fi

for one_feature in "${features[@]}"; do
    filename=$(basename -- "$one_feature")
    extension="${filename##*.}"
    filename="${filename%.*}"
    new_filename_ids="${filename}_with-ids.feature"
    new_filename_formatted="${filename}_formatted.feature"
    new_filepath_ids="$(dirname "$one_feature")/$new_filename_ids"
    new_filepath_formatted="$(dirname "$one_feature")/$new_filename_formatted"

    echo "Actualizando en Jira el archirvo: ${one_feature}"
    echo "toolium jira-upload -p "QALAGLOB" -t "LA - FT - ${TP_NAME}" -m "${COMPONENT_NAME}" -f ${one_feature} -u -i -d -c"

    if [ "$extension" == "feature" ]; then
        toolium jira-upload -p "QALAGLOB" -t "LA - FT - ${TP_NAME}" -m "${COMPONENT_NAME}" -f ${one_feature} -u -i -d -c
        mv $new_filepath_ids $one_feature
        laqacommons format-scenario-tags -f ${one_feature}
        mv $new_filepath_formatted $one_feature
    else
        echo "Unknown extension"
    fi
done
