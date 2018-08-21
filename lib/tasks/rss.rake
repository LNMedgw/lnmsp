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


	  @b = Capybara.current_session
	  # include Capybara::DSL;

	  @b.visit('https://sketch.pixiv.net/lives')

	  @b.windows.each do |w|
	    @b.switch_to_window(w)
	    doc = Nokogiri::HTML.parse(@b.html)
	    doc.xpath('//div[@class="Live"]').each do |node|
	      p "ユーザー名"
	      p node.css('.owner').text
	      p "配信タイトル"
	      p node.css('.LiveFoot').text
	      p "配信URL"
	      p node.css('.thumb').attribute('href').text
	    end
	  end
  end
end