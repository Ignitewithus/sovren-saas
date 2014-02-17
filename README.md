# SovrenSaas

A simple ruby gem that parses a resume using the sovren resume parser and returns the resume back as a ruby object.

## SaaS Version

This is for the Saas version of Sovren, using their web service as the end point.  Use the Sovren gem for pointing to your own install of the Sovren resume parsing service.

The output from Sovren remains unchanged, this gem simply changes the way a client connects to and communicates with the Saas version of Sovren.

## Installation

Add this line to your application's Gemfile:

    gem 'sovren_saas'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sovren_saas

## Usage Example

1. Create a client

    ```ruby
    client = SovrenSaas::Client.new(endpoint: "http://services.resumeparsing.com/ResumeService.asmx?wsdl", account_id: "YOUR ACCTID", service_key: "YOUR SERVICE KEY")
    ```

2. Parse a resume

    ```ruby
    resume = client.parse(File.read('/path/to/your/file/resume.doc'))
    ```

## Contributing

The testing could use some more coverage for other hr-xml use cases.  I also haven't added any of the sovren specific fields returned but those could be added if you need them.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
