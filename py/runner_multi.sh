export ALLOW_MULTIPLE_LIBTPU_LOAD=1
export PJRT_DEVICE=TPU
export LD_LIBRARY_PATH=~/miniconda3/envs/jarvis/lib/

cd ~/litgpt-tpu-phi/

__conda_setup="$('/home/ubuntu/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ubuntu/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ubuntu/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ubuntu/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

conda activate jarvis

# TODO: change data to yours
python py/prepare_checkpoints.py \
--data_file_name=alpaca_data_cleaned_archive.json \
--data_file_url=https://raw.githubusercontent.com/tloen/alpaca-lora/main/alpaca_data_cleaned_archive.json

python py/adapter_multi.py --precision bf16-true