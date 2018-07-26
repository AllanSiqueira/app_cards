require 'rails_helper'

feature 'Upload valid csv file' do
  scenario 'successfully' do
    visit root_path
    attach_file 'file', Rails.root.join('spec', 'support', 'dados-19-07-2018.csv')
    click_on 'Enviar csv'
    expect(page).to have_css('p', text: 'Arquivo enviado com sucesso!')
    expect(page).to have_css('h2', text: 'dados-19-07-2018.csv')
  end
  scenario 'and dont accept nonstandard file' do
    visit root_path
    attach_file 'file', Rails.root.join('spec', 'support', 'dados-invalido.csv')
    click_on 'Enviar csv'
    expect(page).to have_css('p', text: 'Arquivo com formato Inválido!')
    expect(current_path).to eq(root_path)
  end
end