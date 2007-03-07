Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l27F3jcU020285
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 10:03:45 -0500
Received: from web36612.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l27F59vl020594
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 15:05:11 GMT
Date: Wed, 7 Mar 2007 06:58:27 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
To: KaiGai Kohei <kaigai@kaigai.gr.jp>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
In-Reply-To: <45EEBB86.4050408@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <989281.84407.qm@web36612.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:

 
> I think unique identification for all tuples are
> difficult, because we can
> create a table without Oid (object id) or primary
> key to identify a tuple
> from outside of the table...
> 
> BTW, the string representations of security contexts
> are stored in a separate
> table named as 'pg_selinux', defined with Oid (which
> have 4-byte length).
> In SE-PostgreSQL, any tuples have Oid of pg_selinux
> as a security context.
> Thus, storage consumption is limited.

How does this method compare to the schemes
used in the Oracle evaluated MLS DBMS?


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
