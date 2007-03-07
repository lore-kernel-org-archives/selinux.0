Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l27DIwvd016361
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 08:18:58 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l27DKPPG017093
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 13:20:25 GMT
Received: by wx-out-0506.google.com with SMTP id s17so194334wxc
        for <selinux@tycho.nsa.gov>; Wed, 07 Mar 2007 05:20:25 -0800 (PST)
Message-ID: <45EEBB86.4050408@kaigai.gr.jp>
Date: Wed, 07 Mar 2007 22:17:58 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
References: <45EC0D21.2070706@kaigai.gr.jp>	 <200703062034.24993.russell@coker.com.au>  <45EDBB95.50703@kaigai.gr.jp> <1173208625.1230.6.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1173208625.1230.6.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-03-07 at 04:05 +0900, KaiGai Kohei wrote:
>>>> * There is no compatibility between SE-PostgreSQL and PostgreSQL.
>>>>   You have to pay attention not to destroy your database files
>>>>   for native PostgreSQL.
>>> Have you considered enabling "permissive mode" for the database server such 
>>> that it can run with unlabeled databases?
>>>
>>> Why can't "native PostgreSQL" just ignore the labelling?
>> We have to store a security context of tuple in anywhere, so modifying the file
>> format was not avoidable. The storage manager of PostgreSQL cannot handle different
>> file formats, so SE-PostgreSQL cannot run over the unlabeled databased generated
>> by native PostgreSQL.
>>
>> It might be possible, but I expect more hooks to the PostgreSQL is necessary.
>> It will prevent to follow the version-up of native one.
> 
> Do they provide any kind of attribute / metadata support at that
> granularity?  Along the lines of filesystem xattrs?

Any kind of database objects (like tables, columns) are stored as tuples within
special tables called as system catalog, so I think that associating a security
context with a tuple provides enough granularity.
# The meaning of your question was a bit unclear for me.
# If my response is miss the point, please tell me.

> Could you store the labels in a separate table?  Along the lines of the
> old persistent label mapping in SELinux (issues for consistency and
> performance, of course).

I think unique identification for all tuples are difficult, because we can
create a table without Oid (object id) or primary key to identify a tuple
from outside of the table...

BTW, the string representations of security contexts are stored in a separate
table named as 'pg_selinux', defined with Oid (which have 4-byte length).
In SE-PostgreSQL, any tuples have Oid of pg_selinux as a security context.
Thus, storage consumption is limited.

> Could you split the storage from the presentation such that you only
> store data of one context in a given underlying table and then compose a
> set of single context tables to present a multi-context virtual table?
--
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
