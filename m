Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0D1CMIi020901
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 20:12:23 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0D1AG8I006823
	for <selinux@tycho.nsa.gov>; Thu, 13 Jan 2005 01:10:22 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.2/8.13.2/Debian-1) with ESMTP id j0D17vJ8017509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 19:07:58 -0600
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Error building libsepol with gcc 4.0
Date: Wed, 12 Jan 2005 19:07:57 -0600
Message-ID: <87hdlmuoeq.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        There is a problem building 'libsepol' on amd64 with gcc-4.0:

cc -O2 -I. -I../include -c -o policydb.o policydb.c
policydb.c:29: error: static declaration of 'policydb_compat' follows non-static declaration
private.h:27: error: previous declaration of 'policydb_compat' was here
make[2]: *** [policydb.o] Error 1
make[2]: Leaving directory `/libsepol-1.2/src'

	Which is indeed a problem (though gcc used to ignore it in the
 past). Looking at it, policydb_compat is only used in policydb.c, so
 it can remain a static array of struct policydb_compat_info, and we
 can just remove the extern declaration from private.h.

	The following should do the trick:
======================================================================
diff -urN libsepol-1.2/src/private.h ./src/private.h
--- .libsepol-1.2/src/private.h	2004-08-20 21:02:11.000000000 +0200
+++ ./src/private.h	2004-12-27 21:02:34.453860304 +0100
@@ -24,7 +24,6 @@
 	int ocon_num;
 };
 
-extern struct policydb_compat_info policydb_compat[];
 extern struct policydb_compat_info *policydb_lookup_compat(int version);
 
 /* Reading from a policy "file". */
======================================================================

	manoj
-- 
He who utters only gentle, instructive and truthful speech,
criticising no-one - that is what I call a brahmin. 408
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
