Date: Tue, 6 Dec 2016 18:05:22 +0000
From: Gary Tierney <gary.tierney@gmx.com>
To: SELinux <selinux@tycho.nsa.gov>
Cc: sds@tycho.nsa.gov
Subject: Re: Filtering an avtab in libsepol
Message-ID: <20161206180522.GB30914@workstation>
References: <20161206170055.GA30914@workstation>
 <a351189a-cf18-0345-ec36-f2978f563c4a@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
In-Reply-To: <a351189a-cf18-0345-ec36-f2978f563c4a@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 12:53:00PM -0500, Stephen Smalley wrote:
> On 12/06/2016 12:00 PM, Gary Tierney wrote:
> > Hi,
> >=20
> > I've been working on optimizing out AV rules with no applicable
> > types as well as unused attributes to trim down the size of a
> > policy which uses CIL blocks and attributes extensively.  Looking
> > into the avtab code (and how creating a new avtab is implemented in
> > expand.c) I have a question:
> >=20
> > Does the following suffice for taking an existing avtab and
> > creating a new one with all of its elements?  Or do I need to
> > consider avtab_insert_nonunique() like expand.c does?  If I'm
> > following the expand_avtab() code correctly, I'd think I'd need to
> > consider conditional avtabs in the following code:
> >=20
> > static int copy_avtab_map_fn(avtab_key_t *key, avtab_datum_t
> > *datum, void *args) { avtab_t *avtab =3D (avtab_t *) args;
> >=20
> > return avtab_insert(avtab, key, datum); }
> >=20
> > static int copy_avtab(avtab_t *avtab, avtab_t **out) { avtab_t *tmp
> > =3D NULL; if (avtab_init(tmp)) { return POLICYDB_ERROR; }
> >=20
> > if (avtab_alloc(tmp, MAX_AVTAB_SIZE)) { return POLICYDB_ERROR; }
> >=20
> > if (avtab_map(avtab, copy_avtab_map_fn, tmp)) { return
> > POLICYDB_ERROR; }
> >=20
> > *out =3D tmp; return POLICYDB_SUCCESS; }
> >=20
> > Is that the right idea?
> >=20
> > Thanks.
>=20
> Did you consider doing this at the CIL layer instead, given that CIL
> already does similar optimizations and has more semantic information
> available?  Note that CIL used to be more aggressive about removing
> unused attributes but backed off because some attributes are used in
> neverallows and we want to preserve those for neverallow checking in CTS.
>=20

Yes, I think I'll go down that route eventually once I move on to removing
typeattributes with no good AV rules.  This was mostly an exercise in getti=
ng
my feet wet with the binary policy and figuring out what makes up the
majority of its size.  I noticed that the CIL compiler currently does
optimize away typeattributes that aren't used in any AV rules so the
foundation seems to be there (and Jim also shared some input on this
previously: http://marc.info/?l=3Dselinux&m=3D147871772206496&w=3D2).

> Conditional rules can indeed have non-unique entries, and so can
> xperms rules.
>=20
>=20

Thanks, that makes sense.

--=20
Gary Tierney

GPG fingerprint: 412C 0EF9 C305 68E6 B660  BDAF 706E D765 85AA 79D8
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x706ED76585AA79D8

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYRv3aAAoJEHBu12WFqnnYjAYH/iEDt3ibFfX4qP6XmZbQ1QQy
90PRsxjX66OY/e94kSwIksiMQ4+nhieFOJ/9KyWA/ohmoB90UbKWEXqVP5uPZkv4
C6S8/xkMP2sgXTHScAUGL0SzqZyfbXosZAneDoMpzPfyPe++9G/VSXUgneBdUKtS
9hEICdJXiAJ+fuCLci+XunGZCFTGMsXnma9crjrSmI17fvKiz2pmlAOLynry3Nuq
rvayK3OsQw8q32i4gx3UFHdZ91tE3Fij/0wcKOdWrlf/vRQpHmuN2E7fU3yxNnMX
WEm/PisyEArOzbNaJb1AKgBJze0jOmmA4N5FJr5bSuAQo+3vPsbOTBPfpBWnbUQ=
=Jnve
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
