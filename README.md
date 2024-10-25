# litgpt-phi-tpu

## Train
Clone this repo and edit `py/runner.sh` for your preferences.

### For local (single TPU) train
`curl https://raw.githubusercontent.com/YOUR_GH_ID/light-tpu-phi/refs/heads/main/main.sh | bash`

And `cd light-tpu-phi && bash train.local.sh`

### For network (multi TPU = TPU pod) train
`git clone https://github.com/YOUR_GH_ID/light-tpu-phi/`

And `cd light-tpu-phi && bash train.sh`

## Inference