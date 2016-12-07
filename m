Date: Wed, 7 Dec 2016 13:46:49 +0000
From: Gary Tierney <gary.tierney@gmx.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libsepol/cil: remove avrules with no affected types
Message-ID: <20161207134649.GA4532@workstation>
References: <1481112959-26208-1-git-send-email-gary.tierney@gmx.com>
 <1481112959-26208-2-git-send-email-gary.tierney@gmx.com>
 <06461db4-cd7a-c3b8-7a56-7e9e7ab8f2b4@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
In-Reply-To: <06461db4-cd7a-c3b8-7a56-7e9e7ab8f2b4@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2016 at 08:27:05AM -0500, Stephen Smalley wrote:
> On 12/07/2016 07:15 AM, Gary Tierney wrote:
> > Adds a check for avrules with type attributes that have a bitmap cardin=
ality
> > of 0 (i.e., no types in their set) before adding them to the libsepol p=
olicy in
> > __cil_avrule_to_avtab().  Also adds an exception for neverallow rules to
> > prevent breaking anything from AOSP mentioned in
> > f9927d9370f90bd9d975ff933fe107ec4f93a9ac.
>=20
> James Carter is away for a few days, so this might be delayed in review.
>=20

No problem.  I'll try and get the second part of this (removing typeattribu=
tes
which are only used in these dud avrules) to the list in time for reviewing
this.

> >=20
> > Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
> > ---
> >  libsepol/cil/src/cil_binary.c | 47 +++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 47 insertions(+)
> >=20
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index d33981b..3aa350a 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -1411,6 +1411,48 @@ exit:
> >  	return rc;
> >  }
> > =20
> > +static int __cil_type_datum_is_unused_attrib(struct cil_symtab_datum *=
src)
> > +{
> > +	struct cil_tree_node *node =3D NULL;
> > +	struct cil_typeattribute *attrib =3D NULL;
> > +
> > +	if (src->fqn =3D=3D CIL_KEY_SELF) {
> > +		return CIL_FALSE;
> > +	}
> > +
> > +	node =3D src->nodes->head->data;
> > +
> > +	if (node->flavor !=3D CIL_TYPEATTRIBUTE) {
> > +		return CIL_FALSE;
> > +	}
> > +
> > +	attrib =3D (struct cil_typeattribute *) src;
> > +	return ebitmap_cardinality(attrib->types) =3D=3D 0;
> > +}
> > +
> > +static int __cil_avrule_can_remove(struct cil_avrule *cil_avrule)
> > +{
> > +	struct cil_symtab_datum *src =3D cil_avrule->src;
> > +	struct cil_symtab_datum *tgt =3D cil_avrule->tgt;
> > +
> > +	// Don't remove neverallow rules so they are written to
> > +	// the resulting policy and can be checked by tools in
> > +	// AOSP.
> > +	if (cil_avrule->rule_kind =3D=3D CIL_AVRULE_NEVERALLOW) {
> > +		return CIL_FALSE;
> > +	}
> > +
> > +	if (__cil_type_datum_is_unused_attrib(src)) {
> > +		return CIL_TRUE;
> > +	}
> > +
> > +	if (__cil_type_datum_is_unused_attrib(tgt)) {
> > +		return CIL_TRUE;
> > +	}
> > +
> > +	return CIL_FALSE;
> > +}
> > +
> >  int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, st=
ruct cil_avrule *cil_avrule, cond_node_t *cond_node, enum cil_flavor cond_f=
lavor)
> >  {
> >  	int rc =3D SEPOL_ERR;
> > @@ -1425,6 +1467,11 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const=
 struct cil_db *db, struct cil_a
> >  		goto exit;
> >  	}
> > =20
> > +	if (__cil_avrule_can_remove(cil_avrule)) {
> > +		rc =3D SEPOL_OK;
> > +		goto exit;
> > +	}
> > +
> >  	src =3D cil_avrule->src;
> >  	tgt =3D cil_avrule->tgt;
> > =20
> >=20
>=20

--=20
Gary Tierney

GPG fingerprint: 412C 0EF9 C305 68E6 B660  BDAF 706E D765 85AA 79D8
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x706ED76585AA79D8

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYSBLEAAoJEHBu12WFqnnYm8cH+gK3cVht7AEQnZLBihqAQI5D
z8KwkbwkqLvDWHgbuNRmoD7Jsf0G5Pmd+wPaDPipA99Zb6EAQiiiGeWYcq/marAv
lOtbl3v9du4sMmEH9zTF2/myLDb6CbgITl9qYJgG8M7vRqrP1g0vffj91IDUlNls
cxG1uMwVn27s2BVPzWrzoFpttZaNfyKFY3smM/STB1WMh7jWbm5Rq7ijp8Wm3elz
U1sw28wdrXI/ISnAyvwH5PIagK1i3oQY6TBLuj/34FU1/Vx7GMBjcakslg5wMDa+
m1x21lg1cbXQc1jqcUlLP4ZRgTJIipZeeiB7VZiWm5KJSy9ZByZOpxPrwiO9i4s=
=rC55
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
