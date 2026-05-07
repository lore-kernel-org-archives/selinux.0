Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640482F8EAE
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189944; cv=none; b=FfS8dh/NSJjp2by1/D9pdp/PIPaGxC/WBA7ZUz38OujlAGrR9Ag+PbJwn4drC+acQJTOoroYNnu0n2RTRm1Lkrre7RXO9F2HS+EV3uBYdU5ZhbZKQ9m+54V7Zj1kHDBKgTldHRrbHLJlKwj373lH7gPTY2DLaobSuiEkPwLoEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189944; c=relaxed/simple;
	bh=qrzBCxgHhCV0LIWT6zOJA1ScNyhPFf4jiREkwxVWtKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+ty6i2oGKN7nQ+HV8R+fHxl3k5RLbZnAq0qN5+LLKPtoaSc+x153eaFTUeIjrewVRg0r4shDE7G8ByRzyPeI23CMuAljhfDzDx4FzuXDIRXYTDR8FB95ym1bvuEnZQu70hef/S2c9Es83nVnp26+W7tJ1LGht9M8TtGBRGeZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=eIDwph27; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="eIDwph27"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UEzd+LVwLBJEyVlS/CUO8hQCquRvDEqQb40GyvUTkh4=; b=eIDwph27Z4pasxM23Gn+JT/BqP
	S0sn7YYNGdm17nLF4WgJC3sEq3fZX2LrOKHGEJpuERFbyWQjjQYnUmIof3AsGTz8Rbrb3hZKykQAe
	6eRE8tZ0NZhILPjwc90wBmobt9WBVSY1J2AjCLddfneKolv8DEV/+E8RCy8F1dvn1NfouNueKW0GW
	oTRrY2SIxzN7djaeBO2HAXdnBogcWa4Y1RvjLxmIrXQsu430QvVzrhRdfybJKy0+vd9UXFX0gqTzw
	4AJ3Tp4ll5z85XDsSSQyxwwSiOAV+mAKFuwKXob/b4SHzZFc8BjSei0f+e+95XIydnAWx9hosMPnr
	NEO2AdnA==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11414 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wL6Qm-000000093vs-11AI;
	Fri, 08 May 2026 00:38:51 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] checkpolicy: replace malloc()+memset() with calloc()
Date: Fri,  8 May 2026 00:38:38 +0300
Message-ID: <20260507213838.85273-1-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 checkpolicy/policy_define.c | 81 +++++++++++++------------------------
 1 file changed, 27 insertions(+), 54 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index b73de45c..a08cdf59 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -175,12 +175,11 @@ int define_class(void)
 		yyerror("no class name for class definition?");
 		return -1;
 	}
-	datum = (class_datum_t *) malloc(sizeof(class_datum_t));
+	datum = (class_datum_t *) calloc(1, sizeof(class_datum_t));
 	if (!datum) {
 		yyerror("out of memory");
 		goto cleanup;
 	}
-	memset(datum, 0, sizeof(class_datum_t));
 	ret = declare_symbol(SYM_CLASSES, id, datum, &value, &value);
 	switch (ret) {
 	case -3:{
@@ -354,12 +353,11 @@ int define_initial_sid(void)
 		yyerror("no sid name for SID definition?");
 		return -1;
 	}
-	newc = (ocontext_t *) malloc(sizeof(ocontext_t));
+	newc = (ocontext_t *) calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		goto bad;
 	}
-	memset(newc, 0, sizeof(ocontext_t));
 	newc->u.name = id;
 	context_init(&newc->context[0]);
 	head = policydbp->ocontexts[OCON_ISID];
@@ -579,12 +577,11 @@ int define_common_perms(void)
 		free(id);
 		return -1;
 	}
-	comdatum = (common_datum_t *) malloc(sizeof(common_datum_t));
+	comdatum = (common_datum_t *) calloc(1, sizeof(common_datum_t));
 	if (!comdatum) {
 		yyerror("out of memory");
 		goto bad;
 	}
-	memset(comdatum, 0, sizeof(common_datum_t));
 	ret = hashtab_insert(policydbp->p_commons.table,
 			     (hashtab_key_t) id, (hashtab_datum_t) comdatum);
 
