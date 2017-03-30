from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2


class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()

    def process(self, tup):
        uWord = tup.values[0]

        # Increment the local count
        self.counts[uWord] += 1
        uCount = self.counts[uWord]

        # Insert data into tweetwordcount table

        # Connect to existing database tcount
        tcount_connection = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

        # Open a cursor to perform database operations
        tcount_cursor = tcount_connection.cursor()

        # Update tweetwordcount
        tcount_cursor.execute("UPDATE tweetwordcount SET count=%s WHERE word=%s RETURNING word", (uCount, uWord))
        # Check if any rows were updated
        record = tcount_cursor.fetchall()
        num_rows = len(record)

        # Insert if update is unsuccessful, i.e. no rows updated
        if num_rows == 0:
            tcount_cursor.execute("INSERT INTO tweetwordcount (word, count) VALUES (%s, %s)", (uWord, uCount))

        # make changes to the database permanent
        tcount_connection.commit()

        # Close communication with the database
        tcount_cursor.close()
        tcount_connection.close()

        # Emit the resultant tuple
        self.emit([uWord, uCount])

        # Log the count - just to see the topology running
        self.log('%s: %d' % (uWord, uCount))

