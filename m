Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87F1SSs016459
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 11:01:29 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k87F13Eu020761
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 15:01:04 GMT
Message-ID: <3FCBC9B9.8000302@tresys.com>
Date: Mon, 01 Dec 2003 18:07:37 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
CC: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL
References: <44FFEB42.90203@kaigai.gr.jp> <1157633535.14982.9.camel@twoface.columbia.tresys.com> <200609072324.51487.russell@coker.com.au> <45002CA4.40907@kaigai.gr.jp>
In-Reply-To: <45002CA4.40907@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> Sorry for delayed replying. :)
> 
> Russell Coker wrote:
>> On Thursday 07 September 2006 22:52, Joshua Brindle 
>> <jbrindle@tresys.com> wrote:
>>>> I propose a new object class named as 'database' which contains the
>>>> following access vectors.
>>>>
>>>>   class database
>>>>   {
>>>>       createtbl
>>>>       altertbl
>>>>       droptbl
>>>>       select
>>>>       update
>>>>       insert
>>>>       delete
>>>>       relabelfrom
>>>>       relabelto
>>>>   }
>>> I think you are almost there, below you talk about labeling the tables,
>>> rows, etc individually but your object model above isn't treating them
>>> any differently.
>>>
>>> The object model should have an object class for each distinct kind of
>>> object, for example database should have create, drop, createtable,
>>> droptable, relabelto, relabelfrom. the table object class should have
>>> insert. update, delete, select, drop, create, etc. field (or column)
>>> object class should have select, update, etc.
>>
>> Do we need separate object classes for database and table?
>>
>> We can consider databases and tables to be both roughly equivalent to 
>> directories in the filesystem permissions.  In a Reiser4 model that 
>> would be /database/table/row.  ;)
>>
>> So we could have:
>> table_auto_trans(dba1_t, system_db_t, database1_t, table)
>> table_auto_trans(dba1_t, database1_t, table1_t, table)
>> table_trans(dba1_t, database1_t, { table2_t table3_t }, table)
>> table_auto_trans({ dba1_t db_user1_t }, table2_t, row1_t, row)
> 
> I agree Russell's suggestion, because we can describe those structure
> with separated type and type_trans rule.
> In addition, it will be more easily applicable to another DBMS.
> 

under flask object classes are used to differentiate kinds of objects. 
It will make the database access control much more fine grained if you 
implement a proper object model.

> I have a question to Russell.
> How is the security context of database attached?
> I estimate it should be done by type_trans rule with server process context
> and clients process's context on database object class.
> 

you shouldn't use the server process context since the objects are being 
created by the client ultimately and should be labeled based on the 
label of the client. Labeling based on the server context would make for 
almost unusable labeling granularity.

>>>> (A) select * from customer;
>>>>
>>>> (B) select * from customer where avc_has_perm(getpeercon(),
>>>>                                               security_context,
>>>>                                               DATABASE__SELECT);
>>> So is this done from within the database or are you trying to make a
>>> trusted proxy that will munge requests before they make it to the
>>> database server?
>>
>> When I briefly discussed such things with KaiGai the idea was to have 
>> it within the database.  A proxy would be very inefficient for this if 
>> SE Linux controls were used in any serious manner.  Large amounts of 
>> data could be retrieved only to be discarded by the proxy.
> 
> I intend to implement it as a patch against to PostgreSQL, not a 
> independent
> proxy server.
> The reason of this decision is that we cannot enforce SELinux's access 
> controls
> to any tables, columns and rows, even if the proxy server rewrite SQL 
> statement.
> A query to view is a representative example.
> PostgreSQL often rewrite SQL statement into something completely different.
> 
> Thanks,

Proxy didn't necessarily mean a proxy server, it could mean anything 
(even in the same process space) that just relayed and changed the query 
rather than adding access control callbacks at access points in the 
database, it is 2 different models of implementing access control and it 
sounds like you want do to the proxy rather than the hooks.

I still think triggers and stored procedures can be problematic with 
this model, just keep it in mind..

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
