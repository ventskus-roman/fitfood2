require 'open-uri'
require 'nokogiri'

url = "http://edimka.ru/tables/a-0"
html = open(url)
doc = Nokogiri::HTML(html)
doc.encoding = 'utf-8'
products = []
doc.css("tr").each_with_index do |tr, index|
  tds = tr.css('td')
  if tds.length == 1 || index == 0
    next
  end
  name = tds[0].css('a').text
  proteins = tds[1].content ? tds[1].content.to_f : 0
  fat = tds[2].content ? tds[2].content.to_f : 0
  carbs = tds[3].content ? tds[3].content.to_f : 0
  Product.create(name: name.mb_chars, proteins: proteins, fat: fat, carbs: carbs)
end

