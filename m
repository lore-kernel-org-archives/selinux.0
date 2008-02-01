Subject: Re: genhomedircon is broken in libsemanage
From: James Antill <james.antill@redhat.com>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, jbrindle@tresys.com,
        sds@tycho.nsa.gov
In-Reply-To: <200801311513.m0VFDLxr000600@cadmus.columbia.tresys.com>
References: <200801311513.m0VFDLxr000600@cadmus.columbia.tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rnyUVHhP1ALDZjl+y+IT"
Date: Fri, 01 Feb 2008 09:23:14 -0500
Message-Id: <1201875794.3727.104.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-rnyUVHhP1ALDZjl+y+IT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


 Mostly FYI, although there is one minor error dealing with a malloc()
error case.

On Thu, 2008-01-31 at 10:13 -0500, Todd C. Miller wrote:

> Index: trunk/libsemanage/src/genhomedircon.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- trunk/libsemanage/src/genhomedircon.c	(revision 2771)
> +++ trunk/libsemanage/src/genhomedircon.c	(working copy)
> @@ -24,6 +24,8 @@
>  #include <semanage/seusers_policy.h>
>  #include <semanage/users_policy.h>
>  #include <semanage/user_record.h>
> +#include <semanage/fcontext_record.h>
> +#include <semanage/fcontexts_policy.h>
>  #include <sepol/context.h>
>  #include <sepol/context_record.h>
>  #include "semanage_store.h"
> @@ -45,6 +47,7 @@
>  #include <pwd.h>
>  #include <errno.h>
>  #include <unistd.h>
> +#include <regex.h>
> =20
>  /* paths used in get_home_dirs() */
>  #define PATH_ETC_USERADD "/etc/default/useradd"
> @@ -101,6 +104,11 @@
>  	const char *replace_with;
>  } replacement_pair_t;
> =20
> +typedef struct {
> +	const char *dir;
> +	int matched;
> +} fc_match_handle_t;
> +
>  static semanage_list_t *default_shell_list(void)
>  {
>  	semanage_list_t *list =3D NULL;
> @@ -150,10 +158,70 @@
>  	return list;
>  }
> =20
> +/* Helper function called via semanage_fcontext_iterate() */
> +static int fcontext_matches(const semanage_fcontext_t *fcontext, void *v=
arg)
> +{
> +	const char *oexpr =3D semanage_fcontext_get_expr(fcontext);
> +	fc_match_handle_t *handp =3D varg;
> +	struct Ustr *expr;
> +	regex_t re;
> +	size_t n;
> +	int type, retval =3D -1;
> +
> +	/* Only match ALL or DIR */
> +	type =3D semanage_fcontext_get_type(fcontext);
> +	if (type !=3D SEMANAGE_FCONTEXT_ALL && type !=3D SEMANAGE_FCONTEXT_ALL)
> +		return 0;
> +
> +	/* Convert oexpr into a Ustr and anchor it at the beginning */
> +	expr =3D ustr_dup_cstr("^");
> +	if (expr =3D=3D USTR_NULL)
> +		goto done;
> +	ustr_ins_cstr(&expr, 1, oexpr);

 This works fine, but you can use:

          ustr_add_cstr(&expr, oexpr)

...which appends data, so you don't need to keep track of the offset.

> +	if (expr =3D=3D USTR_NULL)

 This will never be true, you either want to test the return value or
use the "has had a memory error" flag:

          if (ustr_enomem(expr))

> +		goto done;
> +	n =3D ustr_len(expr);
> +
> +	/* Strip off trailing ".+" or ".*" */
> +	if (ustr_cmp_suffix_cstr_eq(expr, ".+") ||
> +	    ustr_cmp_suffix_cstr_eq(expr, ".*")) {
> +		if (!ustr_del_subustr(&expr, n - 1, 2))

 This works fine, but you can use:

                  if (!ustr_del(&expr, 2))

...which always removes the last X bytes.

> +			goto done;
> +		n -=3D 2;
> +	}
> +
> +	/* Strip off trailing "(/.*)?" */
> +	if (ustr_cmp_suffix_cstr_eq(expr, "(/.*)?")) {
> +		if (!ustr_del_subustr(&expr, n - 5, 6))
> +			goto done;
> +		n -=3D 6;
> +	}
> +
> +	/* Append pattern to eat up trailing slashes */
> +	if (!ustr_ins_cstr(&expr, n, "/*$"))
> +		goto done;
> +
> +	/* Check dir against expr */
> +	if (regcomp(&re, ustr_cstr(expr), REG_EXTENDED) !=3D 0)
> +		goto done;
> +	if (regexec(&re, handp->dir, 0, NULL, 0) =3D=3D 0)
> +		handp->matched =3D 1;
> +	regfree(&re);
> +
> +	retval =3D 0;
> +
> +done:
> +	if (expr)
> +		ustr_free(expr);

 This works fine, but:

 ustr_free(NULL);

...is guaranteed to be a noop, much like libc free(NULL).

> +
> +	return retval;
> +}


--=20
James Antill <james.antill@redhat.com>
Red Hat

--=-rnyUVHhP1ALDZjl+y+IT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHoytS11eXTEMrxtQRArp+AJ466yhCgokiq95qDUgZ4oK8zvURhwCgrO2T
AmmBRaYW8Xzlh6R82oa6oFc=
=Qgss
-----END PGP SIGNATURE-----

--=-rnyUVHhP1ALDZjl+y+IT--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
