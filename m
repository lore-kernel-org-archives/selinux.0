Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KFWbJc029535
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 10:32:37 -0500
Received: from web51508.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1KFXs3f014890
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 15:33:54 GMT
Date: Tue, 20 Feb 2007 07:33:53 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: restorecond matchpathcon patch
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1347166504-1171985633=:57722"
Message-ID: <691709.57722.qm@web51508.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1347166504-1171985633=:57722
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

I was investigating why restorecond consumes so much memory and noticed that
valgrind is reporting about 18mb of reachable memory at exit. It seems that
matchpathcon sits on a lot of memory that may or may not help restorcond. This
patch causes matchpathcon to free its memory after we get its results. 

This helps cleanup valgrind output so that leaks are confined to utmpter and
another list. But I have to wonder if the strategy of allocating memory for each
file in a directory is a good thing or if we can just depend on partial path
matching to decide if we should care about the file. 

IOW, this patch cleans up one problem, but I wonder if the underlying algorithm
should be changed to be les of a memory hog.

-Steve


 
____________________________________________________________________________________
TV dinner still cooling? 
Check out "Tonight's Picks" on Yahoo! TV.
http://tv.yahoo.com/
--0-1347166504-1171985633=:57722
Content-Type: text/x-patch; name="policycoreutils-2.0.1-restorecond-leak.patch"
Content-Description: 1515479032-policycoreutils-2.0.1-restorecond-leak.patch
Content-Disposition: inline; filename="policycoreutils-2.0.1-restorecond-leak.patch"

diff -urp policycoreutils-2.0.1.orig/restorecond/restorecond.c policycoreutils-2.0.1/restorecond/restorecond.c
--- policycoreutils-2.0.1.orig/restorecond/restorecond.c	2007-02-19 21:25:54.000000000 -0500
+++ policycoreutils-2.0.1/restorecond/restorecond.c	2007-02-19 21:28:09.000000000 -0500
@@ -188,7 +188,9 @@ static void restore(const char *filename
 		return;
 	}
 
-	if (matchpathcon(filename, st.st_mode, &scontext) < 0) {
+	retcontext = matchpathcon(filename, st.st_mode, &scontext);
+	matchpathcon_fini();
+	if (retcontext < 0) {
 		if (errno == ENOENT)
 			return;
 		syslog(LOG_ERR, "matchpathcon(%s) failed %s\n", filename,

--0-1347166504-1171985633=:57722--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
