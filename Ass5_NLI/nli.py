import nltk
nltk.download('punkt')

# opening text file in which facts will be created in write mode
f = open("fact.pl", 'w')

# input the career u have selected
text = input("Tell us about yourself.\n\t--")
text = nltk.word_tokenize(text)

# all lowercase
for i in range(0, len(text)):
    text[i] = text[i].lower()

courses = ['m1', 'ip', 'dc', 'com', 'dsa', 'cn', 'dm', 'ap', 'os']
streams = ['cse', 'csai', 'csd', 'csam', 'csb', 'ece']
roles = ['sde', 'entrepreneur', 'data', 'silicon']
interests = ['theory', 'ssh', 'application']

# process if grade data found
for course in courses:
    grade = 0
    try:
        ind1 = text.index(course)
        if(ind1 + 1 >= len(text)):
            raise Exception('cgpa not found')
        cgpa = int(text[ind1 + 1])

        grade = cgpa
    except:
        grade = 0
    finally:
        f.write('grade(' + course + ', ' + str(grade) + ').\n')

# process if cgpa is found
cgpa = 1
try:
    ind1 = text.index('cgpa')
    ind2 = ind1 + 2
    if(ind2 >= len(text)):
        raise Exception ('cgpa not read')
    cgpa = float(text[ind2])
except:
    cgpa = 1
finally:
    f.write('stud_cgpa(' + str(cgpa) + ').\n')

# parse interest
for interest in interests:
    if(interest in text):
        f.write('stud_interest(' + interest + ').\n')
        break

# parse role
for role in roles:
    if(role in text):
        f.write('stud_role(' + role + ').\n')
        break

# parse stream

for stream in streams:
    if(stream in text):
        f.write('stud_stream(' + stream + ').\n')
        break

# closing the file
f.close()
