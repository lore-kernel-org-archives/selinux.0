Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j33HcdDo024358
	for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2005 13:38:39 -0400 (EDT)
Received: from hermes.domdv.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j33HamSQ017402
	for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2005 17:36:48 GMT
Message-ID: <425029B0.3070208@domdv.de>
Date: Sun, 03 Apr 2005 19:36:48 +0200
From: Andreas Steinmetz <ast@domdv.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: fix for segfault in getconlist of libselinux-1.22
Content-Type: multipart/mixed;
 boundary="------------050604030909010803050803"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050604030909010803050803
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

fix for segfault in case of non-exisiting user attached.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------050604030909010803050803
Content-Type: text/plain;
 name="libselinux-1.22.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-1.22.diff"

diff -rNu libselinux-1.22.orig/utils/getconlist.c libselinux-1.22/utils/getconlist.c
--- libselinux-1.22.orig/utils/getconlist.c	2004-11-01 15:21:46.000000000 +0100
+++ libselinux-1.22/utils/getconlist.c	2005-03-29 13:13:13.000000000 +0200
@@ -38,10 +38,12 @@
 
 	/* Get the list and print it */
 	ret = get_ordered_context_list(argv[1], cur_context, &list);
-	for (i = 0; list[i]; i++)
-		puts (list[i]);
+	if(ret != -1) {
+		for (i = 0; list[i]; i++)
+			puts (list[i]);
+		freeconary(list);
+	}
 
-	freeconary(list);
 	free(usercon);
 
 	return 0;

--------------050604030909010803050803--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
