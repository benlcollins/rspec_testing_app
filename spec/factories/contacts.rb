# spec factories girl for contacts testing
require 'faker'

# FactoryGirl.define do
# 	factory :contact do |f|
# 		f.firstname "John"
# 		f.lastname "Doe"
# 	end
# end

FactoryGirl.define do
  factory :contact do |f|
  	f.firstname { Faker::Name.first_name }
  	f.lastname { Faker::Name.last_name }
  end
end