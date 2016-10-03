Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93B862U007260
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 07:08:07 -0400
Received: from workstation.home ([86.151.246.244]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LbxQO-1bAE5V3A6W-00jG2f for
 <selinux@tycho.nsa.gov>; Mon, 03 Oct 2016 13:06:50 +0200
Date: Mon, 3 Oct 2016 12:06:45 +0100
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] libsepol/cil: create user and role caches when
 building binary policy
Message-ID: <20161003110645.GA4599@workstation.home>
References: <cover.1475491349.git.gary.tierney@gmx.com>
 <ee13bc88daffcc4d136ed0d41ca8348ca3c16e36.1475491349.git.gary.tierney@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
In-Reply-To: <ee13bc88daffcc4d136ed0d41ca8348ca3c16e36.1475491349.git.gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 03, 2016 at 11:46:19AM +0100, Gary Tierney wrote:
> Pre-expands the role and user caches used in context validation when
> conerting a cildb to a binary policydb.  This is currently only done
> when loading a binary policy and prevents context validation from
> working correctly with a newly built policy (i.e., when semanage builds
> a new policy and then runs genhomedircon).
>=20
> Also adds declarations for the hashtable mapping functions used:
> policydb_role_cache and policydb_user_cache().
>=20
> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
> ---
>  libsepol/cil/src/cil_binary.c              | 7 +++++++
>  libsepol/include/sepol/policydb/policydb.h | 8 ++++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index cc73648..200101e 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -4794,6 +4794,13 @@ int cil_binary_create_allocated_pdb(const struct c=
il_db *db, sepol_policydb_t *p
> =20
>  	}
> =20
> +	/* This pre-expands the roles and users for context validity checking */
> +	if (hashtab_map(pdb->p_roles.table, policydb_role_cache, pdb))
> +		return -1;
> +
> +	if (hashtab_map(pdb->p_users.table, policydb_user_cache, pdb))
> +		return -1;
> +
>  	rc =3D SEPOL_OK;
> =20
>  exit:
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index 26cec13..d99fcf4 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -608,6 +608,14 @@ extern int policydb_index_bools(policydb_t * p);
>  extern int policydb_index_others(sepol_handle_t * handle, policydb_t * p,
>  				 unsigned int verbose);
> =20
> +extern int policydb_role_cache(hashtab_key_t key,
> +			       hashtab_datum_t datum,
> +			       void *arg);
> +
> +extern int policydb_user_cache(hashtab_key_t key,
> +			       hashtab_datum_t datum,
> +			       void *arg);
> +
>  extern int policydb_reindex_users(policydb_t * p);
> =20
>  extern void policydb_destroy(policydb_t * p);
> --=20
> 2.4.11
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

Ah, that return should be a goto.  Sending a v2.

--=20
Gary Tierney

GPG fingerprint: 412C 0EF9 C305 68E6 B660  BDAF 706E D765 85AA 79D8
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x706ED76585AA79D8

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX8ju/AAoJEHBu12WFqnnY614H/2mCmm+kH3gACvaid8WRWv50
L2uIIMISl4+8rhvxmrAJKyrAxX3BlKv5/5m7oNFCJ9ocjvRO4BBzbMjLVPJCzvlj
jZEGefa9HofO71vSawBsu7kASb7lMM6CmrMdtxVsaGkUFUn2wHG/enOgME/B+qxA
agWTl033NHsgrcw1zP0bd+LIg6/PxDad83lLsfJRlnAnEmrotMma7EDcZjdi+Sa0
QHSH7dcAtGGsXUPUvmiP38S/+hkCT1tUEtvFoIpNQC+YZ4Hb2260ez8eOWDdLZTU
4zeWilMEPiWc1ojkEnTvKEvCghptiB4V/n5d/lJA/XkQK6ULe/z6ZITIjJMNj6s=
=SFAP
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
