Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w39C7U6K018270
 for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2018 08:07:30 -0400
Received: by mail-wm0-f50.google.com with SMTP id b127so18700061wmf.5
 for <selinux@tycho.nsa.gov>; Mon, 09 Apr 2018 05:07:17 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id p5sm288688edh.7.2018.04.09.05.07.14
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 09 Apr 2018 05:07:14 -0700 (PDT)
Date: Mon, 9 Apr 2018 14:07:12 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180409120712.GC2087@julius.enp8s0.d30>
References: <6a2368f9-5979-737f-ca56-2e8b85e90e93@redhat.com>
 <20180409075523.GA2087@julius.enp8s0.d30>
 <20180409084124.GB2087@julius.enp8s0.d30>
 <d72be794-a882-a7ff-381b-fd1ffb78d0c8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
In-Reply-To: <d72be794-a882-a7ff-381b-fd1ffb78d0c8@redhat.com>
Subject: Re: CIL namespaces and blockinheritfilter keyword.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 01:41:12PM +0200, Lukas Vrabec wrote:
> On 04/09/2018 10:41 AM, Dominick Grift wrote:
> > On Mon, Apr 09, 2018 at 09:55:23AM +0200, Dominick Grift wrote:
> >> On Sun, Apr 08, 2018 at 11:00:53PM +0200, Lukas Vrabec wrote:
> >>> Hi All,
> >>>
> >>> I'm reading "SELINUX COMMON INTERMEDIATE LANGUAGE MOTIVATION AND DESI=
GN"
> >>> wiki page [1] and I'm interested in CIL namespaces. I tried several
> >>> examples related to blockinheritence and all works just great!
> >>>
> >>> However, in following example I see keyword "blockinheritfilter":
> >>>
> >>> (block logger
> >>> 	(blockabstract logger)
> >>> 	(type process)
> >>> 	(type log)
> >>> 	(allow process log (file (getattr append write))))
> >>>
> >>> (block myapp
> >>> 	(blockinherit logger)
> >>> 	(blockinheritfilter myapp logger
> >>> 		(allow process log (file (write)))))
> >>>
> >>
> >> The example above actually demonstrates that you do not need blockinhe=
ritfilter (and should not use it for this example), instead you can just ap=
pend rules to blocks.
> >>
> >> loggers should not open the log file for write and so the main templat=
e should not include that permission in the first place:
> >>
> >> (block logger                                                      =20
> >>        (blockabstract logger)                                       =
=20
> >>        (type process)                                               =
=20
> >>        (type log)                                                   =
=20
> >>        (allow process log (file (getattr append))))
> >>
> >> Then if you have a misbehaving logger you can just append the bad rule=
 to that block:
> >>
> >> (block badlogger
> >>        (blockinherit logger)
> >>        (allow process log (file (write)))))
> >=20
> > Or even:
> >=20
> > (block logger                                                      =20
> >        (blockabstract logger)
> >        (type process)
> >        (type log)
> >        (allow process log (file (getattr append))))=20
> >=20
> > (block badlogger                                                     =
=20
> >        (blockabstract badlogger)
> >        (blockinherit logger)
> >        (allow process log (file (write))))=20
> >=20
> > (block yourlogger
> >        (blockinherit badlogger))
> >=20
>=20
> Hi Dominick,
>=20
> Yes, This is one of the options to create hierarchy when the block on
> top will have just minimum rules and every child block will append new
> rules.
>=20
> Unfortunately, this probably won't work in real world. Let's say that I
> have this hierarchy and badlogger block contains several allow rules and
> I want to inherit all of them except one, *BUT* I'm not SELinux policy
> expert and don't know how hierarchy looks like. That's the reason why
> I'm looking for blockinheritfilter.

I forgot the reason for dropping this functionality (I do recall me asking =
about this as well in the past but it seems that Google has no record of th=
at) and so I will leave it to others to respond to this part of the questio=
n.

>=20
> However, we should go via creating block namespaces hierarchy as you
> described if there are no plans to implement this feature.
>=20
> Thanks,
> Lukas.
>=20
> >>
> >> Appending instead of filtering probably just the better approach also =
if you consider that blocks might have macros or nested blocks
> >> You probably would not be able to filter any of those.
> >>
> >>
> >>>
> >>> If I understand it correctly, it should "remove" rule:
> >>> allow myapp.process log:file write;
> >>>
> >>> So process type in myapp should have allowed:
> >>> allow myapp.process log:file {getattr append};
> >>>
> >>> And process type in logger should have allowed:
> >>> allow logger.process log:file {getattr append write};
> >>>
> >>> Which could be very cool feature, but I don't see any code in secilc
> >>> related to "blockinheritfilter". Are there any plans to implement also
> >>> this in CIL namespaces or is there any other way how to handle this
> >>> (DELETE statement is also not implemented) ?
> >>>
> >>> Thanks for any help.
> >>> Lukas.
> >>>
> >>>
> >>> [1] https://github.com/SELinuxProject/cil/wiki
> >>>
> >>> --=20
> >>> Lukas Vrabec
> >>> Software Engineer, Security Technologies
> >>> Red Hat, Inc.
> >>>
> >>
> >>
> >>
> >>
> >> --=20
> >> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> >> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B=
6B02
> >> Dominick Grift
> >=20
> >=20
> >=20
>=20
>=20
> --=20
> Lukas Vrabec
> Software Engineer, Security Technologies
> Red Hat, Inc.
>=20




--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlrLV20ACgkQJXSOVTf5
R2lbqgv9H3MW6tHqL4KaRm+s8Q5fGnhgek0jK/ctoLdewesq0LYjn6SCgdV/rkll
a1PxkgYB63HK0g0X4cfIfeGy89YHHKmpRrB0SWIUijajK6RhMDACCAhNwGuj2kwU
7/sLNZEVTrYpWhfwy4R/WCKygNbiP/NGvSBZeDV49ocJOyclVzLCt3UJ8PuQEeV7
n2NE0Rj0hDZjmDCeLIlcDZkUTXolkXrK5AF7pGKddr59i5xIba96/HeaLH6+0oT3
s6yRz/IkTKYzgjJUAuao4pEruHBwHXFwIuPDn612jUVz3MCfHOI3K6E8Hi3HLXNG
WLxbpBWRbpVs+cKJSH4VjML6k1Qgv2wI2Dx3CftwOZtYk2Lx/tbxXZvg5a7LdcL2
sdQUGRoIEt45IL945ZPT1wAl7GvJkCzLS9XvXo9YClGlUZovG2T1p7OlJXdMHSMN
c8QZrYxiVUdqy1YdWvGDzrq7aR8LFjS3V58v/Hcp4+NZyKk/HXatUbyIPq3wjPiA
qh4oTgut
=gKv0
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
