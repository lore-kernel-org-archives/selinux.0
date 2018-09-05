Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w85K9hD5026316
 for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2018 16:09:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so7110097eds.1
 for <selinux@tycho.nsa.gov>; Wed, 05 Sep 2018 13:09:19 -0700 (PDT)
Received: from julius.enp8s0.d30 (84-245-31-98.dsl.cambrium.nl. [84.245.31.98])
 by smtp.gmail.com with ESMTPSA id x22-v6sm1535038edb.8.2018.09.05.13.09.13
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Sep 2018 13:09:13 -0700 (PDT)
Date: Wed, 5 Sep 2018 22:09:12 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180905200912.GA29122@julius.enp8s0.d30>
References: <CAJfZ7=niujB=XSC5D=y3fPrcL7rBBuLCsN_G=sy0N0bfDRYNJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
In-Reply-To: <CAJfZ7=niujB=XSC5D=y3fPrcL7rBBuLCsN_G=sy0N0bfDRYNJQ@mail.gmail.com>
Subject: Re: "semanage user" and -s option
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2018 at 09:36:35PM +0200, Nicolas Iooss wrote:
> Hello,
>=20
> While reviewing the last patch sent by Vit Mojzis, I stumbled upon
> something that does not feel right in "semanage user". Both "semanage
> user --help" and "man 8 semanage-user" state:
>=20
> usage: semanage user [-h] [-n] [-N] [-S STORE] [ --add ( -L LEVEL -R
> ROLES -r RANGE -s SEUSER selinux_name) | ...
>=20
> I am wondering what are the meaning of "-s SEUSER" and "selinux_name"
> there. If I try to use "-s" option, semanage complains:
>=20
> semanage: error: unrecognized arguments: -s

If i recall correctly think "-s selinux_name" is right. You cannot add a se=
user withuser giving it a name.

>=20
> Therefore it seems that the usage would rather be "... --add ( -L
> LEVEL -R ROLES -r RANGE SEUSER)". Looking at the code, it seems that
> parser_add_seuser() is not used in setupUserParser() [1], and
> everything works fine when using "semanage user" without -s option. Am
> I missing something obvious, or should I write a patch which fixes the
> documentation?
>=20
> Cheers,
> Nicolas
>=20
> [1] https://github.com/SELinuxProject/selinux/blob/libsemanage-2.8/python=
/semanage/semanage#L403
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAluQN+IACgkQJXSOVTf5
R2m/ogv+OBPGmB/A9tMPR0fZk6HN7kPh++a5kr7c/kLQIvoFpVqkpQHOkNKz8dmm
PKukwDE0Kpe9r3MLESH9IpcG7bOuJRFm1r4V4tOck3IO8jQrjmq2+0ytcRTYuyzX
CQ6WJHx5FRfYbJCnZ9e4iMwXDWanJG55uxZtzErHT4czHFFuhiLQUKNUkEw+LiOb
HWzA34yQ3cibDctcJ7Kzwul8Pvl/LnQQhYkSMFZUZ0D8U9/QWu/8mdZpRIi7Dt24
tRuT441uebnwPG22KdA7moONApWzGVRePQTKoyJv6QjSVdVuh5Nz+jAK8gzeIFbd
mR48d5/VbMbm08pNN5bWWymRYJ3mXwLmNtuVVXoOd/6OWDSBE8BdhoiI0+V4WsMt
eXrn2Emhqwy5J87KW+J9aqGpXv38vLV3PRn8oaCnTSFKDd/OP2uliDPjhQXtODEo
Su8ueIk4XPGbyQxhjki+2FA9/uscKieCSD2Ms4O7Oy0Pfn7vpRnHD0X3yO+MJKcI
Gy2/guxj
=afNP
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
