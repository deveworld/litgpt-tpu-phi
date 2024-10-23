import lightning as L
from lightning.pytorch.strategies import FSDPStrategy
from lightning.pytorch.demos import LightningTransformer

model = LightningTransformer()

strategy = FSDPStrategy(state_dict_type="sharded")
trainer = L.Trainer(
    accelerator="tpu",
    devices=8,
    strategy=strategy,
    max_steps=3,
)
trainer.fit(model)