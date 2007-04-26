Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3QHZ9aX021095
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 13:35:09 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3QHZ3HB007776
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 17:35:04 GMT
Subject: Re: [POLICYREP PATCH] Add objset to libsepol
From: James Antill <jantill@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070426165756.7021.40274.stgit@localhost.localdomain>
References: <20070426165756.7021.40274.stgit@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VS3O4gxvpvxmZoOHBCU4"
Date: Thu, 26 Apr 2007 13:35:00 -0400
Message-Id: <1177608900.3999.34.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-VS3O4gxvpvxmZoOHBCU4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-26 at 12:57 -0400, Karl MacMillan wrote:
> Add the objset data structure to libsepol. Object sets behave similarly t=
o
> Python sets.
[...]
> +struct sepol_objset
> +{
> +       struct sepol_list *objs;
> +       sepol_objset_cmp_t cmp;
> +       unsigned int len;
> +       char compliment;
> +};
>=20
 What is len for?
>=20
> +int sepol_objset_contains(struct sepol_handle *h, struct sepol_objset *s=
, void *obj)
> +{
> +	int ret;
> +	struct sepol_iter *iter;
> +
> +	ret =3D sepol_objset_seek(h, s, &iter, obj);
> +	if (ret =3D=3D SEPOL_EEXIST) {
> +		sepol_iter_free(h, iter);
> +		return 1;
> +	} else if (ret =3D=3D SEPOL_ENOENT) {
> +		sepol_iter_free(h, iter);
> +		return 0;
> +	} else if (ret =3D=3D SEPOL_ITERSTOP) {
> +		return 0;
> +	}

 This should be:

       int ret;
       struct sepol_iter *iter;
       int found =3D !s->compliment;

       ret =3D sepol_objset_seek(h, s, &iter, obj);
       if (ret =3D=3D SEPOL_EEXIST) {
               sepol_iter_free(h, iter);
               return found;
       } else if (ret =3D=3D SEPOL_ENOENT) {
               sepol_iter_free(h, iter);
               return !found;
       } else if (ret =3D=3D SEPOL_ITERSTOP) {
               return !found;
       }

...or something similar, no? Also C has switch, unlike python ;).

> +
> +	return ret;
> +}

 Having the iter errors bubble up the API like this sucks and will make
eq/subset/etc. much more complicated :(.

--=20
James Antill <jantill@redhat.com>

--=-VS3O4gxvpvxmZoOHBCU4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGMOLE11eXTEMrxtQRAl6EAJ41IXl0R4kLcbtnnV2mmGHpMvH6KACfcsSP
9iE+K5wktPtij4eeF+YjysM=
=yFOq
-----END PGP SIGNATURE-----

--=-VS3O4gxvpvxmZoOHBCU4--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
