Date: Thu, 22 Jun 2017 11:00:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Petr Lautrbach <plautrba@redhat.com>,
 Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH 3/3] genhomedircon: avoid use of non-standard `getpwent_r`
Message-ID: <20170622090055.GA19473@pks-pc>
References: <cover.1497967444.git.ps@pks.im>
 <e9a72b068ca86d433ee52a877dad98bc410c39a0.1497967444.git.ps@pks.im>
 <1497973379.12069.10.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
In-Reply-To: <1497973379.12069.10.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 11:42:59AM -0400, Stephen Smalley wrote:
> On Tue, 2017-06-20 at 16:07 +0200, Patrick Steinhardt wrote:
> > The `getpwent_r` function is a non-standard but re-entrant version of
> > the sdardardized `getpwent` function. Next to the benefit of being
> > re-entrant, though, it avoids compilation with libc implementations
> > that
> > do not provide this glibc-specific extension, for example musl libc.
> >=20
> > As the code is usually not run in a threaded environment, it is save
> > to
> > use the non-reentrant version, though. As such, convert code to use
> > `getpwent` instead to fix building with other libc implementations.
>=20
> Not sure we are guaranteed that, since libsemanage has external users
> too, e.g. sssd among others.  OTOH, getpwent_r man page says that it is
> not really reentrant either due to shared reading position in the
> stream, so maybe this doesn't matter.

Hum, okay. man-pages differ here in their wording across systems,
but I guess the part you're referring to is

```
The functions getpwent_r() and fgetpwent_r() are the reentrant
versions of getpwent(3) and fgetpwent(3). The former reads the
next passwd entry from the stream initialized by setpwent(3). The
latter reads the next passwd entry from the stream fp.
```

