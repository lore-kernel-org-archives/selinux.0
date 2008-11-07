Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA7EinVt010815
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:44:49 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA7Eh8Qi010224
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 14:43:08 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EinQS004735
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:44:49 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mA7EimjA000731
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:44:48 -0500
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EilfB015889
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:44:48 -0500
Message-ID: <4914545F.7050102@redhat.com>
Date: Fri, 07 Nov 2008 09:44:47 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: seobject_mls.patch
Content-Type: multipart/mixed;
 boundary="------------030106070504020609010907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030106070504020609010907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch might be somewhat controversial, it basically sets the
default for semanage to MLS mode when selinux is disabled.

System can not determine if the policy is MLS or not, so current default
is not, so semanage blows up on disabled machines.  A better long term
solution would be to add a interface to libsemanage to look at the
installed policy and decipher what the policy supports.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkUVF8ACgkQrlYvE4MpobMG7wCfeSr2C2a2vc6Z3QVizdm4CpTk
EmwAoKDKxaDxq+Zrc3+Bp4RbjhrGUGXv
=GkGs
-----END PGP SIGNATURE-----

--------------030106070504020609010907
Content-Type: text/plain;
 name="seobject_mls.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="seobject_mls.patch"

--- nsapolicycoreutils/semanage/seobject.py	2008-09-12 11:48:15.000000000 -0400
+++ policycoreutils-2.0.57/semanage/seobject.py	2008-10-28 15:48:14.000000000 -0400
@@ -35,7 +35,7 @@
        import __builtin__
        __builtin__.__dict__['_'] = unicode
 
-is_mls_enabled = selinux.is_selinux_mls_enabled()
+is_mls_enabled = not selinux.is_selinux_enabled() or selinux.is_selinux_mls_enabled()
 
 import syslog
 

--------------030106070504020609010907
Content-Type: application/octet-stream;
 name="seobject_mls.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="seobject_mls.patch.sig"

iEYEABECAAYFAkkUVF8ACgkQrlYvE4MpobO3aQCfUuOslium8Jf73UEZXx6+LSBP7rUAn0kV
nQRQBTpVZhdVorQL8+y3rdLF
--------------030106070504020609010907--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
