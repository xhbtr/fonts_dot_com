require "fonts_dot_com/version"
require "fonts_dot_com/config"
require "fonts_dot_com/auth_param"
require "fonts_dot_com/request"
require "fonts_dot_com/response"

module FontsDotCom

  class << self

    ##
    #
    # Projects
    #
    ##
    
    # http://www.fonts.com/web-fonts/developers/api/list-projects
    def list_projects
      FontsDotCom::Request.fire({
        message:  '/rest/json/Projects/', # TODO 
        method:   :get
      })
    end

    # http://www.fonts.com/web-fonts/developers/api/add-project
    def add_project(name)
      unless ( name.is_a? String ) && ( name.length > 0 )
        raise ArgumentError
      end
      
      data = {
        wfsproject_name: name
      }
      
      response = FontsDotCom::Request.fire({
        message:  '/rest/json/Projects/', # TODO 
        method:   :post,
        data:     data
      })
    end
   
    # http://www.fonts.com/web-fonts/developers/api/delete-project
    def delete_project(project_id)
      raise ArgumentError unless project_id
      
      data = {
        wfsproject_name: name
      }
      
      response = FontsDotCom::Request.fire({
        message:  "/rest/json/Projects/?wfspid=#{project_id}",
        method:   :delete
      })
    end



    ###
    # 
    # Project Fonts
    #
    ###

    def list_project_fonts(project_id, options={})
      # `project_id` should be fonts.com's project ID (returned as
      # `ProjectKey` by the API.)
      raise ArgumentError unless project_id
      
      offset_and_limit = ''
      if options[:offset] 
        offset_and_limit += ( '&wfspstart=' + options[:offset].to_s )
      end
      if options[:limit]
        offset_and_limit += ( '&wfsplimit=' + options[:limit].to_s )
      end

      response = FontsDotCom::Request.fire({
        message:  "/rest/json/Fonts/?wfspid=#{project_id}#{offset_and_limit}",
        method:   :get
      })
    end
    
    def add_font(options)
      project_id  = options[:project_id]
      font_id     = options[:font_id]
      publish     = options.has_key?(:publish) ? options[:publish] : true

      raise ArgumentError unless project_id && font_id
      
      data = {
        wfsfid: font_id
      }

      response = FontsDotCom::Request.fire({
        message:  "/rest/json/Fonts/?wfspid=#{project_id}",
        method:   :post,
        data:     data
      })
    end

  end

end
