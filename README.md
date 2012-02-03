# cloudstack_helper
cloudstack_helper is a simple ruby library that helps making request to CloudStack API easier. With cloudstack_helper, you only have to specify the command the parameters for the request and it will handle everything for you.

## Library Usage

```ruby
     require 'cloudstack_helper'

     API_URL = "http://mycloudstack:8080/client/api"
     API_KEY = "WiUVlx74PpVE8w7z7hasgJjiOQvMsMWLFL3A054D_IPeSxxcm1PoNlpYlA2ujGSJBGiS2uBcG0GoLwLisosDCA"
     SECRET_KEY = "uqzgrfMXnYSVvUi2XahgiDgvtXBemILs_npqi90KiYw0OKjyETOvQTtYg093EUrHSLZJEnI3lV1z9PrQmv2SxQ"
     cs_helper = CloudStackHelper.new(:api_key => API_KEY, :secret_key => SECRET_KEY, :api_url => API_URL)

     params = {:command => "listZones"}
     puts cs_helper.get(params).body

     params[:response] = "json"
     puts cs_helper.get(params).body
```

## Executable Script Usage
```
     cloudstack_rb -x listUsers domainid=1
     cloudstack_rb -x deployVirtualMachine serviceofferingid=12 templateid=4 zoneid=1 displayname=ohyea
```
