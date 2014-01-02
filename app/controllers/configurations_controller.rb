class ConfigurationsController < ApplicationController
	def index
		@configuration = StoreConfiguration.find(1)
	end

	def update
		set_configuration

		respond_to do |format|
      if @configuration.update(configuration_params)
        format.html { redirect_to '/configurations', notice: 'Configurations have been successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render controller: 'configurations' }
        format.json { render json: @configuration.errors, status: :unprocessable_entity }
      end
    end
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_configuration
      @configuration = StoreConfiguration.find(1)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def configuration_params
      params[:store_configuration]
    end

end
