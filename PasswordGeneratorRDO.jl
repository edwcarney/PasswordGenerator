using RandomDotOrg
using Printf

# reduce the word list to elements having only words of length in the
# range smallest to largest
function shortenlist( word_list, smallest, largest)
    println(string("List contained: ", length(word_list), " words."))

    testrange = range(smallest, stop=largest)

    for i in length(word_list):-1:1
        !(length(word_list[i]) in testrange) && deleteat!(word_list, i);
    end

    println(string("Shortened list contains: ", length(word_list), " words.\n"))
end

index_groups = 1
function getpassword()
    global index_groups, word_groups
    PUNCTUATION_CHARS = "]{}|()\"!@#\$%^&*<>;:-=";

    word_group = word_list[word_groups[index_groups,:]] # word_list[random_numbers(4, min=1, max=length(word_list))]
    index_groups += 1
    # choose a random punctuation character
    rand_char = PUNCTUATION_CHARS[rand(1:length(PUNCTUATION_CHARS))]
     # choose a random word to capitalize
    rand_cap_word = rand(1:4)     # word_group = word_group_iter
    word_group[rand_cap_word] = titlecase(word_group[rand_cap_word])
    return chop(join([string(x, rand_char) for x in word_group]))
end;


function generatepwd(verbose::Bool)
    new_password = getpassword();
    while true 
        length(new_password) >= 28 && length(new_password) <= 32 && break
        if verbose
            @printf("%s %s-[%d chars]\n",
                    new_password,
                    ifelse(length(new_password)>32, "long", "short"),
                    length(new_password))
        end
        new_password = getpassword()
    end
    @printf("%s - %d chars\n",new_password, length(new_password))
end;

function main(args)
    global word_list, word_groups

    # check for args[1]
    isempty(args) ? verbose = false : verbose = parse(Bool, args[1])

    # read up the List
    println("Which list? (1 or 2)")
    listnum = readline();
    word_list = readlines(string(@__DIR__,"/list",listnum,".txt"))
    shortenlist(word_list, 6, 9)
    
    # get the bit quota from RDO site1
    println(string("Current RDO quota is: ", get_quota()))

    # get a random set of indices into word_list
    word_groups = reshape(random_numbers(100,min=1,max=length(word_list)), 25,4)
    
    generatepwd(verbose);
 
    println(string("\nCurrent RDO quota is: ", get_quota()))
end;

main(ARGS);