Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j07NEMIi019189
	for <selinux@tycho.nsa.gov>; Fri, 7 Jan 2005 18:14:23 -0500 (EST)
Received: from ms-smtp-03.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j07NCS0j022060
	for <selinux@tycho.nsa.gov>; Fri, 7 Jan 2005 23:12:29 GMT
Date: Fri, 7 Jan 2005 17:13:56 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [patch] logrotate
Message-ID: <20050107231356.GA16938@yggdrasil.localdomain>
References: <20050104030117.GB5321@yggdrasil.localdomain> <200501062243.09520.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
In-Reply-To: <200501062243.09520.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--gj572EiMnwbLXET9
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 06, 2005 at 10:43:06PM +1100, Russell Coker wrote:
> > Debian creates the logrotate state file as "/var/lib/logrotate/status",
> > rather than "/var/lib/logrotate.status".  The updated pattern will match
> > both cases.
>=20
> I've attached a slightly different version that will work on other distro=
s=20
> too.

I don't mind tagging that change as Debian-specific.  But wouldn't it be
better to match the "/var/lib/logrotate" directory, instead of the=20
individual file therein?  Just in case additional files are added in the=20
future.

Would this version be acceptable?


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Description: logrotate.fc.diff
Content-Disposition: attachment; filename="logrotate.fc.diff"

--- logrotate.fc.orig	2005-01-01 15:17:35.000000000 -0600
+++ logrotate.fc	2005-01-07 17:12:06.000000000 -0600
@@ -3,9 +3,11 @@
 /usr/sbin/logcheck	--	system_u:object_r:logrotate_exec_t
 ifdef(`distro_debian', `
 /usr/bin/savelog	--	system_u:object_r:logrotate_exec_t
+/var/lib/logrotate(/.*)?	system_u:object_r:logrotate_var_lib_t
+', `
+/var/lib/logrotate\.status --	system_u:object_r:logrotate_var_lib_t
 ')
 /etc/cron\.(daily|weekly)/sysklogd -- system_u:object_r:logrotate_exec_t
-/var/lib/logrotate\.status --	system_u:object_r:logrotate_var_lib_t
 /var/lib/logcheck(/.*)?		system_u:object_r:logrotate_var_lib_t
 # using a hard-coded name under /var/tmp is a bug - new version fixes it
 /var/tmp/logcheck	-d	system_u:object_r:logrotate_tmp_t

--qDbXVdCdHGoSgWSk--

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB3xe0grEMyr8Cx2YRArVBAJ9KQN5feTPpQR3XfCfjykubsWkRCwCgznZ7
3r+nIhDI/66pvsByyUxnk7M=
=uUIP
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
