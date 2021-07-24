require 'net/http'
require 'json'

url = 'https://ifsc.razorpay.com/'
puts "Please type in your IFSC code:"
ifsc_code = gets.chomp()
puts "IFSC code reconfirmation : " + ifsc_code

ifsc_link = url + ifsc_code

uri = URI(ifsc_link)
response = Net::HTTP.get_response(uri)
status = response.code

if status.to_i == 404
  puts "Invalid IFSC Code! Please re-enter correct one"
else
  details = JSON.parse(response.body)
  puts "Your Bank name is " + details["BANK"]
  puts "Your Bank Branch name is " + details["BRANCH"]
end