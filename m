Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88CPW99016309
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 08:25:32 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88COoG1017808
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 12:25:08 GMT
Received: by py-out-1112.google.com with SMTP id 39so670059pyu
        for <selinux@tycho.nsa.gov>; Fri, 08 Sep 2006 05:25:32 -0700 (PDT)
Message-ID: <45016132.60207@kaigai.gr.jp>
Date: Fri, 08 Sep 2006 21:25:22 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL
References: <44FFEB42.90203@kaigai.gr.jp>	 <1157633535.14982.9.camel@twoface.columbia.tresys.com>	 <200609072324.51487.russell@coker.com.au> <45002CA4.40907@kaigai.gr.jp>	 <3FCBC9B9.8000302@tresys.com>  <45004041.3020407@kaigai.gr.jp> <1157648557.22185.8.camel@twoface.columbia.tresys.com>
In-Reply-To: <1157648557.22185.8.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Because the SMTP server of my office was not allowed to deliver
SELinux-list, I posted it again from my house.
I'm sorry if you received same message twice.

>>> under flask object classes are used to differentiate kinds of objects.
>>> It will make the database access control much more fine grained if you
>>> implement a proper object model.
>> Umm, I felt both opinions are correct.
>> I want to consider for a while and hear any more opinions.
>>
>
> we've been thinking about this a little here at tresys and have some
> ideas about the object model if you are interested..

I'm interested in your ideas. Can you post it?

>>> you shouldn't use the server process context since the objects are being
>>> created by the client ultimately and should be labeled based on the
>>> label of the client. Labeling based on the server context would make for
>>> almost unusable labeling granularity.
>> I'm sorry if my description is confusable.
>> I didn't say we should use server process's security context as a initial
>> label of the database. The result of security_compute_create() is used
>> as a initial label of the database, and the arguments of it is client
>> process's context as a subject and server process's context as a object.
>> Do you think it's a strange design?
>>
>
> The database, table and column objects should be labeled the same way
> any other object in SELinux is labeled. It can either be a policy driven
> label (security_compute_create) or be explicit. When an administrator
> sets up the schema for a table he'll want to label the columns
> explicitly if they'll have different access matrices. SQL extensions
> will be required to handle this:
>
> CREATE table users ( username char(24), password char(24)
> context('system_u:object_r:db_users_password_t'));
>
> (or whatever)
>
> meaning that parts of the schema have labels (which is how you determine
> if one can insert, delete, etc into a specific table). Additionally any
> data put into the database is labeled via security_compute_create on a
> per row basis (if you choose to make it that fine grained).
>
> At a minimum you should have the different kinds of objects (databases,
> tables, columns, stored procedures) and label them either explicitly or
> via security_compute_create.

I agree this opinion those objects should be labeled either
implicitly by security policy or explicitly by administrator.

As you mentioned, we can determine the initial label of rows and
tables from security_compute_create() with the combination of the
client process and the label of the table or the database.
But how can we decide the initial lebal of database in this case?

To solve this problem, I said the initial label of database should be
determine from security_compute_create() with the combination of the
client process's label and the server process's label.
In other words, I intend to use the server process's context as an
entry point of type transiton for newly created database.

>>>> I intend to implement it as a patch against to PostgreSQL, not a
>>>> independent
>>>> proxy server.
>>>> The reason of this decision is that we cannot enforce SELinux's access
>>>> controls
>>>> to any tables, columns and rows, even if the proxy server rewrite SQL
>>>> statement.
>>>> A query to view is a representative example.
>>>> PostgreSQL often rewrite SQL statement into something completely
>>>> different.
>>>>
>>>> Thanks,
>>> Proxy didn't necessarily mean a proxy server, it could mean anything
>>> (even in the same process space) that just relayed and changed the query
>>> rather than adding access control callbacks at access points in the
>>> database, it is 2 different models of implementing access control and it
>>> sounds like you want do to the proxy rather than the hooks.
>> Ah, OK. I have misunderstood what you say.
>> In the plan currently I have, the 'proxy' is deployed between the rewriter
>> and the optimizer.
>> (*) the rewriter and the optimizer are modules in PostgreSQL.
>>
>>> I still think triggers and stored procedures can be problematic with
>>> this model, just keep it in mind..
>
> Reiterating above, I don't think you can get full coverage of either the
> schema model above or fine grained row level access with the proxy model
> above.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
