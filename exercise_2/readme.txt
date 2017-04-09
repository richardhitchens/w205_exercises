Instructions
Create and connect to an EC2 instance using the following AMI:
•	AMI Name: UCB MIDS W205 EX2-FULL
•	AMI ID: ami-d4dd4ec3

As root user:
•	Mount an EBS volume created as per the instructions in Lab 2 at /data (use $ fdisk –l to find the disk to be mounted), e.g. if the disk is /dev/svdf then run:  $ mount –t ext4 /dev/svdf /data
•	Install psycopg by running: $ pip install psycopg2==2.6.2
•	Install Tweepy by running: $ pip install tweepy
•	Start Postgres by running: $ /data/start_postgres.sh

Switch user to w205 by running: $ su – w205

Clone my Git repository by running:  $ git clone https://github.com/richardhitchens/w205_exercises.git

Change directory to $ ~/w205_exercises/exercise_2/extweetwordcount

Create the Postgres database and table by running: $ python database.py

Start the Twitter stream application: $ sparse run

Unlike the hello-twitter-stream.py example there is no time out mechanism for my application as there was no specified requirement for this in the project. After a satisfactory period of time has passed and the database has some records simply kill the stream by hitting Ctrl + C.

With the database now populated it is possible to run queries on the database.
To confirm the database query scripts perform their required actions please run:
•	$ python finalresults.py with
•	$ python finalresults.py
•	$ python histogram.py 20,30
•	$ python topwords.py

All done!

Shut down the instance:
•	Return to root user:  $ exit
•	Stop Hadoop:  $ /root/stop-hadoop.sh
•	Stop Postgres:  $ /data/stop-postgres.sh
•	Terminate the EC2 instance in AWS

