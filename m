Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA24925
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2001 11:59:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA14157
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2001 16:58:55 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA14153
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2001 16:58:55 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id LAA11582
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2001 11:58:26 -0500 (EST)
Date: Thu, 25 Jan 2001 11:58:25 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: error in fs/attr.c
Message-ID: <Pine.SOL.3.95.1010125115110.4491K-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


While porting to the 2.4 kernel, I noticed an error in my changes
to the inode_change_ok function in fs/attr.c.  The return value
(retval) is initialized on entry to -EPERM, and the normal Linux access
checks simply return this value if an access check fails.  However, the
Flask permission checks that were inserted into this function
use retval, and consequently reset it to zero if the Flask
permissions are granted.  Consequently, successful Flask permission
checks in this function have an accidental side effect of overriding 
any failure in the normal Linux access checks in this function.  My
apologies for this error.

The following patch should address the issue.  You can apply this
patch to either the 2.2.12 version or the 2.2.17 version.  The
release on the web pages will reflect this change the next time the
release is updated.

--- attr.c.old	Thu Jan 25 10:43:36 2001
+++ attr.c	Thu Jan 25 10:43:41 2001
@@ -69,6 +69,8 @@
 		if (retval)
 			goto error;
 	}
+
+	retval = -EPERM;
 #endif
 
 	/* Make sure a caller can chown. */

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
