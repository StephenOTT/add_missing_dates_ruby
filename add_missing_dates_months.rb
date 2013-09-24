require 'date'
require 'active_support/core_ext'

class DateManipulate

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

		self.addMissingMonths(sortedHash)
		# return sortedHash
	end

	def sortHashPlain (hash)

		dateFormatChangeHash = {}

		sortedDates = hash.keys.sort
		sortedHash = {}

		sortedDates.each do |y|
			sortedHash[y] = hash[y]
		end

		self.addMissingMonths(sortedHash)

	end

	def addMissingMonths (datesHash)
		count = 0
		result = {}
		lastKey = datesHash.keys.last

		datesHash.keys.each do |x|
			if x != lastKey
				(x.next_month(1)).upto(datesHash.keys[count + 1].prev_month(1)) do |a|
				    result[a.beginning_of_month] = 0
				end
			end

			count += 1
		end
		
		#for use when not working with Hashes but working with Arrays:
		# puts result.uniq.to_s
		# The uniq removes all of the extra duplicate values.

		mergedHash = result.merge!(datesHash)
		self.simpleHashSort(mergedHash)

		# return result.merge!(datesHash)
	end

	def simpleHashSort (hash)
		sortedDates = hash.keys.sort
		sortedHash = {}

		sortedDates.each do |y|
			sortedHash[y] = hash[y]
		end

		puts sortedHash
		return sortedHash
	end
end

@creationDateCount = [{"_id"=>{"year"=>2012, "month"=>10}, "number"=>53}, {"_id"=>{"year"=>2012, "month"=>12}, "number"=>58}, {"_id"=>{"year"=>2011, "month"=>8}, "number"=>8}, {"_id"=>{"year"=>2012, "month"=>11}, "number"=>75}, {"_id"=>{"year"=>2011, "month"=>9}, "number"=>58}, {"_id"=>{"year"=>2013, "month"=>9}, "number"=>67}, {"_id"=>{"year"=>2013, "month"=>6}, "number"=>561}, {"_id"=>{"year"=>2012, "month"=>9}, "number"=>102}, {"_id"=>{"year"=>2013, "month"=>5}, "number"=>609}, {"_id"=>{"year"=>2012, "month"=>7}, "number"=>84}, {"_id"=>{"year"=>2010, "month"=>12}, "number"=>1}, {"_id"=>{"year"=>2013, "month"=>7}, "number"=>595}, {"_id"=>{"year"=>2013, "month"=>3}, "number"=>253}, {"_id"=>{"year"=>2012, "month"=>6}, "number"=>129}, {"_id"=>{"year"=>2012, "month"=>2}, "number"=>95}, {"_id"=>{"year"=>2012, "month"=>4}, "number"=>50}, {"_id"=>{"year"=>2013, "month"=>8}, "number"=>736}, {"_id"=>{"year"=>2013, "month"=>1}, "number"=>242}, {"_id"=>{"year"=>2011, "month"=>11}, "number"=>46}, {"_id"=>{"year"=>2012, "month"=>3}, "number"=>68}, {"_id"=>{"year"=>2011, "month"=>10}, "number"=>48}, {"_id"=>{"year"=>2012, "month"=>1}, "number"=>70}, {"_id"=>{"year"=>2012, "month"=>8}, "number"=>70}, {"_id"=>{"year"=>2013, "month"=>2}, "number"=>266}, {"_id"=>{"year"=>2011, "month"=>12}, "number"=>47}, {"_id"=>{"year"=>2013, "month"=>4}, "number"=>449}, {"_id"=>{"year"=>2012, "month"=>5}, "number"=>77}]
start = DateManipulate.new (@creationDateCount)