@@ -603,12 +600,11 @@ int define_common_perms(void)
 	}
 	policydbp->p_commons.nprim++;
 	while ((perm = queue_remove(id_queue))) {
-		perdatum = (perm_datum_t *) malloc(sizeof(perm_datum_t));
+		perdatum = (perm_datum_t *) calloc(1, sizeof(perm_datum_t));
 		if (!perdatum) {
 			yyerror("out of memory");
 			goto bad_perm;
 		}
-		memset(perdatum, 0, sizeof(perm_datum_t));
 		perdatum->s.value = comdatum->permissions.nprim + 1;
 
 		if (perdatum->s.value > (sizeof(sepol_access_vector_t) * 8)) {
@@ -713,12 +709,11 @@ int define_av_perms(int inherits)
 		cladatum->permissions.nprim += comdatum->permissions.nprim;
 	}
 	while ((id = queue_remove(id_queue))) {
-		perdatum = (perm_datum_t *) malloc(sizeof(perm_datum_t));
+		perdatum = (perm_datum_t *) calloc(1, sizeof(perm_datum_t));
 		if (!perdatum) {
 			yyerror("out of memory");
 			goto bad;
 		}
-		memset(perdatum, 0, sizeof(perm_datum_t));
 		perdatum->s.value = ++cladatum->permissions.nprim;
 
 		if (perdatum->s.value > (sizeof(sepol_access_vector_t) * 8)) {
@@ -1330,13 +1325,12 @@ static int add_aliases_to_type(type_datum_t * type)
 			free(id);
 			return -1;
 		}
-		aliasdatum = (type_datum_t *) malloc(sizeof(type_datum_t));
+		aliasdatum = (type_datum_t *) calloc(1, sizeof(type_datum_t));
 		if (!aliasdatum) {
 			free(id);
 			yyerror("Out of memory!");
 			return -1;
 		}
-		memset(aliasdatum, 0, sizeof(type_datum_t));
 		aliasdatum->s.value = type->s.value;
 
 		ret = declare_symbol(SYM_TYPES, id, aliasdatum,
@@ -1890,13 +1884,12 @@ int define_bool_tunable(int is_tunable)
 		free(id);
 		return -1;
 	}
-	datum = (cond_bool_datum_t *) malloc(sizeof(cond_bool_datum_t));
+	datum = (cond_bool_datum_t *) calloc(1, sizeof(cond_bool_datum_t));
 	if (!datum) {
 		yyerror("out of memory");
 		free(id);
 		return -1;
 	}
-	memset(datum, 0, sizeof(cond_bool_datum_t));
 	if (is_tunable)
 		datum->flags |= COND_BOOL_FLAGS_TUNABLE;
 	ret = declare_symbol(SYM_BOOLS, id, datum, &value, &value);
@@ -3343,12 +3336,11 @@ int define_role_trans(int class_specified)
 					}
 				}
 
-				tr = malloc(sizeof(struct role_trans));
+				tr = calloc(1, sizeof(struct role_trans));
 				if (!tr) {
 					yyerror("out of memory");
 					goto bad;
 				}
-				memset(tr, 0, sizeof(struct role_trans));
 				tr->role = i + 1;
 				tr->type = j + 1;
 				tr->tclass = k + 1;
@@ -3359,12 +3351,11 @@ int define_role_trans(int class_specified)
 		}
 	}
 	/* Now add the real rule */
-	rule = malloc(sizeof(struct role_trans_rule));
+	rule = calloc(1, sizeof(struct role_trans_rule));
 	if (!rule) {
 		yyerror("out of memory");
 		goto bad;
 	}
-	memset(rule, 0, sizeof(struct role_trans_rule));
 	rule->roles = roles;
 	rule->types = types;
 	rule->classes = e_classes;
@@ -3731,13 +3722,12 @@ int define_constraint(constraint_expr_t * expr)
 			free(id);
 			goto bad;
 		}
-		node = malloc(sizeof(struct constraint_node));
+		node = calloc(1, sizeof(struct constraint_node));
 		if (!node) {
 			yyerror("out of memory");
 			free(node);
 			goto bad;
 		}
-		memset(node, 0, sizeof(constraint_node_t));
 		if (useexpr) {
 			node->expr = expr;
 			useexpr = 0;
@@ -3892,13 +3882,12 @@ int define_validatetrans(constraint_expr_t * expr)
 			goto bad;
 		}
 
-		node = malloc(sizeof(struct constraint_node));
+		node = calloc(1, sizeof(struct constraint_node));
 		if (!node) {
 			yyerror("out of memory");
 			free(id);
 			goto bad;
 		}
-		memset(node, 0, sizeof(constraint_node_t));
 		if (useexpr) {
 			node->expr = expr;
 			useexpr = 0;
@@ -4209,12 +4198,11 @@ cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void *arg2)
 	}
 
 	/* create a new expression struct */
-	expr = malloc(sizeof(struct cond_expr));
+	expr = calloc(1, sizeof(struct cond_expr));
 	if (!expr) {
 		yyerror("out of memory");
 		return NULL;
 	}
-	memset(expr, 0, sizeof(cond_expr_t));
 	expr->expr_type = expr_type;
 
 	/* create the type asked for */
@@ -4864,12 +4852,11 @@ int define_fs_context(unsigned int major, unsigned int minor)
 		return 0;
 	}
 
-	newc = (ocontext_t *) malloc(sizeof(ocontext_t));
+	newc = (ocontext_t *) calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
-	memset(newc, 0, sizeof(ocontext_t));
 
 	newc->u.name = (char *)malloc(6);
 	if (!newc->u.name) {
@@ -4924,12 +4911,11 @@ int define_pirq_context(unsigned int pirq)
 		return 0;
 	}
 
-	newc = malloc(sizeof(ocontext_t));
+	newc = calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
-	memset(newc, 0, sizeof(ocontext_t));
 
 	newc->u.pirq = pirq;
 
@@ -4975,12 +4961,11 @@ int define_iomem_context(uint64_t low, uint64_t high)
 		return 0;
 	}
 
