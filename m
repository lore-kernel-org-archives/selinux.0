Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m174qOCP017502
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2008 23:52:24 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m174qNn6001153
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 04:52:23 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m174qNcc026647
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2008 23:52:23 -0500
Message-ID: <47AA8E86.8010501@redhat.com>
Date: Wed, 06 Feb 2008 23:52:22 -0500
From: Shawn Wells <swells@redhat.com>
Reply-To: swells@redhat.com
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
CC: gov-eng@redhat.com, Matthew Jamison <jamisonm@redhat.com>
Subject: Multithreaded applications, SELinux, and RAM Protection
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

    I have a customer who is encountering the following issue, and I've 
been unable to solve it myself.

    The scenario:

WebUserX (with TS//SCI//Alpha) sends a query to MACHINE1 which then 
parses the query and executes it on a database. 
For example:
|-- WebUserX Sends Query to Query Engine
|--------> Query Engine creates new thread, parses, sends to database
|--------|--------> Database executes & returns data
|--------|--------|--------> Data is stored in RAM, say the first 512MB 
of allocatable space
|--------|--------|--------|--------> Data passed back to WebUserX
|--------|--------|--------|--------|--------> Query Engine thread dies, 
marks first 512MB of RAM available.  Doesn't delete the data in RAM, but 
it is now tagged as available.

WebUserY (with TS//SCI//Bravo) sends a different query to MACHINE1 which 
then parses the query and executes it on a database.  Same process is 
followed, however the query engine thread becomes highjacked (bad SQL, 
bad coding, whatever). 

The customer is considering writing a hook to zero-out the RAM after the 
thread dies, but this will be a lengthy process.

With all that said, my question is:  how can we make sure that the 
thread handling WebUserYs' connection (which is running as 
TS//SCI//Bravo) can not see the data in the first 512MB of RAM (which 
contains TS//SCI//Alpha)?

Possible ideas, that I just don't know enough about yet:
1)  Program maps anonymous memory with mmap with PROT_EXEC. Note that 
because anonymous memory is zero'd out by the system it makes not much 
sense to not have it writable as well. (stolen from 
http://people.redhat.com/~drepper/selinux-mem.html)


I googled "selinux, multithreaded applications," but didn't find to 
much.  Thanks for any help!
   

-- 
Shawn D. Wells
Solutions Architect, Federal Team


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
