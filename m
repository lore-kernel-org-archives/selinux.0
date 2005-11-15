Message-ID: <437974B6.7020203@cornell.edu>
Date: Tue, 15 Nov 2005 00:40:06 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SELINUX ] Make rpm_execcon failure non-fatal in permissive mode.
Content-Type: multipart/mixed;
 boundary="------------000603050405000603060505"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000603050405000603060505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changelog: Makes failure in rpm_execcon non-fatal in permissive mode.
See: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=173094

P.S. I'm not sure why an rpm-specific function is in the shared library 
- seems strange to me.

--------------000603050405000603060505
Content-Type: text/x-patch;
 name="libselinux.rpm_respect_mode.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux.rpm_respect_mode.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libselinux/src/rpm.c new/libselinux/src/rpm.c
--- old/libselinux/src/rpm.c	2005-08-25 11:32:02.000000000 -0400
+++ new/libselinux/src/rpm.c	2005-11-15 00:27:14.000000000 -0500
@@ -11,7 +11,7 @@ int rpm_execcon(unsigned int verified __
 {
 	security_context_t mycon = NULL, fcon = NULL, newcon = NULL;
 	context_t con = NULL;
-	int rc;
+	int rc = 0;
 
 	if (is_selinux_enabled() < 1)
 		return execve(filename, argv, envp);
@@ -44,8 +44,11 @@ int rpm_execcon(unsigned int verified __
 	rc = setexeccon(newcon);
 	if (rc < 0) 
 		goto out;
-	rc = execve(filename, argv, envp);
 out:
+
+	if (rc >= 0 || !security_getenforce())
+		rc = execve(filename, argv, envp); 
+
 	context_free(con);
 	freecon(newcon);
 	freecon(fcon);

--------------000603050405000603060505--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
