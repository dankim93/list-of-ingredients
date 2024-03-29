class DrinksController < ApiController
  before_action :set_drink, only: [:show, :update, :destroy]

  # GET /drinks
   def index
     @drinks = Drink.select("id, title").all
     render json: @drinks.to_json
   end

   # GET /drinks/:id
   def show
     @drink = Drink.find(params[:id])
     render json: @drink.to_json(:include => { :ingredients => { :only => [:id, :description] }})
   end

  # POST /drinks
  def create
    @drink = Drink.new(drink_params)

    if @drink.save
      render json: @drink, status: :created, location: @drink
    else
      render json: @drink.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /drinks/1
  def update
    if @drink.update(drink_params)
      render json: @drink
    else
      render json: @drink.errors, status: :unprocessable_entity
    end
  end

  # DELETE /drinks/1
  def destroy
    @drink.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drink
      @drink = Drink.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def drink_params
      params.require(:drink).permit(:title, :description, :steps, :source)
    end
end
