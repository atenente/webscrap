class SearchService
  def initialize(params)
    @params = params
    @model = params[:controller].singularize.capitalize.constantize
  end

  def call
    return @model.all if @params[:search_word].blank?

    columns = @model.column_names.reject { _1 == "id" } # Remove 'id' da busca
    conditions = columns.map { |col| "#{@params[:controller]}.#{col}::TEXT ILIKE :search" }.join(" OR ")
    @profiles = @model.where(conditions, search: "%#{@params['search_word']}%")
  end
end