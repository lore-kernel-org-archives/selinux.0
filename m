Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u96CHiPC002022
 for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2016 08:17:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id b201so3256085wmb.1
 for <selinux@tycho.nsa.gov>; Thu, 06 Oct 2016 05:17:35 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id f142sm14782267wmf.19.2016.10.06.05.17.32
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Oct 2016 05:17:32 -0700 (PDT)
Subject: Re: [PATCH v2 0/1] supporting RBACSEP in genhomedircon
To: selinux@tycho.nsa.gov
References: <cover.1475590141.git.gary.tierney@gmx.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <e9fe21ba-ebf5-ebb2-911e-da8a02be0ca2@gmail.com>
Date: Thu, 6 Oct 2016 14:17:22 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1475590141.git.gary.tierney@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gFajSJxQjh52T8bAS0HGicC7lF8IK603i"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gFajSJxQjh52T8bAS0HGicC7lF8IK603i
Content-Type: multipart/mixed; boundary="tjo6KBXC6VgMi4nvLqkeQ1dWlEbiIacaN";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <e9fe21ba-ebf5-ebb2-911e-da8a02be0ca2@gmail.com>
Subject: Re: [PATCH v2 0/1] supporting RBACSEP in genhomedircon
References: <cover.1475590141.git.gary.tierney@gmx.com>
In-Reply-To: <cover.1475590141.git.gary.tierney@gmx.com>

--tjo6KBXC6VgMi4nvLqkeQ1dWlEbiIacaN
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/06/2016 01:09 PM, Gary Tierney wrote:
> New version of the previous genhomedircon-rbacsep patch with some chang=
es.  A
> bit of a delay as I had to get in a libsepol/cil fix which was blocking=
 this.
>=20
> 1. Remove semanage.conf option
> 2. Drop unrelated change
> 3. Adds a new homedir_role member to the genhomedircon_user struct.
> 4. Sets homedir_role if the SELinux users prefix is a valid role for th=
at user.
> 5. Replaces all roles with homedir_role in context specifications if ho=
medir_role is set.
>=20
> One issue that came up when writing these patches is that genhomedircon=

> squashes logging [1] for some reason, which can result in no warning / =
info
> messages and an empty file_contexts.homedirs file if policy has been
> incorrectly configured.  Can we get rid of this behavior or add a flag =
to
> conditionally enable logging?
>=20

If we do that then i suspect that we can also use that for the messages
where an seuser id cannot be found (e.g. that system_u, and gdm.id issue)=


> Dominick Grift helpfully created some test images that demo DSSP policy=
 working
> with both RBACSEP and non-RBACEP:
> https://tfirg.asu.su/2016/10/03/garys-patches/
>=20
> There are still some rough edges though, for example in policy you can'=
t write a
> statement like: (userprefix id role) and put it in an abstract namespac=
e,
> since it is interpreted as a literal:
>=20
> (block usersubj
>     (blockabstract usersubj)
>     (user id)
>     (role role)
>     (userrole id role)
>     (userprefix id role))
>=20
> (block wheel
>     (blockinherit usersubj))
>=20
> Which leaves us with a (userid, prefix) tuple of (wheel.id, role) [whee=
l.id
> might even just be id here, haven't checked if users are expanded or al=
so taken
> as literals].
>=20
> Though this is something I can look at later if all is well here.
>=20
> [1] https://github.com/SELinuxProject/selinux/blob/master/libsemanage/s=
rc/genhomedircon.c#L568-L572
>=20
> Gary Tierney (1):
>   genhomedircon: use userprefix as the role for homedir content
>=20
>  libsemanage/src/genhomedircon.c | 38 +++++++++++++++++++++++++++++++++=
++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--tjo6KBXC6VgMi4nvLqkeQ1dWlEbiIacaN--

--gFajSJxQjh52T8bAS0HGicC7lF8IK603i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX9kDWAAoJECV0jlU3+Udp9NcL/Rll8sYxrrse+ISFIHfG65s4
BGwVkrpFzzWCjNz9rbkZrbGFD3gV5Rdw+CZ+4+p5rvckklBcT29g4n1v9iPAWEeI
sDwhvospRpzgtbamaMBoFioodQPpNYJy95RDPRYZnuBwPu3/k7ZXyJHe8CGnILM1
xND1mwLk1icZInd6lR+HfL6tfimbNS22ECQtTHzTEU1tHF8NeginszrdWahpYoI+
CRcRuTUgnxJ+eannwaqKeaXLvlkrEAVC20ic7FhQX8OPGs897U1duQ+gJeV42N4d
gJoOlcmxNOq0GpgDk0wjWz45v4zJTzvyEx+JyLokEkHYPFEx+2TSlUeKqjKm5uSV
WSQXf2hO5sdBvzWQcP/yY899acONcgYRDTJOi6yuC2dusZ8syYB2mEWphiprkzz9
5mqeCvw2uUxogmMdgzd40DJcjaswpqRBIvlxLpjkKWUoRBnH0C3t2IzrwmC+kLKj
4zBYkjK+7VqD822lOvvkrcvL6+mxweGMtRVgdTRp3Q==
=u2E6
-----END PGP SIGNATURE-----

--gFajSJxQjh52T8bAS0HGicC7lF8IK603i--
