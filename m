Date: Wed, 25 Jan 2017 15:51:06 -0500
From: Lokesh Mandvekar <lsm5@fedoraproject.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: libselinux: selinux_restorecon.3 man page typo fix
Message-ID: <20170125205105.a7ip4mvxfdkpobyk@naruto.nanadai.me>
References: <20170125204635.13443-1-lsm5@fedoraproject.org>
 <1485377535.15074.80.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="72gjws4bq2iv557o"
In-Reply-To: <1485377535.15074.80.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--72gjws4bq2iv557o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2017 at 03:52:15PM -0500, Stephen Smalley wrote:
> On Wed, 2017-01-25 at 15:46 -0500, Lokesh Mandvekar wrote:
> > Signed-off-by: Lokesh Mandvekar <lsm5@fedoraproject.org>
>=20
> Thanks, applied

Great, thanks Stephen!

>=20
> > ---
> > =A0libselinux/man/man3/selinux_restorecon.3 | 2 +-
> > =A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/libselinux/man/man3/selinux_restorecon.3
> > b/libselinux/man/man3/selinux_restorecon.3
> > index 2d8274b..d698818 100644
> > --- a/libselinux/man/man3/selinux_restorecon.3
> > +++ b/libselinux/man/man3/selinux_restorecon.3
> > @@ -26,7 +26,7 @@ containing a directory or file to be relabeled.
> > =A0If this is a directory and the
> > =A0.IR restorecon_flags
> > =A0.B SELINUX_RESTORECON_RECURSE
> > -has been set (for decending through directories), then
> > +has been set (for descending through directories), then
> > =A0.BR selinux_restorecon ()
> > =A0will write an SHA1 digest of the combined specfiles (see the
> > =A0.B NOTES

--=20
Lokesh
Freenode: lsm5
GPG: 0xC7C3A0DD
https://keybase.io/lsm5

--72gjws4bq2iv557o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJYiQ+5AAoJEBwe3XzHw6Dd+jMQAJU49c15WPzpQUe1XsDn0gLb
aqQwI/BBFiWInQ30gxydv/noBf1sUymRV4FoCDSd0I0rSKbtMXzEXO1FbPnZMzEt
+qDw0gCDDHNmYsGuUBv4UQCYgdPW53tzY9pJVwyP8AfEAG85eEJePB5tu8Ha09HE
3HFOlLkB0eLBZb2j78tSClMF55qSm30bQLTP8m4HzQonfoUyj7PEQPjfr31t2NYR
VneFJH9Omgfysnd1tWV0m0lUcy7HQnX6XlsC5US9X0Fi1zrq2M5+31nVwEWfIajZ
gXh3WkdXKHCGhdD6uyCM7E5LbtYR5Hwda+AHjNJSUtEq/njoFT4E2k9UykhTCM0R
2ZLcMxKJx04BqQl8ZZ1THcOXBJhM5b4SX/ltUCIMVdI1zatPdhN5Z3IHNuMN1JIY
f149NZVz1O3/eZYi9z1Xej/Rc9E9ekcvdZAZT7xbYBY46Go7gFbPMzqDVkDLy+QR
8NyU0rlhFgjfOX7VRmwNSosKL75QOmIcl6oIx3eBjuLuzFnJk615L7qwyhq/VvEc
6bcW6RrCTR+64DFy9GlmvE2BZjV61SFZv/SuDvKXaqJozFmQ7HA8X6pDaT33nxlh
7E+06R546XsykwEiweuLcyYXT1v7X6Jm3r6UkBriamaATJ2TiHUVFIKim/lNdfjG
Ng0tmPBDnZ2l1Evh2TVJ
=ouvF
-----END PGP SIGNATURE-----

--72gjws4bq2iv557o--
