class LabelCategoriesController < ApplicationController
  before_action :set_label_category, only: %i[ show edit update destroy ]

  # GET /label_categories or /label_categories.json
  def index
    @label_categories = LabelCategory.all
  end

  # GET /label_categories/1 or /label_categories/1.json
  def show
  end

  # GET /label_categories/new
  def new
    @label_category = LabelCategory.new
  end

  # GET /label_categories/1/edit
  def edit
  end

  # POST /label_categories or /label_categories.json
  def create
    @label_category = LabelCategory.new(label_category_params)

    respond_to do |format|
      if @label_category.save
        format.html { redirect_to @label_category, notice: "Label category was successfully created." }
        format.json { render :show, status: :created, location: @label_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @label_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /label_categories/1 or /label_categories/1.json
  def update
    respond_to do |format|
      if @label_category.update(label_category_params)
        format.html { redirect_to @label_category, notice: "Label category was successfully updated." }
        format.json { render :show, status: :ok, location: @label_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @label_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /label_categories/1 or /label_categories/1.json
  def destroy
    @label_category.destroy
    respond_to do |format|
      format.html { redirect_to label_categories_url, notice: "Label category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_label_category
      @label_category = LabelCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def label_category_params
      params.require(:label_category).permit(:name)
    end
end
