# import community modules. 
from flask import Flask
from elasticapm.contrib.flask import ElasticAPM
import argparse

app = Flask(__name__)
app.config['ELASTIC_APM'] = {
   'SERVICE_NAME': 'Sample App',
   'SECRET_TOKEN': 'test123',
}
apm = ElasticAPM(app)


@app.route('/index',methods=['GET'])
def index():
  return "hello world"

if __name__ == '__main__':
  try:
    parser = argparse.ArgumentParser(description='test app')
    parser.add_argument('--port','-P',type=int,default=5000)
    parser.add_argument('--host','-H',default='0.0.0.0')
    args = parser.parse_args()
    print 'starting test app'
    app.run(debug=False,host=args.host,port=args.port)
  except KeyboardInterrupt:
    print 'stopping test app'
