Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8P1DirT021765
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 21:13:44 -0400 (EDT)
Date: Fri, 24 Sep 2004 20:13:25 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: [patch] jabberd file-context update
Message-ID: <20040925011325.GB23849@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--QNDPHrPUIc00TOLW
Content-Type: multipart/mixed; boundary="N1GIdlSm9i+YlY4t"
Content-Disposition: inline


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please apply the attached jabberd.fc update, which is needed to make the=20
logfile accessible.  Thanx!


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jabberd.fc.diff"

--- jabberd.fc.orig	2004-08-02 02:28:37.000000000 -0500
+++ jabberd.fc	2004-09-12 18:51:04.000000000 -0500
@@ -1,3 +1,4 @@
 # jabberd
 /usr/sbin/jabberd		system_u:object_r:jabberd_exec_t
 /var/lib/jabber(/.*)?		system_u:object_r:jabberd_var_lib_t
+/var/log/jabber(/.*)?		system_u:object_r:jabberd_log_t

--N1GIdlSm9i+YlY4t--

--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBVMY1grEMyr8Cx2YRAvT6AKChtYXiV3XHDZx7eDKm1JXPDgo3VwCdFOg8
q+ykJHLKrEqozhzsJNS0xQg=
=ULg/
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
