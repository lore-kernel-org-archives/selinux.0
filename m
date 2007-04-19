Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3J4lMg0027264
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 00:47:22 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3J4lLvY003462
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 04:47:22 GMT
Subject: Re: [PATCH - policyrep] add objpool to libsepol
From: James Antill <jantill@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1176947838.20763.4.camel@localhost.localdomain>
References: <1176947838.20763.4.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6Q9M55FCzNYsmrzvwg92"
Date: Thu, 19 Apr 2007 00:47:19 -0400
Message-Id: <1176958040.19144.70.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-6Q9M55FCzNYsmrzvwg92
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-04-18 at 21:57 -0400, Karl MacMillan wrote:
> Add a reference counted object pool data structure to libsepol. Object
> pools allow the storage of reference counted pools of objects. This
> allows, for example, for many data structures to reference a single copy
> of an object (e.g., a string).

 As a general observation this makes me want to cry for the silent death
of a common C string ADT. But everyone has to reinvent their own so...

> +int sepol_objpool_free(struct sepol_handle *h, struct sepol_objpool *s)

 If this is going to be used a lot having only a single "destroy"
function that also silently unref's everything it's managing seems
"bad".
 One obvious problem this causes is that if sepol_objpool_free() returns
in error you don't know if it's from the iter create (everything fine,
try again) or from the sepol_iter_free (everything free'd already ...
you are totally screwed). Luckily sepol_iter_free can't ever do that.

> +int sepol_objpool_add(struct sepol_handle *h, struct sepol_objpool *s, v=
oid **obj)

 One minor point here is that while (char *) can change to (void *),
(char **) cannot change to (void **), legally. see:

http://c-faq.com/ptrs/genericpp.html

...having a real string ADT would do the right thing (cough) ... ok I'll
shutup now.

> +{
> +	int ret;
> +	hashtab_ptr_t cur;
> +	unsigned int *refcount;
> +
> +	refcount =3D malloc(sizeof(unsigned int));
> +	if (refcount =3D=3D NULL)
> +		return SEPOL_ENOMEM;
> +	*refcount =3D 1;
> +
> +	ret =3D hashtab_insert2(s->objs, *obj, refcount, &cur);

 hashtab_insert2() seems like a hack based on the fact you can't use the
result of hashtab_search().

> +	if (ret =3D=3D SEPOL_OK) {

 This doesn't copy "*obj" and so assumes s->obj_free is used to free the
input.

> +		return 0;
> +	} else if (ret =3D=3D SEPOL_EEXIST) {
> +		free(refcount);
> +		s->obj_free(*obj);
> +		*obj =3D cur->key;
> +		refcount =3D cur->datum;
> +		*refcount +=3D 1;
> +		return 0;

 This also assumes s->obj_free is the correct thing to use for the
input.

> +	} else {
> +		free(refcount);
> +		return ret;
> +	}
> +}
[...]
> +int sepol_objpool_del(struct sepol_handle *h, struct sepol_objpool *s, v=
oid *obj)
> +{
> +	int ret;
> +	unsigned int *refcount;
> +=09
> +	refcount =3D hashtab_search(s->objs, obj);
> +	if (refcount =3D=3D NULL)
> +		return SEPOL_ENOENT;
> +=09
> +	(*refcount)--;
> +	if (*refcount =3D=3D 0) {
> +		ret =3D hashtab_remove(s->objs, obj,
> +				     sepol_objpool_hashtab_free, s);
> +		if (ret !=3D SEPOL_OK)
> +			return ret;
> +	}

 The only thing hashtab_remove() returns, apart from _OK, is _ENOENT ...
which would mean it could be unref'd or not ... if hashtab_remove()
could return it in this codepath.
 Also if you fixed the hashtab_search followed by hashtab_insert
problem, then this codepath could also benefit in the same way (or maybe
just have hashtab_remove2 ;).

--=20
James Antill <jantill@redhat.com>

--=-6Q9M55FCzNYsmrzvwg92
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGJvRX11eXTEMrxtQRAnS9AKC0V7M/1mvFkQPFq3S+GgBw2XxcvQCggsxe
Oq9YWZyRye6Lsim4U9wv4Kc=
=WI4k
-----END PGP SIGNATURE-----

--=-6Q9M55FCzNYsmrzvwg92--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
