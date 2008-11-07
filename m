Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA7EaoJZ009520
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:36:50 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA7EZ9Qi009030
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 14:35:09 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EajxW003251
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:36:45 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mA7EajC3031412
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:36:45 -0500
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EaigU014946
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:36:44 -0500
Message-ID: <4914527C.1010803@redhat.com>
Date: Fri, 07 Nov 2008 09:36:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils audit2allow patch
Content-Type: multipart/mixed;
 boundary="------------010008020807020906050204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010008020807020906050204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

audit2why can throw a runtime exception and typo in man page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkUUnwACgkQrlYvE4MpobNB3gCg1gVyqHVlNPHofR7iDktfmKSF
cTQAniHIYf8nq+nbB9MC0mlVbyvEECMX
=JXfF
-----END PGP SIGNATURE-----

--------------010008020807020906050204
Content-Type: text/plain;
 name="audit2allow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audit2allow.patch"

--- nsapolicycoreutils/audit2allow/audit2allow	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.57/audit2allow/audit2allow	2008-10-30 14:21:33.000000000 -0400
@@ -287,7 +287,11 @@
     def __output(self):
         
         if self.__options.audit2why:
-            return self.__output_audit2why()
+            try:
+                return self.__output_audit2why()
+            except RuntimeError, e:
+                print e
+                sys.exit(1)
 
         g = policygen.PolicyGenerator()
 
--- nsapolicycoreutils/audit2allow/audit2allow.1	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.57/audit2allow/audit2allow.1	2008-10-29 09:44:41.000000000 -0400
@@ -82,7 +82,7 @@
 Indicates input file is a te (type enforcement) file.  This can be used to translate old te format to new policy format.
 .TP
 .B "\-w" | "\-\-why"
-Translates SELinux audit messages into a description of why the access wasn denied
+Translates SELinux audit messages into a description of why the access was denied
 
 .TP
 .B "\-v" | "\-\-verbose"

--------------010008020807020906050204
Content-Type: application/octet-stream;
 name="audit2allow.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="audit2allow.patch.sig"

iEYEABECAAYFAkkUUnwACgkQrlYvE4MpobMVigCgs9DV/b6WJus0wCdeh0Y8UU/QCZsAn1pn
KbqezrS5UzJdJTxcpTUGPfmH
--------------010008020807020906050204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
