Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l55CwBS7021820
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 08:58:11 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l55Cw8N4004850
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 12:58:08 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] permissions for conditional UPDATE statement
Date: Tue, 5 Jun 2007 08:58:08 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588BF045B@exchange.columbia.tresys.com>
In-Reply-To: <200706040423.l544NU3H086014@www346.sakura.ne.jp>
References: <200706040423.l544NU3H086014@www346.sakura.ne.jp>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <kaigai@kaigai.gr.jp>, <russell@coker.com.au>
Cc: <selinux@tycho.nsa.gov>, <kaigai@ak.jp.nec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

kaigai@kaigai.gr.jp wrote:
> It is a RFC in security design of SE-PostgreSQL.
> 
> In the current version of SE-PostgreSQL, {select update} for
> table, column and tuple classes are required when a client
> execute a SQL query with conditional UPDATE query, for example.
> 
> It means that the following SQL requires '{select update}'
> permission, not only 'update', because the query tries to
> refer 'z' column of 'tbl_1' table on WHERE clause.
> 
>   UPDATE tbl_1 SET x = 10, y = 'aaa' WHERE z = true;
> 
> The query indeed refers 'tbl_1', 'z' column and each targeted
> tuples, so 'select' permission might be appropriate.
> But there is a significant difference from general SELECT
> statement from conditional UPDATE. It does not return its content.
> 
> We have a matter in this approach. DBA have to allow SELECT
> permission to enable conditional UPDATE statement, even if he
> does not want to expose its contents.
> 
> I have an idea to solve them. add 'reference' (or 'refer')
> permission on table, column and tuple object classes.
> It means references to those objects without returning their contents
> to clients. 
> 

I agree to some extent. The where clause can be used to enumerate what
data might be but doesn't tell you what it is explicitely (the boolean
above is a bad example, something like an unknown string is a lot
harder). I kind of like the 'use' permission more, it can be used
anywhere this sort of thing happens where extra granularity doesn't
help.

As an aside, I'm glad to see you are continuing this work dispite
resistance upstream. Do you have a plan for inclusion? Have you talked
to upstream offline or somewhere not public about what their problems
are?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
