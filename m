Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NEmqQA030035
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 10:48:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id w84so3189944wmg.0
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 07:48:46 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id bl3sm7562663wjc.26.2016.09.23.07.48.44
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Sep 2016 07:48:44 -0700 (PDT)
Subject: Re: [PATCH 0/1] supporting RBACSEP in genhomedircon
To: selinux@tycho.nsa.gov
References: <cover.1474639773.git.gary.tierney@gmx.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <912d73d6-ca69-f763-996e-d862fbcd1284@gmail.com>
Date: Fri, 23 Sep 2016 16:48:35 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1474639773.git.gary.tierney@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0UQi5v88bAlDpxHxWGH29X0g5d2qd0PRX"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0UQi5v88bAlDpxHxWGH29X0g5d2qd0PRX
Content-Type: multipart/mixed; boundary="gLM485bqCJ8OBDaEip2bj3dIiNPgwxk1r";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <912d73d6-ca69-f763-996e-d862fbcd1284@gmail.com>
Subject: Re: [PATCH 0/1] supporting RBACSEP in genhomedircon
References: <cover.1474639773.git.gary.tierney@gmx.com>
In-Reply-To: <cover.1474639773.git.gary.tierney@gmx.com>

--gLM485bqCJ8OBDaEip2bj3dIiNPgwxk1r
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/23/2016 04:28 PM, Gary Tierney wrote:
> This patch implements support for policies using RBACSEP in genhomedirc=
on.  It
> works by using an SELinux users "prefix" as the role in their homedir c=
ontexts.
> It seems that genhomedircon has previously supported something similar,=
 as it'll

You are referring to the old "privsep" model. This is indeed no longer
used AFAIK.

> currently replace the string "ROLE" with whatever a users prefix is.  H=
owever,
> if using CIL we can't leverage this, since secilc will complain about t=
he
> semantics of an invalid role named "ROLE" in a filecon statement.
>=20
> Since there's no way for a CIL policy to tell genhomedircon whether a r=
ole should
> be replaced or not, a new "genhomedircon-rbacsep" option was added to
> /etc/selinux/semanage.conf.
>=20
> I'm not convinced that this is the best way to go about this.  Maybe an=
 initial
> role can be implicitly figured out using libsepol's API? Anyway, I've s=
ubmitted
> this to see if there's any better options for supporting RBACSEP in hom=
e dir
> context generation.
>=20
> There was some previous discussion about this here for reference:
> http://oss.tresys.com/pipermail/refpolicy/2011-August/004417.html
>=20
> Gary Tierney (1):
>   genhomedircon: support policies using RBACSEP
>=20
>  libsemanage/src/conf-parse.y    | 14 +++++++++++++-
>  libsemanage/src/conf-scan.l     |  1 +
>  libsemanage/src/genhomedircon.c | 30 +++++++++++++++++++++++++++++-
>  libsemanage/src/semanage_conf.h |  1 +
>  4 files changed, 44 insertions(+), 2 deletions(-)
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--gLM485bqCJ8OBDaEip2bj3dIiNPgwxk1r--

--0UQi5v88bAlDpxHxWGH29X0g5d2qd0PRX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGbBAEBCAAGBQJX5UDHAAoJECV0jlU3+UdpaIIL92DsbGvLvewRGb2jLnfVSD+y
YnDNnyCl23maaziqeLUNZo3yBjvIdDgHerkEEaOft9NSGc7FFEDtwKHRoNnHMzeE
Wb9Sy8WJUW7mUqGOXCbwWnlM0Oi2YOWnqZPWbf78LLZ7uHUPMhpcchtU5cstSCma
2KIdx2d5yCJ95H/bU6jG69sYNwUn8SlN+T6/WLvWRVOK0SLv8dD/yB27VdFGliYi
gh2U+SYQ+2NYcA1/vB+r+m+wiHmj+u0XaKOy112MC/L4uLN6nRslzZwH/Bi1bOcK
vbsADFPEqtFkuQayhXPh1DaGZTWnCiuXQBXwGr99k7h5uJ5h1/WOt7iLOUOldyRm
v5FkwiMuJDYbaK4ot2seZUjNjW5UZiShtkBOHTYbaf1qhJm14lnwzbrGRZsN3yBq
6YOu5iOsepeZgu0MxMfJrhzPBGgp65qIeObYP0jSIDF2q4IAQG7tB5WVEmrhcYyw
9194QIAvJ1L9ss7PqaRJwX+CJd/65EUnuNYjUXrI
=IBgN
-----END PGP SIGNATURE-----

--0UQi5v88bAlDpxHxWGH29X0g5d2qd0PRX--
