require 'rubygems'
require 'base64'
require 'rest_client'
require 'openssl'
require 'cgi'

class CloudStackHelper
  CONFIGURABLE_ATTRIBUTES = [
    :response,
    :secret_key,
    :api_key,
    :api_url
  ]
  attr_accessor *CONFIGURABLE_ATTRIBUTES

  def initialize(options = {})
    CONFIGURABLE_ATTRIBUTES.each do |attribute_name|
      self.send("#{attribute_name}=", options[attribute_name]) if options.has_key?(attribute_name)
    end
  end

  # To generate the signature:
  # 1. For each field-value pair (as separated by a ‘&’) in the Command String, URL encode each value so that it can be safely sent via HTTP GET.
  #     NOTE: Make sure all spaces are encoded as “%20” rather than “+”.
  # 2. Lower case the entire Command String and sort it alphabetically via the field for each field-value pair.  
  # 3. Take the sorted Command String and run it through the HMAC SHA-1 hashing algorithm 
  #    with the user’s Secret Key.  
  # 4. Base64 encode the resulting byte array in UTF-8 so that it can be safely transmitted via HTTP.  
  def generate_signature(params)
    params.each { |k,v| params[k] = CGI.escape(v.to_s).gsub('+', '%20').downcase }
    sorted_params = params.sort_by{|key,value| key.to_s}

    data = parameterize(sorted_params, false)

    hash = OpenSSL::HMAC.digest('sha1', @secret_key, data)
    signature = Base64.b64encode(hash).chomp
  end

  def parameterize(params, escape=true)
    params = params.collect do |k,v| 
      if escape
        "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"
      else
        "#{k}=#{v}"
      end
    end
    params.join('&')
  end

  def generate_params_str(params)
    unless params[:response]
      params[:response] = @response if @response
    end
    params[:apikey] = @api_key
    params[:signature] = generate_signature(params.clone)
    str = parameterize(params)
  end

  def request(params, api_url, method = :get)
    case method
    when :get
      url = api_url + "?" + generate_params_str(params.clone)
      response = RestClient.send(method, url)
    else
      raise "HTTP method #{method} not supported"
    end
    response    
  end

  def get(params, api_url = nil)
    api_url ||= @api_url
    request(params, api_url, :get)
  end
end
