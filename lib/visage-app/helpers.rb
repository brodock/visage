#!/usr/bin/env ruby

require 'sinatra/base'

module Sinatra
  module LinkToHelper
    # from http://gist.github.com/98310
    def link_to(url_fragment, mode=:path_only)
      case mode
      when :path_only
        base = request.script_name
      when :full_url
        if (request.scheme == 'http' && request.port == 80 ||
            request.scheme == 'https' && request.port == 443)
          port = ""
        else
          port = ":#{request.port}"
        end
        base = "#{request.scheme}://#{request.host}#{port}#{request.script_name}"
      else
        raise "Unknown script_url mode #{mode}"
      end
      "#{base}#{url_fragment}"
    end
  end

  module PageTitleHelper
    def page_title(string)
      @page_title = string
    end

    def include_page_title
      @page_title ? "#{@page_title} | Visage" : "Visage"
    end
  end

  module RequireJSHelper
    def require_js(filename)
      @js_filenames ||= []
      @js_filenames << filename
    end

    def include_required_js
      if @js_filenames
        @js_filenames.map { |filename|
          "<script type='text/javascript' src='#{link_to("/javascripts/#{filename}.js")}'></script>"
        }.join("\n")
      else
        ""
      end
    end
  end
end
