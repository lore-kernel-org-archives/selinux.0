Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1SHXis1025399
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 12:33:44 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1SHXidn001745
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 17:33:44 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m1SHXXN7031468
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 12:33:33 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1SHXWTY029951
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 12:33:32 -0500
Received: from localhost.localdomain (vpn-248-40.boston.redhat.com [10.13.248.40])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m1SHXVRE004555
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 12:33:32 -0500
Message-ID: <47C6F067.5050209@redhat.com>
Date: Thu, 28 Feb 2008 12:33:27 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: libselinux does not work properly in upstart/initrd
Content-Type: multipart/mixed;
 boundary="------------070201080904030401090408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070201080904030401090408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

https://bugzilla.redhat.com/show_bug.cgi?id=434793

The way the upstart initrd works is to run nash with a builtin
loadpolicy.  The problem is nash starts before the /sysmount files
system is mounted, so libselinux does not have an /etc/selinux/config to
read.  It defaults to targeted.  So when nash finally executes
loadpolicy (selinux_init_load_policy) it has the wrong config.
Switching to any other type of policy will fail and
selinux_init_load_policy will look for targeted.

I changed this function to reload the config, to fix this problem.

I think I did all the hidden stuff correctly.  I don't think we want to
expose these functions.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfG8GYACgkQrlYvE4MpobNudgCg25fnGfQ6WNyzGiMckpfXy11O
0i8AnjskiEKZX/84EKnpjwujdPydUJEz
=Ku86
-----END PGP SIGNATURE-----

--------------070201080904030401090408
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/load_policy.c libselinux-2.0.57/src/load_policy.c
--- nsalibselinux/src/load_policy.c	2008-02-13 11:16:14.000000000 -0500
+++ libselinux-2.0.57/src/load_policy.c	2008-02-28 11:11:20.000000000 -0500
@@ -308,6 +308,13 @@
 	FILE *cfg;
 	char *buf;
 
+
+	/*
+	  Reinitialize the library, so chroot will work correctly.
+	 */
+	fini_selinux_policyroot();
+	init_selinux_config();
+
 	/*
 	 * Get desired mode (disabled, permissive, enforcing) from 
 	 * /etc/selinux/config. 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-2.0.57/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2007-08-03 16:02:56.000000000 -0400
+++ libselinux-2.0.57/src/selinux_config.c	2008-02-28 11:10:01.000000000 -0500
@@ -127,9 +127,9 @@
 static char *selinux_policyroot = NULL;
 static char *selinux_rootpath = NULL;
 
-static void init_selinux_config(void) __attribute__ ((constructor));
+void init_selinux_config(void) __attribute__ ((constructor));
 
-static void init_selinux_config(void)
+void init_selinux_config(void)
 {
 	int i, *intptr;
 	size_t line_len;
@@ -207,10 +207,11 @@
 		    == -1)
 			return;
 }
+hidden_def(init_selinux_config)
 
-static void fini_selinux_policyroot(void) __attribute__ ((destructor));
+void fini_selinux_policyroot(void) __attribute__ ((destructor));
 
-static void fini_selinux_policyroot(void)
+void fini_selinux_policyroot(void)
 {
 	int i;
 	free(selinux_policyroot);
@@ -222,6 +223,7 @@
 	free(selinux_policytype);
 	selinux_policytype = NULL;
 }
+hidden_def(fini_selinux_policyroot)
 
 static const char *get_path(int idx)
 {
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_internal.h libselinux-2.0.57/src/selinux_internal.h
--- nsalibselinux/src/selinux_internal.h	2007-08-03 16:02:56.000000000 -0400
+++ libselinux-2.0.57/src/selinux_internal.h	2008-02-28 11:11:04.000000000 -0500
@@ -80,6 +80,13 @@
 hidden_proto(security_get_initial_context);
 hidden_proto(security_get_initial_context_raw);
 
+extern void init_selinux_config(void) hidden;
+extern void fini_selinux_policyroot(void) hidden;
+
+hidden_proto(init_selinux_config);
+hidden_proto(fini_selinux_policyroot);
+
 extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
 extern int selinux_page_size hidden;
+

--------------070201080904030401090408
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkfG8GYACgkQrlYvE4MpobMi+QCgzLHtTjnm42XTa58Sml3C8Ac6iEMAn0BJ
yNzsQ5S0rCPFSU1F8AsjEKi+
--------------070201080904030401090408--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
