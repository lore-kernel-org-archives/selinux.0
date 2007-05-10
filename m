Subject: Re: [RFC][PATCH] libselinux: Namespacing
From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1178827922.3504.141.camel@moss-spartans.epoch.ncsc.mil>
References: <1178827922.3504.141.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Fm9hmiKFa7gLitQ+agQc"
Date: Thu, 10 May 2007 18:12:34 -0400
Message-Id: <1178835154.12294.151.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Fm9hmiKFa7gLitQ+agQc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-05-10 at 16:12 -0400, Stephen Smalley wrote:
> libselinux presently lacks proper namespacing of its functions.  This
> patch is just for comment on an approach to gradually fixing that
> problem, starting with just a trivial example for a single function.
> The idea is to switch over the real function to being properly
> namespaced, provide an alias under the old name in the symbol table for
> binary compatibility, and make the old name a macro in the public
> headers that expands to the new name so that source rebuilds against the
> new library will start using the new name.  Then at some point in the
> future, we drop the old name macro from the source API, forcing an
> update to external sources to build against newer headers, while leaving
> the alias present in the symbol table as long as we need compatibility
> with existing binaries.  Thoughts?

 The one thing I'd suggest is having some kind of compiler switch we can
use before we turn it off. For instance something like...


#ifndef SELINUX_COMPAT_API
#define SELINUX_COMPAT_API 1
#endif

#if SELINUX_COMPAT_API

/* ... */
#define freecon(x) selinux_freecon(x)
#endif

...then we can move certain packages over immediately, and do "#define
SELINUX_COMPAT_API 0" in them ... and also change the default at some
point, but allow people to still access the compat. macros for a short
time.

 Also we really want to have some perl/whatever that goes through the
public API looking for symbols ... so we only have to do it once.

--=20
James Antill <jantill@redhat.com>

--=-Fm9hmiKFa7gLitQ+agQc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGQ5jR11eXTEMrxtQRAnI9AJ40ffo8xSR+3dckdqoJ0f4WmHBFNgCgka8x
pPdf6fYw4rAGQNy4RkENWJ4=
=FtzL
-----END PGP SIGNATURE-----

--=-Fm9hmiKFa7gLitQ+agQc--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
