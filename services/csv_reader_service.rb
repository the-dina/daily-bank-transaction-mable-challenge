# frozen_string_literal: true

class CSVReaderService
  def self.read_csv(file_path)
    lines = []
    File.foreach(file_path) do |line|
      lines << line.chomp.split(",")
    end
    lines
  end
end
