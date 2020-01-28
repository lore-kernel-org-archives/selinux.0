Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDD5C2D0DB
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 18:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185B02173E
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 18:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgA1SEW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:04:22 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:41174 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgA1SEW (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 28 Jan 2020 13:04:22 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id D79EF132060C;
        Tue, 28 Jan 2020 19:04:20 +0100 (CET)
Date:   Tue, 28 Jan 2020 19:04:18 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] libsepol,checkpolicy: support omitting unused initial
 sid contexts
Message-ID: <20200128180418.GC36656@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
References: <20200128172600.12896-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <20200128172600.12896-1-sds@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2020 at 12:26:00PM -0500, Stephen Smalley wrote:
> Remove restrictions in libsepol and checkpolicy that required all
> declared initial SIDs to be assigned a context.  With this patch,
> it is possible to build and load a policy that drops the sid <sidname>
> <context> declarations for the unused initial SIDs.  It is still
> required to retain the sid <sidname> declarations (in the flask
> definitions) in order to preserve the initial SID ordering/values.
> The unused initial SIDs can be renamed, e.g. to add an unused_
> prefix or similar, if desired, since the names used in the policy
> are not stored in the kernel binary policy.
>=20
> In CIL policies, the (sid ...) and (sidorder (...)) statements
> must be left intact for compatibility but the (sidcontext ...)
> statements for the unused initial SIDs can be omitted after this change.
>=20
> With current kernels, if one removes an unused initial SID context
> from policy, builds policy with this change applied and loads the
> policy into the kernel, cat /sys/fs/selinux/initial_contexts/<sidname>
> will show the unlabeled context.  With the kernel patch to remove unused
> initial SIDs, the /sys/fs/selinux/initial_contexts/<sidname>
> file will not be created for unused initial SIDs in the first place.
>=20
> NB If an unused initial SID was assigned a context different from
> the unlabeled context in existing policy, then it is not safe to
> remove that initial SID context from policy and reload policy on
> the running kernel that was booted with the original policy.  This
> is because that kernel may have assigned that SID to various kernel
> objects already and those objects will then be treated as having
> the unlabeled context after the removal.  In refpolicy, examples
> of such initial SIDs are the "fs" SID and the "sysctl" SID.  Even
> though these initial SIDs are not directly used (in code) by the current
> kernel, their contexts are being applied to filesystems and sysctl files =
by
> policy and therefore the SIDs are being assigned to objects.
>=20
> NB The "sysctl" SID was in use by the kernel up until
> commit 8e6c96935fcc1ed3dbebc96fddfef3f2f2395afc ("security/selinux:
> fix /proc/sys/ labeling) circa v2.6.39.  Removing its context from
> policy will break kernels < 2.6.39.
>=20
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks

