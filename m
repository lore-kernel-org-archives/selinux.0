Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6CB0AHa007752
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 07:00:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6CB09H5010371
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 11:00:09 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6CB07RX010368 for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 11:00:08 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 4B0A0BF4E
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 21:00:00 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 11020-09
 for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 20:59:58 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id A31DDBF49
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 20:59:58 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id CB575924EC
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 20:59:56 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 04C677F0D3
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 20:59:53 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: patch for new release
Date: Sat, 12 Jul 2003 20:59:52 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oo+D/iAyA7A+AWE"
Message-Id: <200307122059.52553.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_oo+D/iAyA7A+AWE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch from Carsten was omitted from the new release.

I think that this patch is worthy of inclusion for the next release.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_oo+D/iAyA7A+AWE
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru selinux-small-2003071106/libsecure/test/arch/i386/stat64_s.c selinux-small-2003040709/libsecure/test/arch/i386/stat64_s.c
--- selinux-small-2003071106/libsecure/test/arch/i386/stat64_s.c	2002-03-14 06:39:21.000000000 +1100
+++ selinux-small-2003040709/libsecure/test/arch/i386/stat64_s.c	2003-04-24 12:15:19.000000000 +1000
@@ -49,6 +49,7 @@
 		}
 
 		printf("Context:  %s\n", context);
+		free(context);
 	}
 
 	exit(0);
diff -ru selinux-small-2003071106/libsecure/test/getsecsid.c selinux-small-2003040709/libsecure/test/getsecsid.c
--- selinux-small-2003071106/libsecure/test/getsecsid.c	2001-07-19 06:38:06.000000000 +1000
+++ selinux-small-2003040709/libsecure/test/getsecsid.c	2003-04-24 12:15:19.000000000 +1000
@@ -51,6 +51,6 @@
 	}
 
 	printf("Context:  %s\n", scontext);
-
+	free(scontext);
 	exit(0);
 }
diff -ru selinux-small-2003071106/libsecure/test/lstat_s.c selinux-small-2003040709/libsecure/test/lstat_s.c
--- selinux-small-2003071106/libsecure/test/lstat_s.c	2001-07-19 06:38:06.000000000 +1000
+++ selinux-small-2003040709/libsecure/test/lstat_s.c	2003-04-24 12:15:19.000000000 +1000
@@ -48,6 +48,7 @@
 		}
 
 		printf("Context:  %s\n", context);
+		free(context);
 	}
 
 	exit(0);
diff -ru selinux-small-2003071106/libsecure/test/sid_to_context.c selinux-small-2003040709/libsecure/test/sid_to_context.c
--- selinux-small-2003071106/libsecure/test/sid_to_context.c	2001-07-19 06:38:06.000000000 +1000
+++ selinux-small-2003040709/libsecure/test/sid_to_context.c	2003-04-24 12:15:19.000000000 +1000
@@ -43,5 +43,6 @@
 	}
 
 	printf("%s\n", buf);
+	free(buf);
 	exit(0);
 }
diff -ru selinux-small-2003071106/libsecure/test/stat_s.c selinux-small-2003040709/libsecure/test/stat_s.c
--- selinux-small-2003071106/libsecure/test/stat_s.c	2001-07-19 06:38:06.000000000 +1000
+++ selinux-small-2003040709/libsecure/test/stat_s.c	2003-04-24 12:15:19.000000000 +1000
@@ -48,6 +48,7 @@
 		}
 
 		printf("Context:  %s\n", context);
+		free(context);
 	}
 
 	exit(0);
diff -ru selinux-small-2003071106/libsecure/test/statfs_s.c selinux-small-2003040709/libsecure/test/statfs_s.c
--- selinux-small-2003071106/libsecure/test/statfs_s.c	2001-07-19 06:38:06.000000000 +1000
+++ selinux-small-2003040709/libsecure/test/statfs_s.c	2003-04-24 12:15:19.000000000 +1000
@@ -48,6 +48,7 @@
 		}
 
 		printf("Context:  %s\n", context);
+		free(context);
 	}
 
 	exit(0);

--Boundary-00=_oo+D/iAyA7A+AWE--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
