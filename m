Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA09954
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 05:02:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA29733
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 10:00:17 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id KAA29729 for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 10:00:16 GMT
Date: Mon, 28 Oct 2002 11:01:58 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: mysql policy
Message-ID: <20021028110158.A1294@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a few questions about the mysql policy:

For me, starting it up via "run_init /etc/init.d/mysql start" doesn't
work. There's a lot of messages like these:

Oct 28 12:47:23 nsa2 kernel: avc:  denied  { write } for  pid=1376 exe=/usr/bin/tee path=/lib/mysql dev=03:04 ino=3014657 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:mysqld_db_t tclass=dir
Oct 28 12:47:24 nsa2 kernel: avc:  denied  { read } for  pid=1377 exe=/usr/bin/mysqladmin path=/etc/mysql/my.cnf dev=03:01 ino=32610 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:etc_mysqld_t tclass=file

Piped into newrules, it all boils down to:

allow initrc_t etc_mysqld_t:file { read };
allow initrc_t mysqld_db_t:dir { write };


Which tells me that run_init doesn't change context when it calls
mysqladmin, which is part of the "safe_mysql" script.


Is this on purpose or a mistake? If it's on purpose, what is the
workaround I'm missing to get mysql to start?


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
