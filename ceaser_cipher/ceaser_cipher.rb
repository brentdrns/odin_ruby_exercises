def ceaser_cipher (str,key)
    uni = str.bytes
    new_array = ""
    uni.each do |chr|
        if (chr >= 65 && chr <= 90) || (chr >= 97 && chr<= 122)
            new_chr = chr + key
            if (new_chr >= 65 && new_chr <= 90) || (new_chr >= 97 && new_chr <= 122)
                new_array = new_array + new_chr.chr
            else
                new_array = new_array + (new_chr - 26).chr
            end
        else
            new_array = new_array + chr.chr
        end
    end
    puts new_array
end

ceaser_cipher("What a string!",5)