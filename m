Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0DDqxbR012821
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:52:59 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0DDoCKL004706
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 13:50:12 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n0DDqv4a010795
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:52:57 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n0DDqv8d014071
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:52:57 -0500
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n0DDqpef020877
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2009 08:52:57 -0500
Message-ID: <496C9CB3.9010100@redhat.com>
Date: Tue, 13 Jan 2009 08:52:51 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: audit2allow patch
Content-Type: multipart/mixed;
 boundary="------------040904030109080807060607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040904030109080807060607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Remove --tefile from manpage, option does not exist.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAklsnLIACgkQrlYvE4MpobOrGQCgs76GOeXnSKrLCX69GpCAiIZN
f4AAn312U9ill0sLCKWP1bsL661mctEH
=D9bQ
-----END PGP SIGNATURE-----

--------------040904030109080807060607
Content-Type: text/plain;
 name="policycoreutils_audit2allow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils_audit2allow.patch"

--- nsapolicycoreutils/audit2allow/audit2allow.1	2009-01-13 08:45:35.000000000 -0500
+++ policycoreutils-2.0.60/audit2allow/audit2allow.1	2008-12-15 15:35:46.000000000 -0500
@@ -75,9 +75,6 @@
 Generate reference policy using installed macros.
 This attempts to match denials against interfaces and may be inaccurate.
 .TP
-.B "\-t "  | "\-\-tefile"
-Indicates input file is a te (type enforcement) file.  This can be used to translate old te format to new policy format.
-.TP
 .B "\-w" | "\-\-why"
 Translates SELinux audit messages into a description of why the access was denied
 

--------------040904030109080807060607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
