FROM ruby:4.0.2

LABEL org.opencontainers.image.source=https://github.com/nickcharlton/vagrant-metadata-server
LABEL org.opencontainers.image.description="Vagrant Metadata Server"
LABEL org.opencontainers.image.licenses=AGPL-3.0-or-later

WORKDIR /app
COPY . /app
RUN bundle install

EXPOSE 9292

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "9292"]
