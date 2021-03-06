require_dependency "person/application_controller"

module Person
	class SystemsController < ApplicationController
		layout 'layouts/material'
		before_action :set_systems, only: [:index, :create, :destroy, :update]
		before_action :set_system, only: [:edit, :destroy, :update]

		def index
			authorize @systems
		end

		def new
			@system = System.new
			authorize @system
		end

		def create
			@system = System.new(system_params)
			authorize @system
			@system.save
		end

		def edit
		end

		def update
			authorize @system
			@system.update(system_params)
		end

		def destroy
			authorize @system
			if @system.destroy
				redirect_to action: 'index'
			end
		end

		private

		def system_params
			params.require(:system).permit(:name, :code,:status)
		end

		def set_systems
			@systems = System.all
		end

		def set_system
			@system = System.find(params[:id])
		end
	end
end
