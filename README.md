# vagrant-metadata-server

A reference [Vagrant Cloud][] implementation to build a custom server. [The
background is documented in this blog post][blog-post].

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

        add-provider [command options] [command args...]
            --box BOX_NAME               Name of the box including user
            --version VERSION            Name of the version
            --name [NAME]                Name of the provider
            --architecture [ARCHITECTURE]
                                         Architecture of the provider
            --[no-]default-architecture  Set as the default architecture
            --checksum [CHECKSUM]        Checksum of the box file
            --checksum-type [CHECKSUM_TYPE]
                                         Type of checksum used
            --url [URL]                  URL of where to find the box file
```

[Vagrant Cloud]: https://developer.hashicorp.com/vagrant/vagrant-cloud
[Sinatra]: https://sinatrarb.com/
[blog-post]: https://nickcharlton.net/posts/building-a-custom-vagrant-metadata-server
