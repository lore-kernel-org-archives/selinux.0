Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3A21F5825
	for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785719; cv=none; b=Wmk3T6Pj2S9NzB0USMq85gDApxgEljHUvLeOiUcywH5i9J20J877nS4m5qpvFUK0Z/Tt2BVPEnY9LD9AgLTNZTQPJIQzmI+QBuyfL4qCYoja5KvhjBDPcgAdZJonwKtagFtowQpgQywscj/VoQ3nNerLgy8p41shtgveoXddItU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785719; c=relaxed/simple;
	bh=kpIQ9Gb0c7H3a5XR6JymLNYBRvtTXA30vXK29SyDxqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJXfmyDQmwa6pHZ2iODPbC541rAMU110hm1BlN1BDimV+wd8XDg4tRbk/66IDSYB1RrDGptfOXRLWAZyYgy/LSkHLzPDAwgnuJ0kml59MzCrAs2V207PgCBJng1+EIhcMzkGgYthTUd2wQZJIIbqVb4FfJd2I1nQ7r4oO96QwxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=JvtPEMGp; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="JvtPEMGp"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1729785705;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYG7zp9zwiTBa684nCHqahlH37KYzi3e8sRQ5vEmWaA=;
	b=JvtPEMGpB07Er6OUUEO7LRlM0GHg4L2FoyuuOQCD/CXcmPuFuss8CDpQe6YhxcAmbdmVCb
	vg7dXu4yBYCcWJqnHM213RXZPOGY8IQ/ZMQNl6e6ZilvShfZMFjizQ5QYzVDrs0HbmM4ZZ
	j1f2tsg1HPWdRWAuy6Xj+CUQY+ZCnoE+aNhajejls2CLPhOfyqympBzPEQu2iTc915GKnk
	gWQULjdaPj/cVJFBNxYNxrMa8Wvm4CtDvbuf8CrQRVD/PugD27hQa0Mz21cno0paZ5VUxm
	Ac3PiJ20oahG9zUlNanZaZeE4CpwK80SrPnn4oTuToL+Ur8/4959HbEVoMd4OA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 2/4] libsepol: add support for xperms in conditional policies
Date: Thu, 24 Oct 2024 18:01:38 +0200
Message-ID: <20241024160140.71347-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241024160140.71347-1-cgoettsche@seltendoof.de>
References: <20241024160140.71347-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Add support for extended permission rules in conditional policies by
adding a new policy version and adjusting writing and validating
policies accordingly.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - rebase onto libsepol: Support nlmsg xperms in assertions
  - fix assertion checking with xperm av rules in conditional policies
    (spotted by Jim, thanks!)
---
 libsepol/include/sepol/policydb/policydb.h | 12 ++-
 libsepol/src/assertion.c                   | 86 +++++++++++++++++-----
 libsepol/src/policydb.c                    | 21 ++++++
 libsepol/src/policydb_validate.c           |  4 +-
 libsepol/src/write.c                       | 46 ++++++++----
 5 files changed, 131 insertions(+), 38 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 88fb3672..f833354b 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -759,10 +759,11 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_INFINIBAND		31 /* Linux-specific */
 #define POLICYDB_VERSION_GLBLUB		32
 #define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitions */
+#define POLICYDB_VERSION_COND_XPERMS	34 /* extended permissions in conditional policies */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_COMP_FTRANS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_COND_XPERMS
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
@@ -785,9 +786,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_INFINIBAND		19
 #define MOD_POLICYDB_VERSION_GLBLUB		20
 #define MOD_POLICYDB_VERSION_SELF_TYPETRANS	21
+#define MOD_POLICYDB_VERSION_COND_XPERMS	22
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_SELF_TYPETRANS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_COND_XPERMS
 
 #define POLICYDB_CONFIG_MLS    1
 
@@ -801,6 +803,12 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 	 ((p)->policy_type != POLICY_KERN			\
 	  && (p)->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY))
 