While it indeed seems to imply that the stream by `setpwent` is
used, they also pretend to be reentrant here. Puzzled.

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > =A0libsemanage/src/genhomedircon.c | 22 +++++-----------------
> > =A01 file changed, 5 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/libsemanage/src/genhomedircon.c
> > b/libsemanage/src/genhomedircon.c
> > index e8c95ee4..f58c17ce 100644
> > --- a/libsemanage/src/genhomedircon.c
> > +++ b/libsemanage/src/genhomedircon.c
> > @@ -295,9 +295,8 @@ static semanage_list_t
> > *get_home_dirs(genhomedircon_settings_t * s)
> > =A0	long rbuflen;
> > =A0	uid_t temp, minuid =3D 500, maxuid =3D 60000;
> > =A0	int minuid_set =3D 0;
> > -	struct passwd pwstorage, *pwbuf;
> > +	struct passwd *pwbuf;
> > =A0	struct stat buf;
> > -	int retval;
> > =A0
> > =A0	path =3D semanage_findval(PATH_ETC_USERADD, "HOME", "=3D");
> > =A0	if (path && *path) {
> > @@ -369,7 +368,7 @@ static semanage_list_t
> > *get_home_dirs(genhomedircon_settings_t * s)
> > =A0	if (rbuf =3D=3D NULL)
> > =A0		goto fail;
> > =A0	setpwent();
> > -	while ((retval =3D getpwent_r(&pwstorage, rbuf, rbuflen,
> > &pwbuf)) =3D=3D 0) {
> > +	while ((pwbuf =3D getpwent()) !=3D NULL) {
>=20
> Shouldn't you have removed rbuflen and rbuf too?  They are no longer
> used (except to allocate and free, but never used otherwise) after this
> change.

That was an oversight, yeah. Fixed in v2.

> > =A0		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid >
> > maxuid)
> > =A0			continue;
> > =A0		if (!semanage_list_find(shells, pwbuf->pw_shell))
> > @@ -413,7 +412,7 @@ static semanage_list_t
> > *get_home_dirs(genhomedircon_settings_t * s)
> > =A0		path =3D NULL;
> > =A0	}
> > =A0
> > -	if (retval && retval !=3D ENOENT) {
> > +	if (errno && errno !=3D ENOENT) {
>=20
> Does getpwent() set errno to ENOENT? Not mentioned in its man page,
> unlike for getpwent_r().

You're right, it does not. Will remove this check.

> > =A0		WARN(s->h_semanage, "Error while fetching users.=A0=A0"
> > =A0		=A0=A0=A0=A0=A0"Returning list so far.");
> > =A0	}
> > @@ -1064,10 +1063,7 @@ static int
> > get_group_users(genhomedircon_settings_t * s,
> > =A0	long grbuflen;
> > =A0	char *grbuf =3D NULL;
> > =A0	struct group grstorage, *group =3D NULL;
> > -
> > -	long prbuflen;
> > -	char *pwbuf =3D NULL;
> > -	struct passwd pwstorage, *pw =3D NULL;
> > +	struct passwd *pw =3D NULL;
> > =A0
> > =A0	grbuflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> > =A0	if (grbuflen <=3D 0)
> > @@ -1104,15 +1100,8 @@ static int
> > get_group_users(genhomedircon_settings_t * s,
> > =A0		}
> > =A0	}
> > =A0
> > -	prbuflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> > -	if (prbuflen <=3D 0)
> > -		goto cleanup;
> > -	pwbuf =3D malloc(prbuflen);
> > -	if (pwbuf =3D=3D NULL)
> > -		goto cleanup;
> > -
> > =A0	setpwent();
> > -	while ((retval =3D getpwent_r(&pwstorage, pwbuf, prbuflen,
> > &pw)) =3D=3D 0) {
> > +	while ((pw =3D getpwent()) !=3D NULL) {
> > =A0		// skip users who also have this group as their
> > =A0		// primary group
> > =A0		if (lfind(pw->pw_name, group->gr_mem, &nmembers,
>=20
> Interestingly, this goes on to call add_user(), which calls
> getpwnam_r().  So if that one was ever switched back to just
> getpwnam(), we'd have a potential problem there.

Agreed. But in fact, `getpwnam_r` is part of POSIX, so there is
no need to do so here.

> > @@ -1131,7 +1120,6 @@ static int
> > get_group_users(genhomedircon_settings_t * s,
> > =A0	retval =3D STATUS_SUCCESS;
> > =A0cleanup:
> > =A0	endpwent();
> > -	free(pwbuf);
> > =A0	free(grbuf);
> > =A0
> > =A0	return retval;

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAllLh0cACgkQEXxntp6r
8SxKXhAAhfhFG87IrKlGlhPmSlzzOXiYHOwoj17+fRZPO1LdgkhTbLnTGPkBEInV
q7DClq1u1SapDmF79s9VFTDDJSUJASjqH69G8UXityINHrXKnKF44A8bGb3EVBMJ
up/NKpesBXXrvWRtOOMD8b2ZCUXHxX27ZD3IWTf5h0fk8egbzZaGNHpM7YTn1twn
U2EMF3oFqNS4UmQE7rQzXhkyZfert/0LzpoX84XtrO6epnDRMn3b4zAwpD75Kkfy
ea+aLmxgcsWZBzXYSRqbPNvyXdgQ50QVdnTW7liPUoMtIZ4N0DLuJpi5MAk5NOlE
hyL20OKeUHVWsGO5ZoiOw8LHPm8Z1vLTq2Vah5PE6us4IBJEnsAqOZgg5nxDumeH
IaNJP+6nvfCANFhrlibAP2rcmEju6uCHr4pXsjsL3Qo5risW5zssbU+kkIEGgg4W
JBbm3EqV6612mbd3q1SLxrqiq1V+z16q63c0/fPCFccWWIpVs38QuOh+/DtcK8fJ
YYVZZNhThm8l0QfP/OB2jrni7ABxAqyXwg+Ze16hvesPoNipPnI5a6aCdbISmDQK
sm3IoTme+7/LpQbS3EeMKVkUY9FHCxbzHDeYDR6cfDYVrpGZL7cBBqAEzMnNeTnM
jm1NpS2IGqqOsBz8Gktsw3SltQkxnphlY/hdCDpyJ7CXdKBwMK0=
=It9u
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
