Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m88J3p9M015627
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 15:03:51 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m88J39Ah005457
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 19:03:09 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m88J3pZ5013757
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 15:03:51 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m88J3oFi011646
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 15:03:50 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m88J3nvE023531
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 15:03:50 -0400
Message-ID: <48C57717.7080903@redhat.com>
Date: Mon, 08 Sep 2008 15:03:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Add glob support for restorecond
Content-Type: multipart/mixed;
 boundary="------------060005090309050409040908"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060005090309050409040908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have added supported for GLOB expressions in restorecond.  In order to
get nsplugin to work well, you need all of the contents of the homedir
labeled correctly.  Unfortunately gnome creates directories at a fairly
random pace.  FCFS.  So it is very difficult to get transitions to
happen properly.  As a tradeoff, we can use restorecond to watch the
homedir and relabel the directory when it is created.  I know this is a
potential race condition. where some of the files created in the
directory will still have the wrong context, but I don't know of a
better solution.

Telling everyone they need to restorcon -R -v ~ is not a great solution.
 If you are worried about information flow you should never rely on
restorecond.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjFdxcACgkQrlYvE4MpobPtjACg3uyqaHD78FRxdaG5mfitnoB/
lh0AnjvfDC2vmCWisxzWq2qFsZMMu3XK
=JiG7
-----END PGP SIGNATURE-----

--------------060005090309050409040908
Content-Type: text/plain;
 name="policycoreutils-restorecond.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-restorecond.patch"

--- nsapolicycoreutils/restorecond/stringslist.c	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.55/restorecond/stringslist.c	2008-09-03 17:43:40.000000000 -0400
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006 Red Hat 
+ * Copyright (C) 2006, 2008 Red Hat 
  * see file 'COPYING' for use and warranty information
  *
  * This program is free software; you can redistribute it and/or
@@ -27,6 +27,7 @@
 #include <stdlib.h>
 #include "stringslist.h"
 #include "restorecond.h"
+#include <fnmatch.h>
 
 /* Sorted lists */
 void strings_list_add(struct stringsList **list, const char *string)
@@ -57,11 +58,9 @@
 int strings_list_find(struct stringsList *ptr, const char *string)
 {
 	while (ptr) {
-		int cmp = strcmp(string, ptr->string);
-		if (cmp < 0)
-			return -1;	/* Not on list break out to add */
-		if (cmp == 0)
-			return 0;	/* Already on list */
+		int cmp = fnmatch(ptr->string, string, 0);
+		if (cmp == 0) 
+			return 0;	/* Match found */
 		ptr = ptr->next;
 	}
 	return -1;
@@ -120,6 +119,7 @@
 	if (strings_list_diff(list, list1) == 0)
 		printf("strings_list_diff test2 bug\n");
 	strings_list_add(&list1, "/etc/walsh");
+	strings_list_add(&list1, "/etc/walsh/*");
 	strings_list_add(&list1, "/etc/resolv.conf");
 	strings_list_add(&list1, "/etc/mtab1");
 	if (strings_list_diff(list, list1) == 0)
@@ -127,6 +127,7 @@
 	printf("strings list\n");
 	strings_list_print(list);
 	printf("strings list1\n");
+	strings_list_find(list1, "/etc/walsh/dan");
 	strings_list_print(list1);
 	strings_list_free(list);
 	strings_list_free(list1);
--- nsapolicycoreutils/restorecond/restorecond.conf	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.55/restorecond/restorecond.conf	2008-09-03 17:38:35.000000000 -0400
@@ -1,7 +1,8 @@
+/etc/services
 /etc/resolv.conf
 /etc/samba/secrets.tdb
 /etc/mtab
 /var/run/utmp
 /var/log/wtmp
-~/public_html
+~/*
 ~/.mozilla/plugins/libflashplayer.so


--------------060005090309050409040908
Content-Type: application/octet-stream;
 name="policycoreutils-restorecond.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="policycoreutils-restorecond.patch.sig"

iEYEABECAAYFAkjFdxcACgkQrlYvE4MpobNI8ACgtbYk3FQCcg5qbosoxo2NuWT3xPIAnRWG
bPLfc+uW2sGPwBRYcOtY/vED
--------------060005090309050409040908--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
