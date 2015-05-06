# contact model test

require 'spec_helper'
require 'rails_helper'	# had to add this line myself

describe Contact do
	it "has a valid factory" do
		# .should method now deprecated
		# FactoryGirl.create(:contact).should be_valid
		expect(FactoryGirl.create(:contact)).to be_valid
	end

	it "is invalid without a firstname" do
		expect(FactoryGirl.build(:contact, firstname: nil)).not_to be_valid
	end

	it "is invalid without a lastname" do
		expect(FactoryGirl.build(:contact, lastname: nil)).not_to be_valid
	end

	it "returns a contact's full name as a string" do
		contact = FactoryGirl.create(:contact)
		# expect(contact.name).to eq("John Doe")   <-- this doesn't work because of Faker gem data

		# check string and has two words
		expect(contact.name.class).to eq(String)
		expect(contact.name.split(" ").length).to eq(2)
	end

	# test that clicking on letter returns only contacts whose surnames begin with that letter
	
	# need to create test names, where at least two start with same letter and one doesn't
	jones = FactoryGirl.create(:contact, lastname: "Jones").lastname
	james = FactoryGirl.create(:contact, lastname: "James").lastname
	smith = FactoryGirl.create(:contact, lastname: "Smith").lastname

	# need to test if filter with "J" returns the two J-surnames
	it "filters surnames to match chosen letter" do 
		j_names = []
		Contact.by_letter("J").each do |contact|
			j_names.push(contact.lastname)
		end
		expect(j_names.uniq).to match_array([jones, james])
		expect(j_names.uniq).not_to include(smith)
	end


end