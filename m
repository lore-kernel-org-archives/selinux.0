Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAG7h8Ii028643
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 02:43:08 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAG7feAa010433
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 07:41:41 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.1/8.13.1/Debian-17) with ESMTP id iAG7eu5m016350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 01:41:11 -0600
To: selinux@tycho.nsa.gov
Subject: libselinux fails to build on mips and mipsel machines, patch included
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Tue, 16 Nov 2004 01:40:41 -0600
Message-ID: <87k6smjl6u.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        The asm syntax on mips and mipsel machines is similar to that
 of the alphas, so the following patch is required to have libselinux
 build on mips machines.

======================================================================
--- orig/src/dso.h
+++ mod/src/dso.h
@@ -7,7 +7,7 @@
 # define __hidden_proto(fct, internal)	\
      extern __typeof (fct) internal;	\
      extern __typeof (fct) fct __asm (#internal) hidden;
-# ifdef __alpha__
+# if defined(__alpha__) || defined(__mips__)
 #  define hidden_def(fct) \
      asm (".globl " #fct "\n" #fct " = " #fct "_internal");
 # else
======================================================================

	manoj
-- 
Do, or do not; there is no try.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
