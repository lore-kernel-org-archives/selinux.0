Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1IGEAHX017613
	for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 11:14:10 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1IGFQac010557
	for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 16:15:26 GMT
Received: by nz-out-0506.google.com with SMTP id z3so1346045nzf
        for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 08:15:26 -0800 (PST)
Message-ID: <45D87B8D.5030307@kaigai.gr.jp>
Date: Mon, 19 Feb 2007 01:15:09 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux@tycho.nsa.gov, jbrindle@tresys.com
Subject: Re: [RFC] Security design of SE-PostgreSQL (2/3)
References: <45D542AF.1030108@kaigai.gr.jp> <200702182204.21346.russell@coker.com.au>
In-Reply-To: <200702182204.21346.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, Russell

Russell Coker wrote:
> On Friday 16 February 2007 16:35, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
>> 2. about Loadable module
>>
>> PostgreSQL allowed to load dynamic link library.
>> It has a possibility to mess up the access control of SE-PostgreSQL no need
>> to say, so we have to restrict loading them by the security policy.
>>
>> I have an idea to add the following access vector for the purpose.
>>   1. allow (context of client)   (context of database)  
>> database:load_module;
>> 2. allow (context of database) (context of shlib 
>> file) database:associate;
> 
> Who will be loading such modules?  Only the DBA or regular users too?

A regular user also can load shared library modules, but it is limited
to be placed under '$libdir/plugins/' directory.
The DBA can do any files, if PostgreSQL can access.

> In the above access control design you control which databases a user may load 
> modules for and which modules may be associated with a given database.  But 
> you don't control which modules a user may load.  Is it possible that modules 
> A and B may be loaded into a database but only user C will be permitted to 
> load module A?

Your indication is correct. The above design can describe the relationship
between the client and the database, or between the database and the shared
library file.
It doesn't describe who can load which modules.

We have to describe the relationship between the client, the database
and shared library files to block a malicious modules.

How do you think the following design to allow to load a module, for example?
   allow db_client_t sepgsql_db_t : database { load_module };
   allow sepgsql_db_t dhlib_file_t : database { associate };
   allow db_client_t shlib_file_t : database { load_module };
                     ^^^^^^^^^^^^
> Do modules have parameters?  Or is there only one way that a module can be 
> used?

It didn't have any parameters.
It is simply linked, and called as an implementation of the stored procedure.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
