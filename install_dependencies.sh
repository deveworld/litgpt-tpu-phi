export repo_id=microsoft/Phi-3.5-mini-instruct

pip install torch~=2.3.0 torch_xla[tpu]~=2.3.0 torchvision -f https://storage.googleapis.com/libtpu-releases/index.html

cd ~/litgpt-phi-tpu/litgpt
pip install uvloop
pip install -e '.[all]'

sudo apt update
sudo apt install libopenblas-dev

pip install https://storage.googleapis.com/tpu-pytorch/wheels/tpuvm/torch-nightly-cp38-cp38-linux_x86_64.whl
pip install https://storage.googleapis.com/tpu-pytorch/wheels/tpuvm/torch_xla-nightly-cp38-cp38-linux_x86_64.whl

litgpt download $repo_id
