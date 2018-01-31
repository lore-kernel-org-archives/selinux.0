Date: Wed, 31 Jan 2018 12:43:01 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <20180131114301.GB13531@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
 <20180124092736.8432-7-marcus.folkesson@gmail.com>
 <CAJfZ7=miK6rQxdVSNQjx0hBYcCDt4a00+dWCYCGJXo1_C=naEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
In-Reply-To: <CAJfZ7=miK6rQxdVSNQjx0hBYcCDt4a00+dWCYCGJXo1_C=naEA@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] mcstrans: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 10:48:29PM +0100, Nicolas Iooss wrote:
> On Wed, Jan 24, 2018 at 10:27 AM, Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  mcstrans/man/Makefile   |  3 ++-
> >  mcstrans/src/Makefile   | 18 ++++++++++++------
> >  mcstrans/utils/Makefile | 22 ++++++++++++++++------
> >  3 files changed, 30 insertions(+), 13 deletions(-)
> >
> > diff --git a/mcstrans/man/Makefile b/mcstrans/man/Makefile
> > index 8e971192..5030fa81 100644
> > --- a/mcstrans/man/Makefile
> > +++ b/mcstrans/man/Makefile
> > @@ -1,5 +1,6 @@
> >  # Installation directories.
> > -MAN8DIR ?=3D $(DESTDIR)/usr/share/man/man8
> > +PREFIX ?=3D /usr
> > +MAN8DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man8
> >
> >  all:
> >
> > diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
> > index 3f4a89c3..8a8743f1 100644
> > --- a/mcstrans/src/Makefile
> > +++ b/mcstrans/src/Makefile
> > @@ -1,10 +1,16 @@
> >  # Installation directories.
> > -PREFIX ?=3D $(DESTDIR)/usr
> > -LIBDIR ?=3D $(PREFIX)/lib
> > +PREFIX ?=3D /usr
> > +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> >  SBINDIR ?=3D $(DESTDIR)/sbin
> >  INITDIR ?=3D $(DESTDIR)/etc/rc.d/init.d
> > -SYSTEMDDIR ?=3D $(DESTDIR)/usr/lib/systemd
> > -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> > +SYSTEMDDIR ?=3D $(DESTDIR)$(PREFIX)/lib/systemd
> > +
> > +# If no specific libsepol.a is specified, fall back on LDFLAGS search =
path
> > +# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
> > +# is no need to define a value for LDLIBS_LIBSEPOLA
> > +ifeq ($(LIBSEPOLA),)
> > +        LDLIBS_LIBSEPOLA :=3D -l:libsepol.a
> > +endif
> >
> >  PROG_SRC=3Dmcstrans.c  mcscolor.c  mcstransd.c  mls_level.c
> >  PROG_OBJS=3D $(patsubst %.c,%.o,$(PROG_SRC))
> > @@ -15,8 +21,8 @@ override CFLAGS +=3D -D_GNU_SOURCE -D_FILE_OFFSET_BIT=
S=3D64
> >
> >  all: $(PROG)
> >
> > -$(PROG): $(PROG_OBJS)
> > -       $(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBSEPO=
LA)
> > +$(PROG): $(PROG_OBJS) $(LIBSEPOLA)
> > +       $(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LDLIBS_=
LIBSEPOLA)
> >
> >  %.o:  %.c
> >         $(CC) $(CFLAGS) -fPIE -c -o $@ $<
> > diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
> > index 4d3cbfcb..9d740617 100644
> > --- a/mcstrans/utils/Makefile
> > +++ b/mcstrans/utils/Makefile
> > @@ -1,18 +1,28 @@
> >  # Installation directories.
> > -PREFIX ?=3D $(DESTDIR)/usr
> > -LIBDIR ?=3D $(PREFIX)/lib
> > -SBINDIR ?=3D $(PREFIX)/sbin
> > -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> > +PREFIX ?=3D /usr
> > +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
> > +SBINDIR ?=3D $(DESTDIR)$(PREFIX)/sbin
> >
> >  CFLAGS ?=3D -Wall
> >  override CFLAGS +=3D -I../src -D_GNU_SOURCE
> >  override LDLIBS +=3D -lselinux -lpcre
> >
> > -TARGETS=3D$(patsubst %.c,%,$(sort $(wildcard *.c)))
> > +TARGETS=3Dtranscon untranscon
> > +
> > +# If no specific libsepol.a is specified, fall back on LDFLAGS search =
path
> > +# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
> > +# is no need to define a value for LDLIBS_LIBSEPOLA
> > +ifeq ($(LIBSEPOLA),)
> > +        LDLIBS_LIBSEPOLA :=3D -l:libsepol.a
> > +endif
> >
> >  all: $(TARGETS)
> >
> > -$(TARGETS): ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
> > +transcon: transcon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
> > +       $(CC) $(CFLAGS) -o $@ $^ -lpcre -lselinux $(LDLIBS_LIBSEPOLA)
> > +
> > +untranscon: untranscon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEP=
OLA)
> > +       $(CC) $(CFLAGS) -o $@ $^ -lpcre -lselinux $(LDLIBS_LIBSEPOLA)
>=20
> These new rules for transcon and untranscon use CFLAGS instead of
> LDFLAGS, which breaks building with a defined DESTDIR, as the linker
> fails to find libselinux.so (option -L$(LIBDIR) is then missing).

