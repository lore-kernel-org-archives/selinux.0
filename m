Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JG1245031235
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 12:01:02 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JG109K018910
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 16:01:00 GMT
Subject: Re: [PATCH - policyrep] add objpool to libsepol
From: James Antill <jantill@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1176996925.13683.29.camel@localhost.localdomain>
References: <1176947838.20763.4.camel@localhost.localdomain>
	 <1176958040.19144.70.camel@code.and.org>
	 <1176996925.13683.29.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BFHZDE22nTXJK4r0rPWI"
Date: Thu, 19 Apr 2007 11:57:24 -0400
Message-Id: <1176998244.19144.87.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BFHZDE22nTXJK4r0rPWI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-19 at 11:35 -0400, Karl MacMillan wrote:
> On Thu, 2007-04-19 at 00:47 -0400, James Antill wrote:
> > On Wed, 2007-04-18 at 21:57 -0400, Karl MacMillan wrote:
> > > +int sepol_objpool_free(struct sepol_handle *h, struct sepol_objpool =
*s)
> >=20
> >  If this is going to be used a lot having only a single "destroy"
> > function that also silently unref's everything it's managing seems
> > "bad".
>=20
> I'm only intending to use this in the new policyrep where the lifetime
> of the object pool will be tied to the lifetime of the policy tree. I
> could add a destroy function that just destroys the pool though. I'd
> likely need to add a way to iterate over all of the objects in the pool
> to make this generally useful.

 So, sepol_objpool_del() will never be called? If so it seems better to
have it work like an APR memory pool or obstack etc. where you allocate
a bunch of small objects but only remove the entire thing once.

> > > +	if (ret =3D=3D SEPOL_OK) {
> >=20
> >  This doesn't copy "*obj" and so assumes s->obj_free is used to free th=
e
> > input.
>=20
> Yes.
>=20
> > > +		return 0;
> > > +	} else if (ret =3D=3D SEPOL_EEXIST) {
> > > +		free(refcount);
> > > +		s->obj_free(*obj);
> > > +		*obj =3D cur->key;
> > > +		refcount =3D cur->datum;
> > > +		*refcount +=3D 1;
> > > +		return 0;
> >=20
> >  This also assumes s->obj_free is the correct thing to use for the
> > input.
>=20
> Yes - that is intentional to avoid additional copying. Are you pointing
> out a problem, or just suggesting the constraint needs documentation?

 I guess I just wonder why have the s->obj_free member at all, esp.
given the examples used with strdup() ... I kind of assumed you expected
input from strdup(), given the examples, and so was confused about the
non-useage of free().
 It also just seems wrong to have the member free function used for
input ... but if you have a use case feel free to ignore me :).

> > > +	} else {
> > > +		free(refcount);
> > > +		return ret;
> > > +	}
> > > +}
> > [...]
> > > +int sepol_objpool_del(struct sepol_handle *h, struct sepol_objpool *=
s, void *obj)
> > > +{
> > > +	int ret;
> > > +	unsigned int *refcount;
> > > +=09
> > > +	refcount =3D hashtab_search(s->objs, obj);
> > > +	if (refcount =3D=3D NULL)
> > > +		return SEPOL_ENOENT;
> > > +=09
> > > +	(*refcount)--;
> > > +	if (*refcount =3D=3D 0) {
> > > +		ret =3D hashtab_remove(s->objs, obj,
> > > +				     sepol_objpool_hashtab_free, s);
> > > +		if (ret !=3D SEPOL_OK)
> > > +			return ret;
> > > +	}
> >=20
> >  The only thing hashtab_remove() returns, apart from _OK, is _ENOENT ..=
.
> > which would mean it could be unref'd or not ... if hashtab_remove()
> > could return it in this codepath.
>=20
> Not certain what you mean. Generally, these APIs aren't thread safe so I
> assume that the remove will succeed here. The error checking is for
> future changes in the hashtab implementation.

 Sorry, bad English on my part. My point was that I don't see how
hashtab_remove() could ever return in error here (as you've already made
sure it is there) ... and even if it ever did return in error at some
future point, you are leaking a reference count (*refcount =3D=3D 0, but
there is still one reference in the hashtab).

--=20
James Antill <jantill@redhat.com>

--=-BFHZDE22nTXJK4r0rPWI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGJ5Fj11eXTEMrxtQRAuX6AKCNZ/c24EIGZmbQV3hOzhjMbD4rWgCfYkIE
KNCFYNluXvObiPFJ/yMctYc=
=mgdi
-----END PGP SIGNATURE-----

--=-BFHZDE22nTXJK4r0rPWI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
