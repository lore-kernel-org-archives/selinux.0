Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2H7RiC0017402
 for <selinux@tycho.nsa.gov>; Sat, 17 Mar 2018 03:27:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7738EEB70F
 for <selinux@tycho.nsa.gov>; Sat, 17 Mar 2018 07:26:21 +0000 (UTC)
Date: Sat, 17 Mar 2018 08:26:17 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180317072616.GA4209@workstation>
References: <3927bd04-7409-1476-ddf6-200c49abfbe2@tycho.nsa.gov>
 <20180309153944.7733-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <20180309153944.7733-1-vmojzis@redhat.com>
Subject: Re: [PATCH] libsemanage: replace access() checks to make
 setuid programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 04:39:44PM +0100, Vit Mojzis wrote:
> access() uses real UID instead of effective UID which causes false
> negative checks in setuid programs.
> Replace access() calls (mostly tests for file existence) by stat().
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1186431
>=20
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libsemanage/src/direct_api.c     | 137 +++++++++++++++++++++++++--------=
------
>  libsemanage/src/semanage_store.c |  11 +++-
>  2 files changed, 98 insertions(+), 50 deletions(-)
>=20
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 92d7517d..439122df 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -140,6 +140,7 @@ int semanage_direct_is_managed(semanage_handle_t * sh)
>  int semanage_direct_connect(semanage_handle_t * sh)
>  {
>  	const char *path;
> +	struct stat sb;
> =20
>  	if (semanage_check_init(sh, sh->conf->store_root_path))
>  		goto err;
> @@ -302,10 +303,16 @@ int semanage_direct_connect(semanage_handle_t * sh)
> =20
>  	/* set the disable dontaudit value */
>  	path =3D semanage_path(SEMANAGE_ACTIVE, SEMANAGE_DISABLE_DONTAUDIT);
> -	if (access(path, F_OK) =3D=3D 0)
> +
> +	if (stat(path, &sb) =3D=3D 0)
>  		sepol_set_disable_dontaudit(sh->sepolh, 1);
> -	else
> +	else if (errno =3D=3D ENOENT) {
> +		/* The file does not exist */
>  		sepol_set_disable_dontaudit(sh->sepolh, 0);
> +	} else {
> +		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> +		goto err;
> +	}
> =20
>  	return STATUS_SUCCESS;
> =20
> @@ -1139,6 +1146,7 @@ static int semanage_compile_hll_modules(semanage_ha=
ndle_t *sh,
>  	int status =3D 0;
>  	int i;
>  	char cil_path[PATH_MAX];
> +	struct stat sb;
> =20
>  	assert(sh);
>  	assert(modinfos);
> @@ -1155,9 +1163,13 @@ static int semanage_compile_hll_modules(semanage_h=
andle_t *sh,
>  		}
> =20
>  		if (semanage_get_ignore_module_cache(sh) =3D=3D 0 &&
> -				access(cil_path, F_OK) =3D=3D 0) {
> +				(status =3D stat(cil_path, &sb)) =3D=3D 0) {
>  			continue;
>  		}
> +		if (status !=3D 0 && errno !=3D ENOENT) {
> +			ERR(sh, "Unable to access %s: %s\n", cil_path, strerror(errno));
> +			goto cleanup; //an error in the "stat" call
> +		}
> =20
>  		status =3D semanage_compile_module(sh, &modinfos[i]);
>  		if (status < 0) {
> @@ -1196,6 +1208,7 @@ static int semanage_direct_commit(semanage_handle_t=
 * sh)
>  	struct cil_db *cildb =3D NULL;
>  	semanage_module_info_t *modinfos =3D NULL;
>  	mode_t mask =3D umask(0077);
> +	struct stat sb;
> =20
>  	int do_rebuild, do_write_kernel, do_install;
>  	int fcontexts_modified, ports_modified, seusers_modified,
> @@ -1234,10 +1247,16 @@ static int semanage_direct_commit(semanage_handle=
_t * sh)
> =20
>  	/* Create or remove the disable_dontaudit flag file. */
>  	path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
> -	if (access(path, F_OK) =3D=3D 0)
> +	if (stat(path, &sb) =3D=3D 0)
>  		do_rebuild |=3D !(sepol_get_disable_dontaudit(sh->sepolh) =3D=3D 1);
> -	else
> +	else if (errno =3D=3D ENOENT) {
> +		/* The file does not exist */
>  		do_rebuild |=3D (sepol_get_disable_dontaudit(sh->sepolh) =3D=3D 1);
> +	} else {
> +		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> +		retval =3D -1;
> +		goto cleanup;
> +	}
>  	if (sepol_get_disable_dontaudit(sh->sepolh) =3D=3D 1) {
>  		FILE *touch;
>  		touch =3D fopen(path, "w");
> @@ -1259,10 +1278,17 @@ static int semanage_direct_commit(semanage_handle=
_t * sh)
> =20
>  	/* Create or remove the preserve_tunables flag file. */
>  	path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_PRESERVE_TUNABLES);
> -	if (access(path, F_OK) =3D=3D 0)
> +	if (stat(path, &sb) =3D=3D 0)
>  		do_rebuild |=3D !(sepol_get_preserve_tunables(sh->sepolh) =3D=3D 1);
> -	else
> +	else if (errno =3D=3D ENOENT) {
> +		/* The file does not exist */
>  		do_rebuild |=3D (sepol_get_preserve_tunables(sh->sepolh) =3D=3D 1);
> +	} else {
> +		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> +		retval =3D -1;
> +		goto cleanup;
> +	}
> +
>  	if (sepol_get_preserve_tunables(sh->sepolh) =3D=3D 1) {
>  		FILE *touch;
>  		touch =3D fopen(path, "w");
> @@ -1299,40 +1325,25 @@ static int semanage_direct_commit(semanage_handle=
_t * sh)
>  	 * a rebuild.
>  	 */
>  	if (!do_rebuild) {
> -		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL);
> -		if (access(path, F_OK) !=3D 0) {
> -			do_rebuild =3D 1;
> -			goto rebuild;
> -		}
> -
> -		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
> -		if (access(path, F_OK) !=3D 0) {
> -			do_rebuild =3D 1;
> -			goto rebuild;
> -		}
> -
> -		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
> -		if (access(path, F_OK) !=3D 0) {
> -			do_rebuild =3D 1;
> -			goto rebuild;
> -		}
> -
> -		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED);
> -		if (access(path, F_OK) !=3D 0) {
> -			do_rebuild =3D 1;
> -			goto rebuild;
> -		}
> -
> -		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
> -		if (access(path, F_OK) !=3D 0) {
> -			do_rebuild =3D 1;
> -			goto rebuild;
> -		}
> +		int files[] =3D {SEMANAGE_STORE_KERNEL,
> +					   SEMANAGE_STORE_FC,
> +					   SEMANAGE_STORE_SEUSERS,
> +					   SEMANAGE_LINKED,
> +					   SEMANAGE_SEUSERS_LINKED,
> +					   SEMANAGE_USERS_EXTRA_LINKED};
> +
> +		for (i =3D 0; i < (int) sizeof(files); i++) {

The size of the files needs to be divided by size of int, otherwise it caus=
es segfault:

     # semanage fcontext -m -t httpd_log_t "/var/opt/quest/vas/vasd(/
     [1]    3063 segmentation fault (core dumped)  semanage fcontext -m -t =
httpd_log_t "/var/opt/quest/vas/vasd(/.*)?"
   =20
    backtrace:
     #0  0x00007fffe7901f9b in semanage_path (store=3Dstore@entry=3DSEMANAG=
E_TMP, path_name=3D3918632424) at semanage_store.c:487
     #1  0x00007fffe78f4be1 in semanage_direct_commit (sh=3D0x55555840da00)=
 at direct_api.c:1336
     #2  0x00007fffe78f9f71 in semanage_commit (sh=3D0x55555840da00) at han=
dle.c:428


Something like this should fix it:

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

for (i =3D 0; i < ARRAY_SIZE(files); i++) {
=2E..




> +			path =3D semanage_path(SEMANAGE_TMP, files[i]);
> +			if (stat(path, &sb) !=3D 0) {
> +				if (errno !=3D ENOENT) {
> +					ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> +					retval =3D -1;
> +					goto cleanup;
> +				}
> =20
> -		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
> -		if (access(path, F_OK) !=3D 0) {
> -			do_rebuild =3D 1;
> -			goto rebuild;
> +				do_rebuild =3D 1;
> +				goto rebuild;
> +			}
>  		}
>  	}
> =20
> @@ -1465,7 +1476,7 @@ rebuild:
>  			goto cleanup;
> =20
>  		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
> -		if (access(path, F_OK) =3D=3D 0) {
> +		if (stat(path, &sb) =3D=3D 0) {
>  			retval =3D semanage_copy_file(path,
>  						    semanage_path(SEMANAGE_TMP,
>  								  SEMANAGE_STORE_SEUSERS),
> @@ -1473,12 +1484,17 @@ rebuild:
>  			if (retval < 0)
>  				goto cleanup;
>  			pseusers->dtable->drop_cache(pseusers->dbase);
> -		} else {
> +		} else if (errno =3D=3D ENOENT) {
> +			/* The file does not exist */
>  			pseusers->dtable->clear(sh, pseusers->dbase);
> +		} else {
> +			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> +			retval =3D -1;
> +			goto cleanup;
>  		}
> =20
>  		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
> -		if (access(path, F_OK) =3D=3D 0) {
> +		if (stat(path, &sb) =3D=3D 0) {
>  			retval =3D semanage_copy_file(path,
>  						    semanage_path(SEMANAGE_TMP,
>  								  SEMANAGE_USERS_EXTRA),
> @@ -1486,8 +1502,13 @@ rebuild:
>  			if (retval < 0)
>  				goto cleanup;
>  			pusers_extra->dtable->drop_cache(pusers_extra->dbase);
> -		} else {
> +		} else if (errno =3D=3D ENOENT) {
> +			/* The file does not exist */
>  			pusers_extra->dtable->clear(sh, pusers_extra->dbase);
> +		} else {
> +			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> +			retval =3D -1;
> +			goto cleanup;
>  		}
>  	}
> =20
> @@ -1817,6 +1838,7 @@ static int semanage_direct_extract(semanage_handle_=
t * sh,
>  	ssize_t _data_len;
>  	char *_data;
>  	int compressed;
> +	struct stat sb;
> =20
>  	/* get path of module */
>  	rc =3D semanage_module_get_path(
> @@ -1829,8 +1851,8 @@ static int semanage_direct_extract(semanage_handle_=
t * sh,
>  		goto cleanup;
>  	}
> =20
> -	if (access(module_path, F_OK) !=3D 0) {
> -		ERR(sh, "Module does not exist: %s", module_path);
> +	if (stat(module_path, &sb) !=3D 0) {
> +		ERR(sh, "Unable to access %s: %s\n", module_path, strerror(errno));
>  		rc =3D -1;
>  		goto cleanup;
>  	}
> @@ -1859,7 +1881,13 @@ static int semanage_direct_extract(semanage_handle=
_t * sh,
>  		goto cleanup;
>  	}
> =20
> -	if (extract_cil =3D=3D 1 && strcmp(_modinfo->lang_ext, "cil") && access=
(input_file, F_OK) !=3D 0) {
> +	if (extract_cil =3D=3D 1 && strcmp(_modinfo->lang_ext, "cil") && stat(i=
nput_file, &sb) !=3D 0) {
> +		if (errno !=3D ENOENT) {
> +			ERR(sh, "Unable to access %s: %s\n", input_file, strerror(errno));
> +			rc =3D -1;
> +			goto cleanup;
> +		}
> +
>  		rc =3D semanage_compile_module(sh, _modinfo);
>  		if (rc < 0) {
>  			goto cleanup;
> @@ -2004,6 +2032,12 @@ static int semanage_direct_get_enabled(semanage_ha=
ndle_t *sh,
>  	}
> =20
>  	if (stat(path, &sb) < 0) {
> +		if (errno !=3D ENOENT) {
> +			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> +			status =3D -1;
> +			goto cleanup;
> +		}
> +
>  		*enabled =3D 1;
>  	}
>  	else {
> @@ -2330,6 +2364,12 @@ static int semanage_direct_get_module_info(semanag=
e_handle_t *sh,
> =20
>  	/* set enabled/disabled status */
>  	if (stat(fn, &sb) < 0) {
> +		if (errno !=3D ENOENT) {
> +			ERR(sh, "Unable to access %s: %s\n", fn, strerror(errno));
> +			status =3D -1;
> +			goto cleanup;
> +		}
> +
>  		ret =3D semanage_module_info_set_enabled(sh, *modinfo, 1);
>  		if (ret !=3D 0) {
>  			status =3D -1;
> @@ -2738,6 +2778,7 @@ static int semanage_direct_install_info(semanage_ha=
ndle_t *sh,
>  	int status =3D 0;
>  	int ret =3D 0;
>  	int type;
> +	struct stat sb;
> =20
>  	char path[PATH_MAX];
>  	mode_t mask =3D umask(0077);
> @@ -2838,7 +2879,7 @@ static int semanage_direct_install_info(semanage_ha=
ndle_t *sh,
>  			goto cleanup;
>  		}
> =20
> -		if (access(path, F_OK) =3D=3D 0) {
> +		if (stat(path, &sb) =3D=3D 0) {
>  			ret =3D unlink(path);
>  			if (ret !=3D 0) {
>  				ERR(sh, "Error while removing cached CIL file %s: %s", path, strerro=
r(errno));
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index 4bd1d651..14ad99c1 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -514,6 +514,7 @@ char *semanage_conf_path(void)
>  {
>  	char *semanage_conf =3D NULL;
>  	int len;
> +	struct stat sb;
> =20
>  	len =3D strlen(semanage_root()) + strlen(selinux_path()) + strlen(SEMAN=
AGE_CONF_FILE);
>  	semanage_conf =3D calloc(len + 1, sizeof(char));
> @@ -522,7 +523,7 @@ char *semanage_conf_path(void)
>  	snprintf(semanage_conf, len + 1, "%s%s%s", semanage_root(), selinux_pat=
h(),
>  		 SEMANAGE_CONF_FILE);
> =20
> -	if (access(semanage_conf, R_OK) !=3D 0) {
> +	if (stat(semanage_conf, &sb) !=3D 0 && errno =3D=3D ENOENT) {
>  		snprintf(semanage_conf, len + 1, "%s%s", selinux_path(), SEMANAGE_CONF=
_FILE);
>  	}
> =20
> @@ -1508,8 +1509,14 @@ int semanage_split_fc(semanage_handle_t * sh)
>  static int sefcontext_compile(semanage_handle_t * sh, const char *path) {
> =20
>  	int r;
> +	struct stat sb;
> +
> +	if (stat(path, &sb) < 0) {
> +		if (errno !=3D ENOENT) {
> +			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> +			return -1;
> +		}
> =20
> -	if (access(path, F_OK) !=3D 0) {
>  		return 0;
>  	}
> =20
> --=20
> 2.14.3
>=20
>=20

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlqswwQACgkQviIJHj72
InXelxAAvaCcwOgXlQkIXzZawcxJId9+ECl0HumCGFOKN0muSWpvNTKw30tQ2uQX
ol+q1/bPw7KH7z6aWcZZbSLDZnG6RLZwDYBwhvkTCko1wZmS751cznbKrKBs/AHs
jsaySfgBHvvKRC/D15fsB+eaGDyCFwbFY24Z+3Af+TZ0zDOuuR/NlUHwAMfQxb6S
V+UeWtoe8YovLTUyjisk+kkpI/eLFQCJwYT2e7ss0r6Fws6P5mYGCcZN5eNJjMiH
mPi3lXv9J/psicYcIsssMIOjV2Lu5+OpjvymTJwL8DED13Ob6MaDsBc4D8Qr1rzb
oqntsewGQgpYvJcaXr97gbiC8n4fj/nnAfXoQmrSgshPvkqb8kuwEftfw4GR/+0g
8vRqk6hmCnGb0tiisGIuA3xk8sTXILU/uVk1ZotjQk1uHSu4ouwmJ0Az5I4gGJyQ
SMAtZv/MTMwktsK6OMzBlqRSaCTiaz/WXwOM8FCUT2PynByqA66ZiwossT/dV8g4
P0u0BdQHMrKEMkKTvWc+t3eRKgRPhzI3IQ20EgZLO2ejkdWjMFjUWp1OTotoxjwi
3hr4AqOQRoOmAc7ujZPNMl71RBSaKRnqUHZh76db7kzMjA/WsaAmDaz6AY/KsZ4v
x3Bezhc5VnJDU1nId75Zno0ArmeiBzh/D7T22w0mmSvEFktqA18=
=JbKX
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
