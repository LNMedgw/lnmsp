# lib/tasks/rss.rake
namespace :rss do
  task :hello => :environment do
    require 'selenium-webdriver'
	  require 'capybara'
	  require 'nokogiri'
	  # Capybara自体の設定、ここではどのドライバーを使うかを設定しています
	  Capybara.configure do |capybara_config|
	    capybara_config.default_driver = :selenium_chrome
	    capybara_config.default_max_wait_time = 10 # 一つのテストに10秒以上かかったらタイムアウトするように設定しています
	  end
	  # Capybaraに設定したドライバーの設定をします
	  Capybara.register_driver :selenium_chrome do |app|
	    options = Selenium::WebDriver::Chrome::Options.new
	    options.add_argument('headless') # ヘッドレスモードをonにするオプション
	    options.add_argument('--disable-gpu') # 暫定的に必要なフラグとのこと
	    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
	  end

	  Capybara.javascript_driver = :selenium_chrome

	  p "現在日時"
	  now = DateTime.now
	  p "#{now}"


	  @b = Capybara.current_session
	  # include Capybara::DSL;

	  @b.visit('https://sketch.pixiv.net/lives')

	  @b.windows.each do |w|
	    @b.switch_to_window(w)
	    doc = Nokogiri::HTML.parse(@b.html)
			doc.xpath('//div[@class="Live"]').each do |node|
				p "--------------------"
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

			  check = LiveDatum.find_by(username: "#{user}")
			  if !check
				  @live_datum = LiveDatum.new(
				  	username: "#{user}",
				  	liveurl: "#{lurl}", 
				  	streamstart: "#{now}", 
				  	thumbnailurl: "#{turl}"
				  	)
				  @live_datum.save
				  p "#{user}が配信を開始しました"
				else
					@live_datum.update(
						username: "#{user}",
				  	liveurl: "#{lurl}", 
				  	streamstart: "#{now}", 
				  	thumbnailurl: "#{turl}"
						)
				  @live_datum.save
				end

				p "--------------------"
	    end

		old = LiveDatum.where.not(streamstart: "#{now}")
		@LiveDatum.destroy

	  end
  end
end