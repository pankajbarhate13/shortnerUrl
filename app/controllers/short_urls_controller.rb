class ShortUrlsController < ApplicationController
  before_action :set_short_url, only: [:show, :edit, :update, :destroy]

  # It is possible to open an http, https or ftp URL as though it were a file
  require 'open-uri'

  # To read json response
  require 'json'

  # require 'securerandom'


  # GET /short_urls
  # GET /short_urls.json
  def index
    @short_urls = ShortUrl.all.order(clicks: :desc).limit(100).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /short_urls/1
  # GET /short_urls/1.json
  def show
  end

  # GET /short_urls/new
  def new
    @short_url = ShortUrl.new
  end

  # GET /short_urls/1/edit
  def edit
  end

  # POST /short_urls
  # POST /short_urls.json
  def create
    url = params[:short_url][:url]

    # regex to validate url
    is_url = url.match(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix).present?
    
    if is_url == true
      surl = Digest::MD5.hexdigest(url+"in salt we trust").slice(0..6) 
      short_url = "http://" + surl

      @short_url = ShortUrl.create(title: params[:short_url][:title], url: params[:short_url][:url] , short_url: short_url, jmp_url: "", clicks: 0)
      redirect_to @short_url, notice: 'Short url was successfully created.'
    else 
      redirect_to short_urls_path, notice: 'Invalid Url.'
    end  

    
  end

  # PATCH/PUT /short_urls/1
  # PATCH/PUT /short_urls/1.json
  def update
    respond_to do |format|
      if @short_url.update(short_url_params)
        format.html { redirect_to @short_url, notice: 'Short url was successfully updated.' }
        format.json { render :show, status: :ok, location: @short_url }
      else
        format.html { render :edit }
        format.json { render json: @short_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /short_urls/1
  # DELETE /short_urls/1.json
  def destroy
    @short_url.destroy
    respond_to do |format|
      format.html { redirect_to short_urls_url, notice: 'Short url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_clicks
    url = ShortUrl.find(params[:id])
    if url.clicks == nil
      count = 1
      url.update_attributes(clicks: count)
    else 
      count = url.clicks + 1
      url.update_attributes(clicks: count)
    end
    render json: {clicks: count }
    # render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_short_url
      @short_url = ShortUrl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def short_url_params
      params.require(:short_url).permit(:title, :url, :short_url, :jmp_url)
    end
end

