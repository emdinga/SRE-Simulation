from flask import Flask, redirect, url_for, session
from authlib.integrations.flask_client import OAuth
import os

app = Flask(__name__)
app.secret_key = os.urandom(24)  # Use a proper secret for production

oauth = OAuth(app)

oauth.register(
    name='oidc',
    authority='https://cognito-idp.us-east-1.amazonaws.com/us-east-1_D6yeYbyEq',
    client_id='12vl1ht6e686v5lugf1d00s6hr',  # Your App Client ID
    client_secret='195icepcjgf1fa03pn8ml4t6pjug7vt995uq1t4aufo0prgn73jl',
    server_metadata_url='https://cognito-idp.us-east-1.amazonaws.com/us-east-1_D6yeYbyEq/.well-known/openid-configuration',
    client_kwargs={'scope': 'openid email profile'}
)

@app.route('/')
def index():
    user = session.get('user')
    if user:
        return f'Hello, {user["email"]}. <a href="/logout">Logout</a>'
    return f'Welcome! Please <a href="/login">Login</a>.'

@app.route('/login')
def login():
    redirect_uri = url_for('authorize', _external=True)
    return oauth.oidc.authorize_redirect(redirect_uri)

@app.route('/authorize')
def authorize():
    token = oauth.oidc.authorize_access_token()
    user = token.get('userinfo')
    session['user'] = user
    return redirect(url_for('index'))

@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect(url_for('index'))

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
