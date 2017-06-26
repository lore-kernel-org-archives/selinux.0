Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5QHKXCg005659
 for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2017 13:20:33 -0400
Received: by mail-wm0-f51.google.com with SMTP id i127so3918298wma.0
 for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2017 10:20:31 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id p49sm384742edc.47.2017.06.26.10.20.29
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 26 Jun 2017 10:20:29 -0700 (PDT)
Date: Mon, 26 Jun 2017 19:20:28 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: run_init messes up terminal settings
Message-ID: <20170626172028.GC15033@julius.enp8s0.d30>
References: <f19a1c21-5c15-cb56-9e55-08df2f66429a@debian.org>
 <1498482496.13301.2.camel@tycho.nsa.gov>
 <20170626132626.GA15033@julius.enp8s0.d30>
 <1498492210.13301.20.camel@tycho.nsa.gov>
 <20170626164544.GB15033@julius.enp8s0.d30>
 <1498497761.13301.21.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
In-Reply-To: <1498497761.13301.21.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 01:22:41PM -0400, Stephen Smalley wrote:
> On Mon, 2017-06-26 at 18:45 +0200, Dominick Grift wrote:
> > On Mon, Jun 26, 2017 at 11:50:10AM -0400, Stephen Smalley wrote:
> > > On Mon, 2017-06-26 at 15:26 +0200, Dominick Grift wrote:
> > > > On Mon, Jun 26, 2017 at 09:08:16AM -0400, Stephen Smalley wrote:
> > > > > On Sat, 2017-06-24 at 12:20 +0200, Laurent Bigonville wrote:
> > > > > > Hello,
> > > > > > Russell opened the following bug regarding run_init in the
> > > > > > debian
> > > > > > bts:
> > > > > > =3D=3D=3D=3D
> > > > > > [...]
> > > > > > It turns out that the problem was not running $(arch), but
> > > > > > running
> > > > > > run_init in=A0
> > > > > > the shell it spawned.=A0=A0Below is an example of reproducing
> > > > > > this,
> > > > > > the
> > > > > > first time=A0
> > > > > > run_init performs as expected.=A0=A0The second time is fails
> > > > > > without
> > > > > > me
> > > > > > even=A0
> > > > > > typing a password or pressing ENTER.=A0=A0The result is the same
> > > > > > with
> > > > > > any
> > > > > > command,=A0
> > > > > > but ls is just a good example.=A0=A0This happens no matter what
> > > > > > shell
> > > > > > is
> > > > > > spawned=A0
> > > > > > (whether it's ssh, su, or just an Xterm), run_init seems
> > > > > > generally
> > > > > > broken with=A0
> > > > > > the 4.9.0-2-amd64/4.9.13-1 kernel at least.
> > > > > >=20
> > > > > > NB I can't rule out the possibility of a kernel bug at this
> > > > > > stage.=A0=A0But at=A0
> > > > > > this time it seems best to assume it's a run_init bug until
> > > > > > proven
> > > > > > otherwise.
> > > > > >=20
> > > > > > Sorry for the inconvenience Andreas.
> > > > > >=20
> > > > > > # run_init ls /boot
> > > > > > Authenticating root.
> > > > > > Password:=A0
> > > > > > config-4.9.0-2-
> > > > > > amd64=A0=A0=A0=A0=A0=A0lost+found=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0System.map-
> > > > > > 4.9.0-
> > > > > > 3-amd64
> > > > > > config-4.9.0-3-amd64=A0=A0=A0=A0=A0=A0memtest86+.bin=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0vmlinuz-
> > > > > > 4.9.0-2-
> > > > > > amd64
> > > > > > grub=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0memtest86+_multiboot.bin=A0=A0vmlinuz-
> > > > > > 4.9.0-3-
> > > > > > amd64
> > > > > > initrd.img-4.9.0-2-amd64=A0=A0real
> > > > > > initrd.img-4.9.0-3-amd64=A0=A0System.map-4.9.0-2-amd64
> > > > > > # run_init ls /boot
> > > > > > Authenticating root.
> > > > > > Password:=A0
> > > > > > run_init: incorrect password for root
> > > > > > authentication failed.
> > > > > > #=A0
> > > > > > =3D=3D=3D=3D
> > > > > > I can reproduce this with 2.7-rc3, run_init is compiled with
> > > > > > pam
> > > > > > and
> > > > > > audit support.
> > > > > > An idea what could happen here?
> > > > > > Regards,
> > > > > > Laurent Bigonville
> > > > > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D863187
> > > > >=20
> > > > > I don't think this could have ever worked under run_init since
> > > > > open_init_pty was introduced (originally from Debian); note
> > > > > that
> > > > > open_init_pty does alter terminal settings.
> > > > >=20
> > > > > I don't quite follow the example given above.=A0=A0It shows
> > > > > executing
> > > > > run_init twice with ls /boot as the arguments, which is not
> > > > > running
> > > > > run_init within run_init.=A0=A0That works fine for me.
> > > > >=20
> > > > > If I try something like:
> > > > > run_init run_init ls /boot
> > > > > which actually runs run_init within run_init, then that also
> > > > > works
> > > > > for
> > > > > me without problem.
> > > > >=20
> > > > > If I try something like:
> > > > > run_init /bin/bash
> > > > > then I lose any echoing of input characters to the shell (due
> > > > > to
> > > > > open_init_pty turning it off), but I can enter commands and
> > > > > execute
> > > > > them, or run stty sane to regain echoing.=A0=A0But I don't think
> > > > > that
> > > > > has
> > > > > ever been supported since the introduction of open_init_pty in
> > > > > 2005
> > > > > (policycoreutils 1.21.2).=A0=A0What's the use case for it?
> > > > >=20
> > > > > Side bar: run_init (and open_init_pty) are no longer packaged
> > > > > by
> > > > > Fedora
> > > > > since systemd renders it unnecessary, and even prior to that,
> > > > > Fedora
> > > > > policy enabled DIRECT_INITRC=3Dy in build.conf, and therefore
> > > > > run_init
> > > >=20
> > > > Correct me if i am wrong but fedora has DIRECT_INITRC=3Dn AFAICT
> > > >=20
> > > > https://src.fedoraproject.org/cgit/rpms/selinux-policy.git/tree/s
> > > > elin
> > > > ux-policy.spec#n173
> > > > https://src.fedoraproject.org/cgit/rpms/selinux-policy.git/tree/s
> > > > elin
> > > > ux-policy.spec#n393
> > > >=20
> > > > I vaguely recall that in a strict environment one still might
> > > > need
> > > > run_init for the `update aliases` functionality in redhar-based
> > > > distributions.. i might be wrong though
> > >=20
> > > run_init is no longer packaged in Fedora at all (see
> > > policycoreutils.spec, which removes it during %install so that it
> > > will
> > > not be packaged).=A0=A0Looking at the ChangeLog, this happened in 201=
2:
> > > * Mon Nov 5 2012 Dan Walsh <dwalsh@redhat.com> - 2.1.12-25
> > > - Remove run_init, no longer needed with systemd.
> > >=20
> > > Thus, DIRECT_INITRC=3Dy is no longer required either, for the same
> > > reason
> > > (obsoleted by systemd).=A0=A0Prior to that change, Fedora built with
> > > DIRECT_INITRC=3Dy for -targeted policy; only -mls and -strict built
> > > with
> > > DIRECT_INITRC=3Dn and needed run_init.
> >=20
> > Maybe, I recall that previously Fedora use to hack around
> > DIRECT_INITRC with unconfined_t but AFAICR it always applied to
> > sysadm_t.
> > Does not make any difference though. However I do, kind of, wonder if
> > sysadm_t is currently able to update the aliases db with sendmail
> > (but then again it has been a long time since redhat shipped with
> > sendmail enabled by default)
> >=20
> > Nevertheless, gentoo relies on run_init for openrc, and in debian
> > systemd is optional (i think)
> >=20
> > Normally I am all for removing as much as possible, but with run_init
> > I have mixed feelings, because systemd has been and is a headache
> > IMHO
> >=20
> > No one was able to confirm it but last lime i tried the "service
> > enable/disable" access vector was broken. Atleast with good old
> > sysvinit/upstart we didnt have to depend selinux extension code to be
> > able to control this as it was all transparent.
>=20
> You'll have to clarify what you mean by "broken" here, preferably with
> a reproducer.
>=20

In fedora 26 i noticed that the "service disable/enable" checks were no lon=
ger performed.

In other words confined administrators were able to disable/enable arbitrar=
y service units.

https://tfirg.undo.it/wordpress/dssp2-confined-administrators-and-a-what-lo=
oks-to-be-a-bug-in-systemd-233/


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAllRQlgACgkQJXSOVTf5
R2nNLwwAmVV2P6rn0LTpKScnueyigvBdw3gu6PS21PIdBMrIaCW6b0WRNRY5Icaa
mYkVBVPt7tEIbfmcHsQk303aqcBkyI6vpB/5siukbPiqkRTC9tPwpKe9/FrTfWBw
FRTNzHQ59NEQ6/ysTSihJ5CEzMAbxhkwG2so+HCv5L4cJMvysRr5scD8vF4io0QL
I4OMmxM3+CzoC1J3GUc9qieHvY8bnGcy7W4ZCztiOZFtnTo/ZnNpCdwf+iZ5lQ/p
mJe5hpL0ou5GcvDf9fX/vtlSDRg2nUJbA2dKN+yD1gbQntxt/qC4Qa+/Ar0PcnVW
hSl+I94ohyFWGLktN2MHZ2xIp2vk+nvXOjjtCg6eh3bLr2H7YgGN6XMv9kHyCNrD
Kb/nGw0Kn+HnUT2aRD4RPdAUqD8NUKtCfRKoDGfgTab6CcU1DVfryS8ePTxw6b0y
BJlmK0Vpy29Gx53hbK2+wd62Xs5PAxd1h/11VUtjhWTkJ1FSYdhm0kBCWzDFUrQh
uwwCyOaF
=kfjR
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
