Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1AOVXZ024875
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 05:24:31 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1ANACC019370
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 10:23:11 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Mon, 1 Nov 2004 11:24:29 +0100
Date: Mon, 1 Nov 2004 11:24:14 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: add assert statement for syslog
Message-Id: <20041101102345.GA3377@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--PuGuTyElPB9bOcsM
Content-Type: multipart/mixed; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following patch adds an assertion so that only domains with the
"privlog"-attribute can actually syslog.

Please apply.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="syslog-assert.patch"
Content-Transfer-Encoding: quoted-printable

--- orig/assert.te
+++ mod/assert.te
@@ -68,6 +68,11 @@
 neverallow { domain -privmem } memory_device_t:devfile_class_set { read wr=
ite append };
=20
 #
+# Verify that only domains with the privlog attribute can actually syslog
+#
+neverallow { domain -unrestricted -privlog } devlog_t:sock_file { read wri=
te append };
+
+#
 # Verify that /proc/kmsg is only accessible to klogd.
 #
 ifdef(`klogd.te', `


--- orig/attrib.te
+++ mod/attrib.te
@@ -76,12 +76,8 @@
=20
 # The privlog attribute identifies every domain that can=20
 # communicate with syslogd through its Unix domain socket.
-# This attribute is used in the TE rules in=20
-# domains/program/syslogd.te to grant such access. =20
-# XXX If you want to mandate the use of this attribute for all=20
-# XXX domains that can log, then you should also write corresponding=20
-# XXX assertions in assert.te to enforce this restriction.  Otherwise,
-# XXX it is just an optional convenience for domain writers.
+# There is an assertion that other domains can not do it,
+# and an allow rule to permit it
 attribute privlog;
=20
 # The privmodule attribute identifies every domain that can run




--3uo+9/B/ebqu+fSQ--

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBhg6wxWIrrrL0q+cRAim9AJ9oWvc/n5kt5l1VFQCML6+teEFMlwCeOU9f
rlnz8lXJSMzbLLA4Mlbn1gY=
=vsU+
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
