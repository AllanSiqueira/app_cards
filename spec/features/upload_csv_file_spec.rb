require 'rails_helper'

feature 'Upload valid csv file' do
  scenario 'successfully' do

    visit root_path
    attach_file 'Arquivo csv', Rails.root.join('spec', 'support', 'dados-19-07-2018.csv')

    expect(page).to have_css('p', text: 'Arquivo enviado com sucesso!')
  end
end