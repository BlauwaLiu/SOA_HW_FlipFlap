# frozen_string_literal: true

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  require 'yaml'

  TAB = "\t"
  NEWLINE = "\n"

  def row_to_table(headers, row)
    row.map.with_index { |cell, i| [headers[i], cell] }.to_h
  end

  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    rows = tsv.split(NEWLINE).map { |line| line.split(TAB) }
    headers = rows.first
    data_rows = rows[1..-1]
    @data = data_rows.map { |row| row_to_table(headers, row) }
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    headers = @data[0].keys
    out = [] << headers.join("\t") << "\n"
    @data.each { |row| out << headers.map { |header| row[header] }.join("\t") << "\n" }
    out.join
  end
end
