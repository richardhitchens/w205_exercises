import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Connect to the postgres database
postgres_connection = psycopg2.connect(database="postgres", user="postgres", password="pass", host="localhost", port="5432")

#####Create the tcount database#####

try:
    postgres_connection.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    
    # Open a cursor to perform database operations
    postgres_cursor = postgres_connection.cursor()
    
    # Execute a command: to create tcount database
    postgres_cursor.execute("CREATE DATABASE tcount;")
    
    # Close communication with the database
    postgres_cursor.close()
    postgres_connection.close()

except:
    print "Could not create tcount"

##### Create tweetwordcount table #####

# Connect to existing database tcount
tcount_connection = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

# Open a cursor to perform database operations
tcount_cursor = tcount_connection.cursor()

# Execute a command: to create tweetwordcount table in the database
tcount_cursor.execute("CREATE TABLE tweetwordcount (word TEXT PRIMARY KEY, count INT NOT NULL);")

# Make the changes to the database persistent
tcount_connection.commit()

# Close communication with the database
tcount_cursor.close()
tcount_connection.close()



