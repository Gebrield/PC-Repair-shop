class Task < ActiveRecord::Base
	belongs_to :work_order, :touch => true
	belongs_to :user
	validates_presence_of :work_order_id, :description, :title
end
