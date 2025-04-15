require 'rails_helper'

RSpec.describe 'Creating person', type: :feature do
  let(:name) { 'Javier' }
  let(:email) { 'javier@test.com' }
  let(:phone_number) { '5432123456' }

  it 'Creates a new person' do
    visit new_person_path

    expect(page).to have_field :person_name
    expect(page).to have_field :person_email
    expect(page).to have_field :person_phone_number

    fill_in :person_name, with: name
    fill_in :person_email, with: email
    fill_in :person_phone_number, with: phone_number

    click_button 'Create Person'

    visit people_path
    
    expect(page).to have_content(name)
    expect(page).to have_content(email)
    expect(page).to have_content(phone_number)
  end
end
