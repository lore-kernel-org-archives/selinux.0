Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w12AM5Z6002765
 for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2018 05:22:05 -0500
Date: Fri, 2 Feb 2018 11:21:53 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180202102153.GA28019@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <SELinuxProject/selinux/pull/77@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
In-Reply-To: <SELinuxProject/selinux/pull/77@github.com>
Subject: Re: [SELinuxProject/selinux] gui: remove
 selinux-sepolgengui (#77)
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 01:58:46PM -0800, Nicolas Iooss wrote:
> Hi,
> I sent a few hours ago these two patches on the mailing list, by as the f=
irst one seems to be blocked somewhere (I have only received back the secon=
d one), I am publishing them on Github too, as a Pull Request.
>=20
> These patches removes selinux-sepolgengui because this application is not=
 compatible with Gtk3, Python 3 (it requires PyGTK), etc. and would otherwi=
se require some effort to update it.
> More precisely, even though ``pygi-convert.sh`` updated the code in order=
 to try making the application compatible with Python 3, PyGI... (in commit=
 0f3beeb00e7a42cc2f44ef0392b8a3a7566a17d7), ``polgen.glade`` is still incom=
patible with Gtk-Builder (it would need to be converted). I do not want to =
spend time converting this file when I see that a bug preventing this appli=
cation to launch has been present for more than one year.


> polgengui.py is not compatible with Gtk3, Python 3, etc. Moreover it
> fails to load at least since the release 2.6-rc1:
>=20
> $ python2 /usr/share/system-config-selinux/polgengui.py
> Traceback (most recent call last):
>   File "/usr/share/system-config-selinux/polgengui.py", line 778, in <mod=
ule>
>     app =3D childWindow()
>   File "/usr/share/system-config-selinux/polgengui.py", line 205, in __in=
it__
>     self.all_types =3D sepolicy.generate.get_all_types()
> AttributeError: 'module' object has no attribute 'generate'

This particular problem was fixed in Fedora by=20
https://github.com/fedora-selinux/selinux/commit/ecd050d12cde54f3d7a31029be=
8582223d3d6eba

I must have forgotten to re-send it. Sorry.

> In fact, this bug has been introduced more than a year ago by commit
> b43991f ("policycoreutils: import sepolicy directly"), which
> replaced "from sepolicy import generate" with "import sepolicy" instead
> of "import sepolicy.generate".
>=20
> As no one seems to have noticed, this application seems to be no longer
> used. Remove it from gui/.


I'd like to ask to postpone accepting this patch for another 2
weeks. I'll try to port/convert polgengui.py to be compatible with
Gtk-Builder. I'll come back either with patch or with Ack to drop it.

Thanks,

Petr


> Cheers
> You can view, comment on, or merge this pull request online at:
>=20
>   https://github.com/SELinuxProject/selinux/pull/77
>=20
> -- Commit Summary --
>=20
>   * gui: remove selinux-polgengui application
>   * gui: remove "new" button in Modules page
>=20
> -- File Changes --
>=20
>     M gui/Makefile (5)
>     M gui/modulesPage.py (8)
>     D gui/polgen.glade (2468)
>     D gui/polgengui.py (779)
>     D gui/selinux-polgengui.8 (35)
>     D gui/selinux-polgengui.desktop (66)
>     M gui/system-config-selinux.ui (12)
>=20
> -- Patch Links --
>=20
> https://github.com/SELinuxProject/selinux/pull/77.patch
> https://github.com/SELinuxProject/selinux/pull/77.diff
>=20
> --=20
> You are receiving this because you are subscribed to this thread.
> Reply to this email directly or view it on GitHub:
> https://github.com/SELinuxProject/selinux/pull/77

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlp0O6oACgkQviIJHj72
InVwZg//cs5IFmsYu1Hfdeydbp8U8zEO4NtBf7BkbqIJm6SrMlDGhxaZ/t61x/5k
jLzZds9nRsTXRnxFvxBItHh08mgf/3VYH4F1yq3O1iT4OnSc0I3xb41B+fiMtz9J
Wnu9OocR76tplzF6pc3brHvSvUBCfrjWoDBgkRDM8W24i4FaelQbIUe9QVIYMJ/o
5Y16Gc65mRPalVy8zYJ0ROwyAklA4PMyBB2fh7hdcYvzNSEKswXOp4kJyGiEx10J
2CwjFDpkt/QrqZjX7W4kEaZ9dybEfQprSKNOWt3ZhdRyOQBQY9ZoEgLkWE1owYAZ
aUk9TEIYBw/VqxmYLKI6nFWYf4rC8FK+VegBGQMLIAGjTJ8BjTcPxqrLIAzH9rdb
6VTfngwrCBy0b+WRMW0/AyKaM1c9Qf7QROWuhsSBSiCXdKPkOBoaEqpcQ4LNNi6i
ge1HsvCIjVWHpi7cZWtYrtsYl1fjEEgSb78qvRuoOyJ7wASVi15mbm/ZYhlhZ5Av
m/zFthgjKK35QzNKht+vmIZgjFO1axov69gDwOhLAimPVPbykr50gWBqVaGSe54r
8/Dx6tjTorxhzP7skGMyYS2aXuLEeGJPFW8bL4G3V8MFh//udygGgf26CQDRggE4
yPOrMiBlyS01Rb5lYQ4EhJOrNhxpB3ldT2qSygBY7goBQAdfWYM=
=w2Rf
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
