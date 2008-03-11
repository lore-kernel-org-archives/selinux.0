Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2BDIbco021207
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 09:18:37 -0400
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2BDIZwB027262
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 13:18:36 GMT
Received: from [127.0.0.1] (q016180.dynamic.ppp.asahi-net.or.jp [203.181.16.180])
	by mail.asahi-net.or.jp (Postfix) with ESMTP id B297650C3F
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 21:57:12 +0900 (JST)
Message-ID: <47D68154.40505@kaigai.gr.jp>
Date: Tue, 11 Mar 2008 21:55:48 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: [ANN] Now v8.3 based SE-PostgreSQL is available
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It is an announcement of new version of SE-PostgreSQL.

Now v8.3 based SE-PostgreSQL is available
-----------------------------------------
SE-PostgreSQL development team published v8.3 based SE-PostgreSQL at:
  http://download.fedora.redhat.com/pub/fedora/linux/development

You can obtain the v8.3 based sepostgresql package which contains
its security policy module from here.

NOTE: This version is not available at Fedora 8 or prior.
      Please wait for Fedora 9, or update your system to rawhide.

The following official documentation will help your understanding:
  http://sepgsql.googlecode.com/files/sepgsql_security_guide.20080214.en.pdf

Updates from v8.2 based SE-PostgreSQL
- The base version was upgraded to PostgreSQL 8.3.0
- It enabled to share external libraries (like -contrib package)
  with original PostgreSQL.
- Cumulative bugfixes.

The features of SE-PostgreSQL
-----------------------------
Security-Enhanced PostgreSQL (SE-PostgreSQL) is a security extension
built in PostgreSQL, to provide system-wide consistency in access
controls. It enables to apply a single unigied security policy of
SELinux for both operating system and database management system.
In addition, it also provides fine-grained mandatory access which
includes column-/row- level non-bypassable access control even if
privileged database users.
These features enables to deploy SE-PostgreSQL into data flow control
scheme integrated with operating system, to protect our information
asset from threats like leaking, manupulation and so on.

    http://code.google.com/p/sepgsql/wiki/WhatIsSEPostgreSQL

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
