export ALLOW_MULTIPLE_LIBTPU_LOAD=1
export PJRT_DEVICE=TPU

cd ~
cd litgpt-phi-tpu/litgpt

python3 xla/scripts/prepare_alpaca.py --checkpoint_dir checkpoints/tiiuae/falcon-7b
