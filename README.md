# cloudstack_helper
cloudstack_helper is a simple ruby library that helps making request to CloudStack API easier. With cloudstack_helper, you only have to specify the command and the parameters for the request, and it will handle everything for you.

## Installation
It&apos;s hosted on rubygems.org

    sudo gem install cloudstack_helper


## Library Usage

```ruby
     require 'rubygems'
     require 'cloudstack_helper'

     API_URL = "http://mycloudstack:8080/client/api"
     API_KEY = "WiUVlx74PpVE8w7z7hasgJjiOQvMsMWLFL3A054D_IPeSxxcm1PoNlpYlA2ujGSJBGiS2uBcG0GoLwLisosDCA"
     SECRET_KEY = "uqzgrfMXnYSVvUi2XahgiDgvtXBemILs_npqi90KiYw0OKjyETOvQTtYg093EUrHSLZJEnI3lV1z9PrQmv2SxQ"
     cs_helper = CloudStackHelper.new(:api_key => API_KEY, :secret_key => SECRET_KEY, :api_url => API_URL)

     params = {:command => "listZones"}
     result = cs_helper.get(params).body
     puts result

     params[:response] = "json"
     result = cs_helper.get(params).body
     puts result

     params.merge!({:command => 'deployVirtualMachine', :serviceofferingid => 12, :templateid => 4,  :zoneid => 1, :displayname => 'my shiny vm'})
     result = cs_helper.get(params).body
     puts result

```

## Script Usage
```
    Usage: cloudstack_rb -c conf -x command param1=value1 param2=value2
      -x, --execute COMMAND    command to execute. See CloudStack API for list of commands.
      -c, --conf FILE          YAML config file that stores api and secret key.
      -p, --pretty             Pretty print the response of the API call.
      -h, --help               Show this message.

```

####Examples
```
    cloudstack_rb -x listUsers domainid=1
    cloudstack_rb -x listUsers domainid=1 response=json
    cloudstack_rb -x listUsers domainid=1 response=json -p
    cloudstack_rb -x deployVirtualMachine serviceofferingid=12 templateid=4 zoneid=1 displayname=ohyea
```

####Configuration
By default, if you don't specify a config file, cloudstack_rb assumes there is a config file in the current working directory under the name 'cloudstack.yml'
The config file should look like this

```
    api_url: "http://mycloudstack:8080/client/api"
    api_key: "WiUVlx74PpVE8w7z7J7gtojiOQasdaFL3A054D_IPeSxxcm1PadgasdgujGSJBGiS2uBcG0GoLwLisosDCA"
    secret_key: "uqzgrfMXnYSVvUiasdgj0DgvtXBemILs_npqi90Ki0xigOKjagvQTtYg093EUrHSLZJEnI3lV1z9PrQmv2SxQ"
```
