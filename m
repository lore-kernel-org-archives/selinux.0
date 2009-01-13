Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0DDi5lj009697
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:44:06 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0DDi1Og022414
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 13:44:02 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n0DDhq8T008760
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:43:53 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n0DDhq8A011504
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:43:53 -0500
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n0DDhpZo019267
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:43:52 -0500
Message-ID: <496C9A96.1080805@redhat.com>
Date: Tue, 13 Jan 2009 08:43:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to libsemanage to remove labeling of /root
Content-Type: multipart/mixed;
 boundary="------------010508040101090401060308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010508040101090401060308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Policy should label /root with one label and this should not be effected
by the passwd database.

In Fedora policy we label this as admin_home_t.  Having this label vary
depending on policy ends up with lines like

dontaudit * user_home_t:dir search_dir_perms
dontaudit * admin_home_t:dir search_dir_perms
dontaudit * sysadmin_home_t:dir search_dir_perms
dontaudit * staff_home_t:dir search_dir_perms

Labeling this directory as user_home_t, opens the system to possible
security risks since some domains have to be able to write to
user_home_t when they would never be allowed to write to admin_home_t.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAklslqMACgkQrlYvE4MpobPY/ACdHitHOeU+c77VVePxkkTpmSsw
M2gAoJxZPlUKHJ3cL0zIb8fuHMq5VSRz
=LmKq
-----END PGP SIGNATURE-----

--------------010508040101090401060308
Content-Type: text/plain;
 name="libsemanage-root.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-root.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/genhomedircon.c libsemanage-2.0.30/src/genhomedircon.c
--- nsalibsemanage/src/genhomedircon.c	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.30/src/genhomedircon.c	2009-01-12 10:29:24.000000000 -0500
@@ -794,6 +792,12 @@
 			 * /root */
 			continue;
 		}
+		if (strcmp(pwent->pw_dir, "/root") == 0) {
+			/* don't relabel / genhomdircon checked to see if root
+			 * was the user and if so, set his home directory to
+			 * /root */
+			continue;
+		}
 		if (push_user_entry(&head, name, seuname,
 				    prefix, pwent->pw_dir) != STATUS_SUCCESS) {
 			*errors = STATUS_ERR;

--------------010508040101090401060308
Content-Type: application/octet-stream;
 name="libsemanage-root.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libsemanage-root.patch.sig"

iEYEABECAAYFAklslqMACgkQrlYvE4MpobPYhQCgpobF7871KA0oh5yNOPjiL23FIAkAnisu
2ZbDpk8faIJXtaK3jnnTWSP2
--------------010508040101090401060308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
