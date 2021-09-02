class UrlsController < ApplicationController
  before_action :set_url, only: %i[ show edit update destroy ]

  # GET /urls or /urls.json
  def index
    @urls = Url.all
  end

  # GET /urls/1 or /urls/1.json
  def show
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # GET /urls/1/edit
  def edit
  end

  # POST /urls or /urls.json
  def create

    #I check if url exists
    @existsUrl = Url.find_by(:full => params[:url][:full])

    if @existsUrl.present?
      puts 'si existe'
    else
      #save url
      @url = Url.new(url_params)

      #generate token
      @url.token = rand(36**8).to_s(36)
      #
      respond_to do |format|
        if @url.save
          format.html { redirect_to @url, notice: "Url was successfully created." }
          format.json { render :show, status: :created, location: @url }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @url.errors, status: :unprocessable_entity }
        end
      end
    end


  end

  # PATCH/PUT /urls/1 or /urls/1.json
  def update
    respond_to do |format|
      if @url.update(url_params)
        format.html { redirect_to @url, notice: "Url was successfully updated." }
        format.json { render :show, status: :ok, location: @url }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1 or /urls/1.json
  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url, notice: "Url was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    #var
    @searchedUrl = Url.find_by(:token => params[:token])

    #if I found the url, then redirect
    if @searchedUrl.present?
        #I search visitor
        @visitor = Visitor.find_by(:ip => request.remote_ip)
          #If visitor doesn't exists, I will crate
          unless @visitor.present?
              @visitor = Visitor.create(:ip => request.remote_ip)
          end
        #save data
        Visit.create(:url_id => @searchedUrl.id, :visitor_id => @visitor.id)
        redirect_to @searchedUrl.full
      else
        redirect_to root_path
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def url_params
      params.require(:url).permit(:full, :token, :short)
      # params.fetch(:url, {})
    end
end
