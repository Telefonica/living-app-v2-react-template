source .venv/bin/activate
export PYTHONPATH=$(pwd)
source ~/.zprofile
source tests/acceptance/.env.local

WD=${WD:-}
USER=${USER:-la_shop_user_0}
ENV=${ENV:-dev}

# Extract data from JSON file
USER=$(echo "$USER" | xargs)  # Trim leading and trailing whitespace
echo ".\"sdf-mock\".lines.\"${USER}\""
DATA=$(jq -r ".\"sdf-mock\".lines.\"${USER}\"" $WD/tests/acceptance/settings/common-sdf-mock.json)

# Check if DATA is null
if [ "$DATA" == "null" ]; then
    echo "Error: User data does not exist."
    exit 1
fi

NUMBER=$(echo $DATA | jq -r '.phone_number')
USER_ID=$(echo $DATA | jq -r '.user_id')
ADMIN_CODE=$(echo $DATA | jq -r '.admin_code')

echo $DATA
cd $WD

python .venv/lib/python3.11/site-packages/laqacommons/tools/management/management.py \
    --reserve \
    --phone "${NUMBER}" \
    --user-id "${USER_ID}" \
    --environment "${ENV:-dev}" \
    --admin_code "${ADMIN_CODE}"
