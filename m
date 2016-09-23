Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NFi563004563
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 11:44:05 -0400
Received: from workstation.fluency.net.uk ([185.34.9.224]) by mail.gmx.com
 (mrgmx102) with ESMTPSA (Nemesis) id 0LiIgB-1bAKPq002t-00nMPK for
 <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 17:44:01 +0200
Date: Fri, 23 Sep 2016 16:43:56 +0100
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] genhomedircon: support policies using RBACSEP
Message-ID: <20160923154356.GA8039@workstation.fluency.net.uk>
References: <cover.1474639773.git.gary.tierney@gmx.com>
 <1062ebe32922aec79a0232acfdd0005e9ce124da.1474639773.git.gary.tierney@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
In-Reply-To: <1062ebe32922aec79a0232acfdd0005e9ce124da.1474639773.git.gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 03:28:44PM +0100, Gary Tierney wrote:
> Introduces support for generating homedir/user contexts for policies
> that implement RBACSEP.  The support works by taking the prefix of a
> logins seuser and replacing the role field in their context
> specifications with the prefix.  A new option "genhomedircon-rbacsep"
> was added to /etc/selinux/semanage.conf to allow toggling this behavior.
>=20
> The user prefix can be set from both standard kernel policy and CIL:
>=20
> CIL:
>     (user user_u)
>     (role user_r)
>     (userrole user_u user_r)
>     (userprefix user_u user_r)
>=20
> kernel policy language:
>     role user_r;
>     user user_u roles { user_r } prefix user_r;
>=20
> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
> ---
>  libsemanage/src/conf-parse.y    | 14 +++++++++++++-
>  libsemanage/src/conf-scan.l     |  1 +
>  libsemanage/src/genhomedircon.c | 30 +++++++++++++++++++++++++++++-
>  libsemanage/src/semanage_conf.h |  1 +
>  4 files changed, 44 insertions(+), 2 deletions(-)
>=20
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index b527e89..d2112d2 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -61,7 +61,7 @@ static int parse_errors;
> =20
>  %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LI=
NKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT
>  %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE=
_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
> -%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
> +%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL GENHOMEDIRCON_RBACSEP
>  %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
>  %token PROG_PATH PROG_ARGS
>  %token <s> ARG
> @@ -95,6 +95,7 @@ single_opt:     module_store
>  	|	bzip_blocksize
>  	|	bzip_small
>  	|	remove_hll
> +	|	genhomedircon_rbacsep
>          ;
> =20
>  module_store:   MODULE_STORE '=3D' ARG {
> @@ -268,6 +269,17 @@ remove_hll:  REMOVE_HLL'=3D' ARG {
>  	free($3);
>  }
> =20
> +genhomedircon_rbacsep:  GENHOMEDIRCON_RBACSEP'=3D' ARG {
> +	if (strcasecmp($3, "false") =3D=3D 0) {
> +		current_conf->genhomedircon_rbacsep =3D 0;
> +	} else if (strcasecmp($3, "true") =3D=3D 0) {
> +		current_conf->genhomedircon_rbacsep =3D 1;
> +	} else {
> +		yyerror("genhomedircon-rbacsep can only be 'true' or 'false'");
> +	}
> +	free($3);
> +}
> +
>  command_block:=20
>                  command_start external_opts BLOCK_END  {
>                          if (new_external->path =3D=3D NULL) {
> diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
> index 607bbf0..114098c 100644
> --- a/libsemanage/src/conf-scan.l
> +++ b/libsemanage/src/conf-scan.l
> @@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
>  bzip-blocksize	return BZIP_BLOCKSIZE;
>  bzip-small	return BZIP_SMALL;
>  remove-hll	return REMOVE_HLL;
> +genhomedircon-rbacsep	return GENHOMEDIRCON_RBACSEP;
>  "[load_policy]"   return LOAD_POLICY_START;
>  "[setfiles]"      return SETFILES_START;
>  "[sefcontext_compile]"      return SEFCONTEXT_COMPILE_START;
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index 3fc9e7a..98f9ebd 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -71,6 +71,10 @@
>  #define COMMENT_USER_HOME_CONTEXT "\n\n#\n# Home Context for user %s" \
>  			"\n#\n\n"
> =20
> +#define WARNING_RBACSEP_INVALID_ROLE  "genhomedircon-rbacsep is enabled,=
 " \
> +			"but the user prefix of " \
> +			"'%s' for %s is not a valid role.  Skipping user."
> +
>  /* placeholders used in the template file
>     which are searched for and replaced */
>  #define TEMPLATE_HOME_ROOT "HOME_ROOT"
> @@ -638,6 +642,11 @@ static int write_contexts(genhomedircon_settings_t *=
s, FILE *out,
>  			goto fail;
>  		}
> =20
> +		if (s->h_semanage->conf->genhomedircon_rbacsep &&
> +		    sepol_context_set_role(sepolh, context, user->prefix) < 0) {
> +		    goto fail;
> +		}
> +
>  		if (sepol_context_to_string(sepolh, context,
>  					    &new_context_str) < 0) {
>  			goto fail;
> @@ -857,7 +866,7 @@ static int setup_fallback_user(genhomedircon_settings=
_t * s)
>  	int errors =3D 0;
> =20
>  	retval =3D semanage_seuser_list(s->h_semanage, &seuser_list, &nseusers);
> -	if (retval < 0 || (nseusers < 1)) {
> +	if (retval < 0 || (nseusers < 2)) {
>  		/* if there are no users, this function can't do any other work */
>  		return errors;
>  	}
> @@ -886,6 +895,17 @@ static int setup_fallback_user(genhomedircon_setting=
s_t * s)
>  					level =3D FALLBACK_LEVEL;
>  			}
> =20
> +			if (u && s->h_semanage->conf->genhomedircon_rbacsep &&
> +			    !semanage_user_has_role(u, prefix)) {
> +				WARN(s->h_semanage, WARNING_RBACSEP_INVALID_ROLE,
> +				     prefix, seuname);
> +
> +				errors =3D STATUS_ERR;
> +				semanage_user_key_free(key);
> +				semanage_user_free(u);
> +				break;
> +			}
> +
>  			if (push_user_entry(&(s->fallback), FALLBACK_NAME,
>  					    FALLBACK_UIDGID, FALLBACK_UIDGID,
>  					    seuname, prefix, "", level,
> @@ -969,6 +989,14 @@ static int add_user(genhomedircon_settings_t * s,
>  		level =3D FALLBACK_LEVEL;
>  	}
> =20
> +	if (s->h_semanage->conf->genhomedircon_rbacsep &&
> +	    !semanage_user_has_role(user, prefix)) {
> +		WARN(s->h_semanage, WARNING_RBACSEP_INVALID_ROLE, prefix, sename);
> +
> +		retval =3D STATUS_SUCCESS;
> +		goto cleanup;
> +	}
> +
>  	retval =3D getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
>  	if (retval !=3D 0 || pwent =3D=3D NULL) {
>  		if (retval !=3D 0 && retval !=3D ENOENT) {
> diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_c=
onf.h
> index c99ac8c..2c968da 100644
> --- a/libsemanage/src/semanage_conf.h
> +++ b/libsemanage/src/semanage_conf.h
> @@ -46,6 +46,7 @@ typedef struct semanage_conf {
>  	int bzip_blocksize;
>  	int bzip_small;
>  	int remove_hll;
> +	int genhomedircon_rbacsep;
>  	int ignore_module_cache;
>  	char *ignoredirs;	/* ";" separated of list for genhomedircon to ignore =
*/
>  	struct external_prog *load_policy;
> --=20
> 2.4.11
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

perfinion at #selinux on freenode IRC suggested that the genhomedircon-rbac=
sep
option should be dropped, and instead a RBACSEP context should be chosen fi=
rst
in all cases.  If validation of this context fails, then it should fall back
to whatever the existing role is.

Anyone have thoughts on this?  This seems to me like a much better solution=
 than
using a new genhomedircon-rbacsep option, but the problem of using
"userprefix" still remains.

--=20
Gary Tierney

GPG fingerprint: 412C 0EF9 C305 68E6 B660  BDAF 706E D765 85AA 79D8
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x706ED76585AA79D8

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX5U21AAoJEHBu12WFqnnY3OYH/2+PGosjeABEfcea5mLEWGbH
CGQjg0nS1qqPC2IlSSw+/AL6poJ6lGIhlWtAYLjcIeOdawdZ2scA4NrAFJp5rvDm
8Fvz2BvovujRJxWfXtck1u16XXL50ipxs55/lTcKb3L0+x7xNps8aQ8QMOlRftDo
SlxsLNu7MpAYgxFowDyE+rr4ZiJaNp4kCNCoJjwRsI8WnpcYTZNb7RTZx65Dq9cw
KIajHaSRFu0WzXqKYaAVbEVwMzIDwNXb/wgDYL0Dn+i+SfQg34maJxdNv0pLepFa
ObXvyxNAhJxT+9W1CvKiU6p+dRjnwJbA1UbQZTU7BTKFdgs5TIDehzN/VsqEUQ0=
=jpxn
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
