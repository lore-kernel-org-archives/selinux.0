Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1MGxr5h005555
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 11:59:53 -0500
Date: Thu, 22 Feb 2018 17:59:41 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Message-ID: <20180222165940.GC29029@workstation>
References: <20180214095337.1945-1-plautrba@redhat.com>
 <CAJfZ7==9Xj-dXKygmcc2u5o811mA35JUv_9jtaHJu4TPXewB0A@mail.gmail.com>
 <CAJfZ7==fjyC6Uh9CGJ=rqc+uG1MZt08AgPv5PY6V-rx23Dtz3w@mail.gmail.com>
 <20180222153145.GB29029@workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
In-Reply-To: <20180222153145.GB29029@workstation>
Subject: Re: Update selinux-sepolgengui to be compatible with Gtk3, Python 3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 04:31:46PM +0100, Petr Lautrbach wrote:
> On Sun, Feb 18, 2018 at 07:20:02PM +0100, Nicolas Iooss wrote:
> > On Sun, Feb 18, 2018 at 7:09 PM, Nicolas Iooss <nicolas.iooss@m4x.org> =
wrote:
> > > On Wed, Feb 14, 2018 at 10:53 AM, Petr Lautrbach <plautrba@redhat.com=
> wrote:
> > >> Hi,
> > >>
> > >> The following set of patches update polgengui.py, rename polgen.glad=
e to
> > >> polgen.ui, convert it to new format, and fix some other sepolicy Pyt=
hon 3
> > >> related issues.
> > >
> > > Hi,
> > > I have read and tested these patches and they look good to me.
> > (Oops, the mail has been sent before I finished writing it...)
> >=20
> > In order to run polgengui on my development system which uses a policy
> > without MLS, I needed a patch in sepolicy, that I sent a few days ago
> > ("[PATCH 1/3] python/sepolicy: Support non-MLS policy"). With this I
> > have been able to play with polgengui and have been surprised by a
> > warning which appears on my terminal every time I type anything in the
> > "name" field of the form in the second tab ("Enter name of application
> > or user role:"):
> >=20
> > polgengui.py:778: Warning: g_value_get_int: assertion
> > 'G_VALUE_HOLDS_INT (value)' failed
> >   Gtk.main()
> >=20
> > Have you got such warning on your system? Do you know where this
> > warning comes from? For information I use Gtk3 3.22.26 with
> > python-gobject 3.26.1.
>=20
>=20
> I see it as well. I'll try to find the problem and sent a patch for that.

It's caused by line 624 in polgengui.py

624        self.name_entry.connect("insert_text", self.on_name_entry_change=
d)

According to [2][3] it's long term known problem. There's a suggested fix i=
n [1]
but I don't know how to apply it at this moment.

Given that it's not fatal and doesn't have a real impact on the code - you =
can't
insert " " into Name value, I'd leave as it is for now.

[1] https://stackoverflow.com/questions/38815694/gtk-3-position-attribute-o=
n-insert-text-signal-from-gtk-entry-is-always-0
[2] https://bugzilla.gnome.org/show_bug.cgi?id=3D644927
[3] https://gitlab.gnome.org/GNOME/pygobject/issues/12


There's another deprecation warning:

/usr/share/system-config-selinux/polgengui.py:679: PyGIDeprecationWarning: =
Deprecated, please use stop_emission_by_name.
  entry.emit_stop_by_name("insert_text")

which seems to be easy to fix

--- a/gui/polgengui.py
+++ b/gui/polgengui.py
@@ -674,7 +674,7 @@ class childWindow:
=20
     def on_name_entry_changed(self, entry, text, size, position):
         if text.find(" ") >=3D 0:
-            entry.emit_stop_by_name("insert_text")
+            entry.stop_emission_by_name("insert-text")
=20
     def on_focus_out_event(self, entry, third):
         name =3D entry.get_text()


I'll send a patch for that.


> >
> > Anyway, this looks like a harmless warning. Feel free to add
> > "Tested-by: Nicolas Iooss <nicolas.iooss@m4x.org>" to your patches.
> >=20
>=20
> Thanks!



--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlqO9vUACgkQviIJHj72
InUSUg/+PnazjI8Z0IxA4AdAtVFE/xvfZ3vlirqJfDQfYMi7Xoq82/G6YLeOKKYk
3+UKGsJSYKfrNML/u/A6MhfNG6h2GPbOYCJY+zdgEMGiiXcI0kqJNec45MsJnStn
qkMb4UeQDOfDLIU0zDSpU2f/S9wLp2VVEH0Np7RhpWTmKU1LKpZmd7IUO4B25Yx6
IuxfA14mDZauGjy0ELrqbq1yjJjO3UhvTEAcEL8PXUnyIq65wA0NVlS8kDhly1Du
MhE4nbnbCWqkd03LZrFv83h1vCOuzNAhBaYcPdkekchhIjlmWRMJOsfXNV2hNZzF
goDHkisOgHlDY0jthHuke7+uNutxeYUvpzW9JwKFz+I8DBnwvllRZ8dduksZVjsB
lwMolKZ8d9+XFJWnvDvdskit4wXK2+VzU4nI5TAgrfOvzriH6mZ3/5OTFnj08xrn
9Ft7V9oKDdnjRoCE0sMz33nvYNTzmzA/KVaOTyNIP1czSlQ1kNJtVQk4CNNyQw5A
vyKsX5NGYEiGeypvSplRAHQQMMQJDZ4j1xITqDycBYcneYKeKS5zRJAElminCR4T
sxfKPnbtAW4aNgmKjqrj+AJTl1H3x9VItFOQMwG9VEO3I5qHLfDl9DcOblefcr1g
TX0Sxi7Gtu40PhKsixVwm/vdP7NYR1bVc4CBJI38mavGVgdocjc=
=n4kn
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
