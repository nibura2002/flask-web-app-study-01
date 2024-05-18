import os

class Config:
    SECRET_KEY = os.getenv('SECRET_KEY', 'default-secret-key')
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'sqlite:///app.db')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    DEBUG = False
    TESTING = False

class DevelopmentConfig(Config):
    ENV = 'development'
    DEBUG = True

class ProductionConfig(Config):
    ENV = 'production'
    DEBUG = False

class TestingConfig(Config):
    ENV = 'testing'
    TESTING = True
    DEBUG = True
