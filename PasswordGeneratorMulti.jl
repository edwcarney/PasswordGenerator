using Printf

# println("Which list? (1 or 2)")
# listnum = readline();
# word_list = readlines(string(@__DIR__,"/list",listnum,".txt"))

function genpassword()
    PUNCTUATION_CHARS = "]{}|()\"!@#\$%^&*<>;:-=";

    word_group = word_list[rand(1:length(word_list), 4)]
    rand_char = PUNCTUATION_CHARS[rand(1:length(PUNCTUATION_CHARS))]
    rand_cap_word = rand(1:4)
    word_group[rand_cap_word] = titlecase(word_group[rand_cap_word])
    return chop(join([string(x,rand_char) for x in word_group]))
end;

function generatepwds(verbose::Bool)
    new_password = genpassword();
    while true
        length(new_password) >= 28 && length(new_password) <= 32 && break
        if verbose
            @printf("%s %s-[%d chars]\n",
                    new_password,
                    ifelse(length(new_password)>32, "long", "short"),
                    length(new_password))
        end
        new_password = genpassword();
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
    global word_list

    # check for args[1]
    isempty(args) ? verbose = false : verbose = parse(Bool, args[1])
    println("Which list? (1 or 2)")

    listnum = readline();
    word_list = readlines(string(@__DIR__,"/list",listnum,".txt"))
    
 
    println(string("List contained: ", length(word_list), " words."))
    shortenlist(word_list, 6, 9);
    println(string("List now contains: ", length(word_list), " words.\n"))

    print("How many passwords do you want?\n")
    resp = parse(Int32, readline());
    for i in range(1, stop=resp)
        generatepwds(verbose);
    end
end;

main(ARGS);
