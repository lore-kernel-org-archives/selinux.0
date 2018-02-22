Date: Thu, 22 Feb 2018 20:19:24 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Message-ID: <20180222191337.GA742@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
 <CAJfZ7=kT4VRgWzoQMyehL=a4qGNGGcNPqiUcw6523zVH9R+JHA@mail.gmail.com>
 <20180215130455.GA20477@gmail.com>
 <CAJfZ7=mTNBzfVd8z-2-Q0Cwo-TfLVF-T9mBS=oZ6OsBW1WDyEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
In-Reply-To: <CAJfZ7=mTNBzfVd8z-2-Q0Cwo-TfLVF-T9mBS=oZ6OsBW1WDyEw@mail.gmail.com>
Subject: Re: Rework of makefiles v5
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 10:46:45PM +0100, Nicolas Iooss wrote:
> On Thu, Feb 15, 2018 at 2:04 PM, Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> > Hi Nicolas,
> >
> > First of all, thank you for your review.
> >
> > On Wed, Feb 14, 2018 at 08:19:44PM +0100, Nicolas Iooss wrote:
> >> On Wed, Feb 14, 2018 at 10:57 AM, Marcus Folkesson
> >> <marcus.folkesson@gmail.com> wrote:
> >> > I have updated the patchset.
> >> >
> >> > The biggest change is that $(DESTDIR) is now used in the
> >> > install stage only.
> >> >
> >> > Also some overidden CFLAGS/LDFLAGS has been removed since we now have
> >> > explicit build rules.
> >> >
> >> > I have moved the changelog into patches.
> >> >
> >> > Please test to compile with:
> >> > make DESTDIR=3D/tmp/myroot PREFIX=3D/myusr install
> >> > or
> >> > make DESTDIR=3D/tmp/myroot install
> >> >
> >> > Thanks for all feedback.
> >> >
> >> > Best regards
> >> > Marcus Folkesson
> >> >
> >>
> >> Hi,
> >> Thanks for this update! Here are three comments on this patchset:
> >>
> >> * you forgot a $(DESTDIR) occurrence in patch 7.
> >
> > Good catch!
> >
> >> * .travis.yml needs a simple patch to fix the value of PYSITEDIR. I
> >> will send it later.
> >
> > Please do.
> >
> >> * While reading the Makefile after patch 15, I have been surprised by
> >> "LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib", with DESTDIR. As this variable =
is
> >> not exported, it works fine as it is, but it might be cleaner to
> >> define it as "LIBDIR ?=3D $(PREFIX)/lib" and to use $(DESTDIR) in the
> >> following lines. This point may be addressed in a follow-up commit
> >> after the patchset has been merged.
> >
> > I agree.
> > I also think it could be part of a follow-up commit. I will take a note.
> >
> >>
> >> As the patchset looks almost ready to be merged, I have created
> >> https://github.com/SELinuxProject/selinux/pull/79 with a modified
> >> patch 7 and my patch for .travis.yml. This pull request holds the
> >> commits I plan to apply in a few days if no other maintainer disagrees
> >> with this.
> >
> > Ok, then I will not come up with a v6 that fixes your feedback for patch
> > #7.
>=20
> I have merged this patchset. Thanks!

Thank you.

Do you know when the next release is planned?
>=20
> Nicolas
>=20

Best regards
Marcus Folkesson



--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqPF7cACgkQiIBOb1ld
UjJ4mw//QkQPMyHK3WDW3EfI3NveEmdw60X4cxX1240j+tFMSPrGiLysHHrteC4j
oaHHInYgqV7dhu50rC6RgFVPPOpVjl743sCmBwPBXiZn7oqq9vHnsgFUHLk3U7C4
7OhijbHQhxdRtibO8bydiLSc5SoyIRZUZPK1Zzqo0e6RO2Rj7LQRdzTGcei7LTpp
asAIS6CK845EYz+IO5bqrjNW82KQH0kj0HdWNw/B/z8y8i32lBUEqrmfMw+cghyz
ho1qN0vXYSy8Nk7XLO6+zNswHrkCLlW5S2QhBGw3kkdlaaAbtzmJdDw2RLBZpXJV
qKaZJQpNQ1nqLa3KcUjKVvuQasc6o/WdQwGiVJS0YXYn02BKwmDC666wQjYNkWKU
7kODbfDdVndTtWlE2X7Sy91c0BNDh4wSdgDdW3uYWhaSV5WunX6Lyg1w8f7jG2oX
6lENQ5nfhwzjACkPy8KzVYq65J2/N4t5QO7Ipb8Y5UdGxYrsaexmMLERy7lAh6T8
ttv4wwHVI0c2JMeSK17BoCX2JDgNLaZRZrUFWsJeZHW+jIrYbKQalDZNmPN2YGNt
l0KRMTkNouwBdmoyuyPfbA6dPbkSbIEkEd8UCF+XSC9l/C4VW+qo/eqlRb7WQCtl
yQaVGgdJ4L4NdqXxZy2vJfYc8LHlYGKqxxohCKQY2/w6QA9iyUs=
=rxAF
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
