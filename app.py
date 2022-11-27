from flask import Flask, render_template
import random
app = Flask(__name__)
# list of cat images
images = [
  "https://tenor.com/view/drei-speed-wette-drei%C3%B6sterreich-drei-test-gif-15189540",
  "https://tenor.com/view/jack-russell-jack-russell-terrier-jack-russell-gif-13114603",
  "http://ak-hdl.buzzfed.com/static/2013-10/enhanced/webdr05/15/9/anigif_enhanced-buzz-26390-1381844163-18.gif"
]
@app.route('/')
def index():
  url = random.choice(images)
  return render_template('index.html', url=url)
if __name__ == "__main__":
app.run(host="0.0.0.0")
