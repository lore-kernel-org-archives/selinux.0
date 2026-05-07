Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61206165F16
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778190330; cv=none; b=KOoOYDkMmjc0AKWLhl5RXZWY9LL4bLU39V2rdAY8WxlXf+/kPhxewaLURXNt83yH9sCE0JFulCBwJTYpSQZUbxBBEjhQmYeBJ3OuSin6ir3fBObRp9/iFt068T6lDLMQg7+Xh/s8vH4ep+xWzO14ut5eUJVe6eCGVyZxdMUhgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778190330; c=relaxed/simple;
	bh=OkIzKRACOJCkPz+hsogplYKW9HCn9OzsTHT7/ThKW0s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=TN6nH+dm0xytAxION5QFaXjw44rINFCGI/xOODoEQ5UTFP2p2AsG5l7jUo9hPrWvNq8RiZcBkqiVwqQeJgKJLdM3aPdZ8KK/RFEcRIizrEpPrDq37yGK62IBGGQ90U2KswkK4ELrHj7Pic+Mc4tCrjtPBeVuDzcFWHrbNqy9Hi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=GcSJrQbm; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="GcSJrQbm"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 470E624140D
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 23:45:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1778190325; bh=K17zBmthqSZIKLIV1ZaUhZ6w8+4Nv3sxMcIcThMr6SI=;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
	 Message-Id:Subject:From:To:From;
	b=GcSJrQbmEZLr7qNQLg06rB/4DYy2iu+Jl50MCfFwT/b2Uxk3uoQvP5StU40yE6N1a
	 C5WkW6WNV13mqVTFzKAAS237aHw61RDKpQKOJRAoK2/jO17fIHIk0LZQ+2R7s+xT5t
	 WmKbh8RzeoHfue+SN9n54Yb5seyVIpzOHgr1uQXwugCnmDfwYaY4ZMBrMTzLdaZN/N
	 Kfz5NwSFXxKp6TpaMZi5yTSTGGMRwHQ6NrIYplXrulrMHYrWOcZ35tqKwqJJ267umE
	 od74Z22q5xxprqzocSbdgUWJYwiyXgnMqbeh78eoo2qf79aboiXUNhzjjvEuFeiNx0
	 0V6X8YZIpYd8Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gBQlm5qG6z6tx0;
	Thu,  7 May 2026 23:45:24 +0200 (CEST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 May 2026 21:45:25 +0000
Message-Id: <DICRV1S9SASW.2NQC19L5E71QA@posteo.uk>
Subject: Re: [PATCH] checkpolicy: replace malloc()+memset() with calloc()
From: "Rahul Sandhu" <nvraxn@posteo.uk>
To: "Kalevi Kolttonen" <kalevi@kolttonen.fi>, <selinux@vger.kernel.org>
References: <20260507213838.85273-1-kalevi@kolttonen.fi>
In-Reply-To: <20260507213838.85273-1-kalevi@kolttonen.fi>

On Thu May 7, 2026 at 10:38 PM BST, Kalevi Kolttonen wrote:

This overall looks like a good change. I have a few nit suggestions.

> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> ---
>  checkpolicy/policy_define.c | 81 +++++++++++++------------------------
>  1 file changed, 27 insertions(+), 54 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index b73de45c..a08cdf59 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -175,12 +175,11 @@ int define_class(void)
>  		yyerror("no class name for class definition?");
>  		return -1;
>  	}
> -	datum =3D (class_datum_t *) malloc(sizeof(class_datum_t));
> +	datum =3D (class_datum_t *) calloc(1, sizeof(class_datum_t));

What is the point of the cast from void * here? I do realize that this is n=
ot
something that you introduced, but given that said cast is not consistently
applied, even in this file, and is a bit pointless, I'd personally say we m=
ay
as well just drop it whilst we're at it.

Also, I am of the opinion that it is preferred to use *foo over sizeof(type=
),
i.e. in this case *datum instead of sizeof(class_datum_t). Whilst this _is_=
 a
purely stylistic change, it does carry some practical benifits too. Namely,=
 if
the type of datum changes in the future, one can't accidently forget to upd=
ate
the call to calloc()!

