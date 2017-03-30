#!/usr/bin/python

import sys
import psycopg2

def main(uWord):
    # Connect to existing database tcount
    tcount_connection = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

    # Open a cursor to perform database operations
    tcount_cursor = tcount_connection.cursor()

    # Query the database and obtain data as Python objects
    if uWord == 1:
        tcount_cursor.execute("SELECT word, count FROM tweetwordcount;")
        records = tcount_cursor.fetchall()
        my_str = ''
        print 'All words in the database:'
        for rec in records:
            my_str += "(" + str(rec[0]) + "," + str(rec[1]) + ")"  + ", "
        print my_str[:-2] + "\n"
    else:
        tcount_cursor.execute("SELECT word, count FROM tweetwordcount WHERE word=%s", (uWord,))
        record = tcount_cursor.fetchone()
        if record is None:
            print 'Total number of occurrences of "' + str(uWord) + '": 0', '\n'        
        else:
            print 'Total number of occurrences of "' + str(record[0]) + '":', record[1], '\n'

    # Close communication with the database
    tcount_cursor.close()
    tcount_connection.close()

if __name__ == '__main__':
    # run the query
    if len(sys.argv) == 1:
        main(1)    
    else:    
        main(sys.argv[1])


