Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8BDZtW1003790
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 09:35:55 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8BDZttG022106
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 13:35:55 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m8BDZtkb022821
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 09:35:55 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m8BDZsvG018803
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 09:35:54 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m8BDZsL8013744
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 09:35:54 -0400
Message-ID: <48C91EBA.8050400@redhat.com>
Date: Thu, 11 Sep 2008 09:35:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Only call gen_requires once.
Content-Type: multipart/mixed;
 boundary="------------050000090507050102070204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050000090507050102070204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Currently audit2allow/sepolgen will create two identical gen_requires
block if you have allow rules and a role statement.

This patch fixes this problem.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjJHroACgkQrlYvE4MpobPgMQCghgAMBtaQO0BeZX+ug6IwsWB8
bNEAoMkRo4cZa0iJhGoGMmCvy5ncGpj8
=gMFg
-----END PGP SIGNATURE-----

--------------050000090507050102070204
Content-Type: text/plain;
 name="diffsepol"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diffsepol"

diff --exclude-from=exclude -N -u -r nsasepolgen/src/sepolgen/policygen.py policycoreutils-2.0.55/sepolgen-1.0.13/src/sepolgen/policygen.py
--- nsasepolgen/src/sepolgen/policygen.py	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.55/sepolgen-1.0.13/src/sepolgen/policygen.py	2008-09-11 09:26:52.000000000 -0400
@@ -134,6 +134,10 @@
             m.refpolicy = False
 
     def get_module(self):
+        # Generate the requires
+        if self.gen_requires:
+            gen_requires(self.module)
+
         """Return the generated module"""
         return self.module
 
@@ -163,18 +167,10 @@
         # Generate the raw allow rules from the filtered list
         self.__add_allow_rules(raw_allow)
 
-        # Generate the requires
-        if self.gen_requires:
-            gen_requires(self.module)
-
     def add_role_types(self, role_type_set):
         for role_type in role_type_set:
             self.module.children.append(role_type)
 
-        # Generate the requires
-        if self.gen_requires:
-            gen_requires(self.module)
-
 def explain_access(av, ml=None, verbosity=SHORT_EXPLANATION):
     """Explain why a policy statement was generated.
 

--------------050000090507050102070204
Content-Type: application/octet-stream;
 name="diffsepol.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diffsepol.sig"

iEYEABECAAYFAkjJHroACgkQrlYvE4MpobPC1QCg3LqJHaqnW1ZY1tZfwx5ts8C/mdIAn3FV
fQ9Mc5DY8D1RRladZQW9rfUk
--------------050000090507050102070204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
