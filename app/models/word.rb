require 'nokogiri'
require 'open-uri'

class Word < ApplicationRecord
  BASE_URL = 'http://www.iciba.com/'

  def self.check(word, save = false)
    word_url = BASE_URL + word.to_s
    page = Nokogiri::HTML(open(word_url))
    word = page.css('h1').first.children.text.delete(" \t\r\n")
    return false if word.blank?
    description = ''
    page.css('.base-list.switch_part li').each do |list|
      attributr = list.css('.prop')[0].children.text
      description.concat(attributr + ' ')
      description.concat(list.css('p')[0].children.text.delete(" \t\r\n"))
      description.concat('<br/> ')
    end

    word_attribute = {
      :name => word,
      :description => description
    }

    if save == true
      Word.create!(word_attribute) if Word.find_by(name: word).nil?
    end

    return {
      :name => word,
      :description => description
    }
  end
end
