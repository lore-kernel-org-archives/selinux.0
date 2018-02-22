Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1MFWFPh007981
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 10:32:16 -0500
Date: Thu, 22 Feb 2018 16:31:46 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Message-ID: <20180222153145.GB29029@workstation>
References: <20180214095337.1945-1-plautrba@redhat.com>
 <CAJfZ7==9Xj-dXKygmcc2u5o811mA35JUv_9jtaHJu4TPXewB0A@mail.gmail.com>
 <CAJfZ7==fjyC6Uh9CGJ=rqc+uG1MZt08AgPv5PY6V-rx23Dtz3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
In-Reply-To: <CAJfZ7==fjyC6Uh9CGJ=rqc+uG1MZt08AgPv5PY6V-rx23Dtz3w@mail.gmail.com>
Subject: Re: Update selinux-sepolgengui to be compatible with Gtk3, Python 3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2018 at 07:20:02PM +0100, Nicolas Iooss wrote:
> On Sun, Feb 18, 2018 at 7:09 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wr=
ote:
> > On Wed, Feb 14, 2018 at 10:53 AM, Petr Lautrbach <plautrba@redhat.com> =
wrote:
> >> Hi,
> >>
> >> The following set of patches update polgengui.py, rename polgen.glade =
to
> >> polgen.ui, convert it to new format, and fix some other sepolicy Pytho=
n 3
> >> related issues.
> >
> > Hi,
> > I have read and tested these patches and they look good to me.
> (Oops, the mail has been sent before I finished writing it...)
>=20
> In order to run polgengui on my development system which uses a policy
> without MLS, I needed a patch in sepolicy, that I sent a few days ago
> ("[PATCH 1/3] python/sepolicy: Support non-MLS policy"). With this I
> have been able to play with polgengui and have been surprised by a
> warning which appears on my terminal every time I type anything in the
> "name" field of the form in the second tab ("Enter name of application
> or user role:"):
>=20
> polgengui.py:778: Warning: g_value_get_int: assertion
> 'G_VALUE_HOLDS_INT (value)' failed
>   Gtk.main()
>=20
> Have you got such warning on your system? Do you know where this
> warning comes from? For information I use Gtk3 3.22.26 with
> python-gobject 3.26.1.


I see it as well. I'll try to find the problem and sent a patch for that.


>
> Anyway, this looks like a harmless warning. Feel free to add
> "Tested-by: Nicolas Iooss <nicolas.iooss@m4x.org>" to your patches.
>=20

Thanks!
--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlqO4loACgkQviIJHj72
InV6CA//bzslL4dHYaeNxW/Ri+N442hittC8IAligt89cfFUzXL0pcP/GESvPdM1
q9NBAmLX1OB48a7x/2LAAZUOf5iK/NBakvt50jogj/NgqNbwS/SIN5J8dyGQxLni
KHxXGrO5nagPRbXKrMsWLQ2rrv8UPY9HktiMmmGXun7t/Q+gN5AX9mbDIR8GDQEN
5fXDpb0X+9/9MfMg+BIz4bfMjiSj7EXOlqJ9jYloUzb7/syTuEgjmx4LeFkeYiOX
01p3m3iFviH4BVFhss9CAc+B9lYFZNiYnvBV58rVxZrPStaXkwuIapbX5Vf8vOEX
iKx5L2e3n0XpKmcVnJb47KBJNzM/Jr74rDswH/+riuyzdJENfpVZlSOqpeSdC8PX
9i21NXVanQjvrfJzVhDvirl0VefXy0GG1x0cxDhlyE2CNW/JYZhuBV+mJZ/Mmcsi
SSpiYdL0sXwczNbQ2i2ffGgsHYe/hXXoh1/sA5Ma1DU37bg373SiDyFFM0dMDtPr
qI5cGnDOOIYhdC9yWo3mHZgWBUmu6AW1tI6HcAcdpHeGVADNwMjkRWFwYp7XgtGE
AHh3e9Sdrvkqv6v5mZn/b6cU86PSj3kiHNGy+8mBI/MEYaw1IFFJRzWJ5BeiNc7U
R0hGFMy/qIhiQPSy7YsvSk6KGDMk8qSb+f3DK/VV9PWHqGXoYkE=
=8cNA
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
