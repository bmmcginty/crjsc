# crjsc

crjsc bridges Crystal and the JavaScriptCore library.
JavaScriptCore is the javascript engine that powers WebKit, the underlying framework for the Safari web browser and may other applications.

You can call javascript functions and read values from Crystal, and you can write Crystal classes and have them executed in Javascript.
The goal of this library is to allow the most seemless back-and-forth between Javascript and Crystal possible.
Pull requests, issues, comments and suggestions are gladly welcome.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  crjsc:
    github: bmmcginty/crjsc
```

## Usage

To build, run `make` in the root of this repository.

See examples/test.cr.

## Development

You'll need the JavaScriptCore libraries.


## Contributing

1. Fork it ( https://github.com/bmmcginty/crjsc/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [bmmcginty](https://github.com/bmmcginty) Brandon McGinty-Carroll - creator, maintainer
