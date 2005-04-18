Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3IMcQ7C017582
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2005 18:38:27 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3IMVAcd021397
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2005 22:31:10 GMT
Subject: [ANN] SETools-2.1.0 release
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: selinux-dev@tresys.com
Content-Type: text/plain
Date: Mon, 18 Apr 2005 18:34:55 -0400
Message-Id: <1113863695.16319.71.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new version of Setools is available from
http://www.tresys.com/selinux. This release includes:

- Version 19 binary policy support

- Support for parsing MLS components (but no MLS analysis)

- Improved direct relabel analysis 

- Added role transition and conditional expressions to sediff

As well as minor bug fixes.

b4f9fda61546477d92b70cf63e8a3c0b  setools-2.1.0.tar.bz2
3a31b624156b679f4c762553bca53ea5be3ae016  setools-2.1.0.tar.bz2

Joshua Brindle
Tresys Technology


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
