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

class RolesController < ApplicationController
  #skip_authorization_check
  load_and_authorize_resource
  # GET /roles
  # GET /roles.json
  def index
    @title = "Roles"
    @roles = Role.order(:list_position).all


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.json
  def show

    @role = Role.find(params[:id])
    @title = "Role - #{@role.name}"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.json
  def new
    @role = Role.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @role }
    end
  end

  # GET /roles/1/edit
  def edit

    @role = Role.find(params[:id])
    @title = "Editing Role "+@role.name.camelcase
  end

  # POST /roles
  # POST /roles.json
  def create
    @title = t('role.t_new')
    @role = Role.new
    if can? :create, Role
      role.create(role_params) if can? :manage, Role
    end
    role.update!(role_params)
    respond_to do |format|
      if @role.save
        format.html { redirect_to roles_url, notice: 'Role was successfully created.' }
        format.json { render json: @role, status: :created, location: @role }
      else
        format.html { render action: "new" }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.json
  def update
    @role = Role.find(params[:id])
    role.update!(role_params)
    #@role.dynamic_attributes :all if can? :manage, Role

    respond_to do |format|
      if role.update!(role_params)
        format.html { redirect_to roles_url, notice: 'Role was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :no_content }
    end
  end
end

private

def role_params
  params.require(:role).permit(:name, :list_position, :enabled, :permission_ids, :permission_id)
end