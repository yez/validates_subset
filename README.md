## validates_subset

![Build Status](https://travis-ci.org/yez/validates_subset.svg?branch=master)

### Subset validator for Rails

#### Purpose

Validate that an attribute is a subset of another. If an attribute saved to the database (or simply kept in memory) needs to be a subset of another, this is the way to go.

#### Usage

##### With ActiveRecord

```ruby
class Foo < ActiveRecord::Base
  attr_accessor :bar

  # validate that the attribute :bar is a subset of the set [2, 4, 5]
  validates_subset :bar, [2, 4, 5]
end

# Example usage:
foo = Foo.new(bar: [2])
foo.valid?
# => true

foo = Foo.new(bar: [7])
foo.valid?
# => false

foo = Foo.new(bar: 'banana')
foo.valid?
# => false
```

##### With ActiveModel

```ruby
class Bar
  include ActiveModel

  attr_accessor :foo

  # validate that the attribute :foo is a subset of the set ['a', 'b', 'c']
  validates_subset :foo, ['a', 'b', 'c']
end

# Example usage:
bar = Bar.new(foo: ['a'])
bar.valid?
# => true

bar = Bar.new(foo: ['q'])
bar.valid?
# => false

bar = Bar.new(foo: 123)
bar.valid?
# => false
```

##### With `validates` syntax

```ruby
class Banana < ActiveRecord::Base

  attr_accessor :peel

  # validate that the attribute :peel is a subset of the set ['yellow', 'green']
  validates :peel, subset: ['yellow', 'green']
end

# Example usage:
banana = Banana.new(peel: ['yellow'])
banana.valid?
# => true

banana = Banana.new(peel: ['brown']) # Who wants a brown peel? No one.
banana.valid?
# => false

banana = Banana.new(peel: 123)
banana.valid?
# => false
```

##### With multiple modifiers

```ruby
class Foo < ActiveRecord::Base
  attr_accessor :baz

  # validate that attribute :baz is a subset of [1, 2, 3] with a custom error message
  #   only if :conditional_method evaluates to true
  validates_subset :baz, [1, 2, 3],
                  message: 'Baz is not a subset of [1, 2, 3], make it so!',
                  if: :conditional_method

  def conditional_method
    # some kind of logic that is important to pass
  end
end

# Example usage:
foo = Foo.new(baz: [1])

foo.valid?
# => true

foo = Foo.new(baz: [99999])

# When the conditional method is true
foo.conditional_method
# => true
foo.valid?
# => false

# When the conditional method is false
foo.conditional_method
# => false
foo.valid?
# => true
```

#### Contributing

Please feel free to submit pull requests to address issues that you may find with this software. One commit per pull request is preferred please and thank you.
