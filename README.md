=======
# yesman
======

Yesman is a ruby command line interface that creates basic directory structures for starting a C++ project. As a part of the creation of a new project Yesman will download, compile and generally get Google Test setup for the projects testing suite.

## Installation

To install it simply run:

    $ gem install yesman

## Usage

To create a default project simply run:
    
    $ yesman new ProjectName

Doing so will create a "ProjectName" directory with a "src", "tests", "bin" directory. GoogleTests will be compiled into a "gtest" directory inside of the "tests" directory. A main test runner file named "ProjectNameTests.cpp" will be created inside of the "tests" directory and a "ProjectName.cpp" file will be created in your "src" directory.

There are several optional parameters you can use that will adjust the following:

-s  Source Directory Name (defaults to "src")

-t  Tests Directory Name (defaults to "tests")

-o  Output Directory Name (defaults to "bin")

-e  C++ extension to use for generated files (defaults to "cpp")

To generate class files (along with headers and tests) from inside of your project directory run:

    $ yesman generate "jsk::SuperClass<jsk::BaseClass"

The string passed to generate (also aliased to 'g') will create your class file, header, and test file. The format is:

    "namespace::ClassName<namespace::ParentClass"

Namespaces and inheritance are optional, so you could just as easily run:

    $ yesman g "SuperClass<BaseClass

or 

    $ yesman g "SuperClass"


## Requirements

Under the hood there are several technologies that Yesman relies on. In order to run you will need the following:

G++ - You can get this by installing XCode on your mac, be sure to install the command line tools

svn - In order to pull down Google Test you will need to have svn installed on your machine

ruby > 1.9 - OS X is still shipping with 1.8.7. Use rvm to install the latest version of ruby

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
