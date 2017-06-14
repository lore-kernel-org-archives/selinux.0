Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5EHvDso007904
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 13:57:13 -0400
Received: by mail-lf0-f67.google.com with SMTP id u62so1010530lfg.0
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 10:56:50 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id f48sm407095eda.42.2017.06.14.10.56.45
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 14 Jun 2017 10:56:45 -0700 (PDT)
Date: Wed, 14 Jun 2017 19:56:43 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libsepol/cil: Fix bugs when writing policy.conf rules
Message-ID: <20170614175643.GD5298@julius.enp8s0.d30>
References: <20170614173907.20493-1-jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
In-Reply-To: <20170614173907.20493-1-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 01:39:07PM -0400, James Carter wrote:
> The typebounds rules should end with a ";".
>=20
> The netifcon and nodecon rules should not end with a ";".
>=20
> The default rules are missing a "_". They should be "default_usr",
> "default_role" and "default_type".

I might be misunderstanding but according to https://selinuxproject.org/pag=
e/DefaultRules#default_user it should be "default_user"

>=20
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  libsepol/cil/src/cil_policy.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
> index 2196ae8..f7fe24e 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -1069,7 +1069,7 @@ static void cil_typebounds_to_policy(FILE *out, str=
uct cil_list *types)
>  		child =3D i1->data;
>  		if (child->bounds !=3D NULL) {
>  			parent =3D child->bounds;
> -			fprintf(out, "typebounds %s %s\n", parent->datum.fqn, child->datum.fq=
n);
> +			fprintf(out, "typebounds %s %s;\n", parent->datum.fqn, child->datum.f=
qn);
>  		}
>  	}
>  }
> @@ -1779,7 +1779,7 @@ static void cil_netifcons_to_policy(FILE *out, stru=
ct cil_sort *netifcons, int m
>  		cil_context_to_policy(out, netifcon->if_context, mls);
>  		fprintf(out, " ");
>  		cil_context_to_policy(out, netifcon->packet_context, mls);
> -		fprintf(out, ";\n");
> +		fprintf(out, "\n");
>  	}
>  }
> =20
> @@ -1836,7 +1836,7 @@ static void cil_nodecons_to_policy(FILE *out, struc=
t cil_sort *nodecons, int mls
>  		}
> =20
>  		cil_context_to_policy(out, nodecon->context, mls);
> -		fprintf(out, ";\n");
> +		fprintf(out, "\n");
>  	}
>  }
> =20
> @@ -1928,9 +1928,9 @@ void cil_gen_policy(FILE *out, struct cil_db *db)
>  	cil_commons_to_policy(out, lists[CIL_LIST_COMMON]);
>  	cil_classes_to_policy(out, db->classorder);
> =20
> -	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_USER], CIL_KEY_DEFAU=
LTUSER);
> -	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_ROLE], CIL_KEY_DEFAU=
LTROLE);
> -	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_TYPE], CIL_KEY_DEFAU=
LTTYPE);
> +	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_USER], "default_usr"=
);
> +	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_ROLE], "default_role=
");
> +	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_TYPE], "default_type=
");
> =20
>  	if (db->mls =3D=3D CIL_TRUE) {
>  		cil_default_ranges_to_policy(out, lists[CIL_LIST_DEFAULT_RANGE]);
> --=20
> 2.9.4
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAllBeNcACgkQJXSOVTf5
R2nlHAwAmk4X5nDmhN+XrJWy5HvkXg1IMO6lgb263qEfVqpM72WyzYRllhFVSNSx
6ZUtzRMDZr1OAdFCryw2i23MwuYEVxn8AACWHEAXpoW09OXVLXkATN50Khv+FCpR
vK3R064E0Smi/BP7zeCYKdPVz+Djbdl0TspFIy6dkFWgjgU4kIIArOUBchyrHWTt
UfuzlS/HqJVsVt3R1ASFOwq838H8N3NiKPa10QHQZKUdsGMdHzz2vRwK8wU7hIAW
niVa2h/IXjb3JWF9JAkdJjcYwoa1AtHBzaA/VBdHiZ2C02GcBYafBTl1t1MbNqBJ
AXLQqZJ7EzyxemzcyUr8r2uJKBULVmKrjrP4INgEFk3uqpTGYmSMd+UBCK59UDyz
tqDDov45UkykvMmheG/w+jKi5MPBh/+WkGKiVUQjW1fUgI1J5L1riEHLGENXQcA5
hiPGOZbDb2yaS52duckXD8eQ9qi3J6bKc8gWrGec72Lq/2EI8vKgyIIVuwkqCu7x
M0OdkA0n
=aJMC
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
