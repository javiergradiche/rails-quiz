require 'rails_helper'

RSpec.describe 'Listing people', type: :feature do
  before do 
    Person.create(
      name: 'Foo Bar',
      phone_number: 'Biz',
      email: 'Baz'
    )
  end

  scenario 'with valid users' do
    visit people_path

    aggregate_failures do
      expect(page).to have_content('Foo Bar')
      expect(page).to have_content('Baz')
      expect(page).to have_content('Biz')
    end

  end
end
