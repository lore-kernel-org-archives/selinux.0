Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5QDR4Ys000535
 for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2017 09:27:04 -0400
Received: by mail-wm0-f45.google.com with SMTP id 62so1281242wmw.1
 for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2017 06:26:30 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id w48sm38858edb.49.2017.06.26.06.26.28
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 26 Jun 2017 06:26:28 -0700 (PDT)
Date: Mon, 26 Jun 2017 15:26:26 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: run_init messes up terminal settings
Message-ID: <20170626132626.GA15033@julius.enp8s0.d30>
References: <f19a1c21-5c15-cb56-9e55-08df2f66429a@debian.org>
 <1498482496.13301.2.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
In-Reply-To: <1498482496.13301.2.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 09:08:16AM -0400, Stephen Smalley wrote:
> On Sat, 2017-06-24 at 12:20 +0200, Laurent Bigonville wrote:
> > Hello,
> > Russell opened the following bug regarding run_init in the debian
> > bts:
> > =3D=3D=3D=3D
> > [...]
> > It turns out that the problem was not running $(arch), but running
> > run_init in=A0
> > the shell it spawned.=A0=A0Below is an example of reproducing this, the
> > first time=A0
> > run_init performs as expected.=A0=A0The second time is fails without me
> > even=A0
> > typing a password or pressing ENTER.=A0=A0The result is the same with a=
ny
> > command,=A0
> > but ls is just a good example.=A0=A0This happens no matter what shell is
> > spawned=A0
> > (whether it's ssh, su, or just an Xterm), run_init seems generally
> > broken with=A0
> > the 4.9.0-2-amd64/4.9.13-1 kernel at least.
> >=20
> > NB I can't rule out the possibility of a kernel bug at this
> > stage.=A0=A0But at=A0
> > this time it seems best to assume it's a run_init bug until proven
> > otherwise.
> >=20
> > Sorry for the inconvenience Andreas.
> >=20
> > # run_init ls /boot
> > Authenticating root.
> > Password:=A0
> > config-4.9.0-2-amd64=A0=A0=A0=A0=A0=A0lost+found=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0System.map-4.9.0-
> > 3-amd64
> > config-4.9.0-3-amd64=A0=A0=A0=A0=A0=A0memtest86+.bin=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0vmlinuz-4.9.0-2-
> > amd64
> > grub=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0m=
emtest86+_multiboot.bin=A0=A0vmlinuz-4.9.0-3-
> > amd64
> > initrd.img-4.9.0-2-amd64=A0=A0real
> > initrd.img-4.9.0-3-amd64=A0=A0System.map-4.9.0-2-amd64
> > # run_init ls /boot
> > Authenticating root.
> > Password:=A0
> > run_init: incorrect password for root
> > authentication failed.
> > #=A0
> > =3D=3D=3D=3D
> > I can reproduce this with 2.7-rc3, run_init is compiled with pam and
> > audit support.
> > An idea what could happen here?
> > Regards,
> > Laurent Bigonville
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D863187
>=20
> I don't think this could have ever worked under run_init since
> open_init_pty was introduced (originally from Debian); note that
> open_init_pty does alter terminal settings.
>=20
> I don't quite follow the example given above.  It shows executing
> run_init twice with ls /boot as the arguments, which is not running
> run_init within run_init.  That works fine for me.
>=20
> If I try something like:
> run_init run_init ls /boot
> which actually runs run_init within run_init, then that also works for
> me without problem.
>=20
> If I try something like:
> run_init /bin/bash
> then I lose any echoing of input characters to the shell (due to
> open_init_pty turning it off), but I can enter commands and execute
> them, or run stty sane to regain echoing.  But I don't think that has
> ever been supported since the introduction of open_init_pty in 2005
> (policycoreutils 1.21.2).  What's the use case for it?
>=20
> Side bar: run_init (and open_init_pty) are no longer packaged by Fedora
> since systemd renders it unnecessary, and even prior to that, Fedora
> policy enabled DIRECT_INITRC=3Dy in build.conf, and therefore run_init

Correct me if i am wrong but fedora has DIRECT_INITRC=3Dn AFAICT

https://src.fedoraproject.org/cgit/rpms/selinux-policy.git/tree/selinux-pol=
icy.spec#n173
https://src.fedoraproject.org/cgit/rpms/selinux-policy.git/tree/selinux-pol=
icy.spec#n393

I vaguely recall that in a strict environment one still might need run_init=
 for the `update aliases` functionality in redhar-based distributions.. i m=
ight be wrong though

> wasn't required for typical operation (maybe under -mls policy it was
> still needed, not sure). Possibly we should move run_init out of
> policycoreutils into its own subdirectory in the selinux userspace tree
> to reflect this transition and start deprecating it.
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAllRC38ACgkQJXSOVTf5
R2lL0Qv9E/lIXmPIC4iGqkioxfPy9OKXfvI11A7kvh3Y5K2ohxqOtRGjsGETnpT9
7tPVFCkJM+cSRWtXbBcNW5TbcL11P1emE5t7d1rgdVaT5wwK1d6+uT3vz81EV7xA
3XK7LIr1TrtvB8VOU75QtQC/dBk28wq/J8gpAhyxGTb0g2hPYC4GpGqo+cGwk4Et
wvvC6kYZ9X4TrsHKBLQiYcPpvdYfV+/7TICAPkh3ywZYFjjG3TJHbJosFNJ2FPsC
NEODEJJ1ISNFVivMYZ34DfCUqiTpky5JjC14ozEy1HUlk5CWdfr6Bk86jFQpnvSj
WT3ToHQkkHSSth3yILjUHL/cOOwzJ1lzDfpCouivUbLgHfDhC6kgFuHP/qgWA6V2
mJbJ31rY+o0pn30x9z0ANjSNlfDY1aQZpn4ogX6I8YdRNgGzrsddXlWyVv0OC8nd
7gCAxAzjHz+wyRk/JJvDq7YzOGyCvdBwxqmv9FrH85Qf5Iaq5okGFqRQaFxuQcV3
+nmQXLp8
=gbaQ
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
