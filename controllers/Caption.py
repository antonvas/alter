import falcon
from io import BytesIO
from PIL import Image
import requests
import time


class Caption:
    def __init__(self, interrogator):
        self.ci = interrogator

    def on_get(self, req, resp):

        image_url = req.get_param('url', required=True)

        response = requests.get(image_url)
        image = Image.open(BytesIO(response.content)).convert('RGB')

        print('Image loaded. Recognizing.', flush=True)
        start_time = time.time()
        caption, meta = self.ci.interrogate(image)
        print(f"Recognized in {time.time() - start_time:.2f} seconds.", flush=True)

        resp.status = falcon.HTTP_OK
        resp.media = {
            'caption': caption,
            'meta': meta,
        }
