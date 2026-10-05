[<img src="https://about.mappls.com/images/mappls-b-logo.svg" height="80"/> </p>](https://www.mapmyindia.com/api)

# [Custom Search Nearby Records](Custom-Search-Nearby-Records)

## Introduction

This is an easy to integrate nearby search by MAPPLS.

To search the nearby records as per specified record types from the Custom Nearby Record Search database around the provided reference location.

The plugin will search  the results based on Custom Search database wherein the data is managed by you through the use of simple APIs which perform basic CRUD operations that can be performed on database applications: Create (Add Records), Update (Update Records), and Delete(Delete Records).

The plugin will facilitate you in various ways:

- Include the Nearby Search method with or without an interactive Map component.
- Method to initiate nearby search across all categories of places.
- Compatible with our other MAPPLS UI widgets For eg Place Search, place Picker and Directions etc.

We're helping any website or app developer to easily integrate this information, for the benefit of your users and visitors. 

Classes used for nearby Finder search is `MapplsNearbyRecordFinderManager`. Create a `MapplsNearbyRecordFinderManager` object using your rest key or alternatively, you can place your rest key in the `MapplsRestKey` key of your application's Info.plist file, then use the shared instance of `MapplsNearbyRecordFinderManager` class.

To perform nearby Finder search use `MapplsNearbyFinderOptions` class to pass recordType and a reference location as parameters to get Nearby finder search results with an option to pass region in parameter `withRegion`, which is an enum of type `MapplsRegionType`. If no value is passed for region, It will take default value which is India.

`MapplsRegionType` is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.

## [Dependencies](#Dependencies)

`MapplsAPICore` and `MapplsAPIKit` are dependencies which will require to use this SDK.

## Version History
| Version | Last Updated |  Release Note |
| --- | --- |  --- |
| 3.0.1 | - |  Updated dependency versions. Minimum versions set to `MapplsAPICore (2.1.4)`, `MapplsAPIKit (2.0.8)`. |
| 3.0.0 | 05 Oct 2026 |  Nearby search migrated to OAuth 2 based authentication. Added POI Along Route search. Project restructured with a bundled `Sample` app. |
| 2.0.3 | 25 Feb 2025 |  'bitcode' disabled to support Xcode 15 |
| 2.0.2 | 13 Oct 2023 |  Added request parameter `page` of type `int` in  `MapplsNearbyFinderSearchOptions |
| 2.0.1 | 02 Jan 2023 |  Dependency version increaded to fix crash. Minimum versions set to `MapplsAPICore (1.0.4)`, `MapplsAPIKit(2.0.8)`. |
| 2.0.0 | 14 June 2022 |  Initial Mappls Release. |

## [Installation](#Installation)

This library is available through `CocoaPods`. To install, simply add the following line to your `podfile`:

```ruby
pod 'MapplsNearbyFinder', '3.0.0'
```

On running `pod install` command it will automatically download `MapplsNearbyFinder` and dependent frameworks.

## [Authorization](#Authorization)

From version `3.0.0`, nearby search is authenticated using OAuth 2.

### [MapplsAPICore](#MapplsAPICore)
It is required to set MAPPLS's keys to use any MAPPL's SDK. Please see [here](https://github.com/mappls-api/mappls-ios-sdk#Table-Of-Content) to achieve this.

## [Usage](#Usage)

Method can be implemented in simple way.

Create a `MapplsNearbyRecordFinderManager` object using your rest key or alternatively, you can place your rest key in the `MapplsRestKey` key of your application's Info.plist file, then use the shared instance of MapplsNearbyRecordFinderManager` class.

 ```swift
let locations = CLLocation(latitude: 28.00, longitude: 77.98)
let nearbyFinderSearchOptions = MapplsNearbyFinderOptions(recordType: "", refLocation: locations)
let nearbyFinderSearchManager = MapplsNearbyRecordFinderManager.shared
nearbyFinderSearchManager.getSearchResults(nearbyFinderSearchOptions) { (response, error) in
    if let error = error {
        print("Error")
    } else if let response = response, let records = response.records {
        print("Resonse: \(records)")
    } else {
        self.showAlertController(message: "No Results")
    }
}
```

### Mandatory Parameters

1. `recordType (String)` : The category or class of the record, referenced by a defined set of category codes from client.
2. `location (double, double)` : Provides the location around which the search will be performed. e.g. location(28.454,77.435)

The refLocation parameter can also accept `mapplsPin` as reference location. 
Example: location("1T182A")
 
### Optional Parameters

1. `radius (Integer)` : The radius in meters for radial search. Default radius: 10000 meters.
2. `bounds (String)(x1,y1;x2,y2)` : Allows the developer to send in map bounds to provide a nearby search of the geobounds. where x1,y1 are the lat lng of the bound. The bounds are set from topLeft to bottomRight (North-West to South-East). Example :28.639256,77.211133;28.625214,77.237483.
3. `sortBy (String)` : Provides configured sorting operations for the client on cloud. Below are the available sorts:
		-  dist:asc & dist:desc - will sort data in order of distance from the passed location (default).
		-  name:asc & name:desc - will sort the data on alphabetically bases.
    ``` swift 
	if let nearbyFinderSortBy = UserDefaultsManager.nearbyFinderSortBy {
            let sortByType = MMISearchByType(nearbyFinderSortBy)
            if sortByType == .importance {
                nearbyFinderSearchOptions.sortBy = RecordFinderSortby(sortBy: .importance)
            } else {
                if let nearbyFinderOrderBy = UserDefaultsManager.nearbyFinderOrderBy {
                    nearbyFinderSearchOptions.sortBy = RecordFinderSortByDistanceWithOrder(orderBy: MMISortByOrderType(rawValue: nearbyFinderOrderBy))
                }
            }
        }
	```
4. `filter (String)` : This field accepts mapplsPin and restricts the search to the provided administrative area mapplsPin.
    Example : filter("cop:TAVI5S").
    
	``` swift 
        if let nearbyFinderFilterMapplsPin = UserDefaultsManager.nearbyFinderFilterMapplsPin {
            nearbyFinderSearchOptions.filters = [MapplsNearbyRecordFinderKeyValueFilter(filterKey: "cop", filterValues: [nearbyFinderFilterMapplsPin])]
        }
	```

5. `createdTime (Int)`: This is an epoch value in seconds. All records
whose creation time is 'greater than' the provided input time here are responded back in results. 
Example: createdTime(1628855941)
6. `modifiedTime (Int)`: This is an epoch value in seconds.All records whose modified time is 'greater than' the provided input time here are responded back in results. 
Example: modifiedTime(1628855941)

7. `itemCount (Int)`: Number of items per page. Minimum is 1; Default is 10.


### Response Parameters

You will find below useful properties in suggestion object :

-   `latitude` : Latitude of the location.
-   `longitude` : Longitude of the location.
-   `distance` : Provides the distance from the provided location bias in meters.
-   `recordMapplsPin` : Place Id of the location 6-char alphanumeric.
-   `customNote` : Any string Type.
-   `createdOn:` : This is an epoch value in seconds. All records
whose creation time is 'greater than' the provided input time here are responded back in results. 
Example: `createdTime=1628855941`.
-   `modifiedOn:`  This is an epoch value in seconds. All records
whose creation time is 'greater than' the provided input time here are responded back in results. 
Example: `modifiedTime=1628855941`
-   `isExpired:`  false. If set true while adding the record in addRecord api, that particular record will not be searchable.
-   `recordType (String):`  Type of category used while adding the record.
-   `orderIndex(Int)`:  The order where this result should be placed.
- `extendedInfo` : The value added in key:value pairs while adding the records will be returned in this parameter.


# [Mappls Poi Along Route Record](mappls_poi_along_route)

#### Swift
```Swift
let alongTheRouteOption = MapplsNearbyFinderAlongTheRouteOptions(path: routeGeometry, recordType: "WFHORWFO")
alongTheRouteOption.geometryType = .polyline6
let _ = MapplsNearbyFinderAlongTheRouteManager.shared.getAlongTheRoute(alongTheRouteOption) { (response, error) in
    if let error = error {
        // Error to be handled. 
    } else if response == nil {
        // error
    } else if let response = response {
        // Your Logic ...
    }
}
```

### Mandatory Parameters
1. `path(String)`: This parameter takes the encoded route along which records have to be searched.
2. `recordType(String)`: The category or class of the record, referenced by a defined set of category codes from client.

### Optional Parameters
1. `sort(Bool)`: Gets the sorted records along route.
2. `geometryType(GemoetryType)`: Type of geometry encoding. **Below are the available geometries:**
     - GemoetryType.polyline5
     - GemoetryType.polyline6 (Default)
     - GemoetryType.base64
3. `page(Int)`: Used for pagination. By default, a request returns maximum 10 results and to get the next 10 or so on pass the page value accordingly. Default is 1.
4. `buffer(Int)`: Buffer of the road. Minimum value is 25, maximum is 1000 and default is 25.

### Response Parameter
1. `responseCode(Int)`
2. `pageInfo(MapplsNearbyFinderAlongTheRouteResponsePageInfo)`
3. `suggestedPOIs([MapplsNearbyFinderAlongTheRouteResponseData])`

#### MapplsNearbyFinderAlongTheRouteResponseData
1. `distance(Int)`
2. `customNote(String)`
3. `createdOn(Int)`
4. `recordType(String)`
5. `modifiedOn(String)`
6. `latitude(Double)`
7. `longitude(Double)`
8. `address(String)`
9. `recordId(String)`
10. `orderIndex(Int)`
11. `extendedInfo([String: String])`



<br><br><br>

## Our many happy customers:

![](https://www.mapmyindia.com/api/img/logos1/PhonePe.png)![](https://www.mapmyindia.com/api/img/logos1/Arya-Omnitalk.png)![](https://www.mapmyindia.com/api/img/logos1/delhivery.png)![](https://www.mapmyindia.com/api/img/logos1/hdfc.png)![](https://www.mapmyindia.com/api/img/logos1/TVS.png)![](https://www.mapmyindia.com/api/img/logos1/Paytm.png)![](https://www.mapmyindia.com/api/img/logos1/FastTrackz.png)![](https://www.mapmyindia.com/api/img/logos1/ICICI-Pru.png)![](https://www.mapmyindia.com/api/img/logos1/LeanBox.png)![](https://www.mapmyindia.com/api/img/logos1/MFS.png)![](https://www.mapmyindia.com/api/img/logos1/TTSL.png)![](https://www.mapmyindia.com/api/img/logos1/Novire.png)![](https://www.mapmyindia.com/api/img/logos1/OLX.png)![](https://www.mapmyindia.com/api/img/logos1/sun-telematics.png)![](https://www.mapmyindia.com/api/img/logos1/Sensel.png)![](https://www.mapmyindia.com/api/img/logos1/TATA-MOTORS.png)![](https://www.mapmyindia.com/api/img/logos1/Wipro.png)![](https://www.mapmyindia.com/api/img/logos1/Xamarin.png)

<br>

For any queries and support, please contact:

[<img src="https://mmi-api-team.s3.amazonaws.com/Mappls-SDKs/Resources/mappls-logo.png" height="40"/> </p>](https://about.mappls.com/api/)

Email us at [apisupport@mappls.com](mailto:apisupport@mappls.com)

![](https://www.mapmyindia.com/api/img/icons/support.png)
[Support](https://about.mappls.com/contact/)
Need support? contact us!

<br></br>

[<p align="center"> <img src="https://www.mapmyindia.com/api/img/icons/stack-overflow.png"/> ](https://stackoverflow.com/questions/tagged/mappls-api)[![](https://www.mapmyindia.com/api/img/icons/blog.png)](https://about.mappls.com/blog/)[![](https://www.mapmyindia.com/api/img/icons/gethub.png)](https://github.com/mappls-api)[<img src="https://mmi-api-team.s3.ap-south-1.amazonaws.com/API-Team/npm-logo.one-third%5B1%5D.png" height="40"/> </p>](https://www.npmjs.com/org/mapmyindia) 

[<p align="center"> <img src="https://www.mapmyindia.com/june-newsletter/icon4.png"/> ](https://www.facebook.com/Mapplsofficial)[![](https://www.mapmyindia.com/june-newsletter/icon2.png)](https://twitter.com/mappls)[![](https://www.mapmyindia.com/newsletter/2017/aug/llinkedin.png)](https://www.linkedin.com/company/mappls/)[![](https://www.mapmyindia.com/june-newsletter/icon3.png)](https://www.youtube.com/channel/UCAWvWsh-dZLLeUU7_J9HiOA)

<div align="center">@ Copyright 2020 CE Info Systems Pvt. Ltd. All Rights Reserved.</div>

<div align="center"> <a href="https://about.mappls.com/api/terms-&-conditions">Terms & Conditions</a> | <a href="https://www.mappls.com/about/privacy-policy">Privacy Policy</a> | <a href="https://www.mappls.com/pdf/mappls-sustainability-policy-healt-labour-rules-supplir-sustainability.pdf">Supplier Sustainability Policy</a> | <a href="https://www.mappls.com/pdf/Health-Safety-Management.pdf">Health & Safety Policy</a> | <a href="https://www.mappls.com/pdf/Environment-Sustainability-Policy-CSR-Report.pdf">Environmental Policy & CSR Report</a>

<div align="center">Customer Care: +91-9999333223</div>
