Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5O10VM5016308
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 21:00:31 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5O10Upj009662
	for <selinux@tycho.nsa.gov>; Sat, 24 Jun 2006 01:00:30 GMT
Subject: Re: [PATCH] libselinux: 1/2 Introduce {get,set}procattrcon
From: James Antill <jantill@redhat.com>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1151094766.21012.93.camel@localhost.localdomain>
References: <1151094766.21012.93.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-akFXJHwoUmHjWXwcBMd/"
Date: Fri, 23 Jun 2006 21:00:22 -0400
Message-Id: <1151110822.21635.125.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-akFXJHwoUmHjWXwcBMd/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-23 at 16:32 -0400, Eric Paris wrote:
> The below attached patch implements two new function, get and set
> procattrcon.  These are generic functions that take a context and a path
> and attempt to write that context to that path.  These are used by of
> exported libselinux interfaces, like getfscreatecon, as a generic
> backend to reduce duplication of code.

> --- libselinux-1.30.15/src/setprocattrcon.c.p1	2006-06-23 15:05:25.000000=
000 -0400
> +++ libselinux-1.30.15/src/setprocattrcon.c	2006-06-23 15:10:05.000000000=
 -0400
> @@ -0,0 +1,40 @@
> +#include <unistd.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include "selinux_internal.h"
> +
> +int setprocattrcon_raw(char *context, char *proc_entry)
> +{
> +	int fd;
> +	ssize_t ret;
> +
> +	fd =3D open(proc_entry, O_RDWR);
> +	if (fd < 0)
> +		return -1;
> +	if (context)=20
> +		ret =3D write(fd, context, strlen(context)+1);
> +	else
> +		ret =3D write(fd, NULL, 0); /* clear */
> +	close(fd);

 Could you save and restore errno around the close? I know it didn't do
that before, but still...

> +	if (ret < 0)
> +		return -1;
> +	else
> +		return 0;
> +}
> +hidden_def(setprocattrcon_raw)
[...]
> +hidden_def(setprocattrcon)

 These make it impossible to call those functions from outside the
shared library, but you've declared them in the external header.

> --- libselinux-1.30.15/include/selinux/selinux.h.p1	2006-06-23 15:05:25.0=
00000000 -0400
> +++ libselinux-1.30.15/include/selinux/selinux.h	2006-06-23 15:20:06.0000=
00000 -0400
> @@ -24,6 +24,14 @@ extern void freeconary(security_context_
> =20
>  /* Wrappers for the /proc/pid/attr API. */
> =20
> +/* Generic /proc pid attr handlers.  These will either get or set the co=
ntext
> +   from or into the proc location passed to them.  Should only be called=
 from=20
> +   inside libselinux */
> +extern int getprocattrcon(security_context_t *con, char *path);
> +extern int getprocattrcon_raw(security_context_t *con, char *path);
> +extern int setprocattrcon(security_context_t con, char *path);
> +extern int setprocattrcon_raw(security_context_t con, char *path);
> +
>  /* Get current context, and set *con to refer to it.
>     Caller must free via freecon. */
>  extern int getcon(security_context_t *con);

--=20
James Antill <jantill@redhat.com>

--=-akFXJHwoUmHjWXwcBMd/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEnI6m11eXTEMrxtQRAn3AAJ9AR17TxXN2fRnzQIzip/jEp0r8sQCfU/8g
2w2t8y3eOTXMQ3gi/EklvDs=
=K3S4
-----END PGP SIGNATURE-----

--=-akFXJHwoUmHjWXwcBMd/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
