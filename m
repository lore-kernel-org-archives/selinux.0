Subject: Re: [POLICYREP PATCH] Add generic iterators and a list data type
	to	libsepol
From: James Antill <jantill@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
In-Reply-To: <1177364151.6398.9.camel@localhost.localdomain>
References: <20070420133430.9884.86379.stgit@localhost.localdomain>
	 <46291A98.2040003@tycho.nsa.gov>
	 <1177343326.26236.18.camel@localhost.localdomain>
	 <1177345688.20127.9.camel@code.and.org>
	 <1177350773.24282.63.camel@moss-spartans.epoch.ncsc.mil>
	 <1177364151.6398.9.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jztC+rNlnqNKsrBoKpkZ"
Date: Mon, 23 Apr 2007 19:33:03 -0400
Message-Id: <1177371183.20127.43.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-jztC+rNlnqNKsrBoKpkZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-23 at 17:35 -0400, Karl MacMillan wrote:
> On Mon, 2007-04-23 at 13:52 -0400, Stephen Smalley wrote:

> >   However, looking around, I see you can
> > replace the allocator virtual table with your own functions and there
> > are g_try_* functions that return NULL rather than calling abort.  But
> > not clear that helps with its own internal usage of g_new.
> >=20
>=20
> This does help internal usage of g_new (verified by code inspection and
> experimentation).

 Errm, What do you mean here? The vtable calls return NULL on failure
_now_ (they just call libc malloc/realloc/free), they only exist so you
can replace them with debugging versions as in g_mem_profile().
 g_new() calls g_malloc() which is defined as calling abort(), via.
g_error(), on allocation failure. Pretty much everything in glib will
break if that changes, for instance g_list_append() calls g_slice_new()
as you add something to the linked list, which calls g_malloc() ... and
g_list_append() has no error path because it knows it can't fail. Dito.
g_hash_table_new_full() on both counts.

>  However, glib includes several custom allocators and
> replacing the allocator vtable did not seem to help there. It might be
> possible to track down all of the allocators and convince them not to
> abort, but there may be problems in the future. We could also try
> catching sigabort but there would be no good way to figure out why the
> abort was delivered. This is really frustrating and is causing people to
> not use glib (the X hackers rejected it over this reason).

 Dealing with the abort() is the simple problem, it's how you then get
out from the call to g_queue_push_fail() when it happens four functions
calls further down the stack ... without dereferencing NULL a few times.

> Any other options (there don't seem to be any obvious ones)? Personally,
> I vote for the C++ STL but that requires a small change to which some
> might object. In summary - C sucks and I'm tired of this 1980s
> programming environment.

 I completely agree, although personally I think C++ sucks more. The
options are pretty sparse, as everyone generally hacks up mediocre
versions of exactly what they need (as everyone is loath to have
externals deps).
 The only other one that comes to mind is NSPR, which is again mostly a
matter of portability with a few other useful things thrown in for good
measure. But I'd be loath to recommend it for libsepol (or much else,
for that matter).
 Of course there are a few million on the internets, of varying quality,
but nothing that's in Fedora that I know of.

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-jztC+rNlnqNKsrBoKpkZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGLUIu11eXTEMrxtQRAorWAJ4kmU0A6Kcd5Pf0E9ub6B+giFoyqACggYff
3tnUKi3+BINorYKy6yA3WP4=
=XIvx
-----END PGP SIGNATURE-----

--=-jztC+rNlnqNKsrBoKpkZ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
