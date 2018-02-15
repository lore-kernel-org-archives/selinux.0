Date: Thu, 15 Feb 2018 14:04:55 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Message-ID: <20180215130455.GA20477@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
 <CAJfZ7=kT4VRgWzoQMyehL=a4qGNGGcNPqiUcw6523zVH9R+JHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
In-Reply-To: <CAJfZ7=kT4VRgWzoQMyehL=a4qGNGGcNPqiUcw6523zVH9R+JHA@mail.gmail.com>
Subject: Re: Rework of makefiles v5
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

First of all, thank you for your review.

On Wed, Feb 14, 2018 at 08:19:44PM +0100, Nicolas Iooss wrote:
> On Wed, Feb 14, 2018 at 10:57 AM, Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> > I have updated the patchset.
> >
> > The biggest change is that $(DESTDIR) is now used in the
> > install stage only.
> >
> > Also some overidden CFLAGS/LDFLAGS has been removed since we now have
> > explicit build rules.
> >
> > I have moved the changelog into patches.
> >
> > Please test to compile with:
> > make DESTDIR=3D/tmp/myroot PREFIX=3D/myusr install
> > or
> > make DESTDIR=3D/tmp/myroot install
> >
> > Thanks for all feedback.
> >
> > Best regards
> > Marcus Folkesson
> >
>=20
> Hi,
> Thanks for this update! Here are three comments on this patchset:
>=20
> * you forgot a $(DESTDIR) occurrence in patch 7.

Good catch!

> * .travis.yml needs a simple patch to fix the value of PYSITEDIR. I
> will send it later.

Please do.

> * While reading the Makefile after patch 15, I have been surprised by
> "LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib", with DESTDIR. As this variable is
> not exported, it works fine as it is, but it might be cleaner to
> define it as "LIBDIR ?=3D $(PREFIX)/lib" and to use $(DESTDIR) in the
> following lines. This point may be addressed in a follow-up commit
> after the patchset has been merged.

I agree.
I also think it could be part of a follow-up commit. I will take a note.

>=20
> As the patchset looks almost ready to be merged, I have created
> https://github.com/SELinuxProject/selinux/pull/79 with a modified
> patch 7 and my patch for .travis.yml. This pull request holds the
> commits I plan to apply in a few days if no other maintainer disagrees
> with this.

Ok, then I will not come up with a v6 that fixes your feedback for patch
#7.

>=20
> Best,
> Nicolas
>=20

Best regards
Marcus Folkesson

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqFhXMACgkQiIBOb1ld
UjJ4wRAA0SOTgHUfiH2FsIEIxQ70tMSnQEsRj9iZnN8jlvghdwuhU1kdAL4s4Pvb
yIWzZfFUCWyvw5xytY80YERuJ+8WqaJlZLXQ7N1DOAL4pOMOqtjPjKPZowZfthbu
BvxdUGKWoxdlCjEUsPsR006tAmdoECkUTZJkrf11xxwGCbI5Xrx+PnqNyWV3Dyml
FKwNFJuA2OskAg8E2dndzkI3KSOTcAHKgu5wwG8TrmDebrOIKu5n9+5M1MCnTCqe
A3xTr6A7VQpbBQjsDBHHl50uHv0Tyf0c/WBHg0AYsFlJaNTxiGHPY5MZgMP+HamA
ynmFsCwj6ARuyAav0XOdE9GZsvKnPKo5v0VMKQthBJ1u5sECIFcR/2bgUPAPgkXh
nrncUCeXLmqYl1vs264LQZ+INmnjfC7tJxvYTZ6VjpM7J6Etg4B9Q1ZFjRrg+Pzv
ZxCF8wZvN5xffVo6fMxWcLUx92n2I8YjbNcoc7SPpdB7PgFKzCQDTsrAY/fmBQUg
nvatvkvla1ww123j8w/YmeeciAHeB4rSacTD4BzQvoHGQAYZ8PPBG7mytpZSZD7q
BA4wBcZfD3H/vQsOusCx8htGtRkB4QoNMSHHQH3AvTlXQxPa9FjSjKtntJpX3z8M
DMN3Z5OtMQgTJqKwSq2QIQMriwuk5mrfPWy3vJ1Q/KWE6Cm13iU=
=830x
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
