add_missing_dates_ruby
======================

Ruby sample code for adding missing dates between Date A and Date B (originally designed for missing months between two dates)


Code is designed to provide a Hash with Keys being dates and Values being counts of objects inside that date.

Was designed for Graphing and Charting purposes where you have a list of dates and values for each dates in the hash.  When you graph you sometimes want to show the months that are missing from the data.  You want to show those missing dates with 0 values, this code was designed to solve this problem.

There are two methods for initial data conversion.  This code was designed for use with MongoDB Aggregation Framework using the $month grouping operator:
Sample Mongo Ruby query:

```
restaurantCreationDateCount = @coll.aggregate([
			{ "$match" => {fs_fcr_date: {"$ne" => nil}}},
		    { "$project" => {createdate_month: {"$month" => "$fs_fcr_date"},createdate_year: {"$year" => "$fs_fcr_date"}}},
	    	{ "$group" => {_id: {year:"$createdate_year", month:"$createdate_month"},number: { "$sum" => 1 }}},
			# { "$sort" => {"_id.year" => 1}},
		])
```

 
A hash is provided as such into ```sortHash``` method:

```
[{"_id"=>{"year"=>2012, "month"=>10}, "number"=>53},
 {"_id"=>{"year"=>2012, "month"=>12}, "number"=>58},
 {"_id"=>{"year"=>2011, "month"=>8}, "number"=>8}, 
 {"_id"=>{"year"=>2012, "month"=>11}, "number"=>75}, 
 {"_id"=>{"year"=>2011, "month"=>9}, "number"=>58}, 
 {"_id"=>{"year"=>2013, "month"=>9}, "number"=>67}, 
 {"_id"=>{"year"=>2013, "month"=>6}, "number"=>561}, 
 {"_id"=>{"year"=>2012, "month"=>9}, "number"=>102}, 
 {"_id"=>{"year"=>2013, "month"=>5}, "number"=>609}, 
 {"_id"=>{"year"=>2012, "month"=>7}, "number"=>84}, 
 {"_id"=>{"year"=>2010, "month"=>12}, "number"=>1}, 
 {"_id"=>{"year"=>2013, "month"=>7}, "number"=>595}, 
 {"_id"=>{"year"=>2013, "month"=>3}, "number"=>253}, 
 {"_id"=>{"year"=>2012, "month"=>6}, "number"=>129}, 
 {"_id"=>{"year"=>2012, "month"=>2}, "number"=>95}, 
 {"_id"=>{"year"=>2012, "month"=>4}, "number"=>50}, 
 {"_id"=>{"year"=>2013, "month"=>8}, "number"=>736}, 
 {"_id"=>{"year"=>2013, "month"=>1}, "number"=>242}, 
 {"_id"=>{"year"=>2011, "month"=>11}, "number"=>46}, 
 {"_id"=>{"year"=>2012, "month"=>3}, "number"=>68}, 
 {"_id"=>{"year"=>2011, "month"=>10}, "number"=>48}, 
 {"_id"=>{"year"=>2012, "month"=>1}, "number"=>70}, 
 {"_id"=>{"year"=>2012, "month"=>8}, "number"=>70}, 
 {"_id"=>{"year"=>2013, "month"=>2}, "number"=>266}, 
 {"_id"=>{"year"=>2011, "month"=>12}, "number"=>47}, 
 {"_id"=>{"year"=>2013, "month"=>4}, "number"=>449}, 
 {"_id"=>{"year"=>2012, "month"=>5}, "number"=>77}]
```

The initial hash is sorted and then passed into the ```addMissingMonths``` method to determine all of the missing months and returns a new hash with the missing month hash and original hash merged together.

The ```simpleHashSort``` method is then called to resort the hash into the correct order.  The re-sorted hash is the returned value of the entire process.