require 'net/http'
require 'json'

API_URL = 'https://ifsc.razorpay.com/'

def make_request(ifsc_code)
  ifsc_link = API_URL + ifsc_code
  uri = URI(ifsc_link)
  Net::HTTP.get_response(uri)
end

def print_details(ifsc_code)
  response = make_request(ifsc_code)

  if response.code.to_i == 404
    puts "Entered IFSC Code : " + ifsc_code + " is INVALID! Please re-enter correct one"
  else
    details = JSON.parse(response.body)
    puts "Details for bank with IFSC code: " + ifsc_code
    puts "-------------------------------------"
    puts "Your Bank name is " + details["BANK"]
    puts "Your Bank Branch name is " + details["BRANCH"]
    puts "-------------------------------------"
  end
end

puts "Please type in your IFSC code(s): (put comma for multiple entires)"
ifsc_codes = gets.chomp

ifsc_array = ifsc_codes.split(",").uniq

puts "IFSC code(s) reconfirmation : " + ifsc_codes

ifsc_array.each do |ifsc_code|
  print_details(ifsc_code)
end