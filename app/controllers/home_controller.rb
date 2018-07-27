class HomeController < ApplicationController
  require 'csv'
  def index; end

  def result
    @name = params[:file].original_filename
    @more_than_year = []
    @less_than_year = []
    if valid_file_name?(@name)
      flash[:success] = 'Arquivo enviado com sucesso!'
      filter_csv_file(params[:file].path)
    else
      flash[:alert] = 'Arquivo com formato Inválido!'
      redirect_to root_path
    end
  end

  private

  def valid_file_name?(file_name)
    d, m, y = file_name[6..15].split '-'
    file_name[0..5] == 'dados-' && Date.valid_date?(y.to_i, m.to_i, d.to_i)
  end

  def filter_csv_file(file_path)
    @number_lines = CSV.foreach(params[:file].path, headers: true).count
    CSV.foreach file_path, headers: true do |row|
      csv_row_treatment(row.to_hash)
    end
  end

  def csv_row_treatment(row)
    row['admission_date'] = Date.strptime(row['admission_date'],
                                          '%d-%m-%y')
    if row['admission_date'] < 1.year.ago
      @more_than_year << row
    else
      @less_than_year << row
    end
  end
end
