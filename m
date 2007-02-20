Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1K27mYF005503
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 21:07:49 -0500
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1K293Cn013522
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 02:09:04 GMT
Message-ID: <45DA5829.7060800@ak.jp.nec.com>
Date: Tue, 20 Feb 2007 11:08:41 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
Subject: Re: [RFC] Security design of SE-PostgreSQL (2/3)
References: <45D542AF.1030108@kaigai.gr.jp> <200702182204.21346.russell@coker.com.au> <45D87B8D.5030307@kaigai.gr.jp> <200702191750.31301.russell@coker.com.au>
In-Reply-To: <200702191750.31301.russell@coker.com.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Monday 19 February 2007 03:15, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
>>>> I have an idea to add the following access vector for the purpose.
>>>>   1. allow (context of client)   (context of database)
>>>> database:load_module;
>>>> 2. allow (context of database) (context of shlib
>>>> file) database:associate;
>>> Who will be loading such modules?  Only the DBA or regular users too?
>> A regular user also can load shared library modules, but it is limited
>> to be placed under '$libdir/plugins/' directory.
>> The DBA can do any files, if PostgreSQL can access.
> 
> What Unix access controls are applied?  I guess that as PostgreSQL users don't 
> have a direct relationship with Unix users it can't check the UID so it's 
> just a matter of what files the database server has read and execute to which 
> are in that directory.
> 
> Does it just check to make sure that the file isn't a sym-link and isn't 
> world-writable.

UNIX access controls are applied between the PostgreSQL server process UID
and shared library files, independent from client process's UID.
A sym-link checking is done, but its purpose is to avoid to load a same
shared library file twice or more.

PostgreSQL documentation says as follows:
|Non-superusers may only apply LOAD to library files located in $libdir/plugins/
| — the specified filename must begin with exactly that string. (It is the database
|   administrator's responsibility to ensure that only "safe" libraries are
|   installed there.)
http://www.postgresql.org/docs/8.2/static/sql-load.html

>>> In the above access control design you control which databases a user may
>>> load modules for and which modules may be associated with a given
>>> database.  But you don't control which modules a user may load.  Is it
>>> possible that modules A and B may be loaded into a database but only user
>>> C will be permitted to load module A?
>> Your indication is correct. The above design can describe the relationship
>> between the client and the database, or between the database and the shared
>> library file.
>> It doesn't describe who can load which modules.
>>
>> We have to describe the relationship between the client, the database
>> and shared library files to block a malicious modules.
>>
>> How do you think the following design to allow to load a module, for
>> example?
>>    allow db_client_t sepgsql_db_t : database { load_module }; 
>>    allow sepgsql_db_t shlib_file_t : database { associate };
>>    allow db_client_t shlib_file_t : database { load_module };
> 
> That would work.
> 
> We already have triples in the policy language for type_transition, I wonder 
> whether we could do something similar for this.  Having three rules when one 
> might do is not easy to understand.
> 
> Other programs might need such triples in the policy, I wonder if it would be 
> possible to make this a generic language feature.  Some sort of policy class 
> which instead of actions takes another type as the third parameter.

I think it should be resolved by macros in the reference policy period.

e.g)
   sepgsql_enable_load_shlib(db_client_t, sepgsql_t, shlib_t)
     =>  allow db_client_t sepgsql_db_t : database { load_module };
         allow sepgsql_db_t shlib_file_t : database { associate };
         allow db_client_t shlib_file_t : database { load_module };

Thanks,
-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
