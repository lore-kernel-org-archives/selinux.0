Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m175cZQ9019880
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 00:38:35 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m175cYn6009201
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 05:38:34 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m175cUtx006600
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 00:38:30 -0500
Message-ID: <47AA9956.6030002@redhat.com>
Date: Thu, 07 Feb 2008 00:38:30 -0500
From: Shawn Wells <swells@redhat.com>
Reply-To: swells@redhat.com
MIME-Version: 1.0
To: Ben Woodard <woodard@redhat.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: [gov-eng] Multithreaded applications, SELinux, and RAM Protection
References: <47AA8E86.8010501@redhat.com> <47AA91D7.1010504@redhat.com>
In-Reply-To: <47AA91D7.1010504@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ben Woodard wrote:
> Shawn Wells wrote:
>> Hi All,
>>
>>    I have a customer who is encountering the following issue, and 
>> I've been unable to solve it myself.
>>
>>    The scenario:
>>
>> WebUserX (with TS//SCI//Alpha) sends a query to MACHINE1 which then 
>> parses the query and executes it on a database. For example:
>> |-- WebUserX Sends Query to Query Engine
>> |--------> Query Engine creates new thread, parses, sends to database
>> |--------|--------> Database executes & returns data
>> |--------|--------|--------> Data is stored in RAM, say the first 
>> 512MB of allocatable space
>> |--------|--------|--------|--------> Data passed back to WebUserX
>> |--------|--------|--------|--------|--------> Query Engine thread 
>> dies, marks first 512MB of RAM available.  Doesn't delete the data in 
>> RAM, but it is now tagged as available.
>>
> 1st suggestion, don't use threads for the query. The first line of 
> defense that I would setup is to make sure that each and every query 
> operates in its own compartmentalized address space. Threads share 
> address space. Processes do not.

Would it be possible, I'm guessing through setcon(), to have threads 
change their context and label the data in RAM?  Thus revoking 
different/lesser threads from accessing that data later? I'm guessing 
not, as I believe setcon would change the label for the process, not the 
thread -- is this correct? (the man page leads me to this, but I thought 
I'd ask)


>
> Suggestion 2 be very very careful in making distinctions between 
> address apace and RAM. The operating system manages the RAM and gives 
> the process address space which might be backed by RAM at any given 
> point. I believe that if you are more careful about delinitating the 
> two then this will be a simpler problem for you to solve.

Say a process received a range of address space, which was backed by 
RAM, and placed labeled (TS//SCI//Alpha) data into it.  Later a process 
with a lower label receives the same range of address space.  Assuming 
there is data with the old label still in that range, will the new 
process be able to access the old data?

Any pointers to where I can educate myself about how RAM & process space 
is allocated?  I've been googling, but anyone have some favorite docs?



>
>> WebUserY (with TS//SCI//Bravo) sends a different query to MACHINE1 
>> which then parses the query and executes it on a database.  Same 
>> process is followed, however the query engine thread becomes 
>> highjacked (bad SQL, bad coding, whatever).
>> The customer is considering writing a hook to zero-out the RAM after 
>> the thread dies, but this will be a lengthy process.
>>
>> With all that said, my question is:  how can we make sure that the 
>> thread handling WebUserYs' connection (which is running as 
>> TS//SCI//Bravo) can not see the data in the first 512MB of RAM (which 
>> contains TS//SCI//Alpha)?
>>
>> Possible ideas, that I just don't know enough about yet:
>> 1)  Program maps anonymous memory with mmap with PROT_EXEC. Note that 
>> because anonymous memory is zero'd out by the system it makes not 
>> much sense to not have it writable as well. (stolen from 
>> http://people.redhat.com/~drepper/selinux-mem.html)
>>
>>
>> I googled "selinux, multithreaded applications," but didn't find to 
>> much.  Thanks for any help!
>>  
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
