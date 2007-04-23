Subject: Re: [POLICYREP PATCH] Add generic iterators and a list data type
	to	libsepol
From: James Antill <jantill@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1177343326.26236.18.camel@localhost.localdomain>
References: <20070420133430.9884.86379.stgit@localhost.localdomain>
	 <46291A98.2040003@tycho.nsa.gov>
	 <1177343326.26236.18.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-swHp0qySuXjvPcCcvLQm"
Date: Mon, 23 Apr 2007 12:28:08 -0400
Message-Id: <1177345688.20127.9.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-swHp0qySuXjvPcCcvLQm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-23 at 11:48 -0400, Karl MacMillan wrote:

> Glib, on the other hand, would provide everything that we need. In fact,
> gobject is a perfect fit for the policy object abstraction that I
> created with many advantages (including support for exporting the
> objects to other languages like python).
>=20
> The Pros of using glib:
> * All the data structures that we need.
> * Better tested foundation.
> * Safe string functions.
> * Familiar environment for many developers.
> * Complete object-oriented layer for the policy rep.
> * Easy export to Python and other languages.
> * Our code gets much smaller (libsemanage in particular could shrink if
> we used glib).
>=20
> The Cons:
> * Large dependency.
> * Potential security issues in glib (not certain this is a real issue,
> but glib is fairly big).
> * Glib tends to be slightly verbose and boilerplate heavy.

 I'm pretty sure glib is used in a few security relevant places, so I
doubt that's a problem. The "dependency" argument just seems like normal
C programmer twitchyness ... glib is at least as portable as what we'd
use it in and is included in pretty much every distro.

 The only real problem I've ever had with glib is that calling g_new()
calls abort() on failure (and by extension so does everything that
allocates in glib).
 This also tends to mean that glib code allocates much more freely than
normal C code. But if you can swallow the allocation death pill, it's
hard to argue against glib ... IMO.

--=20
James Antill <jantill@redhat.com>

--=-swHp0qySuXjvPcCcvLQm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGLN6Y11eXTEMrxtQRAphjAKCc8BKajKbXsJ8pNGJt45iGfvxkwgCgvVts
Ualm+CN1DvQe7HdlweQamuc=
=Hs97
-----END PGP SIGNATURE-----

--=-swHp0qySuXjvPcCcvLQm--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
