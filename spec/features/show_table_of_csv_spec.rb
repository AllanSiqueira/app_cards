require 'rails_helper'

feature 'Show table of csv' do
  scenario 'successfully' do
    visit root_path
    attach_file 'file', Rails.root.join('spec',
                                        'support', 'dados-19-07-2018.csv')
    click_on 'Enviar csv'
    expect(page).to have_css('td', text: '27/06/2016')
    expect(page).to have_css('td', text: 'R$ 618,00')
    expect(page).to have_css('h3', text: 'Demais funcionários')
  end
  scenario 'and count the number of lines' do
    visit root_path
    attach_file 'file', Rails.root.join('spec',
                                        'support', 'dados-20-07-2018.csv')
    click_on 'Enviar csv'
    expect(page).to have_css('p', text: 'Número de Linhas: 100')
  end
end
