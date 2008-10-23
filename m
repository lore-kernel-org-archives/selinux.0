Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9NHFFhj003007
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2008 13:15:15 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9NHFFIH020189
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2008 17:15:15 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m9NHFFNT023665
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2008 13:15:15 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m9NHFDnb007916
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2008 13:15:13 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m9NHFCGv006305
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2008 13:15:13 -0400
Message-ID: <4900B11F.2050101@redhat.com>
Date: Thu, 23 Oct 2008 13:15:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils patch
Content-Type: multipart/mixed;
 boundary="------------090801050502040109080608"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090801050502040109080608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Fix error message in newrole.

Change semange fcontext -a to check for local customizations rather then
 global, so you can modify a file context.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkAsR4ACgkQrlYvE4MpobPkRgCfQQNFw9DE8oGt7ecsl7ikXJhM
vGIAoKRp+37SMzpfgIoOC9VY0S7bmR+V
=pwc5
-----END PGP SIGNATURE-----

--------------090801050502040109080608
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.13 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/newrole/newrole.c policycoreutils-2.0.57/newrole/newrole.c
--- nsapolicycoreutils/newrole/newrole.c	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.57/newrole/newrole.c	2008-10-17 16:43:52.000000000 -0400
@@ -553,7 +553,7 @@
 	new_caps = cap_init();
 	tmp_caps = cap_init();
 	if (!new_caps || !tmp_caps) {
-		fprintf(stderr, _("Error initing capabilities, aborting.\n"));
+		fprintf(stderr, _("Error initializing capabilities, aborting.\n"));
 		return -1;
 	}
 	rc |= cap_set_flag(new_caps, CAP_PERMITTED, 1, cap_list, CAP_SET);
@@ -631,7 +631,7 @@
 	/* Non-root caller, suid root path */
 	new_caps = cap_init();
 	if (!new_caps) {
-		fprintf(stderr, _("Error initing capabilities, aborting.\n"));
+		fprintf(stderr, _("Error initializing capabilities, aborting.\n"));
 		return -1;
 	}
 	rc |= cap_set_flag(new_caps, CAP_PERMITTED, 6, cap_list, CAP_SET);
diff --exclude-from=exclude --exclude=sepolgen-1.0.13 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-2.0.57/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2008-09-12 11:48:15.000000000 -0400
+++ policycoreutils-2.0.57/semanage/seobject.py	2008-10-23 11:04:33.000000000 -0400
@@ -1430,7 +1430,7 @@
 		if rc < 0:
 			raise ValueError(_("Could not create key for %s") % target)
 
-		(rc,exists) = semanage_fcontext_exists(self.sh, k)
+		(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if file context for %s is defined") % target)
 		if exists:

--------------090801050502040109080608
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkkAsR8ACgkQrlYvE4MpobObJQCggrAxUZCn3FioLNgKtt8zXXzb2ygAni+m
EdW6xkcBKL2G0bn8nt7DcpdV
--------------090801050502040109080608--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
