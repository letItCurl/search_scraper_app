class KeywordsController < ApplicationController
  before_action :set_keyword, only: %i[ show destroy ]

  # GET /keywords or /keywords.json
  def index
    @keywords = current_user.keywords.all
  end

  # GET /keywords/1 or /keywords/1.json
  def show
  end

  # GET /keywords/new
  def new
    @keyword = current_user.keywords.new
  end

  # POST /keywords or /keywords.json
  def create
    @keyword = current_user.keywords.new(keyword_params)

    respond_to do |format|
      if @keyword.save
        Keyword::ProcessingJob.perform_later(keyword_id: @keyword.id)
        format.html { redirect_to @keyword, notice: "Keyword was successfully created." }
        format.json { render :show, status: :created, location: @keyword }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1 or /keywords/1.json
  def destroy
    @keyword.destroy!

    respond_to do |format|
      format.html { redirect_to keywords_path, status: :see_other, notice: "Keyword was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword
      @keyword = Keyword.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def keyword_params
      params.expect(keyword: [ :name, :total_ads, :total_links, :html_cache, :user_id ])
    end
end
