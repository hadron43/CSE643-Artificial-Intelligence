% possible courses

full_form(m1) :- write('Math 1').
full_form(ip) :- write('Intro to Programming').
full_form(dc) :- write('Digital Circuits').
full_form(com) :- write('Communication Skills').
full_form(dsa) :- write('Data Structures and Algorithms').
full_form(cn) :- write('Computer Networks').
full_form(dm) :- write('Discrete Mathematics').
full_form(ap) :- write('Advanced Programming').
full_form(os) :- write('Operating Systems').

full_form(nss) :- write('Networks and Systems Security').
full_form(fcs) :- write('Foundations of Computer Security').
full_form(ml) :- write('Machine Learning').
full_form(dl) :- write('Deep Learning').
full_form(gd) :- write('Game Design').
full_form(ff) :- write('Foundation of Finance').
full_form(pn) :- write('Programmable Networking').
full_form(ent) :- write('Entrepreneurship').
full_form(lm) :- write('Learning and Memory').
full_form(aa) :- write('Abstract Algebra').
full_form(cm) :- write('Computing for Medicine').
full_form(ssd) :- write('Solid State Devices').

full_form(theory) :- write('Theoretical CS').
full_form(ssh) :- write('Social Science and Humanities').
full_form(application) :- write('Applications of CS').

/*
 Courses are represented in terms of short names (declared in order below)
 Pre Req courses: We have data about the performance of the
 user in these courses, based on which we will give electives recommendation.
 [Math 1, Intro to Programming, Digital Circuits, Communication Skills, Data Structures and Algorithms
   Computer Networks, Discrete Mathematics, Advanced Programming, Operating Systems]
*/

course(m1).
course(ip).
course(dc).
course(com).
course(dsa).
course(cn).
course(dm).
course(ap).
course(os).

/*
 Elective Courses: We have to recommend some courses among these advanced elective courses.
 [Networks and Systems Security, Foundations of Computer Security, Machine Learning, Deep Learning,
   Game Design, Foundation of Finance, Programmable Networking, Entrepreneurship, Learning and Memory,
   Abstract Algebra, Computing for Medicine, Solid State Devices]
*/

elective(nss).
elective(fcs).
elective(ml).
elective(dl).
elective(gd).
elective(ff).
elective(pn).
elective(ent).
elective(lm).
elective(aa).
elective(cm).
elective(ssd).

% Pre Req Relations: What are pre requisites of the electives?

pre_req(nss, [ip, cn, os]).
pre_req(fcs, [cn, os]).
pre_req(ml, [ip]).
pre_req(dl, [ip]).
pre_req(gd, [ip]).
pre_req(ff, []).
pre_req(pn, [cn, ip]).
pre_req(ent, [com]).
pre_req(lm, []).
pre_req(aa, [m1, dm]).
pre_req(cm, [ip, dsa]).
pre_req(ssd, [dc]).

% Departments: Possible streams of the students

stream(cse).
stream(csai).
stream(csd).
stream(csam).
stream(csb).
stream(ece).

print_streams:-
    forall(stream(X), format('~w ', [X])).

% Department courses relation

department_electives(cse, [nss, fcs]).
department_electives(csai, [ml, dl]).
department_electives(csd, [gd]).
department_electives(csam, [aa]).
department_electives(csb, [cm]).
department_electives(ece, [ssd]).

% Roles

role(sde).
role(entrepreneur).
role(data).
role(silicon).

print_roles:-
    forall(role(X), format('~w ', [X])).

% Role electives : recommended courses for role

role_electives(sde, [nss]).
role_electives(entrepreneur, [ent]).
role_electives(data, [ml, ai]).
role_electives(silicon, [ssd]).

% Interest Areas

interest(theory).
interest(ssh).
interest(application).

print_interest :-
    forall(interest(X), format('~w ', [X])).

interest_electives(theory, [aa, pn, lm, ssd, ml]).
interest_electives(ssh, [ff, ent, lm]).
interest_electives(application, [nss, fcs, dl]).

% Taking validated inputs
% Predicates starting with stud_ are reserved for storing user inputs.

input_stream :-
    write('Enter your stream ( '), print_streams, write('): '),
    read(X),
    retractall(stud_stream(_)),
    (stream(X), assert(stud_stream(X))) ; (write('Invalid input!'), nl, input_stream).
input_stream.

input_role :-
    write('Enter your preferred career ( '), print_roles, write('): '),
    read(X),
    retractall(stud_role(_)),
    (role(X), assert(stud_role(X))) ; (write('Invalid input!'), nl, input_role).
input_role.

is_valid_cgpa(CGPA) :-
    bounded_number(0.0000000000000001, 10.0000000000000001, CGPA).

input_cgpa :-
    write('Enter your CGPA: '),
    read(X),
    retractall(stud_cgpa(_)),
    (is_valid_cgpa(X), assert(stud_cgpa(X))) ; (write('Invalid input!'), nl, input_cgpa).
input_cgpa.

is_valid_grade(Grade) :-
    between(0, 10, Grade).

input_course_grade(Course) :-
    full_form(Course),
    write(': '),
    read(X),
    retractall(grade(Course, _)),
    (is_valid_grade(X), assert(grade(Course, X))) ; (write('Invalid input!'), nl, input_course_grade(Course)).
input_course_grade.

input_grades :-
    write('Enter course grades (0 if course not taken): '), nl,
    forall(course(X), input_course_grade(X)).
input_grades.

input_interest :-
    write('Enter your interest ( '), print_interest, write('): '),
    read(X),
    retractall(stud_interest(_)),
    (interest(X), assert(stud_interest(X))) ; (write('Invalid input!'), nl, input_interest).
input_interest.

input :-
    input_stream,
    input_role,
    input_interest,
    input_cgpa,
    input_grades.
input.

% Logic for elective recommendation

satisfactory_grade(Grade) :-
    between(6, 10, Grade).

pre_req_satisfied([]).
pre_req_satisfied([Head | RestOfPreReq]) :-
    grade(Head, CourseGrade),
    satisfactory_grade(CourseGrade),
    pre_req_satisfied(RestOfPreReq).

pre_req_satisfied_for_elective(Elective) :-
    pre_req(Elective, ListOfPreReq),
    pre_req_satisfied(ListOfPreReq).

department_requirement(Elective) :-
    stud_stream(Stream),
    department_electives(Stream, ListOfDepElectives),
    member(Elective, ListOfDepElectives).

role_requirement(Elective) :-
    stud_role(Role),
    role_electives(Role, ListOfRoleElectives),
    member(Elective, ListOfRoleElectives).

interested_requirement(Elective) :-
    stud_interest(Interest),
    interest_electives(Interest, ListOfInterestElectives),
    member(Elective, ListOfInterestElectives).

check_elective(Elective) :-
    pre_req_satisfied_for_elective(Elective),
    (role_requirement(Elective) ; department_requirement(Elective) ; interested_requirement(Elective)).

recommend_electives :-
    retractall(recommend(_)),
    forall( elective(X), (check_elective(X), assert(recommend(X))) ; true ).

start :-
    input, recommend_electives,
    write('Recommended Electives: '), forall(recommend(X), (full_form(X), write(', '))), nl.
start.