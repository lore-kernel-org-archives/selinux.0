Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9GGGorT013051
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 12:16:50 -0400 (EDT)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9GGGmlX008810
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 16:16:49 GMT
Message-ID: <417149C9.9010102@gentoo.org>
Date: Sat, 16 Oct 2004 19:18:17 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: gentoo merge for postfix
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE753A9EB8186CC11FE6B6E84"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE753A9EB8186CC11FE6B6E84
Content-Type: multipart/mixed;
 boundary="------------000904050504090308000200"

This is a multi-part message in MIME format.
--------------000904050504090308000200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

can you please ifdef 'rhgb_domain(postfix_master_t)' since it's not part of some distros?

thanks,
peter

--
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------000904050504090308000200
Content-Type: text/plain;
 name="postfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="postfix.diff"

--- /root/public_html/policy/nsa/domains/program/unused/postfix.te	2004-10-15 10:51:22.000000000 +0300
+++ /etc/security/selinux/src/policy/domains/program/postfix.te	2004-10-16 13:15:09.640703128 +0300
@@ -67,7 +67,10 @@
 `allow system_mail_t crond_t:tcp_socket { read write create };')
 
 postfix_domain(master, `, mail_server_domain')
+
+ifdef(`distro_redhat', `
 rhgb_domain(postfix_master_t)
+')
 
 read_sysctl(postfix_master_t)
 

--------------000904050504090308000200--

--------------enigE753A9EB8186CC11FE6B6E84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBcUnNGSBEIeh4AEYRAtyxAJwNQP3A2Gt4ukYVa7K1zAL2H3SlFACfXFPD
walCze83HOvqpHmqn3mshCg=
=YEN2
-----END PGP SIGNATURE-----

--------------enigE753A9EB8186CC11FE6B6E84--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
