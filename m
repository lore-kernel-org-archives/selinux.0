Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2IFrDpF013953
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 11:53:13 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2IFrCFc005492
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 15:53:12 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m2IFR1nd000533
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 11:27:01 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m2IFR1fT025172
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 11:27:01 -0400
Received: from dhcp-10-12-34-132.boston.devel.redhat.com (vpn-248-104.boston.redhat.com [10.13.248.104])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m2IFR0lM027650
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 11:27:00 -0400
Message-ID: <47DFDF4A.8090006@redhat.com>
Date: Tue, 18 Mar 2008 11:27:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Audit2allow/audit2why patch for policycoreutils.
Content-Type: multipart/mixed;
 boundary="------------070406030208010402030909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070406030208010402030909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Reveals dontaudit rules in policy.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkff30kACgkQrlYvE4MpobP0IgCfTxNojL6yGB6t26Nl+aERmQc4
pJUAoNlJHmee/Q++U18HG2ty5UcECkte
=qpCx
-----END PGP SIGNATURE-----

--------------070406030208010402030909
Content-Type: text/plain;
 name="audit2why.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audit2why.patch"

--- nsapolicycoreutils/audit2allow/audit2allow	2008-01-28 16:52:25.000000000 -0500
+++ policycoreutils-2.0.44/audit2allow/audit2allow	2008-03-18 11:22:52.000000000 -0400
@@ -247,6 +247,11 @@
                     print "\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n"
                     print "\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n"
                     continue
+                if rc == audit2why.DONTAUDIT:
+                    print "\t\tUnknown - should be dontaudit'd by active policy\n",
+                    print "\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n"
+                    print "\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n"
+                    continue
                 if rc == audit2why.BOOLEAN:
                     if len(bools) > 1:
                         print "\tOne of the following booleans was set incorrectly."

--------------070406030208010402030909
Content-Type: application/octet-stream;
 name="audit2why.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="audit2why.patch.sig"

iEYEABECAAYFAkff30oACgkQrlYvE4MpobOr8wCgzOVDX17pEt6GIGDDgO8qM1IVCuYAoK3l
7RwKJZXO2/AEdyHmCxhWrlP2
--------------070406030208010402030909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
