Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7TKwkrT001163
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 16:58:46 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7TKwiis004226
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 20:58:44 GMT
Subject: Re: Progress! .532 boots! -- but dbus/hotplug/udev problems remain?
From: Colin Walters <walters@redhat.com>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <41322F5E.90409@comcast.net>
References: <4130CF1B.3090909@comcast.net>
	 <200408291737.17497.russell@coker.com.au>  <41322F5E.90409@comcast.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uzNGqGWbqzeqJ5gZlA7w"
Date: Sun, 29 Aug 2004 16:59:44 -0400
Message-Id: <1093813184.12727.25.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-uzNGqGWbqzeqJ5gZlA7w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-08-29 at 12:32 -0700, Tom London wrote:
> Russell,
>=20
> Thanks, but it didn't quite work. The following change to dbusd.te seems
> to make graphical login work under strict/enforcing.

I think we need to rework the dbusd.te to break it into dbusd_system_t
and dbusd_{user,staff}_t.

--=-uzNGqGWbqzeqJ5gZlA7w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBMkPAOIkJWWp2WGURAjA9AJ4s48YmF/7upKpSr+2OWL4YUSj/lgCfddVY
MGcHI3s+ChCjj/ydBk4v3uY=
=CMLV
-----END PGP SIGNATURE-----

--=-uzNGqGWbqzeqJ5gZlA7w--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
