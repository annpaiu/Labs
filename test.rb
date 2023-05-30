require 'sendgrid-ruby'
include SendGrid

from = Email.new(email: 'en.worker2@gmail.com')
to = Email.new(email: 'en.worker2@gmail.com')
subject = 'Sending with SendGrid is Fun'
content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: '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')
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers
