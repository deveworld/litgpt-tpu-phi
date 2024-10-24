export repo_id=microsoft/Phi-3.5-mini-instruct

cd ~/

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

chmod +x Miniconda3-latest-Linux-x86_64.sh

bash Miniconda3-latest-Linux-x86_64.sh -b

rm Miniconda3-latest-Linux-x86_64.sh

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

pip install torch~=2.3.0 torch_xla[tpu]~=2.3.0 torchvision -f https://storage.googleapis.com/libtpu-releases/index.html

git clone https://github.com/deveworld/litgpt-phi-tpu --recursive

cd ~/litgpt-phi-tpu/litgpt
pip install uvloop
pip install -e '.[all]'

sudo apt update
sudo apt install libopenblas-dev

litgpt download $repo_id
