class HomeController < ApplicationController
  require 'csv'
  def index; end

  def result
    @name = params[:file].original_filename
    @more_than_year = []
    @less_than_year = []
    if valid_file_name?(@name)
      flash[:success] = 'Arquivo enviado com sucesso!'
      CSV.foreach params[:file].path, headers: true do |row|
        hash_row = row.to_hash
        date_more_than_one_year?(hash_row['admission_date']) ? 
          @more_than_year << hash_row : @less_than_year << hash_row
      end
      @number_lines = CSV.foreach(params[:file].path, headers: true).count
    else
      flash[:alert] = 'Arquivo com formato Inválido!'
      redirect_to root_path
    end
    
  end

  private

  def valid_file_name?(file_name)
    d, m, y = file_name[6..15].split '-'
    return file_name[0..5] == 'dados-' &&
           Date.valid_date?(y.to_i, m.to_i, d.to_i)
  end

  def date_more_than_one_year?(date)
    Date.strptime(date, '%d-%m-%y') < 1.year.ago
  end

end