export repo_id=microsoft/Phi-3.5-mini-instruct

cd ~/

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

chmod +x Miniconda3-latest-Linux-x86_64.sh

bash Miniconda3-latest-Linux-x86_64.sh -b

rm Miniconda3-latest-Linux-x86_64.sh

rm ~/.local/bin/litgpt

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

find_in_conda_env(){
    conda env list | grep "${@}" >/dev/null 2>/dev/null
}

if find_in_conda_env ".*jarvis.*" ; then
   conda activate jarvis
else 
   conda create -y -n jarvis python=3.11
   conda activate jarvis
fi

rm ~/.local/bin/pip*

pip install torch~=2.4.0 torch_xla[tpu]~=2.4.0 torchvision -f https://storage.googleapis.com/libtpu-releases/index.html

cd ~/litgpt
pip install uvloop
pip install -e '.[all]'
pip install torch~=2.4.0 torch_xla[tpu]~=2.4.0 torchvision -f https://storage.googleapis.com/libtpu-releases/index.html

sudo apt update -y
sudo apt install libopenblas-dev -y

cd ~/litgpt-tpu-phi
litgpt download $repo_id
