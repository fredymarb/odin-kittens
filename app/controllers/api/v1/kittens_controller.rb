class Api::V1::KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      redirect_to [ :api, :v1, @kitten ], notice: "Kitten created!"
    else
      render :new, status: :unprocessable_entity, alert: "Oops failed to create kitten."
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      redirect_to [ :api, :v1, @kitten ], notice: "Kitten updated successfully."
    else
      render :edit, status: :unprocessable_entity, alert: "Oops, failed to update kitten."
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    redirect_to [ :api, :v1, :kittens ], notice: "#{@kitten.name} deleted successfully!"
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
