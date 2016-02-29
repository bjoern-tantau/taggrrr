class Directory < ActiveRecord::Base
  belongs_to :path
  belongs_to :parent, :class_name => 'Directory'
  has_many :children, :class_name => 'Directory', :foreign_key => 'parent_id'
  has_many :images, dependent: :destroy
end
