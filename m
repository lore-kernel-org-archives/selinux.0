Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0GCkBrU031557
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 07:46:11 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0GCk9TM005200
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 12:46:10 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n0GCk75i019662
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 07:46:07 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n0GCk6ZH020290
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 07:46:07 -0500
Received: from localhost.localdomain (vpn-10-39.bos.redhat.com [10.16.10.39])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n0GCk6D1014811
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 07:46:06 -0500
Message-ID: <4970818C.70205@redhat.com>
Date: Fri, 16 Jan 2009 07:46:04 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Problem with the previous libsemanage patch.
Content-Type: multipart/mixed;
 boundary="------------060202020906030805050609"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060202020906030805050609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The libsemanage patch I sent attempts a link  before doing the copy.
The idea here is to save space whenever possible.  The big win is when
we create the sandbox.  Since this copies all of the module files even
though it usually does not replace them.

The link can cause a problem where it links to files together with
different file context.  For example, on initial install the
/etc/selinux/targeted/seusers file ends up a link to
/etc/selinux/targeted/modules/active/seusers.  We end up with the file
labeled semanage_store_t, instead of selinux_config_t and login programs
are not allowed to read the file.  This patch removes the link code, and
only does it for the copy_dir, which is used to make a copy of the
sandbox.  The sandbox and active have the same label so this is not a
problem.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAklwgYsACgkQrlYvE4MpobNSFwCfQW+xZBSg/tR80dLOAWpYUsOF
SMEAn3GydbE2uQODqGF2ehNzwo46t75a
=q8c3
-----END PGP SIGNATURE-----

--------------060202020906030805050609
Content-Type: text/plain;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-2.0.31/src/semanage_store.c
--- nsalibsemanage/src/semanage_store.c	2009-01-13 08:45:35.000000000 -0500
+++ libsemanage-2.0.31/src/semanage_store.c	2009-01-15 15:53:46.000000000 -0500
@@ -440,8 +440,6 @@
 	char tmp[PATH_MAX];
 	char buf[4192];
 
-	if (link(src,dst) == 0) return 0;
-
 	n = snprintf(tmp, PATH_MAX, "%s.tmp", dst);
 	if (n < 0 || n >= PATH_MAX)
 		return -1;
@@ -509,7 +507,8 @@
 				goto cleanup;
 			}
 		} else if (S_ISREG(sb.st_mode)) {
-			if (semanage_copy_file(path, path2, sb.st_mode) == -1) {
+			if ((link(path,path2) == -1) && 
+			     (semanage_copy_file(path, path2, sb.st_mode) == -1)) {
 				goto cleanup;
 			}
 		}

--------------060202020906030805050609
Content-Type: application/pgp-signature;
 name="libsemanage-rhat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="libsemanage-rhat.patch.sig"

iEYEABECAAYFAklwgYsACgkQrlYvE4MpobPqKwCgjLG/iMWmA/1bnf292drVnL/V41AAn0RC
iwj7AKUHk6IWz9Zz8k7mIb3z
--------------060202020906030805050609--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
