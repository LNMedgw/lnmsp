class LiveDataController < ApplicationController
  before_action :set_live_datum, only: [:show, :edit, :update, :destroy]

  # GET /live_data
  # GET /live_data.json
  def index
    @live_data = LiveDatum.all
  end

  # GET /live_data/1
  # GET /live_data/1.json
  def show
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
      @b.save_screenshot
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

  # GET /live_data/new
  def new
    @live_datum = LiveDatum.new
  end

  # GET /live_data/1/edit
  def edit
  end

  # POST /live_data
  # POST /live_data.json
  def create
    @live_datum = LiveDatum.new(live_datum_params)

    respond_to do |format|
      if @live_datum.save
        format.html { redirect_to @live_datum, notice: 'Live datum was successfully created.' }
        format.json { render :show, status: :created, location: @live_datum }
      else
        format.html { render :new }
        format.json { render json: @live_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /live_data/1
  # PATCH/PUT /live_data/1.json
  def update
    respond_to do |format|
      if @live_datum.update(live_datum_params)
        format.html { redirect_to @live_datum, notice: 'Live datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @live_datum }
      else
        format.html { render :edit }
        format.json { render json: @live_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /live_data/1
  # DELETE /live_data/1.json
  def destroy
    @live_datum.destroy
    respond_to do |format|
      format.html { redirect_to live_data_url, notice: 'Live datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_live_datum
      @live_datum = LiveDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def live_datum_params
      params.require(:live_datum).permit(:username, :liveurl, :streamstart, :thumbnailurl)
    end
end
