# Debian

## Dependencies

To install on Debian, the following package repository,
must be installed:

- [Debian Sid][sid]

This can be installed via the following command:

```terminal
# Debian Sid
echo "deb http://http.us.debian.org/debian sid main" >> /etc/apt/sources.list

## Installation

```terminal
apt update && apt install -y libnss-aad
```

## Configuration

The package provided should automatically install the following configuration file:

- [`/etc/libnss-aad.conf`](../debian/libnss-aad.conf)

## Troubleshooting

If you are unable to add the package repository due to it being served via HTTPS,
support for HTTPS can be installed via the following command:

```terminal
apt install -y apt-transport-https
```

If you receive an error regarding the key not being found,
it can be manually added via the following commands:

```terminal
# Requires GNU Privacy Guard
apt install -y gnupg2

# Azure Active Directory for Debian
apt-key adv --keyserver pgp.mit.edu --recv 67FF8700EB10F0B9
```

[sid]: https://www.debian.org/releases/sid
