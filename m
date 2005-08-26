Message-ID: <430F5EB7.4000308@redhat.com>
Date: Fri, 26 Aug 2005 14:25:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Problems with MCS/Targeted policy update.
References: <430C776B.4060309@redhat.com>
In-Reply-To: <430C776B.4060309@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------010400030708020607060209"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010400030708020607060209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Patch to use raw functions.

-- 



--------------010400030708020607060209
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.25.7/restorecon/restorecon.c
--- nsapolicycoreutils/restorecon/restorecon.c	2005-07-27 09:58:39.000000000 -0400
+++ policycoreutils-1.25.7/restorecon/restorecon.c	2005-08-26 14:20:10.000000000 -0400
@@ -186,7 +186,7 @@
     freecon(scontext);
     return 0;
   }
-  retcontext=lgetfilecon(filename,&prev_context);
+  retcontext=lgetfilecon_raw(filename,&prev_context);
   
   if (retcontext >= 0 || errno == ENODATA) {
     int customizable=0;
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/setfiles/setfiles.c policycoreutils-1.25.7/setfiles/setfiles.c
--- nsapolicycoreutils/setfiles/setfiles.c	2005-04-11 16:00:46.000000000 -0400
+++ policycoreutils-1.25.7/setfiles/setfiles.c	2005-08-26 14:20:28.000000000 -0400
@@ -285,7 +285,7 @@
 	}
 
 	/* Get the current context of the file. */
-	ret = lgetfilecon(my_file, &context);
+	ret = lgetfilecon_raw(my_file, &context);
 	if (ret < 0) {
 		if (errno == ENODATA) {
 			context = malloc(10);

--------------010400030708020607060209--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
