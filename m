Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8PH9drT024281
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 13:09:39 -0400 (EDT)
Received: from rwcrmhc12.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8PH8csn000891
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 17:08:39 GMT
Subject: Re: Remove unrestricted_admin
From: Chris PeBenito <pebenito@gentoo.org>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200409260121.10665.russell@coker.com.au>
References: <200409211526.37810.russell@coker.com.au>
	 <200409252039.01196.russell@coker.com.au>
	 <1096119005.11665.21.camel@gorn.pebenito.net>
	 <200409260121.10665.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-du+cwEE4njzkEVd5LpwI"
Date: Sat, 25 Sep 2004 13:09:00 -0400
Message-Id: <1096132140.11665.34.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-du+cwEE4njzkEVd5LpwI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-09-26 at 01:21 +1000, Russell Coker wrote:
> On Sat, 25 Sep 2004 23:30, "Christopher J. PeBenito" <cpebenito@tresys.co=
m>=20
> wrote:

> > much more likely that an admin would be using a regular backup solution
> > with tapes and autoloaders (bigger systems) and the like for backups
> > with tools seem to be fit for backup_t or similar domain.
>=20
> Tapes and auto-loaders don't make these problems go away.

They're more likely to use backup software to run it, which is what I
meant, then it will be using a program that can be put in its own domain
to do its work.  Raw access could be added to that domain if needed.

> > Since I'm not familiar with LVM, I'm curious as to why doing a snapshot
> > doesn't fit into a domain of its own or fsadm_t.
>=20
> The snapshot device is just like any other fixed disk device.  To use it =
for a=20
> backup you need a process that has permissions to read it and to write to=
=20
> wherever the backup may be stored.  We could allow backup_t to read=20
> fixed_disk_device_t for this case.

Does this not require a program to do a snapshotting?  If it does, why
does it not fit in its own domain?

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--=-du+cwEE4njzkEVd5LpwI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBVaYsvI7kLeavkkMRAgr1AJ97eUhVIg5YQVp8J8oHEYchZPIQ8ACdFPUa
DwgsPxHcOgN+5FdgZOOx5MM=
=8/Gi
-----END PGP SIGNATURE-----

--=-du+cwEE4njzkEVd5LpwI--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
