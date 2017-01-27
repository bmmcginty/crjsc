# crjsc

crjsc bridges Crystal and the JavaScriptCore library.
JavaScriptCore is the javascript engine that powers WebKit, the underlying framework for the Safari web browser and many other applications.

You can call javascript functions and read values from Crystal, and you can write Crystal classes and have them executed in Javascript.
The goal of this library is to allow the most seemless back-and-forth between Javascript and Crystal that is possible.
Pull requests, issues, comments and suggestions are gladly welcome.

## Todo

* Add propper docs to classes
* Explain jsprop
* Allow wildcard getProperty  and setProperty calls
* Pass javascript arrays as special JSArray objects
* Allow single functions to be dropped into js without requiring manual class handling (let top level functions be turned into js objects)
* handle type restrictions and automatic? type conversion
* Use callbacks definitions to dispatch arguments instead of having them shoved into an array

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
