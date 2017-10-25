class Location < ApplicationRecord
  attr_accessor :polygon_coordinates

  validates_presence_of :name, :area

  before_validation :set_polygon

  def set_polygon
    if polygon_coordinates.present?
      coordinates = polygon_coordinates.split(',').each_slice(2).map{|l| "#{l.first} #{l.last}"}.join(', ')
      first_element = coordinates.split(',').first
      self.area = "POLYGON((#{coordinates}, #{first_element}))"
    end
  end
end