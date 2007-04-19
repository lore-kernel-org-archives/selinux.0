Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JGwHwm003252
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 12:58:17 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JGwCrk001807
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 16:58:13 GMT
Subject: Re: [PATCH - policyrep] add objpool to libsepol
From: James Antill <jantill@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1176999086.13683.46.camel@localhost.localdomain>
References: <1176947838.20763.4.camel@localhost.localdomain>
	 <1176958040.19144.70.camel@code.and.org>
	 <1176996925.13683.29.camel@localhost.localdomain>
	 <1176998244.19144.87.camel@code.and.org>
	 <1176999086.13683.46.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IpaVpq5Yw3BK1XxSU4HT"
Date: Thu, 19 Apr 2007 12:58:01 -0400
Message-Id: <1177001881.19144.103.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-IpaVpq5Yw3BK1XxSU4HT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-19 at 12:11 -0400, Karl MacMillan wrote:
> On Thu, 2007-04-19 at 11:57 -0400, James Antill wrote:

> >  I guess I just wonder why have the s->obj_free member at all, esp.
> > given the examples used with strdup() ... I kind of assumed you expecte=
d
> > input from strdup(), given the examples, and so was confused about the
> > non-useage of free().
>=20
> Ahh - but the objects can be arbitrary, so they might be structs that
> need something more than free.
>=20
> >  It also just seems wrong to have the member free function used for
> > input ... but if you have a use case feel free to ignore me :).
>=20
> Well, the model I was thinking was that the caller was giving ownership
> of the object to the pool. The advantage is that the caller simply calls
> add and doesn't have to check return codes to see if their copy of the
> object should be freed.

 Well it needs to check for errors, and do something different then.

>  Otherwise the caller would conditionally free
> the object depending on whether another copy already existed. Object
> deletion would have the same problem.

 Yeh, I understand ... it feels kind of wrong to be mixing layers. Ie.
conceptually you seem to have:

struct higher_layer {
  void *(*make)(void); /* allocate */
  struct lower_layer {
    void (*free)(void *); /* deallocate */
  } lower;
};

...which I don't see often, and so assumed was wrong ... but it works,
you obviously meant to do it, and I can't see a quick way to split the
layers without downsides.

--=20
James Antill <jantill@redhat.com>

--=-IpaVpq5Yw3BK1XxSU4HT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGJ5+Z11eXTEMrxtQRAvmJAJ0fspGrKm6LSt/lmSiiPIpGQiNudgCgqYgG
J12JFCNWuemzfajwMsEbvUk=
=NYmX
-----END PGP SIGNATURE-----

--=-IpaVpq5Yw3BK1XxSU4HT--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
