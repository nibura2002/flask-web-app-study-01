from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_login import LoginManager, login_required, current_user
import os
from config import DevelopmentConfig, ProductionConfig, TestingConfig
from models import db, User

login_manager = LoginManager()

def create_app():
    app = Flask(__name__)

    # 環境設定の読み込み
    env = os.getenv('FLASK_ENV', 'production')
    if env == 'development':
        app.config.from_object(DevelopmentConfig)
    elif env == 'testing':
        app.config.from_object(TestingConfig)
    else:
        app.config.from_object(ProductionConfig)

    # Flask-Loginの初期化
    login_manager.init_app(app)
    login_manager.login_view = 'auth.login'

    # Flask-SQLAlchemyとFlask-Migrateの初期化
    db.init_app(app)
    Migrate(app, db)

    # ユーザーローダーの設定
    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    # ルートの定義
    @app.route('/')
    def index():
        return "Hello, World!"

    @app.route('/dashboard')
    @login_required
    def dashboard():
        return render_template('dashboard.html', username=current_user.username)

    # ブループリントの登録
    from auth import auth as auth_blueprint
    app.register_blueprint(auth_blueprint)

    return app
