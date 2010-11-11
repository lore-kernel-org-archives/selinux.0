Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oABE1NYD009145
	for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2010 09:01:26 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oABE1P9x012085
	for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2010 14:01:25 GMT
Message-ID: <4CDBF732.3050005@redhat.com>
Date: Thu, 11 Nov 2010 09:01:22 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Eric hit a bug with sepolgen handing a newer kernel version then
 the policy handled.
Content-Type: multipart/mixed;
 boundary="------------080500080403010802090105"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080500080403010802090105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch will look for all policyfiles installed on a machine.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzb9zIACgkQrlYvE4MpobPVcACgwGszP4lstRB6KXsu9grIo3Bj
fU8An38O1uTy+84I+yqBkzJ+Jy2Dt/EU
=FbXs
-----END PGP SIGNATURE-----

--------------080500080403010802090105
Content-Type: text/plain;
 name="sepolgen-policyvers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sepolgen-policyvers.patch"

--- /usr/bin/sepolgen-ifgen~	2010-11-08 14:25:20.000000000 -0500
+++ /usr/bin/sepolgen-ifgen	2010-11-11 08:58:33.000000000 -0500
@@ -61,8 +61,18 @@
     return options
 
 def get_attrs():
+    vers = selinux.security_policyvers()
+    while vers > 0:
+        policy_path = selinux.selinux_binary_policy_path() + "." + str(vers)
+        if os.path.exists(policy_path):
+            break
+        vers -= 1
+
+    if vers == 0:
+        sys.stderr.write("could not open policy file %s.*\n" % selinux.selinux_binary_policy_path())
+        return None
+
     try:
-        policy_path = selinux.selinux_binary_policy_path() + "." + str(selinux.security_policyvers())
         outfile = tempfile.NamedTemporaryFile()
     except IOError, e:
         sys.stderr.write("could not open attribute output file\n")
@@ -75,7 +85,7 @@
     ret = subprocess.Popen([ATTR_HELPER, policy_path, outfile.name], stdout=fd).wait()
     fd.close()
     if ret != 0:
-        sys.stderr.write("could not run attribute helper")
+        sys.stderr.write("could not run attribute helper\n")
         return None
 
     attrs = interfaces.AttributeSet()

--------------080500080403010802090105
Content-Type: application/pgp-signature;
 name="sepolgen-policyvers.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sepolgen-policyvers.patch.sig"

iEYEABECAAYFAkzb9zIACgkQrlYvE4MpobO/uQCgh83SeSLxGb8EVLtn/j6pEnNEza8AoLXF
9l04LhOQsD66JUUFrcho6hzK
--------------080500080403010802090105--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
