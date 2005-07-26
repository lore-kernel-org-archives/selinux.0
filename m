Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6QKuvgA007240
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2005 16:56:59 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6QKpR2V025368
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2005 20:51:27 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6QKpSs5006270
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2005 16:51:28 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6QKpNV09027
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2005 16:51:23 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6QKpMMT019695
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2005 16:51:22 -0400
Subject: [ policycoreutils ] Resend: make restorecon print status messages
	to stdout
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-idKLQuKLYfGR5jYMT9us"
Date: Tue, 26 Jul 2005 16:48:45 -0400
Message-Id: <1122410926.3642.1.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-idKLQuKLYfGR5jYMT9us
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-idKLQuKLYfGR5jYMT9us
Content-Disposition: attachment; filename=policycoreutils-restorecon-stdout.diff
Content-Type: text/x-patch; name=policycoreutils-restorecon-stdout.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -p -aru policycoreutils.work/restorecon/restorecon.c policycoreutils-restorecon-stdout/restorecon/restorecon.c
--- policycoreutils.work/restorecon/restorecon.c	2005-06-29 16:09:47.000000000 -0400
+++ policycoreutils-restorecon-stdout/restorecon/restorecon.c	2005-07-26 16:46:17.000000000 -0400
@@ -211,11 +211,11 @@ int restore(char *filename) {
       } else 	
 	      if (verbose && 
 		  (verbose > 1 || !user_only_changed))
-		      fprintf(stderr,"%s reset %s context %s->%s\n",
+		      printf("%s reset %s context %s->%s\n",
 			      progname, filename, (retcontext >= 0 ? prev_context : ""), scontext);
     }
     if (verbose > 1 && customizable>0) {
-	    fprintf(stderr,"%s: %s not reset customized by admin to %s\n",
+	    printf("%s: %s not reset customized by admin to %s\n",
 		      progname, filename, prev_context);
     }
 

--=-idKLQuKLYfGR5jYMT9us--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
