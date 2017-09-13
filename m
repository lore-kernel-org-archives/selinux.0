Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8D92xCA022481
 for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2017 05:03:00 -0400
Received: by mail-wm0-f46.google.com with SMTP id g206so1308823wme.0
 for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2017 02:02:52 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id h45sm2741187eda.92.2017.09.13.02.02.48
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Sep 2017 02:02:48 -0700 (PDT)
Date: Wed, 13 Sep 2017 11:02:47 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170913090247.GB2189@julius.enp8s0.d30>
References: <20170912133835.GA5111@julius.enp8s0.d30>
 <CAB9W1A0yYAg3UzwPMo6RVUZEdHDNr3BhjKb=vhvJ4GcmyEA+mw@mail.gmail.com>
 <20170912173659.GB5111@julius.enp8s0.d30>
 <CAHC9VhSg02C_xd1HnRPkgGvD8WxPQWj3K5+6MpHnZvhHT0vDRA@mail.gmail.com>
 <20170912193151.GC5111@julius.enp8s0.d30>
 <CAHC9VhT0i4TAx3WSbSLtu7+8NfzJ+2Wkaub8vOOLvQpVv-y=LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
In-Reply-To: <CAHC9VhT0i4TAx3WSbSLtu7+8NfzJ+2Wkaub8vOOLvQpVv-y=LA@mail.gmail.com>
Subject: Re: with extended_socket_class should be still be seeing
 "socket"?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2017 at 05:57:53PM -0400, Paul Moore wrote:
> On Tue, Sep 12, 2017 at 3:31 PM, Dominick Grift <dac.override@gmail.com> =
wrote:
> > On Tue, Sep 12, 2017 at 02:55:38PM -0400, Paul Moore wrote:
> >> On Tue, Sep 12, 2017 at 1:36 PM, Dominick Grift <dac.override@gmail.co=
m> wrote:
> >> > On Tue, Sep 12, 2017 at 12:01:35PM -0400, Stephen Smalley wrote:
> >> >> On Sep 12, 2017 7:01 AM, "Dominick Grift" <dac.override@gmail.com> =
wrote:
> >> >>
> >> >> I have extended socket class polcap enabled but i am still seeing "=
socket"
> >> >> class events and i was wondering whether that is to be expected?
> >> >>
> >> >> avc:  denied  { create } for  pid=3D10484 comm=3D"nethogs" scontext=
=3Dwheel.id:
> >> >> sysadm.role:nethogs.subj:s0 tcontext=3Dwheel.id:sysadm.role:nethogs=
=2Esubj:s0
> >> >> tclass=3Dsocket permissive=3D0
> >> >>
> >> >> This seems to be common to processes that also create (and map! [1])
> >> >> "packet_socket" sockets (tcpdump/nethogs)
> >> >>
> >> >> [1] avc:  denied  { map } for  pid=3D10525 comm=3D"nethogs"
> >> >> path=3D"socket:[56040]" dev=3D"sockfs" ino=3D56040
> >> >> scontext=3Dwheel.id:sysadm.role:nethogs.subj:s0
> >> >> tcontext=3Dwheel.id:sysadm.role:nethogs.subj:s0 tclass=3Dpacket_soc=
ket
> >> >> permissive=3D0
> >> >>
> >> >>
> >> >> No, that is not expected. Can you enable sys call audit and get tho=
se
> >> >> records?
> >> >
> >> > type=3DPROCTITLE msg=3Daudit(09/12/2017 19:35:54.063:4458) : proctit=
le=3Dnethogs enp8s0
> >> > type=3DSYSCALL msg=3Daudit(09/12/2017 19:35:54.063:4458) : arch=3Dx8=
6_64 syscall=3Dsocket success=3Dyes exit=3D5 a0=3Dlocal a1=3DSOCK_RAW a2=3D=
ip a3=3D0xb4 items=3D0 ppid=3D3251 pid=3D8963 auid=3Dkcinimod uid=3Droot gi=
d=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=
=3Droot tty=3Dpts5 ses=3D1 comm=3Dnethogs exe=3D/usr/sbin/nethogs subj=3Dwh=
eel.id:sysadm.role:nethogs.subj:s0 key=3D(null)
> >> > type=3DAVC msg=3Daudit(09/12/2017 19:35:54.063:4458) : avc:  denied =
 { create } for  pid=3D8963 comm=3Dnethogs scontext=3Dwheel.id:sysadm.role:=
nethogs.subj:s0 tcontext=3Dwheel.id:sysadm.role:nethogs.subj:s0 tclass=3Dso=
cket permissive=3D1
> >>
> >> Ah ha, AF_UNIX/SOCK_RAW, that's the problem.  Luis Ressel fixed this
> >> (see the commit below) and it should make it up to Linus during the
> >> current merge window (eventually, maybe, hopefully).
> >>
> >> If you run Fedora Rawhide, you can try one of recent kernel builds in
> >> the COPR repo below, it should have the fix.
> >>
> >> *  https://copr.fedorainfracloud.org/coprs/pcmoore/kernel-secnext
> >
> > Thanks i will probably try this out in a virtual machine tomorrow (kind=
 of relieved now with a "stable" 4.13 on my bare bones after quite a turbul=
ent 4.12 and 4.13)
>=20
> Okay, let me know how it works for you.

Works great. its now unix_dgram_socket

got this awesome procedure to test this stuff

1. create (non-legacy rawhide) bootable image from dssp2-standard source tr=
ee with `mkosi`
2. install copr and enable copr
3. update kernel
4. create new efi image with dracut
5. boot and do tests

recorded the whole procedure:

https://www.youtube.com/watch?v=3DObuBJ9qucuY

>=20
> If it helps, v4.14 should be pretty quiet, no major changes like the
> past few releases.
>=20
> --=20
> paul moore
> www.paul-moore.com
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlm49DMACgkQJXSOVTf5
R2lBgAwAgFQducoEbmH4O6UNjY74vy9t2mGL/A5T32J0MF5PoCWiFDmZPHP9PQrl
f/OBFR1uWWOe2tGXkLfRHWLlcMZa5HPHqYfazFomGnIskJK/ctaCfE219ABRUnZY
MweiHRzWAVQpNfNE22PPPeppQkwyAb+ZxYo9gozYIRhLe7V1ONElULDxlAprpH/h
93LZxdQJ7HyM+IC+0Wiuj+o7h3zGj2rjer+faWJrl338Ei5FYakS2WmkX+XPKqqm
XTJ+MK9WlsfWiH8dL09FPRDoeefK5p0tAKMBjjlkjMXjrbGZoqkWb1AK+XVgVunf
dgD/Y+r2pFSjGfs7+yBeBGrLkcKWb3y02MHUqer5WhuXey1gCQsgYSSF1EabIpJ6
7RqbepJOk1Bq3BtYV8Zd/pFS9tuDB2gJfmsONsm+JLzZzesRaHm48r1nYiRZvqig
ssxiE1adDZ0klCNzuloJ5NmkHQ5TDe/Cd7bNRwiNXu99cy792N/7eCeoroM/+0lm
7fixfrIG
=xti6
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
