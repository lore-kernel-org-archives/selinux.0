Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9RHHxXZ022675
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 13:17:59 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9RHHtFh008030
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 17:17:55 GMT
Subject: Re: [PATCH] devpts xattr support
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <1098886534.30470.112.camel@moss-spartans.epoch.ncsc.mil>
References: <417E5BB5.1010300@trustedcs.com>
	 <1098801765.27060.39.camel@moss-spartans.epoch.ncsc.mil>
	 <417E90DB.7050405@trustedcs.com>
	 <1098886534.30470.112.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-u6CYRfi8TAcUkh18AJ/P"
Date: Wed, 27 Oct 2004 13:18:22 -0400
Message-Id: <1098897502.19734.50.camel@x-infinity.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-u6CYRfi8TAcUkh18AJ/P
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-10-27 at 10:15 -0400, Stephen Smalley wrote:

> On the other hand, adding a fake xattr handler to every filesystem that
> doesn't natively support them also seems difficult to accept; we've only
> done this to date on a demand basis; devpts needed the support for pty
> relabeling, tmpfs needed support for udev.

Having xattr support for more filesystems is useful even outside
SELinux.  For example there is some discussion about storing MIME types
in say a user.mimetype xattr.  If that were to happen, we'd want it
to work even for people who make /tmp a tmpfs. =20

Once filesystems like tmpfs gain real xattr support, the "fake" hooks
wouldn't be so anymore.


--=-u6CYRfi8TAcUkh18AJ/P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBf9heOIkJWWp2WGURAq3jAJ9kYW48sK+7j3IAsv40N2tB7Pn8RgCffaft
nI3GQyAJz1JcB44m0zUSkw0=
=wb/P
-----END PGP SIGNATURE-----

--=-u6CYRfi8TAcUkh18AJ/P--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
