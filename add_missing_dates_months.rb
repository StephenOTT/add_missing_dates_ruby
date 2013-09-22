require 'date'
require 'active_support/core_ext'

class DateManipulate
	
	def initialize (hash)
		self.sortHash(hash)
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

		self.addMissingMonths(sortedHash)
		# return sortedHash
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

@creationDateCount = [{"_id"=>{"year"=>2012, "month"=>01}, "number"=>58},{"_id"=>{"year"=>2012, "month"=>9}, "number"=>53}, {"_id"=>{"year"=>2012, "month"=>12}, "number"=>58}]
start = DateManipulate.new
hash = start.sortHash(@creationDateCount)
addedMissingDate = start.addMissingMonths(hash)
resortedDates = start.simpleHashSort(addedMissingDate)



