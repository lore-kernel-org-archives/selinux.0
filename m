Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PNgGxB026116
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 19:42:17 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3PNgFY7028775
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 23:42:15 GMT
Subject: Re: [POLICYREP PATCH] Add objset to libsepol
From: James Antill <jantill@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070425215822.16055.18880.stgit@localhost.localdomain>
References: <20070425215822.16055.18880.stgit@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-onnRI2b3/jjsg5+FsYPf"
Date: Wed, 25 Apr 2007 19:42:14 -0400
Message-Id: <1177544534.3999.22.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-onnRI2b3/jjsg5+FsYPf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-04-25 at 17:58 -0400, Karl MacMillan wrote:
> Add the objset data structure to libsepol. Object sets behave similarly t=
o
> Python sets.

 Umm, From: http://docs.python.org/lib/types-set.html

        A set object is an unordered collection of immutable values.

...AIUI this will be an ordered collection of mutable values, though
documented to maybe be unordered at some point?

> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> ---
>=20
>  libsepol/include/sepol/objset.h |  169 +++++++++++++++++++++++++++++++++=
++++++
>  libsepol/src/objset.c           |  154 +++++++++++++++++++++++++++++++++=
+++

 One thing I thought when reviewing Josh's mamoth patch is that it might
be nice for review to post the unit tests seperately and mark them
clearly. Just a thought.

> diff --git a/libsepol/src/objset.c b/libsepol/src/objset.c
> new file mode 100644
> index 0000000..7b86e6b
> --- /dev/null
> +++ b/libsepol/src/objset.c
> @@ -0,0 +1,154 @@
> +struct sepol_objset
> +{
> +	struct sepol_list *objs;
> +	sepol_objset_cmp_t cmp;
> +	unsigned int len;
> +	char compliment;
> +};
> +
> +int sepol_objset_create(struct sepol_handle *h, struct sepol_objset **se=
t,
> +			sepol_objset_cmp_t cmp)
> +{
> +	int ret;
> +
> +	*set =3D calloc(1, sizeof(struct sepol_objset));
> +	if (*set =3D=3D NULL)
> +		return SEPOL_ENOMEM;
> +
> +	(*set)->cmp =3D cmp;
> +
> +	ret =3D sepol_list_create(h, &(*set)->objs);
> +	if (ret < 0) {
> +		free(set);

 This should be free(*set).

> +		return ret;
> +	}
> +=09
> +	return SEPOL_OK;
> +}
> +
> +int sepol_objset_add(struct sepol_handle *h, struct sepol_objset *s, voi=
d *obj)
> +{
> +	int ret, ret2, cmp;
> +	struct sepol_iter *iter;
> +	void *cur;
> +
> +	ret =3D sepol_iter_create(h, &iter);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D sepol_list_begin(h, s->objs, iter);
> +	sepol_foreach(h, ret, cur, iter) {
> +		cmp =3D s->cmp(s, cur, obj);
> +		if (cmp =3D=3D 0) {
> +			ret =3D SEPOL_EEXIST;
> +			goto out;
> +		} else if (cmp > 0) {
> +			ret =3D sepol_list_insert(h, s->objs, iter, obj);
> +			goto out;
> +		}

 This implies an ordering, so you can't for Eg. add some elements and
then change the cmp function.

> +	}
> +	if (ret !=3D SEPOL_ITERSTOP) {
> +		ERR(h, "iteration ended abnormally");
> +		goto out;
> +	}
> +	ret =3D sepol_list_append(h, s->objs, obj);
> +out:
> +	ret2 =3D sepol_iter_free(h, iter);
> +	if (ret2 !=3D SEPOL_OK) {
> +		ERR(h, "error freeing iterator");
> +		return ret2;
> +	}

 I think it's much more likely that you want to know ret and not ret2
here, if ret=3D=3DSEPOL_EEXIST etc.

> +	return ret;
> +}
> +
> +int sepol_objset_del(struct sepol_handle *h, struct sepol_objset *s, voi=
d *obj)
> +{
> +	int ret, ret2, cmp;
> +	struct sepol_iter *iter;
> +	void *cur;
> +
> +	ret =3D sepol_iter_create(h, &iter);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D sepol_list_begin(h, s->objs, iter);
> +	sepol_foreach(h, ret, cur, iter) {
> +		cmp =3D s->cmp(s, cur, obj);
> +		if (cmp =3D=3D 0) {
> +			ret =3D sepol_list_del(h, s->objs, iter);
> +			goto out;
> +		}
> +	}
> +	if (ret =3D=3D SEPOL_ITERSTOP)
> +		ret =3D SEPOL_ENOENT;

 You aren't using the ordering here, why is that?

> +	=09
> +out:
> +	ret2 =3D sepol_iter_free(h, iter);
> +	if (ret2 !=3D SEPOL_OK)
> +		return ret2;

 Dito. Also no ERR() call?

> +	return ret;=09
> +}
> +void sepol_objset_set_compliment(struct sepol_objset *s, char compliment=
)
> +{
> +	s->compliment =3D compliment;
> +}
> +
> +char sepol_objset_get_compliement(struct sepol_objset *s)
> +{
> +	return s->compliment;
> +}

 Spillink not soo god?;)

 Also if you are going to add these, I think you want at least
sepol_objset_contains_obj() which does the right thing.

--=20
James Antill <jantill@redhat.com>

--=-onnRI2b3/jjsg5+FsYPf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGL+dV11eXTEMrxtQRAn/iAKCzqiE/7wkCNaw/Ee/vjlbsiNXaWwCgqSMx
J31bINuJEN5fr62zY8jVIz4=
=ijoJ
-----END PGP SIGNATURE-----

--=-onnRI2b3/jjsg5+FsYPf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
