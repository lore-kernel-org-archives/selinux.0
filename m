Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JEA77h026720
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 10:10:07 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2JEA63K027428
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 14:10:06 GMT
Received: by wr-out-0506.google.com with SMTP id 68so1278755wri
        for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 07:10:06 -0700 (PDT)
Message-ID: <45FE9A2F.40200@kaigai.gr.jp>
Date: Mon, 19 Mar 2007 23:11:59 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: The reason why SEPostgreSQL use original userspace AVC
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

This was one of the topics discussed on SELinux developer summit held on
last Friday.
I like to send the reason why I made a decision to implement SE-PostgreSQL
with original userspace AVC, for wider discussion.
(SE-PostgreSQL didn't use the userspace AVC provided by libselinux.)

There are two major reasons. The one is a performance gain. The other is
concurrency of invalidation.

Any comment and suggestion please.

[ performance gain ]

The biggest reason is originated from the way to associate a security context
for each tuple. As I mentioned, I modified the internal data structure of
tuples to add its security context. The field is a 4-byte length integer
variable (same as object id data type), not a string expression.
This value is associated with the contains of 'pg_selinux'.

'pg_selinux' is one of the system catalogs. System catalogs are special tables
which contains database meta information like definition of table, view, stored
procedure and so on.
'pg_selinux' has two column. One is 'oid' defined as object id type. It hold
a unique number within the table. The other is 'selcontext' defined as variable
length text type. It hold a security context in text expression.
So, we can refer the pg_selinux system catalog, when a text expression of security
context is required.
(e.g A case when 'security_context' is specified in SQL queries.)

The object id enables to identify a security context in text expression, so we
can also apply them as a key of userspace avc. I named it as psid (persistent
security id).

Using psid enables to be unnecessary to handle a text represented security context
in the most frequently path. When we have to make a decision whether the fetched
tuple is allowed or not, we can search the userspace avc with psid held by the tuple
as is.

In the userspace avc provided by libselinux. Its avc_has_perm() requires security_id_t
as arguments, but it means we have to translate security context from psid to text
representation in a decision making process.
No need to say, it make a bad effect to the performance of SE-PostgreSQL.

[ concurrency of invalidation ]

SE-PostgreSQL deploys its userspace avc on the shared memory region, and generates
a single policy state monitoring process to poll netlink socket at bootup time.
It enables to invalidate the userspace avc referred by all SE-PostgreSQL instances
concurrently.

If the userspace avc is deployed on the process local memory for each instance,
we need policy state monitoring threads for each instances and the invalidation
of userspace avc is not done concurrently.
At a moment, different policies may be applied between SE-PostgreSQL instances.

In addition, we will get a little performance improvement on startup time of instances.
If the userspace avc deployed on the shared memory region, it may contains several
access control rules before it is referred at first. It enables to reduce the number
of calling system-call.
And, it is not necessary to generate a policy state monitoring thread for each
SE-PostgreSQL instance.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