Will change to LDFLAGS.
>=20
> Moreover, the Makefile in mcstrans/utils actually uses the implicit
> rule of linking a program [1]: $(CC) $(LDFLAGS) n.o $(LOADLIBES)
> $(LDLIBS). This is why there is "override LDLIBS +=3D -lselinux -lpcre"
> beforehand in the file. Now that the linking rules are made explicit
> (which I like better, IMHO), this now-useless statement could be
> removed.


I will remove the overriding
>=20
> Best,
> Nicolas
>=20
> [1] Part "Linking a single object file" of Make documentation:
> https://www.gnu.org/software/make/manual/make.html#Catalogue-of-Rules


Thanks,
Marcus

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpxq8AACgkQiIBOb1ld
UjIB3hAAiJGtcb/jb8bi4dW/cLjhvGwSLfTc/SwZMPLNiUqeGOHe5tlMCBOLDjc2
365+Vj8HdE3Z+qnMHRsP4HiY/Yv5Q1FuTxuOzhnOnh7ZXIvP0CCAAopFtcqMMQdC
YlOgMCyE6HYaPHmNO/7thnhUz+9g+46VQ3XxshH6FkOefuE0a22lTlUaElw/CQCP
dEsqSVO/cEHlTVGKQHMadMJ6XlYbVPz1eOc5WixvzomY7XuPHR1pmU+EQeTid6Db
PvsJsE6Dxlcne27WJRrXOHhgpSCMeNA/7WqV5cpFMpICp67Mw6Vb+SelPLyP9MbJ
xwZ9CENWPwLWFEBi328v/275ffV83e4qIAI5sOIH85xm8cWFgFxdMGKIyoitaAo4
rjH+1jdA6Y51IUtMm49ClbWJJjLPpzNO4CJYNUNKyEwZNDszppsVhguCOmqMMkRS
a79iVtc8F37a86nsliGMKJR9H8LHD/8wWQ/eVNN3VCOIEbWtegrfl+mxEmhQlDzn
2USfELx761bDWXFGh3HSxJU9ZpJJxS25nKo0wD+Bg+FUqkap5MCd0bsXIXeqCv3+
mFYSdOzT4w8+p7RuSvl+5alSs4Y/BP7gaRfLiaix/ufnM5LDdlnvqFmdio8DMiZp
3YQN7aF+VWLzFvSs24zVjU/I/imOGNKngRLf+sQw6O/GS5yVTwM=
=ingi
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
