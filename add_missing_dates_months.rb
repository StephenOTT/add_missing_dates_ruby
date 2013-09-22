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

		datesHash.keys.each do |x|
			if x != datesHash.keys.last
				(x+1.month).upto(datesHash.keys[count+1]-1.month) do |a|
				    result[a.at_beginning_of_month] = 0
				end
			end

			count += 1
		end
		mergedHash = result.merge!(datesHash)
		self.simpleHashSort(mergedHash)

		# return result.merge!(datesHash)
		puts sortedHash
		return sortedHash
	end
end

@creationDateCount = [{"_id"=>{"year"=>2012, "month"=>01}, "number"=>58},{"_id"=>{"year"=>2012, "month"=>9}, "number"=>53}, {"_id"=>{"year"=>2012, "month"=>12}, "number"=>58}]
start = DateManipulate.new
hash = start.sortHash(@creationDateCount)
addedMissingDate = start.addMissingMonths(hash)
resortedDates = start.simpleHashSort(addedMissingDate)



