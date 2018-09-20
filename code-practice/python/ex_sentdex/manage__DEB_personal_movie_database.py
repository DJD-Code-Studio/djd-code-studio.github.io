
# importing necessary libraries

import sqlite3


conn = sqlite3.connect('C:/DEB/myGitRepos/djd-code-studio.github.io/sqlite-db-s/DEB_personal_movie_database.db')
c = conn.cursor()


def show_tables():
    c.execute(".TABLES")


def read_db():
    c.execute("SELECT rowid, tbl_name FROM SQLITE_MASTER WHERE type='table';")
    tablerows = c.fetchall()
    #print(tablerows)
    for row in tablerows:
        print(row)
    def read_msg():
        print("The table names have been printed")
        print("The last table name was : " + str(row))
    
    #read_msg()
    
def movie_db_insert():
    print("TBC")
def movie_db_read():
    print("TBC")
def movie_db_update():
    print("TBC")
def movie_db_delete():
    print("TBC")
    
       
def read_row():
    c.execute("SELECT * FROM SQLITE_MASTER WHERE type='table';")
    tablerow = c.fetchone()
    print(tablerow)
    #for row in tablerows:
     #   print(row)



def user_menu():
    selection=0
    print("\n\n\t\tPlease select your action from the options below  : \n")
    print("\t\t\t1\t : for adding new movie to the database")
    print("\t\t\t2\t : for deleting movie/s from the database")
    print("\t\t\t3\t : for modifying movie records in the database")
    print("\t\t\t4\t : for looking up movie records from the database")
    print(input("\n\n\t\t\t\t::\t"),selection)
    
 #   if(selection == 1):
        
        
    
    
#show_tables()

read_db()

#read_row()

user_menu()