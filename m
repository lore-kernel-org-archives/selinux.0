Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i95MHRrT000585
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 18:17:27 -0400 (EDT)
Date: Tue, 5 Oct 2004 17:16:56 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [patch] jabberd file-context update
Message-ID: <20041005221656.GA24557@yggdrasil.localdomain>
References: <20040925011325.GB23849@yggdrasil.localdomain> <1096396843.30810.85.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
In-Reply-To: <1096396843.30810.85.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--3lcZGd9BuhuYXNfi
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2004 at 02:40:43PM -0400, James Carter wrote:
> Merged.
>=20
> On Fri, 2004-09-24 at 21:13, Greg Norris wrote:
> > Please apply the attached jabberd.fc update, which is needed to make th=
e=20
> > logfile accessible.  Thanx!

It seems that I overlooked a related change... would you apply the
attached policy update as well?  Sorry, that'll teach me not to test=20
(only) in permissive mode. :-(

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jabberd.te.diff"
Content-Transfer-Encoding: quoted-printable

--- jabberd.te.orig	2004-10-05 13:07:46.000000000 -0500
+++ jabberd.te	2004-10-05 17:11:00.000000000 -0500
@@ -4,7 +4,7 @@
 # X-Debian-Packages: jabber
=20
 daemon_domain(jabberd)
-log_domain(jabberd)
+logdir_domain(jabberd)
 var_lib_domain(jabberd)
=20
 type jabber_client_port_t, port_type;

--ikeVEW9yuYc//A+q--

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBYx1YgrEMyr8Cx2YRAkJfAJ0YMKky/QgwmPppHiN6wI99NEbsYgCfciQt
BKcJmyK1aKNAWumDTWyWeoQ=
=ovhY
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