-	newc = malloc(sizeof(ocontext_t));
+	newc = calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
-	memset(newc, 0, sizeof(ocontext_t));
 
 	newc->u.iomem.low_iomem  = low;
 	newc->u.iomem.high_iomem = high;
@@ -5036,12 +5021,11 @@ int define_ioport_context(unsigned long low, unsigned long high)
 		return 0;
 	}
 
-	newc = malloc(sizeof(ocontext_t));
+	newc = calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
-	memset(newc, 0, sizeof(ocontext_t));
 
 	newc->u.ioport.low_ioport  = low;
 	newc->u.ioport.high_ioport = high;
@@ -5097,12 +5081,11 @@ int define_pcidevice_context(unsigned long device)
 		return 0;
 	}
 
-	newc = malloc(sizeof(ocontext_t));
+	newc = calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
-	memset(newc, 0, sizeof(ocontext_t));
 
 	newc->u.device = device;
 
@@ -5150,12 +5133,11 @@ int define_devicetree_context(void)
 		return 0;
 	}
 
-	newc = malloc(sizeof(ocontext_t));
+	newc = calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
-	memset(newc, 0, sizeof(ocontext_t));
 
 	newc->u.name = (char *)queue_remove(id_queue);
 	if (!newc->u.name) {
@@ -5208,12 +5190,11 @@ int define_port_context(unsigned int low, unsigned int high)
 		return 0;
 	}
 
-	newc = malloc(sizeof(ocontext_t));
+	newc = calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
-	memset(newc, 0, sizeof(ocontext_t));
 
 	id = (char *)queue_remove(id_queue);
 	if (!id) {
@@ -5301,12 +5282,11 @@ int define_ibpkey_context(unsigned int low, unsigned int high)
 		return 0;
 	}
 
-	newc = malloc(sizeof(*newc));
+	newc = calloc(1, sizeof(*newc));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
-	memset(newc, 0, sizeof(*newc));
 
 	id = queue_remove(id_queue);
 	if (!id) {
@@ -5411,12 +5391,11 @@ int define_ibendport_context(unsigned int port)
 		return -1;
 	}
 
-	newc = malloc(sizeof(*newc));
+	newc = calloc(1, sizeof(*newc));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
-	memset(newc, 0, sizeof(*newc));
 
 	newc->u.ibendport.dev_name = queue_remove(id_queue);
 	if (!newc->u.ibendport.dev_name) {
@@ -5484,12 +5463,11 @@ int define_netif_context(void)
 		return 0;
 	}
 
-	newc = (ocontext_t *) malloc(sizeof(ocontext_t));
+	newc = (ocontext_t *) calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
-	memset(newc, 0, sizeof(ocontext_t));
 
 	newc->u.name = (char *)queue_remove(id_queue);
 	if (!newc->u.name) {
@@ -5615,13 +5593,12 @@ int define_ipv4_node_context(void)
 		yywarn("host bits in ipv4 address set");
 	}
 
-	newc = malloc(sizeof(ocontext_t));
+	newc = calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
 
-	memset(newc, 0, sizeof(ocontext_t));
 	newc->u.node.addr = addr.s_addr;
 	newc->u.node.mask = mask.s_addr;
 
@@ -5864,13 +5841,12 @@ int define_ipv6_node_context(void)
 		yywarn("host bits in ipv6 address set");
 	}
 
-	newc = malloc(sizeof(ocontext_t));
+	newc = calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
 
-	memset(newc, 0, sizeof(ocontext_t));
 	memcpy(&newc->u.node6.addr[0], &addr.s6_addr[0], 16);
 	memcpy(&newc->u.node6.mask[0], &mask.s6_addr[0], 16);
 
@@ -5975,12 +5951,11 @@ int define_fs_use(int behavior)
 		return 0;
 	}
 
-	newc = (ocontext_t *) malloc(sizeof(ocontext_t));
+	newc = (ocontext_t *) calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
-	memset(newc, 0, sizeof(ocontext_t));
 
 	newc->u.name = (char *)queue_remove(id_queue);
 	if (!newc->u.name) {
@@ -6043,12 +6018,11 @@ static int define_genfs_context_helper(char *fstype, int has_type)
 	}
 
 	if (!genfs || strcmp(fstype, genfs->fstype)) {
-		newgenfs = malloc(sizeof(struct genfs));
+		newgenfs = calloc(1, sizeof(struct genfs));
 		if (!newgenfs) {
 			yyerror("out of memory");
 			return -1;
 		}
-		memset(newgenfs, 0, sizeof(struct genfs));
 		newgenfs->fstype = fstype;
 		newgenfs->next = genfs;
 		if (genfs_p)
@@ -6061,12 +6035,11 @@ static int define_genfs_context_helper(char *fstype, int has_type)
 		fstype = NULL;
 	}
 
-	newc = (ocontext_t *) malloc(sizeof(ocontext_t));
+	newc = (ocontext_t *) calloc(1, sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
 		return -1;
 	}
-	memset(newc, 0, sizeof(ocontext_t));
 
 	newc->u.name = (char *)queue_remove(id_queue);
 	if (!newc->u.name)
-- 
2.54.0

