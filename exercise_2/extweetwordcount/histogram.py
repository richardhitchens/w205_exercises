#!/usr/bin/python

import sys
import psycopg2

def main(len1, len2):
    # cast len1 and len2 as integers
    len1 = int(len1)    
    len2 = int(len2)    

    # Connect to existing database tcount
    tcount_connection = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

    # Open a cursor to perform database operations
    tcount_cursor = tcount_connection.cursor()

    # Query the database and obtain data as Python objects
    tcount_cursor.execute("SELECT word, count from tweetwordcount WHERE count >= len1 AND count <= len2;")
    records = tcount_cursor.fetchall()
    for rec in records:
        print rec[0] +  ":", rec[1], "\n"        

    # Close communication with the database
    tcount_cursor.close()
    tcount_connection.close()

if __name__ == '__main__':
    # run the query
    main(sys.argv[1], sys.argv[2])


