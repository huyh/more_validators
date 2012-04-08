## Installation

Add to your Gemfile and run the `bundle` command to install it.

```ruby
gem "more_validators"
```

## Usage

```ruby
class User < ActiveRecord::Base
  validates :email, :email => true
end

class User < ActiveRecord::Base
  validates :json_doc, :json => true
end
```

This gem is created by Huy Hoang and is under the MIT License.
