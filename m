Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBI3l98X026018
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2007 22:47:09 -0500
Received: from QMTA10.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBI3l8Li014595
	for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 03:47:08 GMT
Subject: Re: Xorg modprobe denials
From: Chris PeBenito <pebenito@gentoo.org>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <47673B12.6040205@tycho.nsa.gov>
References: <47673B12.6040205@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5IBN4QqbXzmaw7DQslQp"
Date: Mon, 17 Dec 2007 22:47:07 -0500
Message-Id: <1197949627.4790.4.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-5IBN4QqbXzmaw7DQslQp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-12-17 at 22:14 -0500, Eamon Walsh wrote:
> Attached are some denials that modprobe is encountering while loading=20
> Xorg DRI kernel modules while X server is starting up.  tty7 is the=20
> terminal where the X server is being launched (Ctrl-Alt-F7).  I'm aware=20
> that the Xorg.0.log file is supposed to be labeled xserver_log_t, but my=20
> guess is that would be denied as well.  Think this may be log messages=20
> except for the renicing stuff.
>=20
> This is xselinux branch of refpolicy running in enforcing mode.

Based on the other kernel messages, I'm guessing that the insmod
succeeded despite the tty and capability denials?  If so I suppose we
can dontaudit it.

> plain text document attachment (audit_x.txt)
> Dec 17 21:25:34 moss-charon kernel: audit(1197944734.892:71): avc:  denie=
d  { read write } for  pid=3D2220 comm=3D"modprobe" name=3D"tty7" dev=3Dtmp=
fs ino=3D240 scontext=3Dsystem_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=
=3Dsystem_u:object_r:tty_device_t:s0 tclass=3Dchr_file
> Dec 17 21:25:34 moss-charon kernel: audit(1197944734.893:72): avc:  denie=
d  { write } for  pid=3D2220 comm=3D"modprobe" path=3D"/usr/local/var/log/X=
org.0.log" dev=3Ddm-0 ino=3D5701638 scontext=3Dsystem_u:system_r:insmod_t:s=
0-s0:c0.c255 tcontext=3Dsystem_u:object_r:usr_t:s0 tclass=3Dfile
> Dec 17 21:25:34 moss-charon kernel: audit(1197944734.893:73): avc:  denie=
d  { read write } for  pid=3D2220 comm=3D"modprobe" path=3D"/dev/tty7" dev=
=3Dtmpfs ino=3D240 scontext=3Dsystem_u:system_r:insmod_t:s0-s0:c0.c255 tcon=
text=3Dsystem_u:object_r:tty_device_t:s0 tclass=3Dchr_file
> Dec 17 21:25:34 moss-charon kernel: audit(1197944734.926:74): avc:  denie=
d  { sys_nice } for  pid=3D2220 comm=3D"modprobe" capability=3D23 scontext=
=3Dsystem_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=3Dsystem_u:system_r:in=
smod_t:s0-s0:c0.c255 tclass=3Dcapability
> Dec 17 21:25:34 moss-charon kernel: [drm] Initialized drm 1.1.0 20060810
> Dec 17 21:25:34 moss-charon kernel: audit(1197944734.932:75): avc:  denie=
d  { sys_nice } for  pid=3D2220 comm=3D"modprobe" capability=3D23 scontext=
=3Dsystem_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=3Dsystem_u:system_r:in=
smod_t:s0-s0:c0.c255 tclass=3Dcapability
> Dec 17 21:25:34 moss-charon kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -=
> GSI 16 (level, low) -> IRQ 16
> Dec 17 21:25:34 moss-charon kernel: [drm] Initialized i915 1.11.0 2007112=
2 on minor 0
> Dec 17 21:25:34 moss-charon kernel: mtrr: type mismatch for c0000000,1000=
0000 old: write-back new: write-combining
> Dec 17 21:25:40 moss-charon kernel: mtrr: type mismatch for c0000000,1000=
0000 old: write-back new: write-combining
>=20

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-5IBN4QqbXzmaw7DQslQp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBHZ0K7vI7kLeavkkMRAikdAJ9heC54+0WRieOXGz+Gewg+WBvqPACePhoe
w+bli2diKNCqtwe4LnQRrKI=
=8v2o
-----END PGP SIGNATURE-----

--=-5IBN4QqbXzmaw7DQslQp--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
