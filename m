Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0DDrrJN013053
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:53:53 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0DDp5KL004832
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 13:51:06 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n0DDrp2m010932
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:53:51 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n0DDrpFc014292
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:53:51 -0500
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n0DDrpFY021019
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:53:51 -0500
Message-ID: <496C9CEE.6020407@redhat.com>
Date: Tue, 13 Jan 2009 08:53:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils_restorecond.patch
Content-Type: multipart/mixed;
 boundary="------------010506090209030908010909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010506090209030908010909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Add more error checking.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAklsnO4ACgkQrlYvE4MpobOqdgCgvkzLK6bi1m9oTv217A7CYIvZ
BRcAn005E3lop2wmkaH5DcfVwVv3kCYD
=Xjf4
-----END PGP SIGNATURE-----

--------------010506090209030908010909
Content-Type: text/plain;
 name="policycoreutils_restorecond.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils_restorecond.patch"

--- nsapolicycoreutils/restorecond/restorecond.c	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.60/restorecond/restorecond.c	2008-12-15 15:34:54.000000000 -0500
@@ -283,6 +283,8 @@
 	inotify_rm_watch(fd, master_wd);
 	master_wd =
 	    inotify_add_watch(fd, watch_file_path, IN_MOVED_FROM | IN_MODIFY);
+	if (master_wd == -1)
+		exitApp("Error watching config file.");
 }
 
 /* 
@@ -411,7 +413,14 @@
 
 	if (!ptr)
 		exitApp("Out of Memory");
+
 	ptr->wd = inotify_add_watch(fd, dir, IN_CREATE | IN_MOVED_TO);
+	if (ptr->wd == -1) {
+		free(ptr);
+		syslog(LOG_ERR, "Unable to watch (%s) %s\n",
+		       path, strerror(errno));
+		return;
+	}
 
 	ptr->dir = strdup(dir);
 	if (!ptr->dir)
--- nsapolicycoreutils/restorecond/utmpwatcher.c	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.60/restorecond/utmpwatcher.c	2008-12-15 15:34:54.000000000 -0500
@@ -57,7 +57,7 @@
 	utmp_ptr = NULL;
 	FILE *cfg = fopen(utmp_path, "r");
 	if (!cfg)
-		exitApp("Error reading config file.");
+		exitApp("Error reading utmp file.");
 
 	while (fread(&u, sizeof(struct utmp), 1, cfg) > 0) {
 		if (u.ut_type == USER_PROCESS)
@@ -69,6 +69,9 @@
 
 	utmp_wd =
 	    inotify_add_watch(inotify_fd, utmp_path, IN_MOVED_FROM | IN_MODIFY);
+	if (utmp_wd == -1)
+		exitApp("Error watching utmp file.");
+
 	if (prev_utmp_ptr) {
 		changed = strings_list_diff(prev_utmp_ptr, utmp_ptr);
 		strings_list_free(prev_utmp_ptr);

--------------010506090209030908010909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
