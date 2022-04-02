---
weight: 7
slug: avr
title: AVR Chiptuning
shortAbout: Fronted (Elm) and backend (Hanami API+dry) implementation
projectUrl: https://avr-platform.herokuapp.com/
main_focus:
  - api
  - frontend
images:
  - signin.png
  - upload.png
  - tuning_options.png
  - credits.png
showcaseThumb: signin.png
---

One of my favourite projects! Sadly, the client disappeared right in the middle of the service's frontend implementation, so the screenshots represent the work in progress.

But anyway here is the story.

David needed the car engines database to let the user select he want to tune. After research he found and bought the required DB. But because that DB was just a scraped raw data, there were a lot of corrupted data and of course it wasn't logically structured. So the primary goal was to model the data and create a complex CSV data normalizer

After that done, the next goal was to create an API. Here I decided to use my favourites: ``Rack`` wrapped in tiny ``hanami-api``, ``warden`` for token authentication and ``dry-rb`` gems collection. That way we've got a beautiful and testable code like this:

```ruby
module Avr
  module Api
    module Endpoints
      module Employers
        class SignIn
          include Dry::Monads[:result]
          include Avr::Api::Endpoints::Common::Public
          include Import['avr.logging.logger',
                         action:     'avr.actions.employers.sign_in',
                         serializer: 'avr.api.serializers.employee']

          # Params: Hanami::Params
          def call(params)
            case action.call(params.to_h)
            in Success(employee)
              logger.info("Employee authenticated: #{employee.inspect}")
              json_body(serializer.render(employee, view: :sign_in))
            in Failure(Dry::Validation::Result => result) # match against validation: true
              api_validation_error(message: 'Validation error', errors: result.errors.to_h)
            in Failure(result)
              api_error(message: result, error_type: :sign_in)
            end
          end
        end
      end
    end
  end
end
```

```ruby
module Avr
  module Actions
    module Employers
      class SignIn
        include Dry::Monads[:result, :do]

        include Import[
                  'avr.logging.logger', 'avr.utils.api_tokens_generator',
                  employers:  'avr.repos.employers',
                  api_tokens: 'avr.repos.employee_api_tokens',
                  contract:   'avr.api.contracts.employers.sign_in']

        def call(params)
          values   = yield validate(params)
          employee = yield find_employee(values[:email])
          employee = yield authenticate(employee, values[:password])
          employee = yield generate_new_access_token(employee)

          Success(employee)
        end

        # contracts return the result objects that keep both input values and errors.
        def validate(params)
          contract.call(params).to_monad
        end

        def find_employee(email)
          if (employee = employers.find_by_email(email))
            Success(employee)
          else
            Failure("Can't find Employee")
          end
        end

        def authenticate(employee, password)
          logger.debug("Authenticating")
          if BCrypt::Password.new(employee.password_digest) == password
            logger.debug("Password match!")
            Success(employee)
          else
            logger.debug("Password mismatch")
            Failure("Password mismatch")
          end
        end

        def generate_new_access_token(employee)
          logger.debug("Generating new access/reset token pair for employee: #{employee.email}")

          tokens_data = api_tokens_generator.generate
          logger.debug("Creating new access/reset token pair for employee: #{employee.email}")
          token = api_tokens.create(employee_id: employee.id, **tokens_data)

          return Failure("Can't create access tokens") unless token

          employee.current_api_token = token
          Success(employee)
        end
      end
    end
  end
end
```

Next step was to create frontend part. And that was the first time I choose Elm as a frontend language, having some awesome experience with it in my learning sandboxes. Everything went smooth until in the middle of frontend work my client stopped responding :(

Anyway, I'd love to use Elm again someday, that was a joy to work with it!

Actually this project had my **dream stack**: parsers/normalizers, data modelling, APIs, lightweight stack and Elm for frontend. I'd only add TailwindCSS in that list for completeness.
