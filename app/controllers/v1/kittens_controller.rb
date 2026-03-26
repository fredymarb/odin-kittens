class V1::KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    render json: @kittens
  end

  def show
    @kitten = Kitten.find(params[:id])
    render json: @kitten
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      render json: { status: "success", kitten: @kitten }
    else
      render json: {
        status: "error",
        errors: @kitten.errors.full_messages
      },
      status: :unprocessable_entity
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      render json: { status: "success", kitten: @kitten }
    else
      render json: {
        status: "error",
        errors: @kitten.errors.full_messages
      },
      status: :unprocessable_entity
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    render json: { status: "deleted", id: @kitten.id }
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
