Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OKhmsj029354
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 15:43:48 -0500 (EST)
Message-ID: <41F55E02.6090302@redhat.com>
Date: Mon, 24 Jan 2005 15:43:46 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: libselinux rpm_execon should not fail in permissive mode.
References: <41F03552.90806@redhat.com> <1106596929.3298.9.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1106596929.3298.9.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040101020401080507080709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040101020401080507080709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040101020401080507080709
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/rpm.c libselinux-1.21.1/src/rpm.c
--- nsalibselinux/src/rpm.c	2004-11-09 09:13:54.000000000 -0500
+++ libselinux-1.21.1/src/rpm.c	2005-01-24 15:24:33.000000000 -0500
@@ -41,8 +41,10 @@
 	rc = setexeccon(newcon);
 	if (rc < 0) 
 		goto out;
-	rc = execve(filename, argv, envp);
 out:
+	if ( ( rc == 0 ) || 
+	     (security_getenforce() == 0 ))
+	  rc = execve(filename, argv, envp);
 	context_free(con);
 	freecon(newcon);
 	freecon(fcon);

--------------040101020401080507080709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