+#define policydb_has_cond_xperms_feature(p)			\
+	(((p)->policy_type == POLICY_KERN			\
+	  && (p)->policyvers >= POLICYDB_VERSION_COND_XPERMS) ||	\
+	 ((p)->policy_type != POLICY_KERN			\
+	  && (p)->policyvers >= MOD_POLICYDB_VERSION_COND_XPERMS))
+
 /* the config flags related to unknown classes/perms are bits 2 and 3 */
 #define DENY_UNKNOWN	SEPOL_DENY_UNKNOWN
 #define REJECT_UNKNOWN	SEPOL_REJECT_UNKNOWN
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 71faa3b2..5765d9e5 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -32,7 +32,6 @@ struct avtab_match_args {
 	sepol_handle_t *handle;
 	policydb_t *p;
 	const avrule_t *narule;
-	avtab_t *avtab;
 	unsigned long errors;
 };
 
@@ -160,7 +159,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 				policydb_t *p, const avrule_t *avrule,
 				unsigned int stype, unsigned int ttype,
 				const class_perm_node_t *curperm, uint32_t perms,
-				const avtab_key_t *k, avtab_t *avtab)
+				const avtab_key_t *k)
 {
 	avtab_ptr_t node;
 	avtab_key_t tmp_key;
@@ -171,7 +170,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
 	int rc;
-	int found_xperm = 0;
+	int found_xperm = 0, found_enabled_xperm = 0, found_disabled_xperm = 0;
 	int errors = 0;
 
 	memcpy(&tmp_key, k, sizeof(avtab_key_t));
@@ -181,7 +180,7 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 		tmp_key.source_type = i + 1;
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
 			tmp_key.target_type = j + 1;
-			for (node = avtab_search_node(avtab, &tmp_key);
+			for (node = avtab_search_node(&p->te_avtab, &tmp_key);
 			     node;
 			     node = avtab_search_node_next(node, tmp_key.specified)) {
 				xperms = node->datum.xperms;
@@ -210,11 +209,45 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 					errors++;
 				}
 			}
+
+			for (node = avtab_search_node(&p->te_cond_avtab, &tmp_key);
+			     node;
+			     node = avtab_search_node_next(node, tmp_key.specified)) {
+				xperms = node->datum.xperms;
+				if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
+						&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER)
+						&& (xperms->specified != AVTAB_XPERMS_NLMSG))
+					continue;
+				if (node->key.specified & AVTAB_ENABLED) {
+					found_enabled_xperm = 1;
+				} else {
+					found_disabled_xperm = 1;
+				}
+				rc = check_extended_permissions(avrule->xperms, xperms);
+				/* failure on the extended permission check_extended_permissions */
+				if (rc) {
+					char *permstring;
+
+					extended_permissions_violated(&error, avrule->xperms, xperms);
+					permstring = sepol_extended_perms_to_string(&error);
+
+					ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of %s) violated by\n"
+							"allowxperm %s %s:%s %s;",
+							avrule->source_line, avrule->source_filename, avrule->line, policy_name(p),
+							p->p_type_val_to_name[i],
+							p->p_type_val_to_name[j],
+							p->p_class_val_to_name[curperm->tclass - 1],
+							permstring ?: "<format-failure>");
+
+					free(permstring);
+					errors++;
+				}
+			}
 		}
 	}
 
 	/* failure on the regular permissions */
