#!/usr/bin/python

import sys
import psycopg2

def main(uWord):
    # Connect to existing database tcount
    tcount_connection = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

    # Open a cursor to perform database operations
    tcount_cursor = tcount_connection.cursor()

    # Query the database and obtain data as Python objects
    if not uWord:
        tcount_cursor.execute("SELECT word, count from tweetwordcount WHERE word=%s", (uWord))
        record = tcount_cursor.fetchone()
        print 'Total number of occurrences of "' + str(record[0]) + '":', record[1], '\n'

    else:
        tcount_cursor.execute("SELECT word, count from tweetwordcount;”)
        records = tcount_cursor.fetchall()
        for rec in records:
            print rec, ","
        print "\n"        

    # Close communication with the database
    tcount_cursor.close()
    tcount_connection.close()

if __name__ == '__main__':
    # run the query
    if len(sys.argv) == 1:
        main(False)
    else:
        main(sys.argv[1])


