Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA10458
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 07:24:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA06531
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 12:22:34 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA06527
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 12:22:32 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: mysql policy
Date: Mon, 28 Oct 2002 13:24:12 +0100
References: <20021028110158.A1294@lemuria.org>
In-Reply-To: <20021028110158.A1294@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210281324.12898.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 28 Oct 2002 11:01, Tom wrote:
> I have a few questions about the mysql policy:

Firstly when discussing my policy files please CC me (otherwise I am not 
guaranteed to receive the message).

> For me, starting it up via "run_init /etc/init.d/mysql start" doesn't
> work. There's a lot of messages like these:
>
> Oct 28 12:47:23 nsa2 kernel: avc:  denied  { write } for  pid=1376
> exe=/usr/bin/tee path=/lib/mysql dev=03:04 ino=3014657
> scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:mysqld_db_t
> tclass=dir Oct 28 12:47:24 nsa2 kernel: avc:  denied  { read } for 
> pid=1377 exe=/usr/bin/mysqladmin path=/etc/mysql/my.cnf dev=03:01 ino=32610
> scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:etc_mysqld_t
> tclass=file
>
> Piped into newrules, it all boils down to:
>
> allow initrc_t etc_mysqld_t:file { read };
> allow initrc_t mysqld_db_t:dir { write };

It's not that uncommon for an init script to read the config file before 
starting a daemon.  I'll change my policy in that regard.

For the tee thing, I think that the startup scripts you use are using tee to 
redirect stdout of the daemon to a file on disk as well.  What version of the 
daemon are you using?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
