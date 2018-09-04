class Service < ApplicationRecord
  filterrific(
    default_filter_params: {sorted_by: 'created_at_desc'},

    available_filters: [
      :with_name,
      :sorted_by,
      :with_country,
      :with_price,
      :with_cost
    ]
  )

  #  Filters services with price (more than)
  scope :with_price, -> (price) {where("price > ?", price)}

  #  Filters services with cost (more than)
  scope :with_cost, -> (cost) {where("cost > ?", cost)}

  # Filters services with country selected
  scope :with_country, -> (country) {where(country: country)}

  # Filters services whose name matches the query
  scope :with_name, -> (query) {where("name ILIKE ?", "#{query}%")}
  
  # Order in desc or asc
  scope :sorted_by, -> (sort_option) {
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'

    case sort_option.to_s
    when /^created_at_/
      order("created_at #{ direction}")
    when /^name_/
      order("name #{direction}")
    when /^country_/
      order("country #{direction}")
    when /^price_/
      order("price #{direction}")
    when /^cost_/
      order("cost #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Name (z-a)', 'name_desc'],
      ['Country (a-z)', 'country_name_asc'],
      ['Country (z-a)', 'country_name_desc'],
      ['Price (lowest first)', 'price_asc'],
      ['Price (highest first)', 'price_desc'],
      ['Cost (lowest first)', 'cost_asc'],
      ['Cost (highest first)', 'cost_desc'],
      ['Created date (oldest first)', 'created_at_asc'],
      ['Created date (newest first)', 'created_at_desc']
    ]
  end

  def self.options_for_select
    bigArray = []
    
    order('country').each do |object|
      smallArray = [object.country]
      if smallArray.in?(bigArray) === false
        bigArray << smallArray
      end        
    end

    return bigArray
  end
end
