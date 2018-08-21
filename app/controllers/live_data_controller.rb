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
