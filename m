Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBGLcxIi028038
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 16:38:59 -0500 (EST)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBGLd1qv002148
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 21:39:02 GMT
Subject: Re: Tomcat policy
From: Colin Walters <walters@verbum.org>
To: Nick Gray <nick-lists@austin.rr.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <1103224127.32688.49.camel@hawaii.grays-systems.com>
References: <1103224127.32688.49.camel@hawaii.grays-systems.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GJ323XiQMfL6NzubYbCl"
Date: Thu, 16 Dec 2004 16:39:02 -0500
Message-Id: <1103233142.12552.77.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-GJ323XiQMfL6NzubYbCl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-12-16 at 13:08 -0600, Nick Gray wrote:

> #/usr/local/tomcat/5.0.28(/.*)?         system_u:object_r:tomcat_t

You want tomcat_exec_t.

> I think I understand how to protect the daemon from the system, how do I
> protect the system from the daemon.
>=20
> The example I can come up with is a jsp page that opens
> the /etc/passwd/file and prints it. I want to keep the tomcat process
> encapsulated in it own space

Simply don't allow tomcat_t access to passwd_t.


--=-GJ323XiQMfL6NzubYbCl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBwgB1OIkJWWp2WGURAgfgAJ9fFV29xDEa+2WSIDJpbFKhL/idHwCePxc0
x5cE9w7UZnBtCl7z1VnZt2k=
=C40s
-----END PGP SIGNATURE-----

--=-GJ323XiQMfL6NzubYbCl--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
