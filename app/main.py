from flask import Flask
from redis import Redis
import os


app = Flask(__name__)
REDIS_PASS = os.environ.get('REDIS_PASS')
redismaster = Redis(host='redis-0.redis', port=6379, db=0, password=REDIS_PASS)
redis = Redis(host='redis', port=6379, db=0, password=REDIS_PASS)

name = os.environ.get('NAME')

@app.route('/')
def hello():
    redismaster.incr('hits')
    return 'Greetings from ' + name + ' %s times!!!' % redis.get('hits')

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)
    
    