# Authentication
This Gem helps you to initialize your application, with `devise`, `devise_auth_token`, `rolify` and `pundit`. Theres some level of customization possible and can be passed in as parameters to the install command.

## Usage
Create a new rails app and add the gem in your `Gemfile`. You will required to run the install command next. You can use the following arguments to cutomize the installation.

```
  [--skip-devise], [--no-skip-devise]                    # Skip devise setup
  [--skip-base-controller], [--no-skip-base-controller]  # Skip base controller setup
  [--skip-rolify], [--no-skip-rolify]                    # Skip rolify setup
  [--skip-pundit], [--no-skip-pundit]                    # Skip pundit setup and 
  [--authentication-mount=AUTHENTICATION_MOUNT]          # Define the model for user authentication
                                                         # Default: auth
  [--model=MODEL]                                        # Define the model for user authentication
                                                         # Default: User
  [--roles=one two three]                                # Roles to create by default
                                                         # Default: ["admin"]

```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'authentication', git: 'https://github.com/Liquid-Fire-Tech/authentication.git', tag: '0.1.1'
```

And then execute:
```bash
$ bundle
```

To install
```
$ rails g authentication:install
```

For help
```
$ rails g authentication:install --help
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
