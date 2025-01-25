FROM ruby:3.0-alpine

# 必要なパッケージをインストール
RUN apk update && \
    apk upgrade && \
    apk add --no-cache gcompat linux-headers libxml2-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql git bash \
    imagemagick && \
    apk add --virtual build-packages --no-cache build-base curl-dev

# アプリケーションディレクトリを作成
RUN mkdir /myapp
WORKDIR /myapp

# GemfileとGemfile.lockを追加
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock

# Bundlerで依存関係をインストール
RUN bundle install

# ビルドパッケージを削除してイメージサイズを小さくする
RUN apk del build-packages

# アプリケーションコードを追加
ADD . /myapp

# ポートを公開
EXPOSE 4000

# サーバを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
