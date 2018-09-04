require "selenium-webdriver"
require "nokogiri"
require "active_support"

p Time.now

  @live_datum = LiveDatum.new(
  	username: "あ", 
  	liveurl: "abc", 
  	streamstart: , 
  	thumbnailurl: "ABC"
  	)
  @live_datum.save

html_txt = open("https://sketch.pixiv.net/lives").read
html_txt_utf8 = html_txt.kconv(Kconv::UTF8, Kconv::EUC)
doc = Nokogiri(html_txt_utf8,'nil','UTF-8')

url = "https://sketch.pixiv.net/lives"

driver = Selenium::WebDriver.for :chrome
driver.navigate.to url
# sleep 10
wait = Selenium::WebDriver::Wait.new(:timeout => 10) # second
wait.until { driver.find_element(:id, 'LivesItem').displayed? }
doc = Nokogiri::HTML.parse(driver.page_source)
doc.xpath('//div[@class="Live"]').each do |node|
	p "ユーザー名"
	p node.css('.owner').text
	user = node.css('.owner').text
	p "配信URL"
  p node.css('.thumb').attribute('href').text
  lurl = node.css('.thumb').attribute('href').text
	p "配信タイトル"
	p node.css('.LiveFoot').text
	p "サムネURL"
  p node.css('.MediaBody').attribute('src').text
  turl = node.css('.MediaBody').attribute('src').text

  @live_datum = LiveDatum.new(
  	username: "#{user}",
  	liveurl: "#{lurl}", 
  	streamstart: , 
  	thumbnailurl: "#{turl}"
  	)
  @live_datum.save
end