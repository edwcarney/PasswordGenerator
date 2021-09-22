# include("RandomDotOrgAPI.jl")
using RandomDotOrgAPI

using Printf

apiType = "basic"

function numsfromRDO(output)
    return convert(Array{Int}, output["result"]["random"]["data"])
end

index_groups = 1
function getpassword()
    global index_groups, word_groups

    PUNCTUATION_CHARS = "]{}|()\"!@#\$%^&*<>;:-=";

 
    # get needed random numbers; sleep between requests per advisoryDelay from RDO
 #   responseRDO =  generate_integers(4, min = 1, max = length(word_list), apiType=apiType)
 #   index_words = numsfromRDO(responseRDO)
 #   sleep(responseRDO["result"]["advisoryDelay"]/1000.0)
    # responseRDO = rand(1, min = 1, max = length(PUNCTUATION_CHARS), apiType=apiType)
 
 
    # construct a password
    word_group = word_list[word_groups[index_groups,:]]
    index_groups += 1
    rand_char = PUNCTUATION_CHARS[rand(1:length(PUNCTUATION_CHARS))]
    rand_cap_word = rand(1:4)
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

function shortenlist( word_list, smallest, largest)
    testrange = range(smallest, stop=largest)

    for i in length(word_list):-1:1
        !(length(word_list[i]) in testrange) && deleteat!(word_list, i);
    end
end

function main(args)
    global word_list, word_groups

    # check for args[1]
    isempty(args) ? verbose = false : verbose = parse(Bool, args[1])

    println("Which list? (1 or 2)")
    listnum = readline();
    word_list = readlines(string(@__DIR__,"/list",listnum,".txt"))
    
    println(string("Current quota is: ", get_usage(apiType=apiType)["result"]["bitsLeft"]," bits"))
    println(string("List contained: ", length(word_list), " words."))
    shortenlist(word_list, 6, 9);
    println(string("List now contains: ", length(word_list), " words.\n"))
 
    print("How many passwords do you want?\n")
    resp = parse(Int32, readline());

    # get a random set of indices into word_list
    nrandom_numbers = resp * 4 *10
    word_groups = reshape(numsfromRDO(generate_integers(nrandom_numbers,min=1,max=length(word_list))), Int(nrandom_numbers/4), 4)

    # get a random set of indices into word_list
#     word_groups = reshape(numsfromRDO(generate_integers(100,min=1,max=length(word_list))), 25,4)
    for i in range(1, stop=resp)
        generatepwd(verbose)
    end

    println(string("\nCurrent quota is: ", get_usage(apiType=apiType)["result"]["bitsLeft"], " bits\n"))
end;

main(ARGS);
