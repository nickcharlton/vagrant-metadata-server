# vagrant-metadata-server

A reference [Vagrant Cloud][] implementation to build a custom server.

## Usage

```
bin/setup
```

### API

This uses [Sinatra][], provides enough endpoints to fetch boxes and be run with:

```
bundle exec rackup
```

### CLI

The CLI is used to add boxes:

```sh
$ bin/cli
bin/cli [global options] command [command options] [command args...]

        add-box [command options] [command args...]
            --name NAME                  Name of the box including user

        add-version [command options] [command args...]
            --box BOX_NAME               Name of the box including user
            --version VERSION            Value for the version
            --status [STATUS]            Status of the box, defaults to active
            --description [DESCRIPTION]  Box description. Supports Markdown. Defaults to blank
```

[Vagrant Cloud]: https://developer.hashicorp.com/vagrant/vagrant-cloud
[Sinatra]: https://sinatrarb.com/
