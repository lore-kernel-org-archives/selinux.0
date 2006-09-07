Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87Fqijq017942
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 11:52:44 -0400
Received: from nz-out-0102.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k87FqKEu028119
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 15:52:20 GMT
Received: by nz-out-0102.google.com with SMTP id i11so132982nzi
        for <selinux@tycho.nsa.gov>; Thu, 07 Sep 2006 08:52:42 -0700 (PDT)
Message-ID: <45004041.3020407@kaigai.gr.jp>
Date: Fri, 08 Sep 2006 00:52:33 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL
References: <44FFEB42.90203@kaigai.gr.jp> <1157633535.14982.9.camel@twoface.columbia.tresys.com> <200609072324.51487.russell@coker.com.au> <45002CA4.40907@kaigai.gr.jp> <3FCBC9B9.8000302@tresys.com>
In-Reply-To: <3FCBC9B9.8000302@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>> Do we need separate object classes for database and table?
>>>
>>> We can consider databases and tables to be both roughly equivalent to 
>>> directories in the filesystem permissions.  In a Reiser4 model that 
>>> would be /database/table/row.  ;)
>>>
>>> So we could have:
>>> table_auto_trans(dba1_t, system_db_t, database1_t, table)
>>> table_auto_trans(dba1_t, database1_t, table1_t, table)
>>> table_trans(dba1_t, database1_t, { table2_t table3_t }, table)
>>> table_auto_trans({ dba1_t db_user1_t }, table2_t, row1_t, row)
>>
>> I agree Russell's suggestion, because we can describe those structure
>> with separated type and type_trans rule.
>> In addition, it will be more easily applicable to another DBMS.
>>
> 
> under flask object classes are used to differentiate kinds of objects. 
> It will make the database access control much more fine grained if you 
> implement a proper object model.

Umm, I felt both opinions are correct.
I want to consider for a while and hear any more opinions.

>> I have a question to Russell.
>> How is the security context of database attached?
>> I estimate it should be done by type_trans rule with server process 
>> context
>> and clients process's context on database object class.
>>
> 
> you shouldn't use the server process context since the objects are being 
> created by the client ultimately and should be labeled based on the 
> label of the client. Labeling based on the server context would make for 
> almost unusable labeling granularity.

I'm sorry if my description is confusable.
I didn't say we should use server process's security context as a initial
label of the database. The result of security_compute_create() is used
as a initial label of the database, and the arguments of it is client
process's context as a subject and server process's context as a object.
Do you think it's a strange design?

>> I intend to implement it as a patch against to PostgreSQL, not a 
>> independent
>> proxy server.
>> The reason of this decision is that we cannot enforce SELinux's access 
>> controls
>> to any tables, columns and rows, even if the proxy server rewrite SQL 
>> statement.
>> A query to view is a representative example.
>> PostgreSQL often rewrite SQL statement into something completely 
>> different.
>>
>> Thanks,
> 
> Proxy didn't necessarily mean a proxy server, it could mean anything 
> (even in the same process space) that just relayed and changed the query 
> rather than adding access control callbacks at access points in the 
> database, it is 2 different models of implementing access control and it 
> sounds like you want do to the proxy rather than the hooks.

Ah, OK. I have misunderstood what you say.
In the plan currently I have, the 'proxy' is deployed between the rewriter
and the optimizer.
(*) the rewriter and the optimizer are modules in PostgreSQL.

> I still think triggers and stored procedures can be problematic with 
> this model, just keep it in mind..

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
