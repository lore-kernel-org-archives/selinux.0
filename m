Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8FJ6krT019941
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 15:06:46 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8FJ6hhP013585
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 19:06:46 GMT
Subject: Re: [patch] don't relabel sub-subdirectories of /mnt, /media by
	default
From: Colin Walters <walters@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <rcoker@redhat.com>
In-Reply-To: <1095273509.28981.230.camel@moss-spartans.epoch.ncsc.mil>
References: <1094828936.7061.20.camel@nexus.verbum.private>
	 <1095106896.2161.21.camel@moss-lions.epoch.ncsc.mil>
	 <20040913232841.GB30524@lkcl.net>
	 <1095272723.4231.38.camel@nexus.verbum.private>
	 <1095273509.28981.230.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BsWaBdYctoD+ai2RWmDD"
Date: Wed, 15 Sep 2004 15:08:05 -0400
Message-Id: <1095275285.4231.56.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BsWaBdYctoD+ai2RWmDD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-15 at 14:38 -0400, Stephen Smalley wrote:
> On Wed, 2004-09-15 at 14:25, Colin Walters wrote:
> > Dan, John Palmieri and I talked about this, and we agreed that it is ba=
d
> > that currently file contexts on removable ext3 media is trusted.=20
> >=20
> > Right now when a device is inserted HAL generates an fstab entry for it=
,
> > and includes "nosuid, noexec, nodev" (actually these are implied by the
> > "user" option).
>=20
> Just as a side note, nosuid also disables domain transitions for any
> programs on the filesystem, so at least you can't provide arbitrary
> entrypoint programs on the removable media.=20

I didn't know that; that certainly helps.

Ok, well we still have the other problems of the varied genfs types for
removable media, and that removable media which does have filesystems
that support xattrs but which may not be labeled, and we don't want to
relabel it.






--=-BsWaBdYctoD+ai2RWmDD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBSJMVOIkJWWp2WGURAmtaAJ92YKIWYc52Ma2rKgjdvwOh/138EACeNa8V
xpfhpPvLNc8v/hSNhbzEiFk=
=Cwrw
-----END PGP SIGNATURE-----

--=-BsWaBdYctoD+ai2RWmDD--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
