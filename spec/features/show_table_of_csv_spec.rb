require 'rails_helper'

feature 'Show table of csv' do
  scenario 'successfully' do
    visit root_path
    attach_file 'file', Rails.root.join('spec', 'support', 'dados-19-07-2018.csv')
    click_on 'Enviar csv'
    expect(page).to have_css('h3', text: 'Funcionários com data de admissão superior a 1 ano')
    expect(page).to have_css('h3', text: 'Demais funcionários')
  end
end