>  	if (!datum) {
>  		yyerror("out of memory");
>  		goto cleanup;
>  	}
> -	memset(datum, 0, sizeof(class_datum_t));
>  	ret =3D declare_symbol(SYM_CLASSES, id, datum, &value, &value);
>  	switch (ret) {
>  	case -3:{
> @@ -354,12 +353,11 @@ int define_initial_sid(void)
>  		yyerror("no sid name for SID definition?");
>  		return -1;
>  	}
> -	newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> +	newc =3D (ocontext_t *) calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		goto bad;
>  	}
> -	memset(newc, 0, sizeof(ocontext_t));
>  	newc->u.name =3D id;
>  	context_init(&newc->context[0]);
>  	head =3D policydbp->ocontexts[OCON_ISID];
> @@ -579,12 +577,11 @@ int define_common_perms(void)
>  		free(id);
>  		return -1;
>  	}
> -	comdatum =3D (common_datum_t *) malloc(sizeof(common_datum_t));
> +	comdatum =3D (common_datum_t *) calloc(1, sizeof(common_datum_t));
>  	if (!comdatum) {
>  		yyerror("out of memory");
>  		goto bad;
>  	}
> -	memset(comdatum, 0, sizeof(common_datum_t));
>  	ret =3D hashtab_insert(policydbp->p_commons.table,
>  			     (hashtab_key_t) id, (hashtab_datum_t) comdatum);
> =20
> @@ -603,12 +600,11 @@ int define_common_perms(void)
>  	}
>  	policydbp->p_commons.nprim++;
>  	while ((perm =3D queue_remove(id_queue))) {
> -		perdatum =3D (perm_datum_t *) malloc(sizeof(perm_datum_t));
> +		perdatum =3D (perm_datum_t *) calloc(1, sizeof(perm_datum_t));
>  		if (!perdatum) {
>  			yyerror("out of memory");
>  			goto bad_perm;
>  		}
> -		memset(perdatum, 0, sizeof(perm_datum_t));
>  		perdatum->s.value =3D comdatum->permissions.nprim + 1;
> =20
>  		if (perdatum->s.value > (sizeof(sepol_access_vector_t) * 8)) {
> @@ -713,12 +709,11 @@ int define_av_perms(int inherits)
>  		cladatum->permissions.nprim +=3D comdatum->permissions.nprim;
>  	}
>  	while ((id =3D queue_remove(id_queue))) {
> -		perdatum =3D (perm_datum_t *) malloc(sizeof(perm_datum_t));
> +		perdatum =3D (perm_datum_t *) calloc(1, sizeof(perm_datum_t));
>  		if (!perdatum) {
>  			yyerror("out of memory");
>  			goto bad;
>  		}
> -		memset(perdatum, 0, sizeof(perm_datum_t));
>  		perdatum->s.value =3D ++cladatum->permissions.nprim;
> =20
>  		if (perdatum->s.value > (sizeof(sepol_access_vector_t) * 8)) {
> @@ -1330,13 +1325,12 @@ static int add_aliases_to_type(type_datum_t * typ=
e)
>  			free(id);
>  			return -1;
>  		}
> -		aliasdatum =3D (type_datum_t *) malloc(sizeof(type_datum_t));
> +		aliasdatum =3D (type_datum_t *) calloc(1, sizeof(type_datum_t));
>  		if (!aliasdatum) {
>  			free(id);
>  			yyerror("Out of memory!");
>  			return -1;
>  		}
> -		memset(aliasdatum, 0, sizeof(type_datum_t));
>  		aliasdatum->s.value =3D type->s.value;
> =20
>  		ret =3D declare_symbol(SYM_TYPES, id, aliasdatum,
> @@ -1890,13 +1884,12 @@ int define_bool_tunable(int is_tunable)
>  		free(id);
>  		return -1;
>  	}
> -	datum =3D (cond_bool_datum_t *) malloc(sizeof(cond_bool_datum_t));
> +	datum =3D (cond_bool_datum_t *) calloc(1, sizeof(cond_bool_datum_t));
>  	if (!datum) {
>  		yyerror("out of memory");
>  		free(id);
>  		return -1;
>  	}
> -	memset(datum, 0, sizeof(cond_bool_datum_t));
>  	if (is_tunable)
>  		datum->flags |=3D COND_BOOL_FLAGS_TUNABLE;
>  	ret =3D declare_symbol(SYM_BOOLS, id, datum, &value, &value);
> @@ -3343,12 +3336,11 @@ int define_role_trans(int class_specified)
>  					}
>  				}
> =20
> -				tr =3D malloc(sizeof(struct role_trans));
> +				tr =3D calloc(1, sizeof(struct role_trans));
>  				if (!tr) {
>  					yyerror("out of memory");
>  					goto bad;
>  				}
> -				memset(tr, 0, sizeof(struct role_trans));
>  				tr->role =3D i + 1;
>  				tr->type =3D j + 1;
>  				tr->tclass =3D k + 1;
> @@ -3359,12 +3351,11 @@ int define_role_trans(int class_specified)
>  		}
>  	}
>  	/* Now add the real rule */
> -	rule =3D malloc(sizeof(struct role_trans_rule));
> +	rule =3D calloc(1, sizeof(struct role_trans_rule));
>  	if (!rule) {
>  		yyerror("out of memory");
>  		goto bad;
>  	}
> -	memset(rule, 0, sizeof(struct role_trans_rule));
>  	rule->roles =3D roles;
>  	rule->types =3D types;
>  	rule->classes =3D e_classes;
> @@ -3731,13 +3722,12 @@ int define_constraint(constraint_expr_t * expr)
>  			free(id);
>  			goto bad;
>  		}
> -		node =3D malloc(sizeof(struct constraint_node));
> +		node =3D calloc(1, sizeof(struct constraint_node));
>  		if (!node) {
>  			yyerror("out of memory");
>  			free(node);
>  			goto bad;
>  		}
> -		memset(node, 0, sizeof(constraint_node_t));
>  		if (useexpr) {
>  			node->expr =3D expr;
>  			useexpr =3D 0;
> @@ -3892,13 +3882,12 @@ int define_validatetrans(constraint_expr_t * expr=
)
>  			goto bad;
>  		}
> =20
> -		node =3D malloc(sizeof(struct constraint_node));
> +		node =3D calloc(1, sizeof(struct constraint_node));
>  		if (!node) {
>  			yyerror("out of memory");
>  			free(id);
>  			goto bad;
>  		}
> -		memset(node, 0, sizeof(constraint_node_t));
>  		if (useexpr) {
>  			node->expr =3D expr;
>  			useexpr =3D 0;
> @@ -4209,12 +4198,11 @@ cond_expr_t *define_cond_expr(uint32_t expr_type,=
 void *arg1, void *arg2)
>  	}
> =20
>  	/* create a new expression struct */
> -	expr =3D malloc(sizeof(struct cond_expr));
> +	expr =3D calloc(1, sizeof(struct cond_expr));
>  	if (!expr) {
>  		yyerror("out of memory");
>  		return NULL;
>  	}
> -	memset(expr, 0, sizeof(cond_expr_t));
>  	expr->expr_type =3D expr_type;
> =20
>  	/* create the type asked for */
> @@ -4864,12 +4852,11 @@ int define_fs_context(unsigned int major, unsigne=
d int minor)
>  		return 0;
>  	}
> =20
> -	newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> +	newc =3D (ocontext_t *) calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> -	memset(newc, 0, sizeof(ocontext_t));
> =20
>  	newc->u.name =3D (char *)malloc(6);
>  	if (!newc->u.name) {
> @@ -4924,12 +4911,11 @@ int define_pirq_context(unsigned int pirq)
>  		return 0;
>  	}
> =20
> -	newc =3D malloc(sizeof(ocontext_t));
> +	newc =3D calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> -	memset(newc, 0, sizeof(ocontext_t));
> =20
>  	newc->u.pirq =3D pirq;
> =20
> @@ -4975,12 +4961,11 @@ int define_iomem_context(uint64_t low, uint64_t h=
igh)
>  		return 0;
>  	}
> =20
> -	newc =3D malloc(sizeof(ocontext_t));
> +	newc =3D calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> -	memset(newc, 0, sizeof(ocontext_t));
> =20
>  	newc->u.iomem.low_iomem  =3D low;
>  	newc->u.iomem.high_iomem =3D high;
> @@ -5036,12 +5021,11 @@ int define_ioport_context(unsigned long low, unsi=
gned long high)
>  		return 0;
>  	}
> =20
> -	newc =3D malloc(sizeof(ocontext_t));
> +	newc =3D calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> -	memset(newc, 0, sizeof(ocontext_t));
> =20
>  	newc->u.ioport.low_ioport  =3D low;
>  	newc->u.ioport.high_ioport =3D high;
> @@ -5097,12 +5081,11 @@ int define_pcidevice_context(unsigned long device=
)
>  		return 0;
>  	}
> =20
> -	newc =3D malloc(sizeof(ocontext_t));
> +	newc =3D calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> -	memset(newc, 0, sizeof(ocontext_t));
> =20
>  	newc->u.device =3D device;
> =20
> @@ -5150,12 +5133,11 @@ int define_devicetree_context(void)
>  		return 0;
>  	}
> =20
> -	newc =3D malloc(sizeof(ocontext_t));
> +	newc =3D calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> -	memset(newc, 0, sizeof(ocontext_t));
> =20
>  	newc->u.name =3D (char *)queue_remove(id_queue);
>  	if (!newc->u.name) {
> @@ -5208,12 +5190,11 @@ int define_port_context(unsigned int low, unsigne=
d int high)
>  		return 0;
>  	}
> =20
> -	newc =3D malloc(sizeof(ocontext_t));
> +	newc =3D calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> -	memset(newc, 0, sizeof(ocontext_t));
> =20
>  	id =3D (char *)queue_remove(id_queue);
>  	if (!id) {
> @@ -5301,12 +5282,11 @@ int define_ibpkey_context(unsigned int low, unsig=
ned int high)
>  		return 0;
>  	}
> =20
> -	newc =3D malloc(sizeof(*newc));
> +	newc =3D calloc(1, sizeof(*newc));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> -	memset(newc, 0, sizeof(*newc));
> =20
>  	id =3D queue_remove(id_queue);
>  	if (!id) {
> @@ -5411,12 +5391,11 @@ int define_ibendport_context(unsigned int port)
>  		return -1;
>  	}
> =20
> -	newc =3D malloc(sizeof(*newc));
> +	newc =3D calloc(1, sizeof(*newc));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> -	memset(newc, 0, sizeof(*newc));
> =20
>  	newc->u.ibendport.dev_name =3D queue_remove(id_queue);
>  	if (!newc->u.ibendport.dev_name) {
> @@ -5484,12 +5463,11 @@ int define_netif_context(void)
>  		return 0;
>  	}
> =20
> -	newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> +	newc =3D (ocontext_t *) calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> -	memset(newc, 0, sizeof(ocontext_t));
> =20
>  	newc->u.name =3D (char *)queue_remove(id_queue);
>  	if (!newc->u.name) {
> @@ -5615,13 +5593,12 @@ int define_ipv4_node_context(void)
>  		yywarn("host bits in ipv4 address set");
>  	}
> =20
> -	newc =3D malloc(sizeof(ocontext_t));
> +	newc =3D calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> =20
> -	memset(newc, 0, sizeof(ocontext_t));
>  	newc->u.node.addr =3D addr.s_addr;
>  	newc->u.node.mask =3D mask.s_addr;
> =20
> @@ -5864,13 +5841,12 @@ int define_ipv6_node_context(void)
>  		yywarn("host bits in ipv6 address set");
>  	}
> =20
> -	newc =3D malloc(sizeof(ocontext_t));
> +	newc =3D calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> =20
> -	memset(newc, 0, sizeof(ocontext_t));
>  	memcpy(&newc->u.node6.addr[0], &addr.s6_addr[0], 16);
>  	memcpy(&newc->u.node6.mask[0], &mask.s6_addr[0], 16);
> =20
> @@ -5975,12 +5951,11 @@ int define_fs_use(int behavior)
>  		return 0;
>  	}
> =20
> -	newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> +	newc =3D (ocontext_t *) calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> -	memset(newc, 0, sizeof(ocontext_t));
> =20
>  	newc->u.name =3D (char *)queue_remove(id_queue);
>  	if (!newc->u.name) {
> @@ -6043,12 +6018,11 @@ static int define_genfs_context_helper(char *fsty=
pe, int has_type)
>  	}
> =20
>  	if (!genfs || strcmp(fstype, genfs->fstype)) {
> -		newgenfs =3D malloc(sizeof(struct genfs));
> +		newgenfs =3D calloc(1, sizeof(struct genfs));
>  		if (!newgenfs) {
>  			yyerror("out of memory");
>  			return -1;
>  		}
> -		memset(newgenfs, 0, sizeof(struct genfs));
>  		newgenfs->fstype =3D fstype;
>  		newgenfs->next =3D genfs;
>  		if (genfs_p)
> @@ -6061,12 +6035,11 @@ static int define_genfs_context_helper(char *fsty=
pe, int has_type)
>  		fstype =3D NULL;
>  	}
> =20
> -	newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> +	newc =3D (ocontext_t *) calloc(1, sizeof(ocontext_t));
>  	if (!newc) {
>  		yyerror("out of memory");
>  		return -1;
>  	}
> -	memset(newc, 0, sizeof(ocontext_t));
> =20
>  	newc->u.name =3D (char *)queue_remove(id_queue);
>  	if (!newc->u.name)

