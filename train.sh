export USER=$(whoami)
export TPU_NAME='v4-64'
export ZONE='us-central2-b'

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
"sudo apt install git wget \
&& git clone https://github.com/deveworld/litgpt-tpu-phi/ \
&& git clone https://github.com/Lightning-AI/litgpt/ \
$$ cd ~/litgpt-tpu-phi/ && git pull"

echo "[local] Install_dependencies"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME --zone $ZONE --worker=all --command \
"cd ~/litgpt-tpu-phi; bash install_dependencies.sh; "

echo "[local] Set runner.sh"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME --zone $ZONE --worker=all --command "chmod +x /home/${USER}/litgpt-tpu-phi/py/runner.sh"

echo "[local] RUN!!!"
gcloud compute tpus tpu-vm ssh $USER@$TPU_NAME --zone $ZONE --worker=all --command \
"screen -L -d -m bash -i -c 'export TCMALLOC_LARGE_ALLOC_REPORT_THRESHOLD=107374182400; \
cd litgpt-tpu-phi; /home/${USER}/litgpt-tpu-phi/py/runner.sh'"
