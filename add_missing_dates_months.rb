require 'date'
require 'active_support/core_ext'

class DateManipulate
	
	def initialize
		# @creationDateCount = [{"_id"=>{"year"=>2012, "month"=>10}, "number"=>53}, {"_id"=>{"year"=>2012, "month"=>12}, "number"=>58}, {"_id"=>{"year"=>2011, "month"=>8}, "number"=>8}, {"_id"=>{"year"=>2012, "month"=>11}, "number"=>75}, {"_id"=>{"year"=>2011, "month"=>9}, "number"=>58}, {"_id"=>{"year"=>2013, "month"=>9}, "number"=>67}, {"_id"=>{"year"=>2013, "month"=>6}, "number"=>561}, {"_id"=>{"year"=>2012, "month"=>9}, "number"=>102}, {"_id"=>{"year"=>2013, "month"=>5}, "number"=>609}, {"_id"=>{"year"=>2012, "month"=>7}, "number"=>84}, {"_id"=>{"year"=>2010, "month"=>12}, "number"=>1}, {"_id"=>{"year"=>2013, "month"=>7}, "number"=>595}, {"_id"=>{"year"=>2013, "month"=>3}, "number"=>253}, {"_id"=>{"year"=>2012, "month"=>6}, "number"=>129}, {"_id"=>{"year"=>2012, "month"=>2}, "number"=>95}, {"_id"=>{"year"=>2012, "month"=>4}, "number"=>50}, {"_id"=>{"year"=>2013, "month"=>8}, "number"=>736}, {"_id"=>{"year"=>2013, "month"=>1}, "number"=>242}, {"_id"=>{"year"=>2011, "month"=>11}, "number"=>46}, {"_id"=>{"year"=>2012, "month"=>3}, "number"=>68}, {"_id"=>{"year"=>2011, "month"=>10}, "number"=>48}, {"_id"=>{"year"=>2012, "month"=>1}, "number"=>70}, {"_id"=>{"year"=>2012, "month"=>8}, "number"=>70}, {"_id"=>{"year"=>2013, "month"=>2}, "number"=>266}, {"_id"=>{"year"=>2011, "month"=>12}, "number"=>47}, {"_id"=>{"year"=>2013, "month"=>4}, "number"=>449}, {"_id"=>{"year"=>2012, "month"=>5}, "number"=>77}]
		# @creationDateCount = [{"_id"=>{"year"=>2012, "month"=>01}, "number"=>58},{"_id"=>{"year"=>2012, "month"=>9}, "number"=>53}, {"_id"=>{"year"=>2012, "month"=>12}, "number"=>58}]
	end

	def sortHash (hash)
		dateFormatChangeHash = {}

		hash.each do |x|
			temp = Date.strptime(x["_id"].values_at('month', 'year').join(" "), '%m %Y')
			dateFormatChangeHash[temp] = x["number"]	
		end

		sortedDates = dateFormatChangeHash.keys.sort
		sortedHash = {}

		sortedDates.each do |y|
			sortedHash[y] = dateFormatChangeHash[y]
		end

		return sortedHash
	end

	def simpleHashSort (hash)
		sortedDates = hash.keys.sort
		sortedHash = {}

		sortedDates.each do |y|
			sortedHash[y] = hash[y]
		end

		puts "sorted Hash:  #{pp sortedHash}"
		return sortedHash
	end

	def addMissingMonths (datesHash)
		count = 0
		result = {}

		datesHash.keys.each do |x|
			if x != datesHash.keys.last
				(x+1.month).upto(datesHash.keys[count+1]-1.month) do |a|
				    result[a.at_beginning_of_month] = 0
				end
			end

			count += 1
		end

		return result.merge!(datesHash)
	end
end

@creationDateCount = [{"_id"=>{"year"=>2012, "month"=>01}, "number"=>58},{"_id"=>{"year"=>2012, "month"=>9}, "number"=>53}, {"_id"=>{"year"=>2012, "month"=>12}, "number"=>58}]
start = DateManipulate.new
hash = start.sortHash(@creationDateCount)
addedMissingDate = start.addMissingMonths(hash)
resortedDates = start.simpleHashSort(addedMissingDate)



