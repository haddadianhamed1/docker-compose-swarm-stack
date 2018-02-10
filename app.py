from flask import Flask
from redis import Redis
import os, socket

app = Flask(__name__)
redis = Redis(host='redis', port=6379)
@app.route('/')
def hello():
    return ("Hello world this is a test app")

@app.route('/hello')
def hello_world():
   return 'hello world'

@app.route('/inc')
def hello_world1():
   redis.incr('totalhits')
   return 'hello from container %s ! I have been viewd %s times' %(socket.gethostname(),redis.get('totalhits'))




if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")
