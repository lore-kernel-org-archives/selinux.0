Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w397tX0n030935
 for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2018 03:55:33 -0400
Received: by mail-wm0-f53.google.com with SMTP id b127so16842933wmf.5
 for <selinux@tycho.nsa.gov>; Mon, 09 Apr 2018 00:55:27 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id k7sm27960edb.51.2018.04.09.00.55.25
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 09 Apr 2018 00:55:25 -0700 (PDT)
Date: Mon, 9 Apr 2018 09:55:23 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180409075523.GA2087@julius.enp8s0.d30>
References: <6a2368f9-5979-737f-ca56-2e8b85e90e93@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
In-Reply-To: <6a2368f9-5979-737f-ca56-2e8b85e90e93@redhat.com>
Subject: Re: CIL namespaces and blockinheritfilter keyword.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2018 at 11:00:53PM +0200, Lukas Vrabec wrote:
> Hi All,
>=20
> I'm reading "SELINUX COMMON INTERMEDIATE LANGUAGE MOTIVATION AND DESIGN"
> wiki page [1] and I'm interested in CIL namespaces. I tried several
> examples related to blockinheritence and all works just great!
>=20
> However, in following example I see keyword "blockinheritfilter":
>=20
> (block logger
> 	(blockabstract logger)
> 	(type process)
> 	(type log)
> 	(allow process log (file (getattr append write))))
>=20
> (block myapp
> 	(blockinherit logger)
> 	(blockinheritfilter myapp logger
> 		(allow process log (file (write)))))
>=20

The example above actually demonstrates that you do not need blockinheritfi=
lter (and should not use it for this example), instead you can just append =
rules to blocks.

loggers should not open the log file for write and so the main template sho=
uld not include that permission in the first place:

(block logger                                                      =20
       (blockabstract logger)                                       =20
       (type process)                                               =20
       (type log)                                                   =20
       (allow process log (file (getattr append))))

Then if you have a misbehaving logger you can just append the bad rule to t=
hat block:

(block badlogger
       (blockinherit logger)
       (allow process log (file (write)))))

Appending instead of filtering probably just the better approach also if yo=
u consider that blocks might have macros or nested blocks
You probably would not be able to filter any of those.


>=20
> If I understand it correctly, it should "remove" rule:
> allow myapp.process log:file write;
>=20
> So process type in myapp should have allowed:
> allow myapp.process log:file {getattr append};
>=20
> And process type in logger should have allowed:
> allow logger.process log:file {getattr append write};
>=20
> Which could be very cool feature, but I don't see any code in secilc
> related to "blockinheritfilter". Are there any plans to implement also
> this in CIL namespaces or is there any other way how to handle this
> (DELETE statement is also not implemented) ?
>=20
> Thanks for any help.
> Lukas.
>=20
>=20
> [1] https://github.com/SELinuxProject/cil/wiki
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

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlrLHGgACgkQJXSOVTf5
R2nipAv/R1Ih3q7JJn2arOijfH4MzeYsr0rj4fH+oI0yuDUkaAtqFRZECJkEtW3S
Lnf5IWPqU7tYrW/8jkEdHm1HX/mrSUMeD7v+53PYpgtSA2gdpeQl0rfRZinp6/2s
pp7WrARlH9m6VEzRA82C5Zr3muAli67Qw67lJn6U96cgkYhGGiYtSdSDbw5JAKBf
QTROkhmDIVyONY0PqwwVyO1J29Ux+GcpxyiloZB43VJKQIzIcY3Ktep2BO5TdCfq
PaLdYnfHGlQOTX8ctX93YnVVNxJuz6yiEjo0HuSHKlogxviY2XUJbvKRIxGo2Lt+
j4rPoGuM4ycuD9/qC8X8FqHMJxxL48YRu7xKBCd87jLe+65jaJ4RwADHf36Qcm5+
lS/ehN7gpZ5yUoqWISMzzeoMcmrbrGAcN44UrAFcvlAq9jRE+TGg/u6mvjsVeJnD
vFQnGB0giC88eaZGNph9gFpPgpxImxeHhkxpIUW9siNFSrLvFEyFjFNa2cSUELUR
0ng4Vqcc
=EEgt
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
