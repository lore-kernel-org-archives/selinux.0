Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87ET3tC015429
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 10:29:03 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k87ESdEu016324
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 14:28:40 GMT
Received: by py-out-1112.google.com with SMTP id 39so310325pyu
        for <selinux@tycho.nsa.gov>; Thu, 07 Sep 2006 07:29:01 -0700 (PDT)
Message-ID: <45002CA4.40907@kaigai.gr.jp>
Date: Thu, 07 Sep 2006 23:28:52 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL
References: <44FFEB42.90203@kaigai.gr.jp> <1157633535.14982.9.camel@twoface.columbia.tresys.com> <200609072324.51487.russell@coker.com.au>
In-Reply-To: <200609072324.51487.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry for delayed replying. :)

Russell Coker wrote:
> On Thursday 07 September 2006 22:52, Joshua Brindle <jbrindle@tresys.com> 
> wrote:
>>> I propose a new object class named as 'database' which contains the
>>> following access vectors.
>>>
>>>   class database
>>>   {
>>>       createtbl
>>>       altertbl
>>>       droptbl
>>>       select
>>>       update
>>>       insert
>>>       delete
>>>       relabelfrom
>>>       relabelto
>>>   }
>> I think you are almost there, below you talk about labeling the tables,
>> rows, etc individually but your object model above isn't treating them
>> any differently.
>>
>> The object model should have an object class for each distinct kind of
>> object, for example database should have create, drop, createtable,
>> droptable, relabelto, relabelfrom. the table object class should have
>> insert. update, delete, select, drop, create, etc. field (or column)
>> object class should have select, update, etc.
> 
> Do we need separate object classes for database and table?
> 
> We can consider databases and tables to be both roughly equivalent to 
> directories in the filesystem permissions.  In a Reiser4 model that would 
> be /database/table/row.  ;)
> 
> So we could have:
> table_auto_trans(dba1_t, system_db_t, database1_t, table)
> table_auto_trans(dba1_t, database1_t, table1_t, table)
> table_trans(dba1_t, database1_t, { table2_t table3_t }, table)
> table_auto_trans({ dba1_t db_user1_t }, table2_t, row1_t, row)

I agree Russell's suggestion, because we can describe those structure
with separated type and type_trans rule.
In addition, it will be more easily applicable to another DBMS.

I have a question to Russell.
How is the security context of database attached?
I estimate it should be done by type_trans rule with server process context
and clients process's context on database object class.

>>> (A) select * from customer;
>>>
>>> (B) select * from customer where avc_has_perm(getpeercon(),
>>>                                               security_context,
>>>                                               DATABASE__SELECT);
>> So is this done from within the database or are you trying to make a
>> trusted proxy that will munge requests before they make it to the
>> database server?
> 
> When I briefly discussed such things with KaiGai the idea was to have it 
> within the database.  A proxy would be very inefficient for this if SE Linux 
> controls were used in any serious manner.  Large amounts of data could be 
> retrieved only to be discarded by the proxy.

I intend to implement it as a patch against to PostgreSQL, not a independent
proxy server.
The reason of this decision is that we cannot enforce SELinux's access controls
to any tables, columns and rows, even if the proxy server rewrite SQL statement.
A query to view is a representative example.
PostgreSQL often rewrite SQL statement into something completely different.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
