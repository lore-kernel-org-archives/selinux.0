Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28DAn6f001063
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 08:10:49 -0500
Received: from py-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28DCGHa016735
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 13:12:16 GMT
Received: by py-out-1112.google.com with SMTP id a78so191177pyh
        for <selinux@tycho.nsa.gov>; Thu, 08 Mar 2007 05:12:16 -0800 (PST)
Message-ID: <45F00BA8.6090107@kaigai.gr.jp>
Date: Thu, 08 Mar 2007 22:12:08 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: casey@schaufler-ca.com, Stephen Smalley <sds@tycho.nsa.gov>,
        russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
References: <989281.84407.qm@web36612.mail.mud.yahoo.com> <45EEE1C1.4070804@tresys.com>
In-Reply-To: <45EEE1C1.4070804@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Casey Schaufler wrote:
>> --- KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
>>
>>  
>>  
>>> I think unique identification for all tuples are
>>> difficult, because we can
>>> create a table without Oid (object id) or primary
>>> key to identify a tuple
>>> from outside of the table...
>>>
>>> BTW, the string representations of security contexts
>>> are stored in a separate
>>> table named as 'pg_selinux', defined with Oid (which
>>> have 4-byte length).
>>> In SE-PostgreSQL, any tuples have Oid of pg_selinux
>>> as a security context.
>>> Thus, storage consumption is limited.
>>>     
>>
>> How does this method compare to the schemes
>> used in the Oracle evaluated MLS DBMS?
>>
>>   
> IIRC Oracle basically has polyinstanciated tables (using views) to 
> implement MLS, which gives far less granularity and doesn't allow for 
> labeled rows or columns. KaiGai's work leverages all the security models 
> SELinux can use to allow for flexible policies. The technical decision 
> to use another table to store the oid of the context seems appropriate, 
> since that is how rdbms's operate in general.

I think the biggest difference is whether RDBMS utilizes the security
functionalities of operating system, or not.

For example, SE-PostgreSQL obtains the security context of the client via
getpeercon(), and makes a decision with the security policy.
It enables to ensure a process with lower clearance cannot access secret
data, even if it is stored in database.

In my understanding, Oracle pay no attention for the peer's clearance.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
