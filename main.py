import falcon
from controllers.Caption import Caption

from PIL import Image
from clip_interrogator import Config, Interrogator


print('BOOTING!!!', flush=True)

ci = Interrogator(Config(clip_model_name="ViT-L-14/openai"))

print('BOOTED!!!', flush=True)

app = falcon.App()

app.add_route('/caption', Caption(ci))
