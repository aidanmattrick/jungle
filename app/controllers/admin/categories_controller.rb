class Admin::CategoriesController < AdminController
  before_action :set_admin_category, only: [:show]

  # GET /admin/categories
  # GET /admin/categories.json
  def index
    @admin_categories = Category.all
  end

  # GET /admin/categories/new
  def new
    @admin_category = Category.new
  end

  # POST /admin/categories
  # POST /admin/categories.json
  def create
    @admin_category = Category.new(admin_category_params)

    respond_to do |format|
      if @admin_category.save
        format.html { redirect_to admin_categories_path, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @admin_category }
      else
        format.html { render :new }
        format.json { render json: @admin_category.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_category
      @admin_category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_category_params
      params.require(:category).permit(:name)
    end
end
