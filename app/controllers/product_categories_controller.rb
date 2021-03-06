# MyITCRM - Repairs Business CRM Software
# Copyright (C) 2009-2014  Glen Vanderhel
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

class ProductCategoriesController < ApplicationController
  skip_authorization_check

  def index
    @product_categories = ProductCategory.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @product_categories.map(&:name)
  end

  private

  def prodcat_params
    params.require(:product_categories).permit(:name, :created_at, :updated_at)
  end
end
