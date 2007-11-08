Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA86b6sm029309
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 01:37:06 -0500
Received: from asterix.wonder.pl (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA86b5ke005783
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 06:37:05 GMT
Received: from localhost (localhost [127.0.0.1])
	by asterix.wonder.pl (Postfix) with ESMTP id 27A7D140C888
	for <selinux@tycho.nsa.gov>; Thu,  8 Nov 2007 07:37:03 +0100 (CET)
Received: from asterix.wonder.pl ([127.0.0.1])
	by localhost (asterix [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21605-05 for <selinux@tycho.nsa.gov>;
	Thu, 8 Nov 2007 07:36:57 +0100 (CET)
Date: Thu, 8 Nov 2007 07:36:57 +0100
To: SELinux list <selinux@tycho.nsa.gov>
Subject: [PATCH] restorecon
Message-ID: <20071108063657.GA21903@asterix.wonder.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linio@wonder.pl (Litwiniec Robert)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,
i wrote patch for restorecon, which warns, if file has hardlinks, and
file which has hardlinks is relabeled second time since run restorecon
(it's a hack, check is based on change time):

--- restorecon.orig.c   2007-09-27 21:53:22.000000000 +0200
+++ restorecon.c        2007-09-27 21:52:31.000000000 +0200
@@ -40,6 +40,7 @@
 #include <stdio.h>
 #define __USE_XOPEN_EXTENDED 1 /* nftw */
 #include <ftw.h>
+#include <time.h>
 
 static int change = 1;
 static int verbose = 0;
@@ -53,6 +54,8 @@
 #define STAT_BLOCK_SIZE 1
 static int pipe_fds[2] = { -1, -1 };
 static unsigned long long count = 0;
+static time_t starttime;
+
 
 #define MAX_EXCLUDES 100
 static int excludeCtr = 0;
@@ -248,6 +251,12 @@
                                if (outfile)
                                        fprintf(outfile, "%s\n", filename);
                                if (change) {
+                                       if ( (st.st_nlink>1) ) {
+                                               fprintf(stderr, "warning: %s has hard links\n", filename);
+                                               if ( st.st_ctime>=starttime) {
+                                                       fprintf(stderr, "warning: %s changed since run restorecon\n", filename);
+                                               }
+                                       }
                                        if (lsetfilecon(filename, scontext) < 0) {
                                                fprintf(stderr,
                                                        "%s set context %s->%s failed:'%s'\n",
@@ -358,6 +367,7 @@
        int opt;
        char *buf = NULL;
        size_t buf_len;
+        starttime = time (NULL);
 
        memset(excludeArray, 0, sizeof(excludeArray));

Regards,
Robert Litwiniec 
-- 
http://debian.wonder.pl - Debian/GNU Linux wiki
http://zamosc.wonder.pl - Wonders of Zamosc

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
