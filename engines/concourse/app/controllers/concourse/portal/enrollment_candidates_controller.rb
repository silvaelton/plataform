module Concourse
  class Portal::EnrollmentCandidatesController < ApplicationController
    layout 'layouts/concourse/project'
    before_action :candidate_session
    before_action :set_project, except: [:show]
    before_action :set_enrollment, except: [:show]
    def new
      @candidate = @enrollment.enrollment_candidates.new
    end

    def create
      @candidate = @enrollment.enrollment_candidates.new(set_params_enrollment)
      @candidate.candidate_id = session[:candidate_id]
      
      if @candidate.save
        redirect_to portal_candidates_path
      else
        render action: 'new'
      end
    end

    def show
      @candidate = EnrollmentCandidate.find_by_candidate_id(session[:candidate_id])
      render layout: "layouts/concourse/candidate"

    end

    private

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_enrollment
      @enrollment = @project.enrollments.find(params[:enrollment_id])
    end

    def set_params_enrollment
      params.require(:enrollment_candidate).permit(:properties).tap do |whitelisted|
        whitelisted[:properties] = params[:enrollment_candidate][:properties]
      end
    end

    def candidate_session
      redirect_to portal_candidates_path unless session[:candidate_id].present?
    end
  end
end