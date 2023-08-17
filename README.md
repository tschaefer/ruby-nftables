# ruby-nftables

Ruby high-level userspace netfilter nftables package.

## Introduction

**ruby-nftables** is a foreign function interface for the high-level userspace
netfilter nftables library.

It provides a basic run method, to execute nftables commands. For valid
commands see the `nftables(8)` manpage and the [nftables wiki](https://wiki.nftables.org).

## Installation

    $ gem build
    $ gem install -g
    $ gem install nftables-$(ruby -Ilib -e 'require "nftables/version"; puts NFT::VERSION').gem

## Usage

For API documentatin use `rake doc`.

## License

[GNU GPLv3](https://spdx.org/licenses/GPL-3.0-only.html)

## Is it any good?

[Yes](https://news.ycombinator.com/item?id=3067434)
