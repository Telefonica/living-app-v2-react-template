source .venv/bin/activate
export PYTHONPATH=$(pwd)
source ~/.zprofile

WD=${WD:-}
USER_LINE=${USER_LINE:-}

cd $WD

laqacommons management \
    --reserve \
    --line ${USER_LINE} \
    --environment dev \
    --atlas True \
    --matricula XXXXXX \
    --admin_code XXXXXX
