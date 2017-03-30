#!/usr/bin/python

import sys
import psycopg2

def main(len1, len2):
    
    # Connect to existing database tcount
    tcount_connection = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

    # Open a cursor to perform database operations
    tcount_cursor = tcount_connection.cursor()

    # Query the database and obtain data as Python objects
    tcount_cursor.execute("SELECT word, count from tweetwordcount WHERE count >= %s AND count <= %s;", (len1, len2))
    records = tcount_cursor.fetchall()
    print "All words of frequency between", len1, "and", len2, "times in the database:"
    for rec in records:
        print rec[0] +  ":", rec[1]       

    # Close communication with the database
    tcount_cursor.close()
    tcount_connection.close()

if __name__ == '__main__':
    # run the query
    args = sys.argv[1].split(',')    
    main(int(args[0]), int(args[1]))


