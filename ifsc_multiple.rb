require 'net/http'
require 'json'

url = 'https://ifsc.razorpay.com/'
puts "Please type in your IFSC code(s): (put comma for multiple entires)"
ifsc_codes = gets.chomp
ifsc_array = ifsc_codes.split(",").uniq

puts "IFSC code(s) reconfirmation : " + ifsc_codes

ifsc_array.each do |ifsc_code|
	ifsc_link = url + ifsc_code
	uri = URI(ifsc_link)
  response = Net::HTTP.get_response(uri)
  status = response.code

  if status.to_i == 404
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