anima
=====

[![Build Status](https://secure.travis-ci.org/mbj/anima.png?branch=master)](http://travis-ci.org/mbj/anima)
[![Dependency Status](https://gemnasium.com/mbj/anima.png)](https://gemnasium.com/mbj/anima)
[![Code Climate](https://codeclimate.com/github/mbj/anima.png)](https://codeclimate.com/github/mbj/anima)
[![Gem Version](https://img.shields.io/gem/v/anima.svg)](https://rubygems.org/gems/anima)

Simple library to declare read only attributes on value-objects that are initialized via attributes hash.

Installation
------------

Install the gem `anima` via your preferred method.

Examples
--------

```ruby
require 'anima'

# Definition
class Person
  include Anima.new(:salutation, :firstname, :lastname)
end

# Every day operation
a = Person.new(
  salutation: 'Mr',
  firstname:  'Markus',
  lastname:   'Schirp'
)

# Returns expected values
a.salutation # => "Mr"
a.firstname  # => "Markus"
a.lastname   # => "Schirp"
a.frozen?    # => false

b = Person.new(
  salutation: 'Mr',
  firstname:  'John',
  lastname:   'Doe'
)

c = Person.new(
  salutation: 'Mr',
  firstname:  'Markus',
  lastname:   'Schirp'
)

# Equality based on attributes
a == b      # => false
a.eql?(b)   # => false
a.equal?(b) # => false

a == c      # => true
a.eql?(c)   # => true
a.equal?(c) # => false

# Functional-style updates
d = b.with(
  salutation: 'Mrs',
  firstname:  'Sue',
)

# It returns copies, no inplace modification
d.equal?(b) # => false

# Hash representation
d.to_h # => { salutation: 'Mrs', firstname: 'Sue', lastname: 'Doe' }

# Disallows initialization with incompatible attributes

Person.new(
  # :saluatation key missing
  "firstname" => "Markus", # does NOT coerce this by intention
  :lastname   => "Schirp"
) # raises Anima::Error with message "Person attributes missing: [:salutation, :firstname], unknown: ["firstname"]
```

Credits
-------

* Markus Schirp <mbj@schirp-dso.com>

Contributing
-------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with Rakefile or version
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

License
-------

Copyright (c) 2013 Markus Schirp

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
