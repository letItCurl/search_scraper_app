class KeywordsUploadsController < ApplicationController
  before_action :set_keywords_upload, only: %i[ show edit update destroy ]

  # GET /keywords_uploads or /keywords_uploads.json
  def index
    @keywords_uploads = KeywordsUpload.all
  end

  # GET /keywords_uploads/1 or /keywords_uploads/1.json
  def show
  end

  # GET /keywords_uploads/new
  def new
    @keywords_upload = KeywordsUpload.new
  end

  # GET /keywords_uploads/1/edit
  def edit
  end

  # POST /keywords_uploads or /keywords_uploads.json
  def create
    @keywords_upload = KeywordsUpload.new(keywords_upload_params)

    respond_to do |format|
      if @keywords_upload.save
        format.html { redirect_to @keywords_upload, notice: "Keywords upload was successfully created." }
        format.json { render :show, status: :created, location: @keywords_upload }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @keywords_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keywords_uploads/1 or /keywords_uploads/1.json
  def update
    respond_to do |format|
      if @keywords_upload.update(keywords_upload_params)
        format.html { redirect_to @keywords_upload, notice: "Keywords upload was successfully updated." }
        format.json { render :show, status: :ok, location: @keywords_upload }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @keywords_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords_uploads/1 or /keywords_uploads/1.json
  def destroy
    @keywords_upload.destroy!

    respond_to do |format|
      format.html { redirect_to keywords_uploads_path, status: :see_other, notice: "Keywords upload was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keywords_upload
      @keywords_upload = KeywordsUpload.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def keywords_upload_params
      params.expect(keywords_upload: [ :status, :user_id ])
    end
end
