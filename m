Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w398fZ4V001234
 for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2018 04:41:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 40KP0n0v3hz2KQDV
 for <selinux@tycho.nsa.gov>; Mon,  9 Apr 2018 08:41:29 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 40KP0m3p29z2FxrM
 for <selinux@tycho.nsa.gov>; Mon,  9 Apr 2018 08:41:28 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id o23so16607457wmf.0
 for <selinux@tycho.nsa.gov>; Mon, 09 Apr 2018 01:41:27 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id v28sm70988edd.61.2018.04.09.01.41.26
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 09 Apr 2018 01:41:26 -0700 (PDT)
Date: Mon, 9 Apr 2018 10:41:24 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180409084124.GB2087@julius.enp8s0.d30>
References: <6a2368f9-5979-737f-ca56-2e8b85e90e93@redhat.com>
 <20180409075523.GA2087@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
In-Reply-To: <20180409075523.GA2087@julius.enp8s0.d30>
Subject: Re: CIL namespaces and blockinheritfilter keyword.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 09:55:23AM +0200, Dominick Grift wrote:
> On Sun, Apr 08, 2018 at 11:00:53PM +0200, Lukas Vrabec wrote:
> > Hi All,
> >=20
> > I'm reading "SELINUX COMMON INTERMEDIATE LANGUAGE MOTIVATION AND DESIGN"
> > wiki page [1] and I'm interested in CIL namespaces. I tried several
> > examples related to blockinheritence and all works just great!
> >=20
> > However, in following example I see keyword "blockinheritfilter":
> >=20
> > (block logger
> > 	(blockabstract logger)
> > 	(type process)
> > 	(type log)
> > 	(allow process log (file (getattr append write))))
> >=20
> > (block myapp
> > 	(blockinherit logger)
> > 	(blockinheritfilter myapp logger
> > 		(allow process log (file (write)))))
> >=20
>=20
> The example above actually demonstrates that you do not need blockinherit=
filter (and should not use it for this example), instead you can just appen=
d rules to blocks.
>=20
> loggers should not open the log file for write and so the main template s=
hould not include that permission in the first place:
>=20
> (block logger                                                      =20
>        (blockabstract logger)                                       =20
>        (type process)                                               =20
>        (type log)                                                   =20
>        (allow process log (file (getattr append))))
>=20
> Then if you have a misbehaving logger you can just append the bad rule to=
 that block:
>=20
> (block badlogger
>        (blockinherit logger)
>        (allow process log (file (write)))))

Or even:

(block logger                                                      =20
       (blockabstract logger)
       (type process)
       (type log)
       (allow process log (file (getattr append))))=20

(block badlogger                                                     =20
       (blockabstract badlogger)
       (blockinherit logger)
       (allow process log (file (write))))=20

(block yourlogger
       (blockinherit badlogger))

>=20
> Appending instead of filtering probably just the better approach also if =
you consider that blocks might have macros or nested blocks
> You probably would not be able to filter any of those.
>=20
>=20
> >=20
> > If I understand it correctly, it should "remove" rule:
> > allow myapp.process log:file write;
> >=20
> > So process type in myapp should have allowed:
> > allow myapp.process log:file {getattr append};
> >=20
> > And process type in logger should have allowed:
> > allow logger.process log:file {getattr append write};
> >=20
> > Which could be very cool feature, but I don't see any code in secilc
> > related to "blockinheritfilter". Are there any plans to implement also
> > this in CIL namespaces or is there any other way how to handle this
> > (DELETE statement is also not implemented) ?
> >=20
> > Thanks for any help.
> > Lukas.
> >=20
> >=20
> > [1] https://github.com/SELinuxProject/cil/wiki
> >=20
> > --=20
> > Lukas Vrabec
> > Software Engineer, Security Technologies
> > Red Hat, Inc.
> >=20
>=20
>=20
>=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlrLJzAACgkQJXSOVTf5
R2nSfwwAvWwRpeuDZ/Z6r0p9bfPFxxR/Ydpv1FRwKV9PstA+ss6m99g4F2iyGO5b
uSghPH0l3BQUD22U7ukAFYqfAamfIhe+nqaoSFm6iy0qqcMoD+hUdYGS52+PlfPK
3igwtNdt606Bozr1t+qw64e8uY5hDrQrqw+is+T/PpGm58oQJDFy9MZ9PiRpwgv9
bAzt1QWTUKza+uehUAxHjzZF0Qu0uuMfoEk8uJlDLo8t4mWOKP8GMihSPe1xXZyZ
1oJZfucBBTgqEUMhBBy8wYK2rkDGBjx3DiO9PD/XdyE1PSOEIWiMWJn5cEGj2LLA
o7isOF1zY20+mmPQEO5c33UDrvIC7ztjVLunzh3oPH5ySUC9iNrWTLQtLmikbg/T
0zrCrwvqbIyC7SionMmUhd45hjuMetgJ/g8TnyyHuV77eQLcaMDHTNLSwbXG0KZA
Bd1t/c71xcg/ctUnbqGY2RfUC8v4HqkuzzX6VaLxCVKDzn2VlpGHkkR5Lz0f3rXL
nUY6Ukt+
=ehVB
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
