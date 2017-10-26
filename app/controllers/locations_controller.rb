class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def show
    @location = Location.find_by(id: params[:id])
  end

  def edit
    @location = Location.find_by(id: params[:id])
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to location_path(@location)
    else
      render :new
    end
  end

  def update
    @location = Location.find_by(id: params[:id])

    if @location.update(location_params)
      redirect_to location_path(@location.id)
    else
      render :edit
    end
  end

  def destroy
    @location = Location.find_by(id: params[:id])

    if @location.destroy
      redirect_to root_path
    else
      redirect_to location_path(@location.id)
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :polygon_coordinates)
  end
end