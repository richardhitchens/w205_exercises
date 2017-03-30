#!/usr/bin/python

import sys
import psycopg2

def main(num_top):

    # Connect to existing database tcount
    tcount_connection = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

    # Open a cursor to perform database operations
    tcount_cursor = tcount_connection.cursor()

    # Query the database and obtain data as Python objects
    tcount_cursor.execute("SELECT word, count from tweetwordcount ORDER BY count DESC LIMIT %s", (num_top))
    records = tcount_cursor.fetchall()
    for rec in records:
        print rec[0] +  ":", rec[1], "\n"

    # Close communication with the database
    tcount_cursor.close()
    tcount_connection.close()

if __name__ == '__main__':
    # run the query
    main(int(sys.args[1]))


