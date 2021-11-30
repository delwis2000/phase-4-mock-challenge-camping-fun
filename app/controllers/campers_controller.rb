class CampersController < ApplicationController
    rescue_from ActiceRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiceRecord::RecordInvalid, with: :record_invalid
    
    #GET#
    def index
        campers = Camper.all  
        render json: campers, statut: :ok
    end

    def show
        camper = Camper.find_by(id:params[:id])
        if camper
            render json: camper, serializer: CamperActivitySerializer, status: :ok
        else     
            render json: {error: "Camper not found"}, status: :not_found
        end
    end

    #POST
    def create
        camper = Camper.create(camper_params)
         if camper.valid?  
            render json: camper, status: :created
        else   
            render json: {errors: camper.errors.full_messages}, status: :unprocessable_entity
        end
        
    end

    # #PATCH
    # def update
    #     camper = Camper.find_by(id: params[:id])
    #     if camper
    #         camper.update(camper_params)
    #         render json: camper
    #     else   
    #         render json: {error: "Camper not found"}, status: :not_found
    #     end
    # end



    # private, we need to do the params 
    private
    def camper_params
    params.permit(:name, :age)
    end

    def render_not_found
        render json: {error: "Camper not found"}, status: :not_found
    end

    def record_invalid(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
