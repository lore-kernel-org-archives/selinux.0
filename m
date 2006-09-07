Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87F78Ub016627
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 11:07:08 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k87F6hEu021580
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 15:06:44 GMT
Received: by py-out-1112.google.com with SMTP id 39so322479pyu
        for <selinux@tycho.nsa.gov>; Thu, 07 Sep 2006 08:07:05 -0700 (PDT)
Message-ID: <4500358F.9030808@kaigai.gr.jp>
Date: Fri, 08 Sep 2006 00:06:55 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL
References: <44FFEB42.90203@kaigai.gr.jp>	 <200609072324.51487.russell@coker.com.au>	 <1157637259.14982.22.camel@twoface.columbia.tresys.com>	 <200609080007.39558.russell@coker.com.au> <1157638500.14982.29.camel@twoface.columbia.tresys.com>
In-Reply-To: <1157638500.14982.29.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I intend to filter the result set by appending avc_has_perm(...) condition
for each targeted table. I believe it is the most simple implementation
and it can utilize the optimizer of PostgreSQL.

>>> (A) select * from customer;
>>>
>>> (B) select * from customer where avc_has_perm(getpeercon(),
>>>                                               security_context,
>>>                                               DATABASE__SELECT);
> 
> A turns in to B via the proxy. Then the database does the avc_has_perm
> check as part of the query. An administrator would have more access via
> the policy. The proxy would not be discarding anything.

If we consider the modules in PostgreSQL as separated processes,
we may be able to say this mechanism the proxy.
But we cannot rewrite SQL statement outside the server process,
because PosgreSQL itself may rewrite the query tree internally.

The details are described in the following URL:
  Chapter 34. The Rule System
  http://www.postgresql.org/docs/8.1/static/rules.html

By the above reason, we must inject additional conditions of
SELinux after completion of query rewriting, and we cannot
have any option except the implementation within DBMS.

>> Then when you do a join of two tables with such configurations things would 
>> get even more interesting for the author of a proxy.
>>
>>> One could even use the proxy model within the same process space to
>>> manipulate the query as it enters the database server instead of hooking
>>> in to the database server at every access point.
>>>
>>> The bad part about this is that it makes for a less fine grained model
>>> than hooking at access points.
>> If you want to only control table access then things become much easier.

When we do a join of two tables, the joined virtual table are generated
from filtered two result set. All of its contains are allowed to select.

The result is same, even if a view was defined as a select statement
which do a join of multiple tables.

> like I said, "it makes for a less fine grained model"
> 
>>> One thing to think about is stored procedures and how those can be dealt
>>> with, triggers, etc. Without access control hooks triggers are much
>>> harder to deal with access control wise, as are stored procedures.

The stored procedure is a bit considerable.
Now I cannot conclude about its handling whether it's suitable for this solution.
More hacking to PostgreSQL is necessary. ;)

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
