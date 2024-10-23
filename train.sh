export USER=$(whoami)
export TPU_NAME='v4-64'
export ZONE='us-central2-b'
export BUCKET=''
export DATASET=''

echo "[local] Killing TPU"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME \
--zone $ZONE --worker=all --command "sudo fuser -k /dev/accel0"

echo "[local] Removing TPU Lock"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME \
--zone $ZONE --worker=all --command "sudo rm -f /tmp/libtpu_lockfile"

echo "[local] Killing All Python"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME \
--zone $ZONE --worker=all --command "pkill -e python"

echo "[local] Removing screens"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME \
--zone $ZONE --worker=all --command "killall screen"

echo "[local] Git pull"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME --zone $ZONE --worker=all --command \
"cd litgpt-phi-tpu && git pull"

echo "[local] Workflow 1/2 - install_dependencies"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME --zone $ZONE --worker=all --command \
"cd ~/litgpt-phi-tpu; bash install_dependencies.sh; "

echo "[local] Workflow 2/2 - prepare_checkpoints"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME --zone $ZONE --worker=all --command \
"cd ~/litgpt-phi-tpu; bash prepare_checkpoints.sh; "

echo "[local] Set runner.sh"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME --zone $ZONE --worker=all --command "chmod +x /home/${USER}/litgpt-phi-tpu/runner.sh"

echo "[local] RUN!!!"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME --zone us-central2-b --worker=all --command \
"screen -L -d -m bash -i -c 'export TCMALLOC_LARGE_ALLOC_REPORT_THRESHOLD=107374182400; \
cd litgpt-phi-tpu; /home/${USER}/litgpt-phi-tpu/runner.sh'"
