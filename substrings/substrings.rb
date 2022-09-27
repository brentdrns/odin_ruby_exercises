def substrings(txt, dictionary)
    myHash = Hash.new
    dictionary.each do |word|
        txt.each_char.with_index do |chr,index|
            check_txt = txt[index,word.length]
            if word.downcase === check_txt.downcase
                if myHash.has_key?(word)
                    myHash[word] += 1
                else
                    myHash[word] = 1
                end
            end
        end
    end
    return myHash
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("Howdy partner, sit down! How's it going?",dictionary)