-	if (!found_xperm) {
+	if (!found_xperm && (!found_enabled_xperm || !found_disabled_xperm)) {
 		char *permstr = sepol_av_to_string(p, curperm->tclass, perms);
 
 		ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of %s) violated by\n"
@@ -239,7 +272,6 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	struct avtab_match_args *a = (struct avtab_match_args *)args;
 	sepol_handle_t *handle = a->handle;
 	policydb_t *p = a->p;
-	avtab_t *avtab = a->avtab;
 	const avrule_t *narule = a->narule;
 	const class_perm_node_t *cp;
 	uint32_t perms;
@@ -313,7 +345,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 					continue;
 				if (narule->specified == AVRULE_XPERMS_NEVERALLOW) {
 					a->errors += report_assertion_extended_permissions(handle,p, narule,
-											i, j, cp, perms, k, avtab);
+											i, j, cp, perms, k);
 				} else {
 					a->errors++;
 					report_failure(handle, p, narule, i, j, cp, perms);
@@ -340,12 +372,10 @@ static int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, cons
 	args.narule = narule;
 	args.errors = 0;
 
-	args.avtab =  &p->te_avtab;
 	rc = avtab_map(&p->te_avtab, report_assertion_avtab_matches, &args);
 	if (rc < 0)
 		goto oom;
 
-	args.avtab =  &p->te_cond_avtab;
 	rc = avtab_map(&p->te_cond_avtab, report_assertion_avtab_matches, &args);
 	if (rc < 0)
 		goto oom;
@@ -360,7 +390,7 @@ oom:
  * Look up the extended permissions in avtab and verify that neverallowed
  * permissions are not granted.
  */
-static int check_assertion_extended_permissions_avtab(const avrule_t *narule, avtab_t *avtab,
+static int check_assertion_extended_permissions_avtab(const avrule_t *narule,
 						unsigned int stype, unsigned int ttype,
 						const avtab_key_t *k, policydb_t *p)
 {
@@ -372,7 +402,8 @@ static int check_assertion_extended_permissions_avtab(const avrule_t *narule, av
 	const ebitmap_t *tattr = &p->type_attr_map[ttype];
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
-	int rc = 1;
+	int found_xperm = 0, found_enabled_xperm = 0, found_disabled_xperm = 0;
+	int rc;
 
 	memcpy(&tmp_key, k, sizeof(avtab_key_t));
 	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
@@ -381,7 +412,22 @@ static int check_assertion_extended_permissions_avtab(const avrule_t *narule, av
 		tmp_key.source_type = i + 1;
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
 			tmp_key.target_type = j + 1;
-			for (node = avtab_search_node(avtab, &tmp_key);
+			for (node = avtab_search_node(&p->te_avtab, &tmp_key);
+			     node;
+			     node = avtab_search_node_next(node, tmp_key.specified)) {
+				xperms = node->datum.xperms;
+
+				if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
+						&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER)
+						&& (xperms->specified != AVTAB_XPERMS_NLMSG))
+					continue;
+				found_xperm = 1;
+				rc = check_extended_permissions(neverallow_xperms, xperms);
+				if (rc)
+					return rc;
+			}
+
+			for (node = avtab_search_node(&p->te_cond_avtab, &tmp_key);
 			     node;
 			     node = avtab_search_node_next(node, tmp_key.specified)) {
 				xperms = node->datum.xperms;
@@ -390,6 +436,11 @@ static int check_assertion_extended_permissions_avtab(const avrule_t *narule, av
 						&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER)
 						&& (xperms->specified != AVTAB_XPERMS_NLMSG))
 					continue;
+				if (node->key.specified & AVTAB_ENABLED) {
+					found_enabled_xperm = 1;
+				} else {
+					found_disabled_xperm = 1;
+				}
 				rc = check_extended_permissions(neverallow_xperms, xperms);
 				if (rc)
 					return rc;
@@ -397,7 +448,7 @@ static int check_assertion_extended_permissions_avtab(const avrule_t *narule, av
 		}
 	}
 
-	return rc;
+	return !found_xperm && (!found_enabled_xperm || !found_disabled_xperm);
 }
 
 /*
@@ -416,7 +467,7 @@ static int check_assertion_extended_permissions_avtab(const avrule_t *narule, av
  * 4. FAIL - The ioctl permission is granted AND the extended permission is
  *    granted
  */
-static int check_assertion_extended_permissions(const avrule_t *narule, avtab_t *avtab,
+static int check_assertion_extended_permissions(const avrule_t *narule,
 						const avtab_key_t *k, policydb_t *p)
 {
 	ebitmap_t src_matches, tgt_matches, self_matches;
@@ -479,7 +530,7 @@ static int check_assertion_extended_permissions(const avrule_t *narule, avtab_t
 				continue;
 			if (is_narule_notself && i == j)
 				continue;
-			if (check_assertion_extended_permissions_avtab(narule, avtab, i, j, k, p)) {
+			if (check_assertion_extended_permissions_avtab(narule, i, j, k, p)) {
 				rc = 1;
 				goto exit;
 			}
@@ -583,7 +634,6 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	struct avtab_match_args *a = (struct avtab_match_args *)args;
 	policydb_t *p = a->p;
 	const avrule_t *narule = a->narule;
-	avtab_t *avtab = a->avtab;
 
 	if ((k->specified & AVTAB_ALLOWED) == 0)
 		goto nomatch;
@@ -616,7 +666,7 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	}
 
 	if (narule->specified == AVRULE_XPERMS_NEVERALLOW) {
-		rc = check_assertion_extended_permissions(narule, avtab, k, p);
+		rc = check_assertion_extended_permissions(narule, k, p);
 		if (rc < 0)
 			goto oom;
 		if (rc == 0)
@@ -639,13 +689,11 @@ int check_assertion(policydb_t *p, const avrule_t *narule)
 		.p = p,
 		.narule = narule,
 		.errors = 0,
-		.avtab = &p->te_avtab,
 	};
 
 	rc = avtab_map(&p->te_avtab, check_assertion_avtab_match, &args);
 
 	if (rc == 0) {
-		args.avtab = &p->te_cond_avtab;
 		rc = avtab_map(&p->te_cond_avtab, check_assertion_avtab_match, &args);
 	}
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index e90ccca1..0747e789 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -208,6 +208,13 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_COND_XPERMS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_IBENDPORT + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -334,6 +341,13 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_COND_XPERMS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_IBENDPORT + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -460,6 +474,13 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = 0,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_COND_XPERMS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 };
 
 #if 0
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5035313b..e021e025 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -903,7 +903,7 @@ static int validate_avtab_key(const avtab_key_t *key, int conditional, const pol
 	case AVTAB_XPERMS_DONTAUDIT:
 		if (p->target_platform != SEPOL_TARGET_SELINUX)
 			goto bad;
-		if (conditional)
+		if (conditional && !policydb_has_cond_xperms_feature(p))
 			goto bad;
 		break;
 	default:
@@ -1046,7 +1046,7 @@ static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule, int
 		case AVRULE_XPERMS_AUDITALLOW:
 		case AVRULE_XPERMS_DONTAUDIT:
 		case AVRULE_XPERMS_NEVERALLOW:
-			if (conditional)
+			if (conditional && !policydb_has_cond_xperms_feature(p))
 				goto bad;
 			break;
 		default:
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index a52e2e82..4ef98449 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -56,7 +56,8 @@ struct policy_data {
 };
 
 static int avrule_write_list(policydb_t *p,
-			     avrule_t * avrules, struct policy_file *fp);
+			     avrule_t * avrules, struct policy_file *fp,
+			     unsigned conditional);
 
 static int ebitmap_write(ebitmap_t * e, struct policy_file *fp)
 {
@@ -104,7 +105,8 @@ static uint16_t spec_order[] = {
 
 static int avtab_write_item(policydb_t * p,
 			    avtab_ptr_t cur, struct policy_file *fp,
-			    unsigned merge, unsigned commit, uint32_t * nel)
+			    unsigned merge, unsigned commit, unsigned conditional,
+			    uint32_t * nel)
 {
 	avtab_ptr_t node;
 	uint8_t buf8;
@@ -229,14 +231,20 @@ static int avtab_write_item(policydb_t * p,
 		return POLICYDB_ERROR;
 	if ((p->policyvers < POLICYDB_VERSION_XPERMS_IOCTL) &&
 			(cur->key.specified & AVTAB_XPERMS)) {
-		ERR(fp->handle, "policy version %u does not support ioctl extended"
+		ERR(fp->handle, "policy version %u does not support extended"
 				"permissions rules and one was specified", p->policyvers);
 		return POLICYDB_ERROR;
 	}
 
+	if (!policydb_has_cond_xperms_feature(p) && (cur->key.specified & AVTAB_XPERMS) && conditional) {
+		ERR(fp->handle, "policy version %u does not support extended"
+				"permissions rules in conditional policies and one was specified", p->policyvers);
+		return POLICYDB_ERROR;
+	}
+
 	if (p->target_platform != SEPOL_TARGET_SELINUX &&
 			(cur->key.specified & AVTAB_XPERMS)) {
-		ERR(fp->handle, "Target platform %s does not support ioctl "
+		ERR(fp->handle, "Target platform %s does not support "
 				"extended permissions rules and one was specified",
 				policydb_target_strings[p->target_platform]);
 		return POLICYDB_ERROR;
@@ -313,7 +321,7 @@ static int avtab_write(struct policydb *p, avtab_t * a, struct policy_file *fp)
 		for (cur = a->htable[i]; cur; cur = cur->next) {
 			/* If old format, compute final nel.
 			   If new format, write out the items. */
-			if (avtab_write_item(p, cur, fp, 1, !oldvers, &nel)) {
+			if (avtab_write_item(p, cur, fp, 1, !oldvers, 0, &nel)) {
 				rc = -1;
 				goto out;
 			}
@@ -332,7 +340,7 @@ static int avtab_write(struct policydb *p, avtab_t * a, struct policy_file *fp)
 		avtab_reset_merged(a);
 		for (i = 0; i < a->nslot; i++) {
 			for (cur = a->htable[i]; cur; cur = cur->next) {
-				if (avtab_write_item(p, cur, fp, 1, 1, NULL)) {
+				if (avtab_write_item(p, cur, fp, 1, 1, 0, NULL)) {
 					rc = -1;
 					goto out;
 				}
@@ -795,7 +803,7 @@ static int cond_write_av_list(policydb_t * p,
 
 	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next) {
 		if (cur_list->node->parse_context)
-			if (avtab_write_item(p, cur_list->node, fp, 0, 1, NULL))
+			if (avtab_write_item(p, cur_list->node, fp, 0, 1, 1, NULL))
 				goto out;
 	}
 
@@ -846,9 +854,9 @@ static int cond_write_node(policydb_t * p,
 		if (cond_write_av_list(p, node->false_list, fp) != 0)
 			return POLICYDB_ERROR;
 	} else {
-		if (avrule_write_list(p, node->avtrue_list, fp))
+		if (avrule_write_list(p, node->avtrue_list, fp, 1))
 			return POLICYDB_ERROR;
-		if (avrule_write_list(p, node->avfalse_list, fp))
+		if (avrule_write_list(p, node->avfalse_list, fp, 1))
 			return POLICYDB_ERROR;
 	}
 
@@ -1743,7 +1751,7 @@ static int range_write(policydb_t * p, struct policy_file *fp)
 /************** module writing functions below **************/
 
 static int avrule_write(policydb_t *p, avrule_t * avrule,
-			struct policy_file *fp)
+			struct policy_file *fp, unsigned conditional)
 {
 	size_t items, items2;
 	uint32_t buf[32], len;
@@ -1801,15 +1809,23 @@ static int avrule_write(policydb_t *p, avrule_t * avrule,
 
 		if (p->policyvers < MOD_POLICYDB_VERSION_XPERMS_IOCTL) {
 			ERR(fp->handle,
-			    "module policy version %u does not support ioctl"
+			    "module policy version %u does not support"
 			    " extended permissions rules and one was specified",
 			    p->policyvers);
 			return POLICYDB_ERROR;
 		}
 
+		if (conditional && !policydb_has_cond_xperms_feature(p)) {
+			ERR(fp->handle,
+			    "module policy version %u does not support"
+			    " extended permissions rules in conditional policies and one was specified",
+			    p->policyvers);
+			return POLICYDB_ERROR;
+		}
+
 		if (p->target_platform != SEPOL_TARGET_SELINUX) {
 			ERR(fp->handle,
-			    "Target platform %s does not support ioctl"
+			    "Target platform %s does not support"
 			    " extended permissions rules and one was specified",
 			    policydb_target_strings[p->target_platform]);
 			return POLICYDB_ERROR;
@@ -1834,7 +1850,7 @@ static int avrule_write(policydb_t *p, avrule_t * avrule,
 }
 
 static int avrule_write_list(policydb_t *p, avrule_t * avrules,
-			     struct policy_file *fp)
+			     struct policy_file *fp, unsigned conditional)
 {
 	uint32_t buf[32], len;
 	avrule_t *avrule;
@@ -1852,7 +1868,7 @@ static int avrule_write_list(policydb_t *p, avrule_t * avrules,
 
 	avrule = avrules;
 	while (avrule) {
-		if (avrule_write(p, avrule, fp))
+		if (avrule_write(p, avrule, fp, conditional))
 			return POLICYDB_ERROR;
 		avrule = avrule->next;
 	}
@@ -2056,7 +2072,7 @@ static int avrule_decl_write(avrule_decl_t * decl, int num_scope_syms,
 		return POLICYDB_ERROR;
 	}
 	if (cond_write_list(p, decl->cond_list, fp) == -1 ||
-	    avrule_write_list(p, decl->avrules, fp) == -1 ||
+	    avrule_write_list(p, decl->avrules, fp, 0) == -1 ||
 	    role_trans_rule_write(p, decl->role_tr_rules, fp) == -1 ||
 	    role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
 		return POLICYDB_ERROR;
-- 
2.45.2

