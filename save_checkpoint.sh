export USER=$(whoami)
export TPU_NAME='v4-64'
export ZONE='us-central2-b'

path_to_shards="out/adapter/phi/lit_model_adapter_finetuned"
mkdir -p $path_to_shards
workers=8
for ((i = 0; i < workers; i++)); do
  gcloud compute tpus tpu-vm scp \
  --zone $ZONE --worker=$i "litgpt:${path_to_shards}/*" "${path_to_shards}/"
done

gcloud compute tpus tpu-vm scp \
--zone $ZONE --worker=all "${path_to_shards}/*" "litgpt:${path_to_shards}/"

gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME \
--zone $ZONE --worker=all \
--command="python -m torch_xla.distributed.fsdp.consolidate_sharded_ckpts --ckpt_prefix ${path_to_shards}/checkpoint --ckpt_suffix '_rank-*-of-*.pth' --save_path ${path_to_shards}.pth"
