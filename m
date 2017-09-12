Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8CHco0V010282
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 13:38:50 -0400
Received: by mail-wm0-f42.google.com with SMTP id f199so512562wme.0
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 10:37:05 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id 26sm1169601eds.5.2017.09.12.10.37.01
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Sep 2017 10:37:01 -0700 (PDT)
Date: Tue, 12 Sep 2017 19:36:59 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170912173659.GB5111@julius.enp8s0.d30>
References: <20170912133835.GA5111@julius.enp8s0.d30>
 <CAB9W1A0yYAg3UzwPMo6RVUZEdHDNr3BhjKb=vhvJ4GcmyEA+mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
In-Reply-To: <CAB9W1A0yYAg3UzwPMo6RVUZEdHDNr3BhjKb=vhvJ4GcmyEA+mw@mail.gmail.com>
Subject: Re: with extended_socket_class should be still be seeing
 "socket"?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2017 at 12:01:35PM -0400, Stephen Smalley wrote:
> On Sep 12, 2017 7:01 AM, "Dominick Grift" <dac.override@gmail.com> wrote:
>=20
> I have extended socket class polcap enabled but i am still seeing "socket"
> class events and i was wondering whether that is to be expected?
>=20
> avc:  denied  { create } for  pid=3D10484 comm=3D"nethogs" scontext=3Dwhe=
el.id:
> sysadm.role:nethogs.subj:s0 tcontext=3Dwheel.id:sysadm.role:nethogs.subj:=
s0
> tclass=3Dsocket permissive=3D0
>=20
> This seems to be common to processes that also create (and map! [1])
> "packet_socket" sockets (tcpdump/nethogs)
>=20
> [1] avc:  denied  { map } for  pid=3D10525 comm=3D"nethogs"
> path=3D"socket:[56040]" dev=3D"sockfs" ino=3D56040
> scontext=3Dwheel.id:sysadm.role:nethogs.subj:s0
> tcontext=3Dwheel.id:sysadm.role:nethogs.subj:s0 tclass=3Dpacket_socket
> permissive=3D0
>=20
>=20
> No, that is not expected. Can you enable sys call audit and get those
> records?

type=3DPROCTITLE msg=3Daudit(09/12/2017 19:35:54.063:4458) : proctitle=3Dne=
thogs enp8s0=20
type=3DSYSCALL msg=3Daudit(09/12/2017 19:35:54.063:4458) : arch=3Dx86_64 sy=
scall=3Dsocket success=3Dyes exit=3D5 a0=3Dlocal a1=3DSOCK_RAW a2=3Dip a3=
=3D0xb4 items=3D0 ppid=3D3251 pid=3D8963 auid=3Dkcinimod uid=3Droot gid=3Dr=
oot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Dro=
ot tty=3Dpts5 ses=3D1 comm=3Dnethogs exe=3D/usr/sbin/nethogs subj=3Dwheel.i=
d:sysadm.role:nethogs.subj:s0 key=3D(null)=20
type=3DAVC msg=3Daudit(09/12/2017 19:35:54.063:4458) : avc:  denied  { crea=
te } for  pid=3D8963 comm=3Dnethogs scontext=3Dwheel.id:sysadm.role:nethogs=
=2Esubj:s0 tcontext=3Dwheel.id:sysadm.role:nethogs.subj:s0 tclass=3Dsocket =
permissive=3D1

type=3DPROCTITLE msg=3Daudit(09/12/2017 19:35:07.983:4457) : proctitle=3Dne=
thogs enp8s0=20
type=3DMMAP msg=3Daudit(09/12/2017 19:35:07.983:4457) : fd=3D5 flags=3DMAP_=
SHARED=20
type=3DSYSCALL msg=3Daudit(09/12/2017 19:35:07.983:4457) : arch=3Dx86_64 sy=
scall=3Dmmap success=3Dyes exit=3D140169557827584 a0=3D0x0 a1=3D0x200000 a2=
=3DPROT_READ|PROT_WRITE a3=3DMAP_SHARED items=3D0 ppid=3D3251 pid=3D8907 au=
id=3Dkcinimod uid=3Droot gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot eg=
id=3Droot sgid=3Droot fsgid=3Droot tty=3Dpts5 ses=3D1 comm=3Dnethogs exe=3D=
/usr/sbin/nethogs subj=3Dwheel.id:sysadm.role:nethogs.subj:s0 key=3D(null)=
=20
type=3DAVC msg=3Daudit(09/12/2017 19:35:07.983:4457) : avc:  denied  { map =
} for  pid=3D8907 comm=3Dnethogs path=3Dsocket:[103238] dev=3D"sockfs" ino=
=3D103238 scontext=3Dwheel.id:sysadm.role:nethogs.subj:s0 tcontext=3Dwheel.=
id:sysadm.role:nethogs.subj:s0 tclass=3Dpacket_socket permissive=3D1

>=20
>=20
> --
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlm4GzgACgkQJXSOVTf5
R2kiGgwAp5uVbHEmaKdxUruA8QaK6WKN+EVdWjfaX2Ek4nKhFUdSDlDAMJv20aTW
2BwEdRqkZADoWiIIIcKrrGSDW8RyXGtUFlEXb4JOaov5K0lChr6saRo6NDbLsNUx
AGRfwQDY/ZkMw/EouPwF0zYjwoW429stCxbv40LFnX7taBINfIjESlkIFiYvc+fT
aTEcun1Kw5jxBcfDYb9g2U8eVNssC1Ki5pN05fGCc/evvWMi30dINdzkP0syBNwe
0aRGKseVnveyNtHZIhWc7tXHkguwcH0UkSD3WPqkTt4/TtL65CVGWRiLxjbiO5Dl
MIoyMLAZASiAG9kGoA8BxBfVKhNxOa+tTA+uUpOu4DlQda678CA5p8wn/UKQpolP
YTya7DBdTNzFZvL+SkSEociRRzjTohGtyp/m0bG4XQqYfcs3WLINAalVpYfmhz9X
YY/NKpyaJcveLq6HF05SdwgXex/UjcSqub3yJmE7VNBMFWG6+u6JSlX5fzWW35+g
8CHggeAC
=czW3
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
