class BandsController < ApplicationController

    def index
        @bands = Band.all.includes(:name)
        render :index
    end

    def new
        @band = Band.new
        render :new
    end

    def edit
        @band = Band.find(params[:id])
        render :edit
    end

    def create
        @band = Band.new(band_params)

        if @band
            redirect_to bands_url(@band)
        else
            flash.now[:errors] = @band.errors.full_messages
            render :new
        end
    end

    def show
        @band = Band.find_by(name: params[:name])

        if @band
            render :show
        else
            redirect_to bands_url
        end

    end

    def destroy
        @band = Band.find(params[:id])
        @band.destroy
        redirect_to bands_url
    end

    def update
        @band = Band.find(params[:id])

        if @band.update(band_params)
            redirect_to bands_url(@band)
        else
            flash.now[:errors] = @band.errors.full_messages
            render :edit
        end
    end

    private

    def band_params
        params.require(:band).permit(:name)
    end

end