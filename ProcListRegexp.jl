using Printf

println("Which list? (1 or 2)")
listnum = readline()
if listnum==""
    listnum = "2"
end
word_list = readlines(string("./list",listnum,".txt"));

function search_strings(words, str)
    x = collect(m for m in words if occursin(str, m) & !occursin(r"s$", m));
    # y = collect(m for m in x if !occursin(r"s$", m));
end

function main()
    # str = r"tite$"
    str = ""
    while str == ""
        println("Enter search string:")
        str = readline()
    end
    Regexstr = Regex(str);
    str_array = search_strings(word_list, str);
    println("Create a file? (y or n)")
    fileopt = readline()
    if fileopt == "y"
        filename = string(str, ".txt")
        io = open(filename,"w")
        for i in str_array
            println(io, i)
        end
        close(io)
    end
    return str_array
end

main();