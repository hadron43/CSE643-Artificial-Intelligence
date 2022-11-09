# Author: Harsh Kumar
# Roll No: 2019043

from durable.lang import *

# possible values for variables
#
# m.acad = ['electronics', 'design', 'mathematics', 'bioinformatics', 'computers', 'data science']
# m.interest = ['corporate', 'public service', 'academics']
# m.cgpa = ['good', 'bad']
# m.hobby = ['music', 'dance', 'sports']

# Possible Careers
# ['Web Developer', 'Mobile App Developer', 'Consultant', 'Management', 'Computer Security Analyst', 'Web Designer', 'App Designer'
# 'UPSC Public Servant', 'SSC Public Servant', 'Armed Forces',
# 'Researcher', 'Teacher', 'Professor',
# 'Hardware Engineer',
# 'Singer', 'Dancer', Sportsperson']

"""
Interests ruleset
    This ruleset asserts facts on the basis of interest
    of the student.
"""
with ruleset('interests'):
    # Define careers when interest is corporate
    @when_all((m.cgpa == 'good') & (m.interest == 'corporate'))
    def corporate(c):
        c.assert_fact('career', {'field': 'Developer'})

    @when_all((m.interest == 'corporate')
        &  (m.cpga == 'bad'))
    def corporate(c):
        c.assert_fact('career', {'field': 'Consultant' })

    # Define careers when interest is public service
    @when_all((m.cgpa == 'good') & (m.interest == 'public service'))
    def public_service(c):
        c.assert_fact('career', {'field': 'UPSC Public Servant'})

    @when_all((m.interest == 'public service')
        &  (m.cpga == 'bad'))
    def public_service(c):
        c.assert_fact('career', {'field': 'SSC Public Servant' })

    # Define careers when interest is academics
    @when_all((m.cgpa == 'good') & (m.interest == 'academics'))
    def academics(c):
        c.assert_fact('career', {'field': 'Professor'})
        c.assert_fact('career', {'field': 'Researcher'})

    @when_all((m.interest == 'academics')
        &  (m.cpga == 'bad'))
    def academics(c):
        c.assert_fact('career', {'field': 'Teacher' })


with ruleset('academics'):
    # Define careers when academics is electronics
    @when_all((m.acad == 'electronics'))
    def electronics(d):
        d.assert_fact('career', {'field': 'Hardware Engineer'})

    # Define careers when academics is design
    @when_all((m.acad == 'design'))
    def design(d):
        d.assert_fact('career', {'field': 'Designer'})

    # Define careers when academics is mathematics
    @when_all((m.acad == 'mathematics'))
    def mathematics(d):
        d.assert_fact('career', {'field': 'Professor'})

    # Define careers when academics is design
    @when_all((m.acad == 'bioinformatics'))
    def bioinformatics(d):
        d.assert_fact('career', {'field': 'Researcher'})

    # Define careers when academics is computers
    @when_all((m.acad == 'computers'))
    def computers(d):
        d.assert_fact('career', {'field': 'Systems'})

    # Define careers when academics is data science
    @when_all((m.acad == 'data science'))
    def data_science(d):
        d.assert_fact('career', {'field': 'Researcher'})


# """
# Ruleset for hobbies
# """
with ruleset('hobby'):
    # Define careers when hobby is music
    @when_all((m.hobby == 'music'))
    def music(e):
        e.assert_fact('career', {'field': 'Musician'})

    # Define careers when hobby is dance
    @when_all((m.hobby == 'dance'))
    def dance(e):
        e.assert_fact('career', {'field': 'Dancer'})

    # Define careers when hobby is sports
    @when_all((m.hobby == 'sports'))
    def sports(e):
        e.assert_fact('career', {'field': 'Sportsperson'})


# Possible Careers
# ['Web Developer', 'Mobile App Developer', 'Consulatant', 'Management', 'Computer Security Analyst', 'Web Designer', 'App Designer'
# 'UPSC Public Servant', 'SSC Public Servant', 'Armed Forces',
# 'Researcher', 'Teacher', 'Professor',
# 'Hardware Engineer',
# 'Singer', 'Dancer', Sportsperson']

"""
Ruleset for career
"""
with ruleset('career'):

    @when_all(m.field == 'Developer')
    def developer_jobs(f):
        f.assert_fact({ 'job': 'Mobile App Developer' })
        f.assert_fact({ 'job': 'Web Developer' })

    @when_all(m.field == 'Systems')
    def systems_jobs(f):
        f.assert_fact({ 'job': 'Cyber Security Expert' })
        f.assert_fact({ 'job': 'Cloud Engineer' })

    @when_all(m.field == 'Designer')
    def designer_jobs(f):
        f.assert_fact({ 'job': 'Web Designer' })
        f.assert_fact({ 'job': 'App Desinger' })

    @when_all(m.field == 'Consultant')
    def consultant_jobs(f):
        f.assert_fact({ 'job': 'Consultant' })
        f.assert_fact({ 'job': 'Manager' })

    @when_all(m.field == 'UPSC Public Servant')
    def upsc_jobs(f):
        f.assert_fact({ 'job': 'IAS' })
        f.assert_fact({ 'job': 'IPS' })
        f.assert_fact({ 'job': 'IRS' })
        f.assert_fact({ 'job': 'IFS' })

    @when_all(m.field == 'SSC Public Servant')
    def ssc_jobs(f):
        f.assert_fact({ 'job': 'Clerk' })
        f.assert_fact({ 'job': 'Stenographer' })

    @when_all(m.field == 'Professor')
    def professor_jobs(f):
        f.assert_fact({ 'job': 'Professor' })

    @when_all(m.field == 'Researcher')
    def researcher_jobs(f):
        f.assert_fact({ 'job': 'Researcher' })

    @when_all(m.field == 'Teacher')
    def teacher_jobs(f):
        f.assert_fact({ 'job': 'School Teacher' })
        f.assert_fact({ 'job': 'Coaching Teacher' })

    @when_all(m.field == 'Hardware Engineer')
    def hardware_jobs(f):
        f.assert_fact({ 'job': 'Hardware Engineer' })

    @when_all(m.field == 'Musician')
    def musician_jobs(f):
        f.assert_fact({ 'job': 'Singer' })
        f.assert_fact({ 'job': 'Music Composer' })
        f.assert_fact({ 'job': 'Musical Instrument Player' })

    @when_all(m.field == 'Dancer')
    def dancer_jobs(f):
        f.assert_fact({ 'job': 'Dancer' })
        f.assert_fact({ 'job': 'Actor' })
        f.assert_fact({ 'job': 'Social Media Influencer' })

    @when_all(m.field == 'Sportsperson')
    def sports_jobs(f):
        f.assert_fact({ 'job': 'Sports Player' })
        f.assert_fact({ 'job': 'Coach' })
        f.assert_fact({ 'job': 'Physical Fitness Trainer' })

    # printing the job facts
    @when_all(+m.job)
    def output(f):
        print('Possible career: You can be {0}'.format(f.m.job))


# possible values for variables
#
# m.acad = ['electronics', 'design', 'mathematics', 'bioinformatics', 'computers', 'data science']
# m.interest = ['corporate', 'public service', 'academics']
# m.cgpa = ['good', 'bad']
# m.hobby = ['music', 'dance', 'sports']

assert_fact('interests', {'interest' : 'corporate', 'cgpa': 'good'})
assert_fact('hobby', {'hobby' : 'sports'})
assert_fact('academics', {'acad' : 'computers'})