> ---
>  checkpolicy/test/dismod.c     |  6 +++--
>  libsepol/cil/src/cil_binary.c |  4 ++-
>  libsepol/cil/src/cil_verify.c | 10 -------
>  libsepol/src/expand.c         |  8 ++----
>  libsepol/src/policydb.c       | 51 ++++++++++++++++++++++++-----------
>  5 files changed, 44 insertions(+), 35 deletions(-)
>=20
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index 8d6be2ff9522..49d610d94b00 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -441,11 +441,13 @@ void display_initial_sids(policydb_t * p, FILE * fp)
> =20
>  	fprintf(fp, "Initial SIDs:\n");
>  	for (cur =3D p->ocontexts[OCON_ISID]; cur !=3D NULL; cur =3D cur->next)=
 {
> +		if (!cur->context[0].user)
> +			continue;
>  		user =3D p->p_user_val_to_name[cur->context[0].user - 1];
>  		role =3D p->p_role_val_to_name[cur->context[0].role - 1];
>  		type =3D p->p_type_val_to_name[cur->context[0].type - 1];
> -		fprintf(fp, "\t%s: sid %d, context %s:%s:%s\n",
> -			cur->u.name, cur->sid[0], user, role, type);
> +		fprintf(fp, "\tsid %d, context %s:%s:%s\n",
> +			cur->sid[0], user, role, type);
>  	}
>  #if 0
>  	fprintf(fp, "Policy Initial SIDs:\n");
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index f8e20d32f9f1..e52b6679c289 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -3067,9 +3067,11 @@ int cil_sidorder_to_policydb(policydb_t *pdb, cons=
t struct cil_db *db)
>  		struct cil_sid *cil_sid =3D (struct cil_sid*)curr->data;
>  		struct cil_context *cil_context =3D cil_sid->context;
> =20
> +		/* even if no context, we must preserve initial SID values */
> +		count++;
> +
>  		if (cil_context !=3D NULL) {
>  			ocontext_t *new_ocon =3D cil_add_ocontext(&pdb->ocontexts[OCON_ISID],=
 &tail);
> -			count++;
>  			new_ocon->sid[0] =3D count;
>  			new_ocon->u.name =3D cil_strdup(cil_sid->datum.fqn);
>  			rc =3D __cil_context_to_sepol_context(pdb, cil_context, &new_ocon->co=
ntext[0]);
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 018514dc1bb9..0367a8e58273 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -428,22 +428,12 @@ int __cil_verify_ordered(struct cil_tree_node *curr=
ent, enum cil_flavor flavor)
>  int __cil_verify_initsids(struct cil_list *sids)
>  {
>  	int rc =3D SEPOL_OK;
> -	struct cil_list_item *i;
> =20
>  	if (sids->head =3D=3D NULL) {
>  		cil_log(CIL_ERR, "At least one initial sid must be defined in the poli=
cy\n");
>  		return SEPOL_ERR;
>  	}
> =20
> -	cil_list_for_each(i, sids) {
> -		struct cil_sid *sid =3D i->data;
> -		if (sid->context =3D=3D NULL) {
> -			struct cil_tree_node *node =3D sid->datum.nodes->head->data;
> -			cil_tree_log(node, CIL_ERR, "No context assigned to SID %s declared",=
sid->datum.name);
> -			rc =3D SEPOL_ERR;
> -		}
> -	}
> -
>  	return rc;
>  }
> =20
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 796121cf5ad8..5f8e75c38632 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2159,6 +2159,8 @@ static int ocontext_copy_selinux(expand_state_t *st=
ate)
>  	for (i =3D 0; i < OCON_NUM; i++) {
>  		l =3D NULL;
>  		for (c =3D state->base->ocontexts[i]; c; c =3D c->next) {
> +			if (i =3D=3D OCON_ISID && c->context[0].user =3D=3D 0)
> +				continue;
>  			n =3D malloc(sizeof(ocontext_t));
>  			if (!n) {
>  				ERR(state->handle, "Out of memory!");
> @@ -2172,12 +2174,6 @@ static int ocontext_copy_selinux(expand_state_t *s=
tate)
>  			l =3D n;
>  			switch (i) {
>  			case OCON_ISID:
> -				if (c->context[0].user =3D=3D 0) {
> -					ERR(state->handle,
> -					    "Missing context for %s initial sid",
> -					    c->u.name);
> -					return -1;
> -				}
>  				n->sid[0] =3D c->sid[0];
>  				break;
>  			case OCON_FS:	/* FALLTHROUGH */
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 745e546baa3a..03360c88e7d3 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1610,10 +1610,8 @@ int policydb_load_isids(policydb_t * p, sidtab_t *=
 s)
> =20
>  	head =3D p->ocontexts[OCON_ISID];
>  	for (c =3D head; c; c =3D c->next) {
> -		if (!c->context[0].user) {
> -			ERR(NULL, "SID %s was never defined", c->u.name);
> -			return -1;
> -		}
> +		if (!c->context[0].user)
> +			continue;
>  		if (sepol_sidtab_insert(s, c->sid[0], &c->context[0])) {
>  			ERR(NULL, "unable to load initial SID %s", c->u.name);
>  			return -1;
> @@ -2020,12 +2018,8 @@ static int mls_range_to_semantic(mls_range_t * r, =
mls_semantic_range_t * sr)
>  	return 0;
>  }
> =20
> -/*
> - * Read and validate a security context structure
> - * from a policydb binary representation file.
> - */
> -static int context_read_and_validate(context_struct_t * c,
> -				     policydb_t * p, struct policy_file *fp)
> +static int context_read_no_validate(context_struct_t * c,
> +				    policydb_t * p, struct policy_file *fp)
>  {
>  	uint32_t buf[3];
>  	int rc;
> @@ -2049,6 +2043,19 @@ static int context_read_and_validate(context_struc=
t_t * c,
>  		}
>  	}
> =20
> +	return 0;
> +}
> +
> +/*
> + * Read and validate a security context structure
> + * from a policydb binary representation file.
> + */
> +static int context_read_and_validate(context_struct_t * c,
> +				     policydb_t * p, struct policy_file *fp)
> +{
> +	if (context_read_no_validate(c, p, fp))
> +		return -1;
> +
>  	if (!policydb_context_isvalid(p, c)) {
>  		ERR(fp->handle, "invalid security context");
>  		context_destroy(c);
> @@ -2797,6 +2804,7 @@ static int ocontext_read_selinux(struct policydb_co=
mpat_info *info,
>  	unsigned int i, j;
>  	size_t nel, len;
>  	ocontext_t *l, *c;
> +	context_struct_t tmpc;
>  	uint32_t buf[8];
>  	int rc;
> =20
> @@ -2807,6 +2815,22 @@ static int ocontext_read_selinux(struct policydb_c=
ompat_info *info,
>  		nel =3D le32_to_cpu(buf[0]);
>  		l =3D NULL;
>  		for (j =3D 0; j < nel; j++) {
> +			if (i =3D=3D OCON_ISID) {
> +				rc =3D next_entry(buf, fp, sizeof(uint32_t));
> +				if (rc < 0)
> +					return -1;
> +				context_init(&tmpc);
> +				if (context_read_no_validate
> +				    (&tmpc, p, fp))
> +					return -1;
> +				if (!tmpc.user)
> +					continue;
> +				if (!policydb_context_isvalid(p, &tmpc)) {
> +				  ERR(fp->handle, "invalid security context");
> +				  context_destroy(&tmpc);
> +				  return -1;
> +				}
> +			}
>  			c =3D calloc(1, sizeof(ocontext_t));
>  			if (!c) {
>  				return -1;
> @@ -2819,13 +2843,8 @@ static int ocontext_read_selinux(struct policydb_c=
ompat_info *info,
>  			l =3D c;
>  			switch (i) {
>  			case OCON_ISID:
> -				rc =3D next_entry(buf, fp, sizeof(uint32_t));
> -				if (rc < 0)
> -					return -1;
>  				c->sid[0] =3D le32_to_cpu(buf[0]);
> -				if (context_read_and_validate
> -				    (&c->context[0], p, fp))
> -					return -1;
> +				memcpy(&c->context[0], &tmpc, sizeof tmpc);
>  				break;
>  			case OCON_FS:
>  			case OCON_NETIF:
> --=20
> 2.24.1
>=20

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl4wd5wACgkQAlFoDzf+
eRPXYRAAkDljLIMje7YLnXCUBaoSHGyBhMfMhwCx/X08mFEbfjaCpFj+r1dJVLhL
s5RY20unPjpD3F/w4rjL9Hv5NZyRDWQ/twWPzWlPxGmmQV31YvV6BrSNh03iESiD
NKQFSDZqr9c/bOncahcRzRxNAqPlEnD9Fa7SNt5eiRipoLEu4Xnd//1LFdNVAV0V
4yyvGUMFfqgNPT4ZqrS5EmTreLDhMpIUeCQaVOWaPCh/vvLBlmdOX+qX78/IiWZu
d5UcQqRaQHDYQjhL7Obfdw43VeqvgVq+gzjBU7m6Fe8PUiZYv/HMRBhNZyfbJhni
jSCPhXwxuYJle0WHoOhH34yNdYPuT/LVSe3QCSg+6kUSGthNiTnY+Bfb/BSyscrE
Evt5TE5F/8ocIQzMw3QBc5TeKlFCjjVdQQKqBBl8a3ve6nvHbWjoNLZAQrvlBtTo
DWQ13Z8KWOlZXHsWEaIwJNIMVdfQK3uY9qz1HGJD2IIQyA9K4JgvR9mLAIBgj2N+
NaDSWKduAKBAVG0Q5A6JLbS8vkXZ/zlPd0spPn3CPdOv1FnOPk4UE43aS9QZcauG
yWW0ETAUpWOxL+9ldnbuSseveIV8KGXCXEvUqbaj7+hfL1C9uosZu9hdTfjATuW5
RpdAcpqtnHesxosV80aiIMZ13idCj+Z4AIAPjtrZgAl1tqig2J4=
=Pmzd
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
