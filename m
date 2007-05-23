Subject: Re: [PATCH 1/4] selinux: add support for querying object classes
	and permissions from the running policy
From: James Antill <jantill@redhat.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <11799259343624-git-send-email-cpebenito@tresys.com>
References: <1179925929721-git-send-email-cpebenito@tresys.com>
	 <11799259343624-git-send-email-cpebenito@tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-K5Rw5+cq290OZDyN/2TA"
Date: Wed, 23 May 2007 11:42:07 -0400
Message-Id: <1179934928.23650.65.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-K5Rw5+cq290OZDyN/2TA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-23 at 09:12 -0400, Christopher J. PeBenito wrote:
>=20
> +static int get_permissions_callback(void *k, void *d, void *args)
> +{
> +       struct perm_datum *datum =3D d;
> +       char *name =3D k, **perms =3D args;
> +       int value =3D datum->value - 1;
> +
> +       perms[value] =3D kstrdup(name, GFP_ATOMIC);
> +       if (!perms[value])
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +int security_get_permissions(char *class, char ***perms, int *nperms)
> +{
[...]
> +       *nperms =3D match->permissions.nprim;
> +       *perms =3D kcalloc(*nperms, sizeof(*perms), GFP_ATOMIC);
> +       if (!*perms)
> +               goto out;
> +
> +       if (match->comdatum) {
> +               rc =3D hashtab_map(match->comdatum->permissions.table,
> +                               get_permissions_callback, *perms);
> +               if (rc < 0)
> +                       goto err;
> +       }
> +
> +       rc =3D hashtab_map(match->permissions.table, get_permissions_call=
back,
> +                       *perms);


 So I'm probably just wasting your time out of ignorance here, but this
looks really suspicious to me. Why don't you need to add in
match->comdatum->permissions.nprim for the allocation? Also how is it
guaranteed that one "datum->value - 1" won't be the same in both
hashtabs? (if it isn't you've leaked memory).

--=20
James Antill <jantill@redhat.com>

--=-K5Rw5+cq290OZDyN/2TA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGVGDP11eXTEMrxtQRAsg2AJ9giof7j5bGA6kqwKL6wM7GraPIZQCgkN14
44/Bwphk3ryw0YbaElugHPk=
=+9bo
-----END PGP SIGNATURE-----

--=-K5Rw5+cq290OZDyN/2TA--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
