Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47Fm8bC016269
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 11:48:08 -0400
Received: by mail-wm0-f50.google.com with SMTP id b84so30410219wmh.0
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 08:48:03 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id t57sm5125453edb.28.2017.05.07.08.48.01
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 07 May 2017 08:48:01 -0700 (PDT)
Date: Sun, 7 May 2017 17:47:59 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170507154759.GA31890@julius>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
In-Reply-To: <590F3B98.406@quarksecurity.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 07, 2017 at 11:22:00AM -0400, Joshua Brindle wrote:
> Dominick Grift wrote:
> <snip>
>=20
> > The idea is nice, unfortunately its inflexible and it has hard-referenc=
es to reference policy all-over. It has potential but it is still rough.
> >=20
>=20
> Of course, it is an analysis of a refpolicy-based policy. If you want to
> analyze a different policy (e.g., Android or home-rolled) you will have to
> change out all of the type sets, etc.
>=20
> You can't make a magic generic analysis script without knowing how key pa=
rts
> of the system work and what types are associated with those components.

What do you mean? that for example that hard-coded array of "trusted" types=
=2E Is that not just redundant.

Can't i just create that array myself and use it to exlude rules with types=
 in that array? That was one does not have to hard-code it.

Also with regard to hardcoding the refpolicy file system (ps.load_policy_so=
urce). I mean if youre just going to `grep -r` then why do we have to assum=
e anything there and hard code file suffixed, directory structures etc etc?

>=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkPQasACgkQJXSOVTf5
R2nusAv+K3t47oPhMo1zBJAi3pFv0U0F38GgJPcPu2eOa0vMBFfj+ZMXpa32SEbW
f7+UJJ9B/Eg7umLK3kFs9XFzOmUKCIhJatSN9ZuZFdEFmGwvVshTyc1nRLLB2tI2
ixFS5VnDmIdHF4h+bhYKCAEp8cj1L/M6rK5qhlvdk1V+9xztY53WhgheHoBI03Sm
wfAmC68+j4i5/xhju9KqNat5nyXXztYf0uiVpkq2F2B/nVp34mIKeN4IfZ6I5Jw2
4KXvtsOiQXb9r+JQDDTXVKQz/T5O0OwaN/nvZmkikrcMHKf09M521f2KmJ/NLTiM
u7vW0mJcD+nuZpR6jPqwiPIhYOvbUyGC9mTI4TFH5UFHN939K5qsfKufRcSLubOh
dum7C8RzoXexhwi+suddT3OaUXDRRygngy1n3vN6zT6dHewDgZ9QNpFLhbj/dFq8
9C0h9RQutYgF65wJYJbSYuXZIz1L9JrOPGQq9c5xeWZd7Mdqj2qXn40ERCj0sju6
9tOPa0Rf
=x13u
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
