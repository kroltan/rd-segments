class SegmentsController < ApplicationController
	before_action :authenticate_admin!

	def index
		page_size = Rails.configuration.paging["segments"]
		@segments = Segment.all
			.limit(page_size)
			.offset(page_size * params.fetch(:page, 0))
	end

	def query
		table = Contact
		raw_query = params[:q] || Segment.find(params[:id]).query
		sql = SegmentQuery.from_json table, raw_query
		render json: Contact.where(sql.to_sql)
	end
	
	def show
		@segment = Segment.find(params[:id])
		@sql = SegmentQuery.from_json Contact, @segment.query
	end

	def new
		@segment = Segment.new
	end

	def edit
		@segment = Segment.find(params[:id])
	end

	def create
		@segment = Segment.new(segment_params)
		if @segment.save
			redirect_to @segment
		else
			render 'new'
		end
	end

	def update
		@segment = Segment.find(params[:id])
		if @segment.update(segment_params)
			redirect_to @segment
		else
			render 'edit'
		end
	end

	def destroy
		@segment = Segment.find(params[:id])
		@segment.destroy

		redirect_to segments_path
	end

	private
	def segment_params
		params.require(:segment).permit(:name, :query)
	end
end
