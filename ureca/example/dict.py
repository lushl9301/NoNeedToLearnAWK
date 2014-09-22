words = "".join(open("words.txt", 'r').readlines()).split('\n')
dic = {}
for x in words:
    if x in dic:
        dic[x] += 1
    else:
        dic[x] = 1
import operator
sorted_words = sorted(dic.iteritems(), key=operator.itemgetter(1), reverse=True)
for tu in sorted_words:
    print tu