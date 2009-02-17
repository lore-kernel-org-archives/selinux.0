Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1HGf29g011314
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:41:02 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1HGbaJD013401
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 16:37:40 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n1HGeuf5021666
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:40:56 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n1HGevPu006578
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:40:57 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n1HGetMJ015595
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:40:55 -0500
Message-ID: <499AE896.8000709@redhat.com>
Date: Tue, 17 Feb 2009 11:40:54 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Several fixes to restorecond
Content-Type: multipart/mixed;
 boundary="------------080900000000000206000002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080900000000000206000002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Init script should be 755

libflashplayer.so has moved in the homedir and is now correct so no
longer needs to have labeling checked.

restorecond supports glob matching and should not complain on multiple
hard links if they match a glob.

So if a file has > 1 link and is an exact match complain, otherwise do not.

Also fix a couple of error messages.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkma6JYACgkQrlYvE4MpobOoIACfUgUfpCuhvVTWyHgsq7/8hY0z
9WcAmgPK2KktAlY84HhtRmdu/Hy+9eE/
=zcCj
-----END PGP SIGNATURE-----

--------------080900000000000206000002
Content-Type: text/plain;
 name="restorecond.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="restorecond.patch"

--- nsapolicycoreutils/restorecond/Makefile	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.61/restorecond/Makefile	2009-01-30 11:22:46.000000000 -0500
@@ -20,7 +20,7 @@
 	install -m 755 restorecond $(SBINDIR)
 	install -m 644 restorecond.8 $(MANDIR)/man8
 	-mkdir -p $(INITDIR)
-	install -m 644 restorecond.init $(INITDIR)/restorecond
+	install -m 755 restorecond.init $(INITDIR)/restorecond
 	-mkdir -p $(SELINUXDIR)
 	install -m 600 restorecond.conf $(SELINUXDIR)/restorecond.conf
 
--- nsapolicycoreutils/restorecond/restorecond.conf	2008-09-12 11:48:15.000000000 -0400
+++ policycoreutils-2.0.61/restorecond/restorecond.conf	2009-01-30 11:10:14.000000000 -0500
@@ -5,4 +5,3 @@
 /var/run/utmp
 /var/log/wtmp
 ~/*
-~/.mozilla/plugins/libflashplayer.so
--- nsapolicycoreutils/restorecond/restorecond.c	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.61/restorecond/restorecond.c	2009-01-30 11:21:09.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * restorecond
  *
- * Copyright (C) 2006 Red Hat 
+ * Copyright (C) 2006-2009 Red Hat 
  * see file 'COPYING' for use and warranty information
  *
  * This program is free software; you can redistribute it and/or
@@ -75,7 +75,7 @@
 static int debug_mode = 0;
 static int verbose_mode = 0;
 
-static void restore(const char *filename);
+static void restore(const char *filename, int exact);
 
 struct watchList {
 	struct watchList *next;
@@ -113,12 +113,13 @@
 		printf("%d: File=%s\n", wd, file);
 	while (ptr != NULL) {
 		if (ptr->wd == wd) {
-			if (strings_list_find(ptr->files, file) == 0) {
+			int exact=0;
+			if (strings_list_find(ptr->files, file, &exact) == 0) {
 				char *path = NULL;
 				if (asprintf(&path, "%s/%s", ptr->dir, file) <
 				    0)
 					exitApp("Error allocating memory.");
-				restore(path);
+				restore(path, exact);
 				free(path);
 				return 0;
 			}
@@ -155,7 +156,7 @@
    Set the file context to the default file context for this system.
    Same as restorecon.
 */
-static void restore(const char *filename)
+static void restore(const char *filename, int exact)
 {
 	int retcontext = 0;
 	security_context_t scontext = NULL;
@@ -181,9 +182,11 @@
 	}
 
 	if (!(st.st_mode & S_IFDIR) && st.st_nlink > 1) {
-		syslog(LOG_ERR,
-		       "Will not restore a file with more than one hard link (%s) %s\n",
-		       filename, strerror(errno));
+		if (exact) { 
+			syslog(LOG_ERR,
+			       "Will not restore a file with more than one hard link (%s) %s\n",
+			       filename, strerror(errno));
+		}
 		close(fd);
 		return;
 	}
@@ -283,6 +286,8 @@
 	inotify_rm_watch(fd, master_wd);
 	master_wd =
 	    inotify_add_watch(fd, watch_file_path, IN_MOVED_FROM | IN_MODIFY);
+	if (master_wd == -1)
+		exitApp("Error watching config file.");
 }
 
 /* 
@@ -396,7 +401,7 @@
 	char *file = basename(path);
 	ptr = firstDir;
 
-	restore(path);
+	restore(path, 1);
 
 	while (ptr != NULL) {
 		if (strcmp(dir, ptr->dir) == 0) {
@@ -411,7 +416,14 @@
 
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
--- nsapolicycoreutils/restorecond/stringslist.c	2008-09-12 11:48:15.000000000 -0400
+++ policycoreutils-2.0.61/restorecond/stringslist.c	2009-01-30 11:20:48.000000000 -0500
@@ -55,9 +55,10 @@
 		*list = newptr;
 }
 
-int strings_list_find(struct stringsList *ptr, const char *string)
+int strings_list_find(struct stringsList *ptr, const char *string, int *exact)
 {
 	while (ptr) {
+		*exact = strcmp(ptr->string, string) == 0;
 		int cmp = fnmatch(ptr->string, string, 0);
 		if (cmp == 0) 
 			return 0;	/* Match found */
--- nsapolicycoreutils/restorecond/stringslist.h	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.61/restorecond/stringslist.h	2009-01-30 11:27:00.000000000 -0500
@@ -31,7 +31,7 @@
 void strings_list_free(struct stringsList *list);
 void strings_list_add(struct stringsList **list, const char *string);
 void strings_list_print(struct stringsList *list);
-int strings_list_find(struct stringsList *list, const char *string);
+int strings_list_find(struct stringsList *list, const char *string, int *exact);
 int strings_list_diff(struct stringsList *from, struct stringsList *to);
 
 #endif
--- nsapolicycoreutils/restorecond/utmpwatcher.c	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.61/restorecond/utmpwatcher.c	2009-01-20 09:49:03.000000000 -0500
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

--------------080900000000000206000002
Content-Type: application/pgp-signature;
 name="restorecond.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="restorecond.patch.sig"

iEYEABECAAYFAkma6JYACgkQrlYvE4MpobOEuwCeI4J73ZauD/Sw6G4SqepgWTk3iEUAn2T2
W+RZaUblFn+5DliXNXiB0yiM
--------------080900000000000206000002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
