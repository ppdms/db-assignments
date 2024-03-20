import csv
import ast

file = open("keywords.csv", 'r', encoding='utf-8') # encoding='utf-8' is used to read the file in the correct format (with special characters)
csvreader = csv.reader(file)
header = next(csvreader)
print(header)

keyword_data = []
hashkeyword_data = []
for row in csvreader:
    movie_id = row[0]
    data = ast.literal_eval(row[1])
    for d in data:
        keyword_data.append(("id", d['id'], "name", d['name']))
        hashkeyword_data.append(("movie_id", movie_id, "id", d['id']))
file.close()

keyword_data = set(keyword_data)

f = open("Keyword.csv", 'w',newline='', encoding='utf-8')
writer = csv.writer(f)
writer.writerow(["id", "name"])
# Write the data for the keyword table
for row in keyword_data:
    writer.writerow([row[1], row[3]])
f.close()

f = open("hashkeyword.csv", 'w', newline='',encoding='utf-8')
writer = csv.writer(f)
writer.writerow(["movie_id", "keyword_id"])
for row in hashkeyword_data:
    writer.writerow([row[1], row[3]])
# Write the data for the hashkeyword table
f.close()


