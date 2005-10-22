Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9MEnaNs023588
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 10:49:36 -0400 (EDT)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j9MEkIK1024230
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 14:46:19 GMT
Date: Sat, 22 Oct 2005 17:46:09 +0300
From: Petre Rodan <kaiowas@gentoo.org>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: run_init: Fork:: No such file or directory
Message-ID: <20051022144609.GA9002@peter.sunspire.org>
References: <1129985971.31615.31.camel@localhost.localdomain> <1129986782.31615.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
In-Reply-To: <1129986782.31615.37.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sat, Oct 22, 2005 at 02:13:01PM +0100, Antoine Martin wrote:
> Next time, I'll wait before posting...
> I can't explain why that fixed it, but I rebooted, relabeled and now
> everything works ok. I've had issues with ttys/ptys before, I guess this
> is what has happened here.
> Not understanding the problem or the fix makes me nervous though.

it is a quite common problem that is happening since around ~ 2.6.9. someti=
mes even ssh logins are impossible because of this bug ("can't open pty" er=
ror IIRC).

for me the only way to unlock the situation is to close all open ssh termin=
als left open toward that server.
once that done, everything (including run_init behavior) returns to normal.

bye,
peter
=20
> Thanks
> Antoine
>=20
>=20
>=20
> On Sat, 2005-10-22 at 13:59 +0100, Antoine Martin wrote:
> > Hi,
> >=20
> > I've been running a system with SELinux enforcing mode for some time
> > (Gentoo x86), but since yesterday I can't seem to use run_init to start
> > daemons, it fails with:
> > Fork:: No such file or directory
> >=20
> > When I straced it, I found that it is failing to open /dev/ptmx|pty?? :
> > open("/dev/ptmx", O_RDWR)               =3D -1 EIO (Input/output error)
> > open("/dev/ptyp0", O_RDWR)              =3D -1 ENXIO (No such device or
> > address)
> > open("/dev/ptyp1", O_RDWR)              =3D -1 ENXIO (No such device or
> > address)
> > (...)
> > open("/dev/ptyef", O_RDWR)              =3D -1 ENXIO (No such device or
> > address)
> > dup(2)                                  =3D 3
> > fcntl64(3, F_GETFL)                     =3D 0x2 (flags O_RDWR)
> > brk(0)                                  =3D 0x804b000
> > brk(0x806c000)                          =3D 0x806c000
> > fstat64(3, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(136, 1), ...}) =
=3D 0
> > mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> > 0) =3D 0xb7f17000
> > _llseek(3, 0, 0xbfc256e4, SEEK_CUR)     =3D -1 ESPIPE (Illegal seek)
> > write(3, "Fork:: No such file or directory"..., 33Fork:: No such file or
> > directory
> > ) =3D 33
> > close(3)                                =3D 0
> > munmap(0xb7f17000, 4096)                =3D 0
> > exit_group(71)                          =3D ?
> >=20
> > Obviously, the devices are there and I'm not using devfs (kernel
> > 2.6.13.4) /dev is static on ext3 /.
> > I am really stumped. I've tried rebuilding it, rebuilding the libraries
> > it depends on, switched to non-enforcing mode, etc.. No luck
> > Any ideas would be much appreciated.

--=20
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux=20

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iD8DBQFDWlCxGSBEIeh4AEYRAqa6AKCFJ+mMmOCp0pbQErCikM4ZSv6psQCeJcte
lcC83z5rs1SzSyert0viUE4=
=Z//z
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
