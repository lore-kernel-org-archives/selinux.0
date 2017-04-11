Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3BJY91n029997
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 15:34:09 -0400
Received: by mail-wr0-f193.google.com with SMTP id o21so1092750wrb.3
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 12:33:55 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id a10sm22796631wra.17.2017.04.11.12.33.53
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Apr 2017 12:33:53 -0700 (PDT)
Date: Tue, 11 Apr 2017 21:33:51 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] libsepol/cil: Add ability to expand some attributes
 in binary policy
Message-ID: <20170411193351.GC2232@markus>
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1491933223-18277-2-git-send-email-jwcart2@tycho.nsa.gov>
 <20170411183722.GA2232@markus> <20170411184610.GB2232@markus>
 <a0b1da83-6bdd-590d-e5d6-e0ef7795d1c3@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
In-Reply-To: <a0b1da83-6bdd-590d-e5d6-e0ef7795d1c3@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 03:17:28PM -0400, James Carter wrote:
> On 04/11/2017 02:46 PM, Dominick Grift wrote:
> > On Tue, Apr 11, 2017 at 08:37:22PM +0200, Dominick Grift wrote:
> > > On Tue, Apr 11, 2017 at 01:53:42PM -0400, James Carter wrote:
> > > > Originally, all type attributes were expanded when building a binary
> > > > policy. As the policy grew, binary policy sizes became too large, so
> > > > changes were made to keep attributes in the binary policy to minimi=
ze
> > > > policy size.
> > > >=20
> > > > Keeping attributes works well as long as each type does not have too
> > > > many attributes. If an access check fails for types t1 and t2, then
> > > > additional checks must be made for every attribute that t1 is a mem=
ber
> > > > of against t2 and all the attributes that t2 is a member of. This is
> > > > O(n*m) behavior and there are cases now where this is becoming a
> > > > performance issue.
> > > >=20
> > > > Attributes are more aggressively removed than before. An attribute
> > > > will now be removed if it only appears in rules where attributes are
> > > > always expanded (typetransition, typechange, typemember, roletransi=
tion,
> > > > rangetransition, roletype, and AV Rules with self).
> > > >=20
> > > > Attributes that are used in constraints are always kept because the
> > > > attribute name is stored for debugging purposes in the binary polic=
y.
> > > >=20
> > > > Attributes that are used in neverallow rules, but not in other AV r=
ules,
> > > > will be kept unless the attribute is auto-generated.
> > > >=20
> > > > Attributes that are only used in AV rules other than neverallow rul=
es
> > > > are kept unless the number of types assigned to them is less than t=
he
> > > > value of attrs_expand_size in the CIL db. The default is 1, which m=
eans
> > > > that any attribute that has no types assigned to it will be expande=
d (and
> > > > the rule removed from the policy), which is CIL's current behavior.
> > >=20
> > > I might be misunderstanding here but how is that CIL's current behavi=
or.
> > >=20
> > > With my dssp1 policy I ended up with many rules that were associated =
with type attributes that had no types associated with them. The attributes=
 and rules associated with them were not removed.
> >=20
> > I suppose that my dssp1 scenario was slightly different. As these rules=
 used type attributes in both source as well as target, the target type att=
ribute had a type associated with it but the source type attribute didn't. =
Wondering whether the source isnt actually what should count in this case .=
=2E.
> >=20
>=20
> I am not sure that I understand. Everything that I did applies to an
> attribute whether it is used as a src or a tgt.

Take this example:

$ sesearch policy.30 -A -s vconsole_setup.unix_dgram_sockets_sendto_subj_ty=
pe_attribute -t vconsole_setup.subj -c unix_dgram_socket -p sendto -ds
allow vconsole_setup.unix_dgram_sockets_sendto_subj_type_attribute vconsole=
_setup.subj:unix_dgram_socket sendto;

$ seinfo policy.30 -xtvconsole_setup.unix_dgram_sockets_sendto_subj_type_at=
tribute

Types: 0

>=20
> Jim
>=20
> > >=20
> > >=20
> > >  The
> > > > value can be set using the function cil_set_attrs_expand_size().
> > > >=20
> > > > Auto-generated attributes that are used only in neverallow rules are
> > > > always expanded. The rest are kept by default, but if the value of
> > > > attrs_expand_generated in the CIL db is set to true, they will be
> > > > expanded. The function cil_set_attrs_expand_generated() can be used
> > > > to set the value.
> > > >=20
> > > > When creating the binary policy, CIL will expand all attributes that
> > > > are being removed and it will expand all attributes with less membe=
rs
> > > > than the value specified by attrs_expand_size. So even if an attrib=
ute
> > > > is used in a constraint or neverallow and the attribute itself will=
 be
