Date: Wed, 31 Jan 2018 12:58:20 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <20180131115820.GC13531@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
 <20180124092736.8432-5-marcus.folkesson@gmail.com>
 <CAJfZ7=mZe7P10+akti9yvm+T9X8rb9Hd8PG2n14WOjefSZbJYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
In-Reply-To: <CAJfZ7=mZe7P10+akti9yvm+T9X8rb9Hd8PG2n14WOjefSZbJYQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] checkpolicy: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 11:04:10PM +0100, Nicolas Iooss wrote:
> On Wed, Jan 24, 2018 at 10:27 AM, Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> > This patch solves the following issues:
> > - DESTDIR is needed during compile time to compute library
> >   and header paths which it should not.
> > - Installing with both DESTDIR and PREFIX set gives us odd paths
> > - Make usage of DESTDIR and PREFIX more standard
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  checkpolicy/Makefile      | 19 +++++++++++++------
> >  checkpolicy/test/Makefile | 17 ++++++++++++-----
> >  2 files changed, 25 insertions(+), 11 deletions(-)
> >
> > diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> > index 68e11f2a..9a55b968 100644
> > --- a/checkpolicy/Makefile
> > +++ b/checkpolicy/Makefile
> > @@ -1,12 +1,10 @@
> >  #
> >  # Makefile for building the checkpolicy program
> >  #
> > -PREFIX ?=3D $(DESTDIR)/usr
> > -BINDIR ?=3D $(PREFIX)/bin
> > -MANDIR ?=3D $(PREFIX)/share/man
> > -LIBDIR ?=3D $(PREFIX)/lib
> > -INCLUDEDIR ?=3D $(PREFIX)/include
> > -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> > +PREFIX ?=3D /usr
> > +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> > +MANDIR ?=3D $(DESTDIR)$(PREFIX)/share/man
> > +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> >  TARGETS =3D checkpolicy checkmodule
> >
> >  LEX =3D flex
> > @@ -14,6 +12,13 @@ YACC =3D bison -y
> >
> >  CFLAGS ?=3D -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
> >
> > +# If no specific libsepol.a is specified, fall back on LDFLAGS search =
path
> > +# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
> > +# is no need to define a value for LDLIBS_LIBSEPOLA
> > +ifeq ($(LIBSEPOLA),)
> > +        LDLIBS_LIBSEPOLA :=3D -l:libsepol.a
> > +endif
> > +
> >  override CFLAGS +=3D -I.

I will remove this override as well.

> >
> >  CHECKOBJS =3D y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o \
> > @@ -27,8 +32,10 @@ all:  $(TARGETS)
> >         $(MAKE) -C test
> >
> >  checkpolicy: $(CHECKPOLOBJS) $(LIBSEPOLA)
> > +       $(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
> >
> >  checkmodule: $(CHECKMODOBJS) $(LIBSEPOLA)
> > +       $(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
>=20
> Please do not introduce $(CFLAGS) in linking rules (if I remember
> correctly, clang reports warnings when using some compile-time-only
> options at link time, which breaks the build when using -Werror). The
> rules for checkpolicy and checkmodule should be:
> $(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)

Will do, thanks

>=20
> >  %.o: %.c
> >         $(CC) $(CFLAGS) -o $@ -c $<
> > diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
> > index 59fa4460..094e7ee2 100644
> > --- a/checkpolicy/test/Makefile
> > +++ b/checkpolicy/test/Makefile
> > @@ -1,19 +1,26 @@
> >  #
> >  # Makefile for building the dispol program
> >  #
> > -PREFIX ?=3D $(DESTDIR)/usr
> > -BINDIR ?=3D $(PREFIX)/bin
> > -LIBDIR ?=3D $(PREFIX)/lib
> > -INCLUDEDIR ?=3D $(PREFIX)/include
> > -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> > +PREFIX ?=3D /usr
> > +BINDIR ?=3D $(DESTDIR)$(PREFIX)/bin
> > +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> >
> >  CFLAGS ?=3D -g -Wall -W -Werror -O2 -pipe
> >
> > +# If no specific libsepol.a is specified, fall back on LDFLAGS search =
path
> > +# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
> > +# is no need to define a value for LDLIBS_LIBSEPOLA
> > +ifeq ($(LIBSEPOLA),)
> > +        LDLIBS_LIBSEPOLA :=3D -l:libsepol.a
> > +endif
> > +
> >  all: dispol dismod
> >
> >  dispol: dispol.o $(LIBSEPOLA)
> > +       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
> >
> >  dismod: dismod.o $(LIBSEPOLA)
> > +       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
>=20
> Same comment here. Please remove $(CFLAGS).

Will do, thanks

>=20
> Best regards,
> Nicolas
>=20
> >
> >  clean:
> >         -rm -f dispol dismod *.o
> > --
> > 2.15.1
> >


Best regards
Marcus

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpxr1cACgkQiIBOb1ld
UjL72xAArfdq+5Km4hZXAt3eBGXiF7Tn+0mD1hF1lg3UHV+ySk2xla2mvQhnWSsg
idfNdRkzQv/19+8a5C44LCd54vVc9Cc7J3m1qJUtuO1ueZJg7HnQxUIvXajSLVfx
vtZPRgAMfit9zReu/eU9Z3KiYALguJU02JTNwqWG5jeSjaNSWy6u3H/YauDhRfGc
r0grkgJ2lZOlfbUtrJ5UjPlECc+ucJEhbdvCwXhegHoE1/C9BBELm+ImUk9VJZqj
zWTdDt4q2PmS+dQPi9u9euIOEvEQe2dOAMGxiOM7UeNIgnifb0eKaVh4nebycRqU
R/NmY0CWJt27G1TnaTjk5+VEOveszQuP3gOxk0pWGxqfSyLgYiy8U7CWGoxk9mj5
ibaBIEZgZaEF2Ji1no7qaTAmTGn6ey38+78p2JMQZA/n/lCltnXOYdIvLEpVH/IM
1OanP1W4Cq9pUFNKixJnGMLxrWC6W0ZHgOWmasUSBouMfC/qOJWfCjEpspcoSgZE
E0p2P12kmEx8EDdQjXDxNVAGwEFcKAAlNOHTZGNkju7VjGHkMyx5vNP6MIArIWiD
wjISZqXsO1K22s430Zk2osTbyhGPp/nKqjDLseq49ywkaWVO9gu7RC9Tu/ArBaHc
AQL6tyzyKXfKfsfQlo6ab4j+aJg8v1UNQZDMDVK3JpRGofSRNY4=
=S8RG
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
