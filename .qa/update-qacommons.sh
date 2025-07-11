source .venv/bin/activate
export PYTHONPATH=$(pwd)
source ~/.zprofile

WF=${WF:-}

cd $WF

pip uninstall -y laqacommons && pip install -r tests/acceptance/requirements.txt
