Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8CL4NA8019716
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 17:04:27 -0400
Received: by mail-wm0-f50.google.com with SMTP id f199so2623508wme.0
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 12:31:58 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id g45sm6495600eda.38.2017.09.12.12.31.52
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Sep 2017 12:31:53 -0700 (PDT)
Date: Tue, 12 Sep 2017 21:31:51 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170912193151.GC5111@julius.enp8s0.d30>
References: <20170912133835.GA5111@julius.enp8s0.d30>
 <CAB9W1A0yYAg3UzwPMo6RVUZEdHDNr3BhjKb=vhvJ4GcmyEA+mw@mail.gmail.com>
 <20170912173659.GB5111@julius.enp8s0.d30>
 <CAHC9VhSg02C_xd1HnRPkgGvD8WxPQWj3K5+6MpHnZvhHT0vDRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
In-Reply-To: <CAHC9VhSg02C_xd1HnRPkgGvD8WxPQWj3K5+6MpHnZvhHT0vDRA@mail.gmail.com>
Subject: Re: with extended_socket_class should be still be seeing
 "socket"?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2017 at 02:55:38PM -0400, Paul Moore wrote:
> On Tue, Sep 12, 2017 at 1:36 PM, Dominick Grift <dac.override@gmail.com> =
wrote:
> > On Tue, Sep 12, 2017 at 12:01:35PM -0400, Stephen Smalley wrote:
> >> On Sep 12, 2017 7:01 AM, "Dominick Grift" <dac.override@gmail.com> wro=
te:
> >>
> >> I have extended socket class polcap enabled but i am still seeing "soc=
ket"
> >> class events and i was wondering whether that is to be expected?
> >>
> >> avc:  denied  { create } for  pid=3D10484 comm=3D"nethogs" scontext=3D=
wheel.id:
> >> sysadm.role:nethogs.subj:s0 tcontext=3Dwheel.id:sysadm.role:nethogs.su=
bj:s0
> >> tclass=3Dsocket permissive=3D0
> >>
> >> This seems to be common to processes that also create (and map! [1])
> >> "packet_socket" sockets (tcpdump/nethogs)
> >>
> >> [1] avc:  denied  { map } for  pid=3D10525 comm=3D"nethogs"
> >> path=3D"socket:[56040]" dev=3D"sockfs" ino=3D56040
> >> scontext=3Dwheel.id:sysadm.role:nethogs.subj:s0
> >> tcontext=3Dwheel.id:sysadm.role:nethogs.subj:s0 tclass=3Dpacket_socket
> >> permissive=3D0
> >>
> >>
> >> No, that is not expected. Can you enable sys call audit and get those
> >> records?
> >
> > type=3DPROCTITLE msg=3Daudit(09/12/2017 19:35:54.063:4458) : proctitle=
=3Dnethogs enp8s0
> > type=3DSYSCALL msg=3Daudit(09/12/2017 19:35:54.063:4458) : arch=3Dx86_6=
4 syscall=3Dsocket success=3Dyes exit=3D5 a0=3Dlocal a1=3DSOCK_RAW a2=3Dip =
a3=3D0xb4 items=3D0 ppid=3D3251 pid=3D8963 auid=3Dkcinimod uid=3Droot gid=
=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=
=3Droot tty=3Dpts5 ses=3D1 comm=3Dnethogs exe=3D/usr/sbin/nethogs subj=3Dwh=
eel.id:sysadm.role:nethogs.subj:s0 key=3D(null)
> > type=3DAVC msg=3Daudit(09/12/2017 19:35:54.063:4458) : avc:  denied  { =
create } for  pid=3D8963 comm=3Dnethogs scontext=3Dwheel.id:sysadm.role:net=
hogs.subj:s0 tcontext=3Dwheel.id:sysadm.role:nethogs.subj:s0 tclass=3Dsocke=
t permissive=3D1
>=20
> Ah ha, AF_UNIX/SOCK_RAW, that's the problem.  Luis Ressel fixed this
> (see the commit below) and it should make it up to Linus during the
> current merge window (eventually, maybe, hopefully).
>=20
> If you run Fedora Rawhide, you can try one of recent kernel builds in
> the COPR repo below, it should have the fix.
>=20
> *  https://copr.fedorainfracloud.org/coprs/pcmoore/kernel-secnext

Thanks i will probably try this out in a virtual machine tomorrow (kind of =
relieved now with a "stable" 4.13 on my bare bones after quite a turbulent =
4.12 and 4.13)

>=20
>   commit 2a764b529ae57bed61da2c90ff132b9fec97f80b
>   Author: Luis Ressel <aranea@aixah.de>
>   Date:   Tue Jul 25 15:13:41 2017 -0400
>=20
>    selinux: Assign proper class to PF_UNIX/SOCK_RAW sockets
>=20
>    For PF_UNIX, SOCK_RAW is synonymous with SOCK_DGRAM (cf.
>    net/unix/af_unix.c). This is a tad obscure, but libpcap uses it.
>=20
>    Signed-off-by: Luis Ressel <aranea@aixah.de>
>    Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>    Signed-off-by: Paul Moore <paul@paul-moore.com>
>=20
> --=20
> paul moore
> www.paul-moore.com
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlm4NiMACgkQJXSOVTf5
R2nlkAv/bMV68aAToN5jbgFuMx7Dg2E7/NFWDAuCvIrjwOFOk5bb8O4h3ps/55Ql
Ugq2mpVoq4T1UcY/ygQ/gKaZfI8RtZicb4HvAiWVDgY79k5YKu0mPvU/Y+Y9QNzK
E4w0hVD0Nmd8eFmkYlZj5NZk5ljPgSaFBWo0WAlwPpgkGXrniVPOQwUxi6wAZjoo
vSNEJtNtTiEV3lj5wmKlVOFTvbZ78JqX35gf41bYQltn4JgTiY4EpfEDcH6gYWjJ
xpnh6i5U4q9+8KPHmmUTk0y8SMuFEb5U/stnPZNO32tJKUMUi58BeQEvceQXquea
NdrbjLJEcvDQuVxfsCBsKcHJKrfbb8L2ickbTivX3ZJPoGiTV7DEc0ftZISKOwpM
LsZMnIyZB434rpbx626IGpww/ovAFDL3dAFdDIE7JHki9j6cCWHay9W6sNADoEUi
MMJ9vsbL201z8GofoUJpKDGugLiYVedIx/e5b6RNGWaWpCFXD19wOs/rr6KXGS1P
hCab/9A6
=QMTv
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
