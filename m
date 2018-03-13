Date: Tue, 13 Mar 2018 11:58:43 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Message-ID: <20180313105843.GA29387@workstation>
References: <3927bd04-7409-1476-ddf6-200c49abfbe2@tycho.nsa.gov>
 <20180309153944.7733-1-vmojzis@redhat.com>
 <408cc4fc-9cea-dcd8-7a88-df733bdf6507@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
In-Reply-To: <408cc4fc-9cea-dcd8-7a88-df733bdf6507@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: replace access() checks to make
 setuid programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 10:51:20AM -0500, Stephen Smalley wrote:
> On 03/09/2018 10:39 AM, Vit Mojzis wrote:
> > access() uses real UID instead of effective UID which causes false
> > negative checks in setuid programs.
> > Replace access() calls (mostly tests for file existence) by stat().
> >=20
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1186431
>=20
> Thanks, I've put this up as a PR for testing here:
> https://github.com/SELinuxProject/selinux/pull/84
>=20
> I won't be around next week so someone else can merge it or I will get to=
 it when I return.

This is merged now. Thanks!

> >=20
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > ---
> >  libsemanage/src/direct_api.c     | 137 +++++++++++++++++++++++++------=
--------
> >  libsemanage/src/semanage_store.c |  11 +++-
> >  2 files changed, 98 insertions(+), 50 deletions(-)
> >=20
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> > index 92d7517d..439122df 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -140,6 +140,7 @@ int semanage_direct_is_managed(semanage_handle_t * =
sh)
> >  int semanage_direct_connect(semanage_handle_t * sh)
> >  {
> >  	const char *path;
> > +	struct stat sb;
> > =20
> >  	if (semanage_check_init(sh, sh->conf->store_root_path))
> >  		goto err;
> > @@ -302,10 +303,16 @@ int semanage_direct_connect(semanage_handle_t * s=
h)
> > =20
> >  	/* set the disable dontaudit value */
> >  	path =3D semanage_path(SEMANAGE_ACTIVE, SEMANAGE_DISABLE_DONTAUDIT);
> > -	if (access(path, F_OK) =3D=3D 0)
> > +
> > +	if (stat(path, &sb) =3D=3D 0)
> >  		sepol_set_disable_dontaudit(sh->sepolh, 1);
> > -	else
> > +	else if (errno =3D=3D ENOENT) {
> > +		/* The file does not exist */
> >  		sepol_set_disable_dontaudit(sh->sepolh, 0);
> > +	} else {
> > +		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> > +		goto err;
> > +	}
> > =20
> >  	return STATUS_SUCCESS;
> > =20
> > @@ -1139,6 +1146,7 @@ static int semanage_compile_hll_modules(semanage_=
handle_t *sh,
> >  	int status =3D 0;
> >  	int i;
> >  	char cil_path[PATH_MAX];
> > +	struct stat sb;
> > =20
> >  	assert(sh);
> >  	assert(modinfos);
> > @@ -1155,9 +1163,13 @@ static int semanage_compile_hll_modules(semanage=
_handle_t *sh,
> >  		}
> > =20
> >  		if (semanage_get_ignore_module_cache(sh) =3D=3D 0 &&
> > -				access(cil_path, F_OK) =3D=3D 0) {
> > +				(status =3D stat(cil_path, &sb)) =3D=3D 0) {
> >  			continue;
> >  		}
> > +		if (status !=3D 0 && errno !=3D ENOENT) {
> > +			ERR(sh, "Unable to access %s: %s\n", cil_path, strerror(errno));
> > +			goto cleanup; //an error in the "stat" call
> > +		}
> > =20
> >  		status =3D semanage_compile_module(sh, &modinfos[i]);
> >  		if (status < 0) {
> > @@ -1196,6 +1208,7 @@ static int semanage_direct_commit(semanage_handle=
_t * sh)
> >  	struct cil_db *cildb =3D NULL;
> >  	semanage_module_info_t *modinfos =3D NULL;
> >  	mode_t mask =3D umask(0077);
> > +	struct stat sb;
> > =20
> >  	int do_rebuild, do_write_kernel, do_install;
> >  	int fcontexts_modified, ports_modified, seusers_modified,
> > @@ -1234,10 +1247,16 @@ static int semanage_direct_commit(semanage_hand=
le_t * sh)
> > =20
> >  	/* Create or remove the disable_dontaudit flag file. */
> >  	path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
> > -	if (access(path, F_OK) =3D=3D 0)
> > +	if (stat(path, &sb) =3D=3D 0)
> >  		do_rebuild |=3D !(sepol_get_disable_dontaudit(sh->sepolh) =3D=3D 1);
> > -	else
> > +	else if (errno =3D=3D ENOENT) {
> > +		/* The file does not exist */
> >  		do_rebuild |=3D (sepol_get_disable_dontaudit(sh->sepolh) =3D=3D 1);
> > +	} else {
> > +		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> > +		retval =3D -1;
> > +		goto cleanup;
> > +	}
> >  	if (sepol_get_disable_dontaudit(sh->sepolh) =3D=3D 1) {
> >  		FILE *touch;
> >  		touch =3D fopen(path, "w");
> > @@ -1259,10 +1278,17 @@ static int semanage_direct_commit(semanage_hand=
le_t * sh)
> > =20
> >  	/* Create or remove the preserve_tunables flag file. */
> >  	path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_PRESERVE_TUNABLES);
> > -	if (access(path, F_OK) =3D=3D 0)
> > +	if (stat(path, &sb) =3D=3D 0)
> >  		do_rebuild |=3D !(sepol_get_preserve_tunables(sh->sepolh) =3D=3D 1);
> > -	else
> > +	else if (errno =3D=3D ENOENT) {
> > +		/* The file does not exist */
> >  		do_rebuild |=3D (sepol_get_preserve_tunables(sh->sepolh) =3D=3D 1);
> > +	} else {
> > +		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> > +		retval =3D -1;
> > +		goto cleanup;
> > +	}
> > +
> >  	if (sepol_get_preserve_tunables(sh->sepolh) =3D=3D 1) {
> >  		FILE *touch;
> >  		touch =3D fopen(path, "w");
> > @@ -1299,40 +1325,25 @@ static int semanage_direct_commit(semanage_hand=
le_t * sh)
> >  	 * a rebuild.
> >  	 */
> >  	if (!do_rebuild) {
> > -		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL);
> > -		if (access(path, F_OK) !=3D 0) {
> > -			do_rebuild =3D 1;
> > -			goto rebuild;
> > -		}
> > -
> > -		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
> > -		if (access(path, F_OK) !=3D 0) {
> > -			do_rebuild =3D 1;
> > -			goto rebuild;
> > -		}
> > -
> > -		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
> > -		if (access(path, F_OK) !=3D 0) {
> > -			do_rebuild =3D 1;
> > -			goto rebuild;
> > -		}
> > -
> > -		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED);
> > -		if (access(path, F_OK) !=3D 0) {
> > -			do_rebuild =3D 1;
> > -			goto rebuild;
> > -		}
> > -
> > -		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
> > -		if (access(path, F_OK) !=3D 0) {
> > -			do_rebuild =3D 1;
> > -			goto rebuild;
> > -		}
> > +		int files[] =3D {SEMANAGE_STORE_KERNEL,
> > +					   SEMANAGE_STORE_FC,
> > +					   SEMANAGE_STORE_SEUSERS,
> > +					   SEMANAGE_LINKED,
> > +					   SEMANAGE_SEUSERS_LINKED,
> > +					   SEMANAGE_USERS_EXTRA_LINKED};
> > +
> > +		for (i =3D 0; i < (int) sizeof(files); i++) {
> > +			path =3D semanage_path(SEMANAGE_TMP, files[i]);
> > +			if (stat(path, &sb) !=3D 0) {
> > +				if (errno !=3D ENOENT) {
> > +					ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> > +					retval =3D -1;
> > +					goto cleanup;
> > +				}
> > =20
> > -		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
> > -		if (access(path, F_OK) !=3D 0) {
> > -			do_rebuild =3D 1;
> > -			goto rebuild;
> > +				do_rebuild =3D 1;
> > +				goto rebuild;
> > +			}
> >  		}
> >  	}
> > =20
> > @@ -1465,7 +1476,7 @@ rebuild:
> >  			goto cleanup;
> > =20
> >  		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
> > -		if (access(path, F_OK) =3D=3D 0) {
> > +		if (stat(path, &sb) =3D=3D 0) {
> >  			retval =3D semanage_copy_file(path,
> >  						    semanage_path(SEMANAGE_TMP,
> >  								  SEMANAGE_STORE_SEUSERS),
> > @@ -1473,12 +1484,17 @@ rebuild:
> >  			if (retval < 0)
> >  				goto cleanup;
> >  			pseusers->dtable->drop_cache(pseusers->dbase);
> > -		} else {
> > +		} else if (errno =3D=3D ENOENT) {
> > +			/* The file does not exist */
> >  			pseusers->dtable->clear(sh, pseusers->dbase);
> > +		} else {
> > +			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> > +			retval =3D -1;
> > +			goto cleanup;
> >  		}
> > =20
> >  		path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
> > -		if (access(path, F_OK) =3D=3D 0) {
> > +		if (stat(path, &sb) =3D=3D 0) {
> >  			retval =3D semanage_copy_file(path,
> >  						    semanage_path(SEMANAGE_TMP,
> >  								  SEMANAGE_USERS_EXTRA),
> > @@ -1486,8 +1502,13 @@ rebuild:
> >  			if (retval < 0)
> >  				goto cleanup;
> >  			pusers_extra->dtable->drop_cache(pusers_extra->dbase);
> > -		} else {
> > +		} else if (errno =3D=3D ENOENT) {
> > +			/* The file does not exist */
> >  			pusers_extra->dtable->clear(sh, pusers_extra->dbase);
> > +		} else {
> > +			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> > +			retval =3D -1;
> > +			goto cleanup;
> >  		}
> >  	}
> > =20
> > @@ -1817,6 +1838,7 @@ static int semanage_direct_extract(semanage_handl=
e_t * sh,
> >  	ssize_t _data_len;
> >  	char *_data;
> >  	int compressed;
> > +	struct stat sb;
> > =20
> >  	/* get path of module */
> >  	rc =3D semanage_module_get_path(
> > @@ -1829,8 +1851,8 @@ static int semanage_direct_extract(semanage_handl=
e_t * sh,
> >  		goto cleanup;
> >  	}
> > =20
> > -	if (access(module_path, F_OK) !=3D 0) {
> > -		ERR(sh, "Module does not exist: %s", module_path);
> > +	if (stat(module_path, &sb) !=3D 0) {
> > +		ERR(sh, "Unable to access %s: %s\n", module_path, strerror(errno));
> >  		rc =3D -1;
> >  		goto cleanup;
> >  	}
> > @@ -1859,7 +1881,13 @@ static int semanage_direct_extract(semanage_hand=
le_t * sh,
> >  		goto cleanup;
> >  	}
> > =20
> > -	if (extract_cil =3D=3D 1 && strcmp(_modinfo->lang_ext, "cil") && acce=
ss(input_file, F_OK) !=3D 0) {
> > +	if (extract_cil =3D=3D 1 && strcmp(_modinfo->lang_ext, "cil") && stat=
(input_file, &sb) !=3D 0) {
> > +		if (errno !=3D ENOENT) {
> > +			ERR(sh, "Unable to access %s: %s\n", input_file, strerror(errno));
> > +			rc =3D -1;
> > +			goto cleanup;
> > +		}
> > +
> >  		rc =3D semanage_compile_module(sh, _modinfo);
> >  		if (rc < 0) {
> >  			goto cleanup;
> > @@ -2004,6 +2032,12 @@ static int semanage_direct_get_enabled(semanage_=
handle_t *sh,
> >  	}
> > =20
> >  	if (stat(path, &sb) < 0) {
> > +		if (errno !=3D ENOENT) {
> > +			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> > +			status =3D -1;
> > +			goto cleanup;
> > +		}
> > +
> >  		*enabled =3D 1;
> >  	}
> >  	else {
> > @@ -2330,6 +2364,12 @@ static int semanage_direct_get_module_info(seman=
age_handle_t *sh,
> > =20
> >  	/* set enabled/disabled status */
> >  	if (stat(fn, &sb) < 0) {
> > +		if (errno !=3D ENOENT) {
> > +			ERR(sh, "Unable to access %s: %s\n", fn, strerror(errno));
> > +			status =3D -1;
> > +			goto cleanup;
> > +		}
> > +
> >  		ret =3D semanage_module_info_set_enabled(sh, *modinfo, 1);
> >  		if (ret !=3D 0) {
> >  			status =3D -1;
> > @@ -2738,6 +2778,7 @@ static int semanage_direct_install_info(semanage_=
handle_t *sh,
> >  	int status =3D 0;
> >  	int ret =3D 0;
> >  	int type;
> > +	struct stat sb;
> > =20
> >  	char path[PATH_MAX];
> >  	mode_t mask =3D umask(0077);
> > @@ -2838,7 +2879,7 @@ static int semanage_direct_install_info(semanage_=
handle_t *sh,
> >  			goto cleanup;
> >  		}
> > =20
> > -		if (access(path, F_OK) =3D=3D 0) {
> > +		if (stat(path, &sb) =3D=3D 0) {
> >  			ret =3D unlink(path);
> >  			if (ret !=3D 0) {
> >  				ERR(sh, "Error while removing cached CIL file %s: %s", path, strer=
ror(errno));
> > diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanag=
e_store.c
> > index 4bd1d651..14ad99c1 100644
> > --- a/libsemanage/src/semanage_store.c
> > +++ b/libsemanage/src/semanage_store.c
> > @@ -514,6 +514,7 @@ char *semanage_conf_path(void)
> >  {
> >  	char *semanage_conf =3D NULL;
> >  	int len;
> > +	struct stat sb;
> > =20
> >  	len =3D strlen(semanage_root()) + strlen(selinux_path()) + strlen(SEM=
ANAGE_CONF_FILE);
> >  	semanage_conf =3D calloc(len + 1, sizeof(char));
> > @@ -522,7 +523,7 @@ char *semanage_conf_path(void)
> >  	snprintf(semanage_conf, len + 1, "%s%s%s", semanage_root(), selinux_p=
ath(),
> >  		 SEMANAGE_CONF_FILE);
> > =20
> > -	if (access(semanage_conf, R_OK) !=3D 0) {
> > +	if (stat(semanage_conf, &sb) !=3D 0 && errno =3D=3D ENOENT) {
> >  		snprintf(semanage_conf, len + 1, "%s%s", selinux_path(), SEMANAGE_CO=
NF_FILE);
> >  	}
> > =20
> > @@ -1508,8 +1509,14 @@ int semanage_split_fc(semanage_handle_t * sh)
> >  static int sefcontext_compile(semanage_handle_t * sh, const char *path=
) {
> > =20
> >  	int r;
> > +	struct stat sb;
> > +
> > +	if (stat(path, &sb) < 0) {
> > +		if (errno !=3D ENOENT) {
> > +			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> > +			return -1;
> > +		}
> > =20
> > -	if (access(path, F_OK) !=3D 0) {
> >  		return 0;
> >  	}
> > =20
> >=20
>=20

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlqnrtsACgkQviIJHj72
InWQbg/+NgBFSWiAVB0J/CQpelkNM/W25WvUbn7H8W3+S2QjxLd7IbAhMoxUxmHc
L8FjNzROmi3Wc4kN4tEuMl4NvqjRknRdhyR+Yyd/AuLFm7sqwN4IHixDVU2etSnb
itVSj6NEpgqsF4lXZplUEVv7Sujf1P4XN0H76n0jM8gY7i5Ydxh59quw/INxzACv
c5v0AZS1TOH0lt4n3kppYoGvSjXY8K5onZmuvcG1WmYK0EQJ0e6EK6u04RCY7qxX
SIuFqPa3wI4gp2MNf9NeX/KAnALi7aSztB6EAx03428v8MprCoWQSuuBlXoYCFny
SYjGh9lO2iHw94lBTHykCVcFZnXGPQhqcAvbfc7XM+VKBU5Yn469aHy3yEx1QQdW
Q6yJK3YWENIjpDwmnrJBJ9+dSO5FMVFh7yhQdJn8s4Y9dXeQVZu+1lDbB9T1lRRs
lEDOQWvVlqTmHJkI+5tC/hB445ngt2SLUZwWXqm1eMbB/mDBWYJEmXYxRdDUX5x9
pmfZVnkZUFlN1YQ19e4yArrSFpGNpygw65/BlUht85qyuQY625jEJpdY3OwLr6Yi
ifYIVwpJgV8q6vxdLIHms9rSAYXKZo9PBnbEaXnp1CHTH46t9nuk7YTyc62HgU7J
htH4FRE2JZ10TEKMD0YN7sQ+hkGKd9JgNAeIvSG592mI6rF169I=
=qbol
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