> > > > included in the binary policy, it will be expanded when writing AV
> > > > rules if it has less members than attrs_expand_size.
> > > >=20
> > > > Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> > > > ---
> > > >  libsepol/cil/include/cil/cil.h     |   2 +
> > > >  libsepol/cil/src/cil.c             |  12 ++
> > > >  libsepol/cil/src/cil_binary.c      | 253 +++++++++++++++++++++++++=
++----------
> > > >  libsepol/cil/src/cil_internal.h    |   7 +-
> > > >  libsepol/cil/src/cil_post.c        |  32 +++--
> > > >  libsepol/cil/src/cil_resolve_ast.c |  25 ++--
> > > >  libsepol/src/libsepol.map.in       |   2 +
> > > >  7 files changed, 233 insertions(+), 100 deletions(-)
> > > >=20
> > > > diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/=
cil/cil.h
> > > > index c4a6fb9..4507892 100644
> > > > --- a/libsepol/cil/include/cil/cil.h
> > > > +++ b/libsepol/cil/include/cil/cil.h
> > > > @@ -50,6 +50,8 @@ extern void cil_set_disable_neverallow(cil_db_t *=
db, int disable_neverallow);
> > > >  extern void cil_set_preserve_tunables(cil_db_t *db, int preserve_t=
unables);
> > > >  extern int cil_set_handle_unknown(cil_db_t *db, int handle_unknown=
);
> > > >  extern void cil_set_mls(cil_db_t *db, int mls);
> > > > +extern void cil_set_attrs_expand_generated(struct cil_db *db, int =
attrs_expand_generated);
> > > > +extern void cil_set_attrs_expand_size(struct cil_db *db, unsigned =
attrs_expand_size);
> > > >  extern void cil_set_target_platform(cil_db_t *db, int target_platf=
orm);
> > > >  extern void cil_set_policy_version(cil_db_t *db, int policy_versio=
n);
> > > >  extern void cil_write_policy_conf(FILE *out, struct cil_db *db);
> > > > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > > > index 7c40ad0..a64c528 100644
> > > > --- a/libsepol/cil/src/cil.c
> > > > +++ b/libsepol/cil/src/cil.c
> > > > @@ -282,6 +282,8 @@ void cil_db_init(struct cil_db **db)
> > > >=20
> > > >  	(*db)->disable_dontaudit =3D CIL_FALSE;
> > > >  	(*db)->disable_neverallow =3D CIL_FALSE;
> > > > +	(*db)->attrs_expand_generated =3D CIL_FALSE;
> > > > +	(*db)->attrs_expand_size =3D 1;
> > > >  	(*db)->preserve_tunables =3D CIL_FALSE;
> > > >  	(*db)->handle_unknown =3D -1;
> > > >  	(*db)->mls =3D -1;
> > > > @@ -1629,6 +1631,16 @@ void cil_set_disable_neverallow(struct cil_d=
b *db, int disable_neverallow)
> > > >  	db->disable_neverallow =3D disable_neverallow;
> > > >  }
> > > >=20
> > > > +void cil_set_attrs_expand_generated(struct cil_db *db, int attrs_e=
xpand_generated)
> > > > +{
> > > > +	db->attrs_expand_generated =3D attrs_expand_generated;
> > > > +}
> > > > +
> > > > +void cil_set_attrs_expand_size(struct cil_db *db, unsigned attrs_e=
xpand_size)
> > > > +{
> > > > +	db->attrs_expand_size =3D attrs_expand_size;
> > > > +}
> > > > +
> > > >  void cil_set_preserve_tunables(struct cil_db *db, int preserve_tun=
ables)
> > > >  {
> > > >  	db->preserve_tunables =3D preserve_tunables;
> > > > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_b=
inary.c
> > > > index ac18c4e..e1481a4 100644
> > > > --- a/libsepol/cil/src/cil_binary.c
> > > > +++ b/libsepol/cil/src/cil_binary.c
> > > > @@ -567,7 +567,7 @@ int cil_typeattribute_to_policydb(policydb_t *p=
db, struct cil_typeattribute *cil
> > > >  	char *key =3D NULL;
> > > >  	type_datum_t *sepol_attr =3D NULL;
> > > >=20
> > > > -	if (cil_attr->used =3D=3D CIL_FALSE) {
> > > > +	if (!cil_attr->used) {
> > > >  		return SEPOL_OK;	=09
> > > >  	}
> > > >=20
> > > > @@ -632,7 +632,7 @@ int cil_typeattribute_to_bitmap(policydb_t *pdb=
, const struct cil_db *db, struct
> > > >  	ebitmap_node_t *tnode;
> > > >  	unsigned int i;
> > > >=20
> > > > -	if (cil_attr->used =3D=3D CIL_FALSE) {
> > > > +	if (!cil_attr->used) {
> > > >  		return SEPOL_OK;
> > > >  	}
> > > >=20
> > > > @@ -1429,46 +1429,20 @@ exit:
> > > >  	return rc;
> > > >  }
> > > >=20
> > > > -static int __cil_type_datum_is_unused_attrib(struct cil_symtab_dat=
um *src)
> > > > +static int __cil_should_expand_attribute( const struct cil_db *db,=
 struct cil_symtab_datum *datum)
> > > >  {
> > > > -	struct cil_tree_node *node =3D NULL;
> > > > -	struct cil_typeattribute *attrib =3D NULL;
> > > > +	struct cil_tree_node *node;
> > > > +	struct cil_typeattribute *attr;
> > > >=20
> > > > -	if (src->fqn =3D=3D CIL_KEY_SELF) {
> > > > -		return CIL_FALSE;
> > > > -	}
> > > > -
> > > > -	node =3D NODE(src);
> > > > +	node =3D NODE(datum);
> > > >=20
> > > >  	if (node->flavor !=3D CIL_TYPEATTRIBUTE) {
> > > >  		return CIL_FALSE;
> > > >  	}
> > > >=20
> > > > -	attrib =3D (struct cil_typeattribute *) src;
> > > > -	return ebitmap_cardinality(attrib->types) =3D=3D 0;
> > > > -}
> > > > -
> > > > -static int __cil_avrule_can_remove(struct cil_avrule *cil_avrule)
> > > > -{
> > > > -	struct cil_symtab_datum *src =3D cil_avrule->src;
> > > > -	struct cil_symtab_datum *tgt =3D cil_avrule->tgt;
> > > > -
> > > > -	// Don't remove neverallow rules so they are written to
> > > > -	// the resulting policy and can be checked by tools in
> > > > -	// AOSP.
> > > > -	if (cil_avrule->rule_kind =3D=3D CIL_AVRULE_NEVERALLOW) {
> > > > -		return CIL_FALSE;
> > > > -	}
> > > > -
> > > > -	if (__cil_type_datum_is_unused_attrib(src)) {
> > > > -		return CIL_TRUE;
> > > > -	}
> > > > -
> > > > -	if (__cil_type_datum_is_unused_attrib(tgt)) {
> > > > -		return CIL_TRUE;
> > > > -	}
> > > > +	attr =3D (struct cil_typeattribute *)datum;
> > > >=20
> > > > -	return CIL_FALSE;
> > > > +	return !attr->used || (ebitmap_cardinality(attr->types) < db->att=
rs_expand_size);
> > > >  }
> > > >=20
> > > >  int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db=
, struct cil_avrule *cil_avrule, cond_node_t *cond_node, enum cil_flavor co=
nd_flavor)
> > > > @@ -1478,6 +1452,9 @@ int __cil_avrule_to_avtab(policydb_t *pdb, co=
nst struct cil_db *db, struct cil_a
> > > >  	struct cil_symtab_datum *src =3D NULL;
> > > >  	struct cil_symtab_datum *tgt =3D NULL;
> > > >  	struct cil_list *classperms =3D cil_avrule->perms.classperms;
> > > > +	ebitmap_t src_bitmap, tgt_bitmap;
> > > > +	ebitmap_node_t *snode, *tnode;
> > > > +	unsigned int s,t;
> > > >=20
> > > >  	if (cil_avrule->rule_kind =3D=3D CIL_AVRULE_DONTAUDIT && db->disa=
ble_dontaudit =3D=3D CIL_TRUE) {
> > > >  		// Do not add dontaudit rules to binary
> > > > @@ -1485,36 +1462,98 @@ int __cil_avrule_to_avtab(policydb_t *pdb, =
const struct cil_db *db, struct cil_a
> > > >  		goto exit;
> > > >  	}
> > > >=20
> > > > -	if (__cil_avrule_can_remove(cil_avrule)) {
> > > > -		rc =3D SEPOL_OK;
> > > > -		goto exit;
> > > > -	}
> > > > -
> > > >  	src =3D cil_avrule->src;
> > > >  	tgt =3D cil_avrule->tgt;
> > > >=20
> > > >  	if (tgt->fqn =3D=3D CIL_KEY_SELF) {
> > > > -		ebitmap_t type_bitmap;
> > > > -		ebitmap_node_t *tnode;
> > > > -		unsigned int i;
> > > > -
> > > > -		rc =3D __cil_expand_type(src, &type_bitmap);
> > > > -		if (rc !=3D SEPOL_OK) goto exit;
> > > > +		rc =3D __cil_expand_type(src, &src_bitmap);
> > > > +		if (rc !=3D SEPOL_OK) {
> > > > +			goto exit;
> > > > +		}
> > > >=20
> > > > -		ebitmap_for_each_bit(&type_bitmap, tnode, i) {
> > > > -			if (!ebitmap_get_bit(&type_bitmap, i)) continue;
> > > > +		ebitmap_for_each_bit(&src_bitmap, snode, s) {
> > > > +			if (!ebitmap_get_bit(&src_bitmap, s)) continue;
> > > >=20
> > > > -			src =3D DATUM(db->val_to_type[i]);
> > > > +			src =3D DATUM(db->val_to_type[s]);
> > > >  			rc =3D __cil_avrule_expand(pdb, kind, src, src, classperms, con=
d_node, cond_flavor);
> > > >  			if (rc !=3D SEPOL_OK) {
> > > > -				ebitmap_destroy(&type_bitmap);
> > > > +				ebitmap_destroy(&src_bitmap);
> > > >  				goto exit;
> > > >  			}
> > > >  		}
> > > > -		ebitmap_destroy(&type_bitmap);
> > > > +		ebitmap_destroy(&src_bitmap);
> > > >  	} else {
> > > > -		rc =3D __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond=
_node, cond_flavor);
> > > > -		if (rc !=3D SEPOL_OK) goto exit;
> > > > +		int expand_src =3D __cil_should_expand_attribute(db, src);
> > > > +		int expand_tgt =3D __cil_should_expand_attribute(db, tgt);
> > > > +		if (!expand_src && !expand_tgt) {
> > > > +			rc =3D __cil_avrule_expand(pdb, kind, src, tgt, classperms, con=
d_node, cond_flavor);
> > > > +			if (rc !=3D SEPOL_OK) {
> > > > +				goto exit;
> > > > +			}
> > > > +		} else if (expand_src && expand_tgt) {
> > > > +			rc =3D __cil_expand_type(src, &src_bitmap);
> > > > +			if (rc !=3D SEPOL_OK) {
> > > > +				goto exit;
> > > > +			}
> > > > +
> > > > +			rc =3D __cil_expand_type(tgt, &tgt_bitmap);
> > > > +			if (rc !=3D SEPOL_OK) {
> > > > +				ebitmap_destroy(&src_bitmap);
> > > > +				goto exit;
> > > > +			}
> > > > +
> > > > +			ebitmap_for_each_bit(&src_bitmap, snode, s) {
> > > > +				if (!ebitmap_get_bit(&src_bitmap, s)) continue;
> > > > +				src =3D DATUM(db->val_to_type[s]);
> > > > +				ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
> > > > +					if (!ebitmap_get_bit(&tgt_bitmap, t)) continue;
> > > > +					tgt =3D DATUM(db->val_to_type[t]);
> > > > +
> > > > +					rc =3D __cil_avrule_expand(pdb, kind, src, tgt, classperms, c=
ond_node, cond_flavor);
> > > > +					if (rc !=3D SEPOL_OK) {
> > > > +						ebitmap_destroy(&src_bitmap);
> > > > +						ebitmap_destroy(&tgt_bitmap);
> > > > +						goto exit;
> > > > +					}
> > > > +				}
> > > > +			}
> > > > +			ebitmap_destroy(&src_bitmap);
> > > > +			ebitmap_destroy(&tgt_bitmap);
> > > > +		} else if (expand_src) {
> > > > +			rc =3D __cil_expand_type(src, &src_bitmap);
> > > > +			if (rc !=3D SEPOL_OK) {
> > > > +				goto exit;
> > > > +			}
> > > > +
> > > > +			ebitmap_for_each_bit(&src_bitmap, snode, s) {
> > > > +				if (!ebitmap_get_bit(&src_bitmap, s)) continue;
> > > > +				src =3D DATUM(db->val_to_type[s]);
> > > > +
> > > > +				rc =3D __cil_avrule_expand(pdb, kind, src, tgt, classperms, co=
nd_node, cond_flavor);
> > > > +				if (rc !=3D SEPOL_OK) {
> > > > +					ebitmap_destroy(&src_bitmap);
> > > > +					goto exit;
> > > > +				}
> > > > +			}
> > > > +			ebitmap_destroy(&src_bitmap);
> > > > +		} else { /* expand_tgt */
> > > > +			rc =3D __cil_expand_type(tgt, &tgt_bitmap);
> > > > +			if (rc !=3D SEPOL_OK) {
> > > > +				goto exit;
> > > > +			}
> > > > +
> > > > +			ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
> > > > +				if (!ebitmap_get_bit(&tgt_bitmap, t)) continue;
> > > > +				tgt =3D DATUM(db->val_to_type[t]);
> > > > +
> > > > +				rc =3D __cil_avrule_expand(pdb, kind, src, tgt, classperms, co=
nd_node, cond_flavor);
> > > > +				if (rc !=3D SEPOL_OK) {
> > > > +					ebitmap_destroy(&tgt_bitmap);
> > > > +					goto exit;
> > > > +				}
> > > > +			}
> > > > +			ebitmap_destroy(&tgt_bitmap);
> > > > +		}
> > > >  	}
> > > >=20
> > > >  	return SEPOL_OK;
> > > > @@ -1789,11 +1828,9 @@ int cil_avrulex_to_hashtable(policydb_t *pdb=
, const struct cil_db *db, struct ci
> > > >  	uint16_t kind;
> > > >  	struct cil_symtab_datum *src =3D NULL;
> > > >  	struct cil_symtab_datum *tgt =3D NULL;
> > > > -	ebitmap_t type_bitmap;
> > > > -	ebitmap_node_t *tnode;
> > > > -	unsigned int i;
> > > > -
> > > > -	ebitmap_init(&type_bitmap);
> > > > +	ebitmap_t src_bitmap, tgt_bitmap;
> > > > +	ebitmap_node_t *snode, *tnode;
> > > > +	unsigned int s,t;
> > > >=20
> > > >  	if (cil_avrulex->rule_kind =3D=3D CIL_AVRULE_DONTAUDIT && db->dis=
able_dontaudit =3D=3D CIL_TRUE) {
> > > >  		// Do not add dontaudit rules to binary
> > > > @@ -1806,28 +1843,97 @@ int cil_avrulex_to_hashtable(policydb_t *pd=
b, const struct cil_db *db, struct ci
> > > >  	tgt =3D cil_avrulex->tgt;
> > > >=20
> > > >  	if (tgt->fqn =3D=3D CIL_KEY_SELF) {
> > > > -		rc =3D __cil_expand_type(src, &type_bitmap);
> > > > +		rc =3D __cil_expand_type(src, &src_bitmap);
> > > >  		if (rc !=3D SEPOL_OK) goto exit;
> > > >=20
> > > > -		ebitmap_for_each_bit(&type_bitmap, tnode, i) {
> > > > -			if (!ebitmap_get_bit(&type_bitmap, i)) continue;
> > > > +		ebitmap_for_each_bit(&src_bitmap, snode, s) {
> > > > +			if (!ebitmap_get_bit(&src_bitmap, s)) continue;
> > > >=20
> > > > -			src =3D DATUM(db->val_to_type[i]);
> > > > +			src =3D DATUM(db->val_to_type[s]);
> > > >  			rc =3D __cil_avrulex_to_hashtable_helper(pdb, kind, src, src, c=
il_avrulex->perms.x.permx, args);
> > > >  			if (rc !=3D SEPOL_OK) {
> > > >  				goto exit;
> > > >  			}
> > > >  		}
> > > > +		ebitmap_destroy(&src_bitmap);
> > > >  	} else {
> > > > -		rc =3D __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, ci=
l_avrulex->perms.x.permx, args);
> > > > -		if (rc !=3D SEPOL_OK) goto exit;
> > > > +		int expand_src =3D __cil_should_expand_attribute(db, src);
> > > > +		int expand_tgt =3D __cil_should_expand_attribute(db, tgt);
> > > > +
> > > > +		if (!expand_src && !expand_tgt) {
> > > > +			rc =3D __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, c=
il_avrulex->perms.x.permx, args);
> > > > +			if (rc !=3D SEPOL_OK) {
> > > > +				goto exit;
> > > > +			}
> > > > +		} else if (expand_src && expand_tgt) {
> > > > +			rc =3D __cil_expand_type(src, &src_bitmap);
> > > > +			if (rc !=3D SEPOL_OK) {
> > > > +				goto exit;
> > > > +			}
> > > > +
> > > > +			rc =3D __cil_expand_type(tgt, &tgt_bitmap);
> > > > +			if (rc !=3D SEPOL_OK) {
> > > > +				ebitmap_destroy(&src_bitmap);
> > > > +				goto exit;
> > > > +			}
> > > > +
> > > > +			ebitmap_for_each_bit(&src_bitmap, snode, s) {
> > > > +				if (!ebitmap_get_bit(&src_bitmap, s)) continue;
> > > > +				src =3D DATUM(db->val_to_type[s]);
> > > > +				ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
> > > > +					if (!ebitmap_get_bit(&tgt_bitmap, t)) continue;
> > > > +					tgt =3D DATUM(db->val_to_type[t]);
> > > > +
> > > > +					rc =3D __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt,=
 cil_avrulex->perms.x.permx, args);
> > > > +					if (rc !=3D SEPOL_OK) {
> > > > +						ebitmap_destroy(&src_bitmap);
> > > > +						ebitmap_destroy(&tgt_bitmap);
> > > > +						goto exit;
> > > > +					}
> > > > +				}
> > > > +			}
> > > > +			ebitmap_destroy(&src_bitmap);
> > > > +			ebitmap_destroy(&tgt_bitmap);
> > > > +		} else if (expand_src) {
> > > > +			rc =3D __cil_expand_type(src, &src_bitmap);
> > > > +			if (rc !=3D SEPOL_OK) {
> > > > +				goto exit;
> > > > +			}
> > > > +
> > > > +			ebitmap_for_each_bit(&src_bitmap, snode, s) {
> > > > +				if (!ebitmap_get_bit(&src_bitmap, s)) continue;
> > > > +				src =3D DATUM(db->val_to_type[s]);
> > > > +
> > > > +				rc =3D __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, =
cil_avrulex->perms.x.permx, args);
> > > > +				if (rc !=3D SEPOL_OK) {
> > > > +					ebitmap_destroy(&src_bitmap);
> > > > +					goto exit;
> > > > +				}
> > > > +			}
> > > > +			ebitmap_destroy(&src_bitmap);
> > > > +		} else { /* expand_tgt */
> > > > +			rc =3D __cil_expand_type(tgt, &tgt_bitmap);
> > > > +			if (rc !=3D SEPOL_OK) {
> > > > +				goto exit;
> > > > +			}
> > > > +
> > > > +			ebitmap_for_each_bit(&tgt_bitmap, tnode, t) {
> > > > +				if (!ebitmap_get_bit(&tgt_bitmap, t)) continue;
> > > > +				tgt =3D DATUM(db->val_to_type[t]);
> > > > +
> > > > +				rc =3D __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, =
cil_avrulex->perms.x.permx, args);
> > > > +				if (rc !=3D SEPOL_OK) {
> > > > +					ebitmap_destroy(&tgt_bitmap);
> > > > +					goto exit;
> > > > +				}
> > > > +			}
> > > > +			ebitmap_destroy(&tgt_bitmap);
> > > > +		}
> > > >  	}
> > > >=20
> > > > -	rc =3D SEPOL_OK;
> > > > +	return SEPOL_OK;
> > > >=20
> > > >  exit:
> > > > -	ebitmap_destroy(&type_bitmap);
> > > > -
> > > >  	return rc;
> > > >  }
> > > >=20
> > > > @@ -2417,12 +2523,19 @@ int __cil_constrain_expr_datum_to_sepol_exp=
r(policydb_t *pdb, const struct cil_d
> > > >  		if (pdb->policyvers >=3D POLICYDB_VERSION_CONSTRAINT_NAMES) {
> > > >  			rc =3D __cil_get_sepol_type_datum(pdb, item->data, &sepol_type);
> > > >  			if (rc !=3D SEPOL_OK) {
> > > > -				ebitmap_destroy(&type_bitmap);
> > > > -				goto exit;
> > > > +				if (FLAVOR(item->data) =3D=3D CIL_TYPEATTRIBUTE) {
> > > > +					struct cil_typeattribute *attr =3D item->data;
> > > > +					if (!attr->used) {
> > > > +						rc =3D 0;
> > > > +					}
> > > > +				}
> > > >  			}
> > > >=20
> > > > -			if (ebitmap_set_bit(&expr->type_names->types, sepol_type->s.val=
ue - 1, 1)) {
> > > > -				ebitmap_destroy(&type_bitmap);
> > > > +			if (sepol_type) {
> > > > +				rc =3D ebitmap_set_bit(&expr->type_names->types, sepol_type->s=
=2Evalue - 1, 1);
> > > > +			}
> > > > +
> > > > +			if (rc !=3D SEPOL_OK) {
> > > >  				goto exit;
> > > >  			}
> > > >  		}
> > > > diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil=
_internal.h
> > > > index 03672bb..efa2cd6 100644
> > > > --- a/libsepol/cil/src/cil_internal.h
> > > > +++ b/libsepol/cil/src/cil_internal.h
> > > > @@ -306,6 +306,8 @@ struct cil_db {
> > > >  	struct cil_user **val_to_user;
> > > >  	int disable_dontaudit;
> > > >  	int disable_neverallow;
> > > > +	int attrs_expand_generated;
> > > > +	unsigned attrs_expand_size;
> > > >  	int preserve_tunables;
> > > >  	int handle_unknown;
> > > >  	int mls;
> > > > @@ -513,11 +515,14 @@ struct cil_type	{
> > > >  	int value;
> > > >  };
> > > >=20
> > > > +#define CIL_ATTR_AVRULE     0x01
> > > > +#define CIL_ATTR_NEVERALLOW 0x02
> > > > +#define CIL_ATTR_CONSTRAINT 0x04
> > > >  struct cil_typeattribute {
> > > >  	struct cil_symtab_datum datum;
> > > >  	struct cil_list *expr_list;
> > > >  	ebitmap_t *types;
> > > > -	int used;	// whether or not this typeattribute was used and shoul=
d be added to the binary
> > > > +	int used;	// whether or not this attribute was used in a binary p=
olicy rule
> > > >  };
> > > >=20
> > > >  struct cil_typeattributeset {
> > > > diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_pos=
t.c
> > > > index 089c02f..ae62ddb 100644
> > > > --- a/libsepol/cil/src/cil_post.c
> > > > +++ b/libsepol/cil/src/cil_post.c
> > > > @@ -1188,22 +1188,32 @@ exit:
> > > >  	return SEPOL_ERR;
> > > >  }
> > > >=20
> > > > -static int cil_typeattribute_used(struct cil_typeattribute *cil_at=
tr)
> > > > +static int cil_typeattribute_used(struct cil_typeattribute *attr, =
struct cil_db *db)
> > > >  {
> > > > -	if (cil_attr->used) {
> > > > -		return CIL_TRUE;
> > > > +	if (!attr->used) {
> > > > +		return CIL_FALSE;
> > > >  	}
> > > >=20
> > > > -	if (strcmp(DATUM(cil_attr)->name, GEN_REQUIRE_ATTR) =3D=3D 0) {
> > > > -		return CIL_FALSE;
> > > > +	if (attr->used & CIL_ATTR_CONSTRAINT) {
> > > > +		return CIL_TRUE;
> > > >  	}
> > > >=20
> > > > -	if (strstr(DATUM(cil_attr)->name,TYPEATTR_INFIX) !=3D NULL) {
> > > > -		return CIL_FALSE;
> > > > +	if (db->attrs_expand_generated || attr->used =3D=3D CIL_ATTR_NEVE=
RALLOW) {
> > > > +		if (strcmp(DATUM(attr)->name, GEN_REQUIRE_ATTR) =3D=3D 0) {
> > > > +			return CIL_FALSE;
> > > > +		} else if (strstr(DATUM(attr)->name, TYPEATTR_INFIX) !=3D NULL) {
> > > > +			return CIL_FALSE;
> > > > +		}
> > > > +
> > > > +		if (attr->used =3D=3D CIL_ATTR_NEVERALLOW) {
> > > > +			return CIL_TRUE;
> > > > +		}
> > > >  	}
> > > >=20
> > > > -	if (ebitmap_cardinality(cil_attr->types) =3D=3D 0) {
> > > > -		return CIL_FALSE;
> > > > +	if (attr->used =3D=3D CIL_ATTR_AVRULE) {
> > > > +		if (ebitmap_cardinality(attr->types) < db->attrs_expand_size) {
> > > > +			return CIL_FALSE;
> > > > +		}
> > > >  	}
> > > >=20
> > > >  	return CIL_TRUE;
> > > > @@ -1231,9 +1241,7 @@ static int __cil_post_db_attr_helper(struct c=
il_tree_node *node, uint32_t *finis
> > > >  		if (attr->types =3D=3D NULL) {
> > > >  			rc =3D __evaluate_type_expression(attr, db);
> > > >  			if (rc !=3D SEPOL_OK) goto exit;
> > > > -			if (cil_typeattribute_used(attr)) {
> > > > -				attr->used =3D CIL_TRUE;
> > > > -			}
> > > > +			attr->used =3D cil_typeattribute_used(attr, db);
> > > >  		}
> > > >  		break;
> > > >  	}
> > > > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/=
cil_resolve_ast.c
> > > > index 1870501..6da44ba 100644
> > > > --- a/libsepol/cil/src/cil_resolve_ast.c
> > > > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > > > @@ -269,13 +269,13 @@ exit:
> > > >  	return rc;
> > > >  }
> > > >=20
> > > > -int cil_type_used(struct cil_symtab_datum *datum)
> > > > +int cil_type_used(struct cil_symtab_datum *datum, int used)
> > > >  {
> > > >  	struct cil_typeattribute *attr =3D NULL;
> > > >=20
> > > >  	if (FLAVOR(datum) =3D=3D CIL_TYPEATTRIBUTE) {
> > > >  		attr =3D (struct cil_typeattribute*)datum;
> > > > -		attr->used =3D CIL_TRUE;
> > > > +		attr->used |=3D used;
> > > >  	}
> > > >=20
> > > >  	return 0;
> > > > @@ -307,6 +307,7 @@ int cil_resolve_avrule(struct cil_tree_node *cu=
rrent, void *extra_args)
> > > >  	struct cil_symtab_datum *src_datum =3D NULL;
> > > >  	struct cil_symtab_datum *tgt_datum =3D NULL;
> > > >  	struct cil_symtab_datum *permx_datum =3D NULL;
> > > > +	int used;
> > > >  	int rc =3D SEPOL_ERR;
> > > >=20
> > > >  	if (args !=3D NULL) {
> > > > @@ -318,9 +319,6 @@ int cil_resolve_avrule(struct cil_tree_node *cu=
rrent, void *extra_args)
> > > >  		goto exit;
> > > >  	}
> > > >  	rule->src =3D src_datum;
> > > > -	if (rule->rule_kind !=3D CIL_AVRULE_NEVERALLOW) {
> > > > -		cil_type_used(src_datum);
> > > > -	}
> > > >  	=09
> > > >  	if (rule->tgt_str =3D=3D CIL_KEY_SELF) {
> > > >  		rule->tgt =3D db->selftype;
> > > > @@ -330,9 +328,10 @@ int cil_resolve_avrule(struct cil_tree_node *c=
urrent, void *extra_args)
> > > >  			goto exit;
> > > >  		}
> > > >  		rule->tgt =3D tgt_datum;
> > > > -		if (rule->rule_kind !=3D CIL_AVRULE_NEVERALLOW) {
> > > > -			cil_type_used(tgt_datum);
> > > > -		}
> > > > +		used =3D (rule->rule_kind =3D=3D CIL_AVRULE_NEVERALLOW) ?
> > > > +			CIL_ATTR_NEVERALLOW : CIL_ATTR_AVRULE;
> > > > +		cil_type_used(src_datum, used); /* src not used if tgt is self */
> > > > +		cil_type_used(tgt_datum, used);
> > > >  	}
> > > >=20
> > > >  	if (!rule->is_extended) {
> > > > @@ -376,14 +375,12 @@ int cil_resolve_type_rule(struct cil_tree_nod=
e *current, void *extra_args)
> > > >  		goto exit;
> > > >  	}
> > > >  	rule->src =3D src_datum;
> > > > -	cil_type_used(src_datum);
> > > >=20
> > > >  	rc =3D cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, ex=
tra_args, &tgt_datum);
> > > >  	if (rc !=3D SEPOL_OK) {
> > > >  		goto exit;
> > > >  	}
> > > >  	rule->tgt =3D tgt_datum;
> > > > -	cil_type_used(tgt_datum);
> > > >=20
> > > >  	rc =3D cil_resolve_name(current, rule->obj_str, CIL_SYM_CLASSES, =
extra_args, &obj_datum);
> > > >  	if (rc !=3D SEPOL_OK) {
> > > > @@ -589,14 +586,12 @@ int cil_resolve_nametypetransition(struct cil=
_tree_node *current, void *extra_ar
> > > >  		goto exit;
> > > >  	}
> > > >  	nametypetrans->src =3D src_datum;
> > > > -	cil_type_used(src_datum);
> > > >=20
> > > >  	rc =3D cil_resolve_name(current, nametypetrans->tgt_str, CIL_SYM_=
TYPES, extra_args, &tgt_datum);
> > > >  	if (rc !=3D SEPOL_OK) {
> > > >  		goto exit;
> > > >  	}
> > > >  	nametypetrans->tgt =3D tgt_datum;
> > > > -	cil_type_used(tgt_datum);
> > > >=20
> > > >  	rc =3D cil_resolve_name(current, nametypetrans->obj_str, CIL_SYM_=
CLASSES, extra_args, &obj_datum);
> > > >  	if (rc !=3D SEPOL_OK) {
> > > > @@ -647,14 +642,12 @@ int cil_resolve_rangetransition(struct cil_tr=
ee_node *current, void *extra_args)
> > > >  		goto exit;
> > > >  	}
> > > >  	rangetrans->src =3D src_datum;
> > > > -	cil_type_used(src_datum);
> > > >=20
> > > >  	rc =3D cil_resolve_name(current, rangetrans->exec_str, CIL_SYM_TY=
PES, extra_args, &exec_datum);
> > > >  	if (rc !=3D SEPOL_OK) {
> > > >  		goto exit;
> > > >  	}
> > > >  	rangetrans->exec =3D exec_datum;
> > > > -	cil_type_used(exec_datum);
> > > >=20
> > > >  	rc =3D cil_resolve_name(current, rangetrans->obj_str, CIL_SYM_CLA=
SSES, extra_args, &obj_datum);
> > > >  	if (rc !=3D SEPOL_OK) {
> > > > @@ -1006,7 +999,6 @@ int cil_resolve_roletype(struct cil_tree_node =
*current, void *extra_args)
> > > >  		goto exit;
> > > >  	}
> > > >  	roletype->type =3D (struct cil_type*)type_datum;
> > > > -	cil_type_used(type_datum);
> > > >=20
> > > >  	return SEPOL_OK;
> > > >=20
> > > > @@ -1035,7 +1027,6 @@ int cil_resolve_roletransition(struct cil_tre=
e_node *current, void *extra_args)
> > > >  		goto exit;
> > > >  	}
> > > >  	roletrans->tgt =3D tgt_datum;
> > > > -	cil_type_used(tgt_datum);
> > > >=20
> > > >  	rc =3D cil_resolve_name(current, roletrans->obj_str, CIL_SYM_CLAS=
SES, extra_args, &obj_datum);
> > > >  	if (rc !=3D SEPOL_OK) {
> > > > @@ -3108,7 +3099,7 @@ int cil_resolve_expr(enum cil_flavor expr_typ=
e, struct cil_list *str_expr, struc
> > > >  			}
> > > >=20
> > > >  			if (sym_index =3D=3D CIL_SYM_TYPES && (expr_type =3D=3D CIL_CON=
STRAIN || expr_type =3D=3D CIL_VALIDATETRANS)) {
> > > > -				cil_type_used(res_datum);
> > > > +				cil_type_used(res_datum, CIL_ATTR_CONSTRAINT);
> > > >  			}
> > > >=20
> > > >  			cil_list_append(*datum_expr, CIL_DATUM, res_datum);
> > > > diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.m=
ap.in
> > > > index 5e68fcb..4042640 100644
> > > > --- a/libsepol/src/libsepol.map.in
> > > > +++ b/libsepol/src/libsepol.map.in
> > > > @@ -45,6 +45,8 @@ LIBSEPOL_1.1 {
> > > >  	cil_set_target_platform;
> > > >  	cil_set_policy_version;
> > > >  	cil_set_mls;
> > > > +	cil_set_attrs_expand_generated;
> > > > +	cil_set_attrs_expand_size;
> > > >  	cil_write_policy_conf;
> > > >  	sepol_ppfile_to_module_package;
> > > >  	sepol_module_package_to_cil;
> > > > --
> > > > 2.7.4
> > > >=20
> > > > _______________________________________________
> > > > Selinux mailing list
> > > > Selinux@tycho.nsa.gov
> > > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > > To get help, send an email containing "help" to Selinux-request@tyc=
ho.nsa.gov.
> > >=20
> > > --
> > > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7=
B6B02
> > > Dominick Grift
> >=20
> >=20
> >=20
> >=20
> >=20
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
> >=20
>=20
>=20
> --=20
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljtL5sACgkQJXSOVTf5
R2lqhwv/f9ia7d2B1HUEPSg9lE5m+7PLq4CJJCYHLUJ/lDYrrILPTW/TOukkCEHv
FruuU0c+EJL+26ukiwlLacAkVb14xt8/v+ImS/8/791UFa9zsHAZZujbPDSUtlwn
8DG0vIQr2uxB1naDjvjLGkuG0YpW6A1NeSeqVB4hWDoEdJAx0QA/WEz/sk223ZUj
1sx1VScXZHHOet6d+Hhp+A9182KKupZEVdZzEexUOXPn/pCcUbUL3ml6uQSkusZN
9hmhr8XFJww0VA21xC0NRTDMr/dAgneBGHjkld12AELwP11CT5BPJc8k/8PP9cl2
I9j7irVH1yzIQ3c69Zkzn80+6zbcLB/bQY7sj3b4ja/wifwt7UtEltLliEJGlg+1
qBD287EqQ4g32hKAa5DYNlWOVqeBJEDE2MoK3R4MPD0QNargxhBQMuSju9/zP8B3
ywN5NSx1QzJXer1zVDr13rg6OKBBc05OwpQ27LfR6UP5t+at9TkpmVWZBfSaa6ST
eT0WZYOK
=xQkW
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
