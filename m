Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l544OB1I025476
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2007 00:24:11 -0400
Received: from www346.sakura.ne.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l544O7Hw001226
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2007 04:24:09 GMT
Message-Id: <200706040423.l544NU3H086014@www346.sakura.ne.jp>
Subject: [RFC] permissions for conditional UPDATE statement
From: kaigai@kaigai.gr.jp
To: jbrindle@tresys.com, russell@coker.com.au
Cc: selinux@tycho.nsa.gov, kaigai@kaigai.gr.jp, kaigai@ak.jp.nec.com
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Date: Mon, 04 Jun 2007 13:23:30 +0900
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It is a RFC in security design of SE-PostgreSQL.

In the current version of SE-PostgreSQL, {select update} for table,
column and tuple classes are required when a client execute a SQL
query with conditional UPDATE query, for example.

It means that the following SQL requires '{select update}' permission,
not only 'update', because the query tries to refer 'z' column
of 'tbl_1' table on WHERE clause.

  UPDATE tbl_1 SET x = 10, y = 'aaa' WHERE z = true;

The query indeed refers 'tbl_1', 'z' column and each targeted tuples,
so 'select' permission might be appropriate.
But there is a significant difference from general SELECT statement
from conditional UPDATE. It does not return its content.

We have a matter in this approach. DBA have to allow SELECT permission
to enable conditional UPDATE statement, even if he does not want to
expose its contents.

I have an idea to solve them. add 'reference' (or 'refer') permission
on table, column and tuple object classes.
It means references to those objects without returning their contents
to clients.

Any comments please,
Thanks,
--
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
