# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  phone_number :string           not null
#  email        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#

require 'rails_helper'

RSpec.describe Person, type: :model do
  it { is_expected.to belong_to(:company).optional }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:phone_number) }

  describe 'validations' do
    let(:email) { 'foo@bar.com' }
    let(:name) { 'Foo Bar' }
    let(:phone_number) { '1234567890' }

    let(:company1) { Company.create(name: 'Company 1') }
    let(:company2) { Company.create(name: 'Company 2') }
    let!(:person) { Person.create(company: company1, email: email, name: name, phone_number: phone_number) }
    let!(:person2) { Person.new(company: company2, email: email, name: name, phone_number: phone_number) }

    context 'with valid attributes' do
      it 'is valid' do
        expect(person).to be_valid
      end
    end

    context 'when the email is invalid' do
      let(:email) { 'invalid' }

      it 'is invalid' do
        expect(person).to be_invalid
      end
    end

    context 'when the email is unique' do
      it 'is valid' do
        expect(person2).to be_valid
      end
    end

    context 'when the email is not unique for the same company' do
      let(:company2) { company1 }

      it 'is invalid' do
        expect(person2).to_not be_valid
      end
    end
  end
end
