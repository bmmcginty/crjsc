# crjsc

crjsc bridges Crystal and the JavaScriptCore library.
JavaScriptCore is the javascript engine that powers WebKit, the underlying framework for the Safari web browser and many other applications.

You can call javascript functions and read values from Crystal, and you can write Crystal classes and have them executed in Javascript.
The goal of this library is to allow the most seemless back-and-forth between Javascript and Crystal that is possible.
Pull requests, issues, comments and suggestions are gladly welcome.

This library is not suitable in production, and should be considered alpha level software.

## Todo

* Support calling js functions atached to js objects from crystal.
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

All of the following should be performed from the root of this repository.

* To build, run `make`.
* To test, run `make spec`.
* To run the example(s), run `make examples`.

See examples/file_interface.cr for an example that exposes file access to Javascript.

## Development

The JavaScriptCore library will be downloaded to `src/ext/webkit`.
It will also be symlinked to `jscore` for quicker access.
Use `jscore/API` to look at the C interface to JavaScriptCore.
Make changes in `src/crjsc/lib.cr` or the appropriate file.

### Low-level Notes
* All JSObjects are (interchangeable) JSValues.
* Not all JSValues are JSObjects. Use `value_is_object` to check this.
* To convert a crystal type to Javascript, insure that a `to_js(ctx)` method exists, that it accepts a Crjsc::Context, and that it outputs a Crjsc::LibJavaScriptCore::Valueref (or in some cases a Crjsc::LibJavaScriptCore::Objectref).
* To convert a Javascript type to a native Crystal type, insure that a to_cr method exists and returns a crystal type.
* If you are accessing a complex JS object from Crystal, use the obj[name] and obj[name]=value method to access and mutate properties/functions of that object.

## Contributing

1. Fork it ( https://github.com/bmmcginty/crjsc/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [bmmcginty](https://github.com/bmmcginty) Brandon McGinty-Carroll - creator, maintainer
