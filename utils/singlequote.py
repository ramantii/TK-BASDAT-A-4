def getSingleQuoteIndex(string):
    res=[]
    if ("'" in string):
        for i in range(len(string)):
            if string[i] == "'":
                res.append(i)
    return res

def manipulateSingleQuote(array, string):
    if (len(array) == 1):
        for i in range(len(array)):
            string = string[:array[i]] + "'" + string[array[i]:]

    return string