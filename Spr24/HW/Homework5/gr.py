class Student:
    def __init__(self, name, age, grades):
        self.name = name
        self.age = age
        self.grades = grades

    def average_grade(self):
        return sum(self.grades) / len(self.grades)

def find_top_student(students):
    top_student = students[0]
    for student in students:
        if student.average_grade() > top_student.average_grade():
            top_student = student
    return top_student

def factorial(n):
    if n == 0:
        return 1
    else:
        return n * factorial(n-1)

def fibonacci(n):
    if n <= 0:
        return []
    elif n == 1:
        return [0]
    elif n == 2:
        return [0, 1]
    else:
        fibs = fibonacci(n-1)
        fibs.append(fibs[-1] + fibs[-2])
        return fibs

def add_grades_to_set(s, grades):
    for grade in grades:
        s.add(grade)
    return s

def calculate_total_length(strings):
    total = 0
    for s in strings:
        total += len(s)
    return total

students = [
    Student('Alice', 20, [90, 92, 85]),
    Student('Bob', 22, [85, 87, 90]),
    Student('Charlie', 23, [100, 95, 90])
]

top_student = find_top_student(students)
print(f'Top student: {top_student.name} with average grade {top_student.average_grade()}')

factorial(5)
fibonacci(10)
find_top_student(students)
add_grades_to_set({1, 2, 3}, [4, 5, 6])
add_grades_to_set({1, 2, 3}, [4, 5, 'six'])
calculate_total_length(['hello', 'world'])
students[0].average_grade()
students[1].average_grade()
students[2].average_grade()
fibonacci(15)
factorial(0)
factorial(10)
add_grades_to_set(set(), [7, 8, 9])
calculate_total_length(['hello', 'world', 123])
calculate_total_length(['one', 'two', 'three'])
students[0].name
students[1].age
students[2].grades
