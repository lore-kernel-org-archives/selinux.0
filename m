Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF31CF7AB
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704054; cv=none; b=QNaXVetM3/sqAfQk+oR1MexgvFJs5DbSbEEs6t00QTLG6MxXWg/Aaf0NnHZ6REOFTEkDdCY+onr/YQP086P5ie5XBSoStBmb7eIGXrG2iUAh+T7fH/vMXMju4To8OOiz9OPcMrTdMgkr4MfyPq59OdTAjAst2IeAQmueN/sIn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704054; c=relaxed/simple;
	bh=ClSzxuN7jzRo1yh33Vnqu23kO/F3qfsS5J9DR1KBk+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fG1ZVRwPreSjRm/5e4VJRy4B9YlGATxIbwj7G5u9I7c7O0PD4WovBJMvdOzeYaQ793vbBSBqDNo5CzI4K8VdK2UlMzij3IcY0PNLpYfc39/MEBgmVRTRGjAr2jtkopySVv0+HgiitWE/ec8uyT3SchHx1S4aOTQvTVwT+a33vo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=fUMyJBoH; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="fUMyJBoH"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1729704049;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=VGiC9V7iv5vgH+UmkxqMlaserA86ah/wYv02JNVy4tY=;
	b=fUMyJBoHHan8n2w6jZVT/5GTTipI/AAeRnSUVi+MoZPup1SrawxGIdsYY+Dj7UB63S1ryt
	//bmbmfk0Ax3OLLTvpfmyHeDZ+SgYkHWZQIhrLFGyX+9GixueeaYbp+2hWyUJRmCo+bRiH
	QOqsmlStK8O2GcUP9FD8/aJwcMjRUfDAHmCiKBk2lAZkc2eRylcw6+b4nxsUlJmqMeJnGf
	9Lxi8CP7TbwUJCjj4K6XET7ZbwGrEKCw41M/KUokpwFFW4iXVjAzHO+8mecEKOJSN5qDFe
	5OyaTVbGsbqmq1Iq0qraVR2/Jy6ncCFdDJxbImzhKl8ddCjgnGA2z//N6NSuRQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/3] libsepol: add support for xperms in conditional policies
Date: Wed, 23 Oct 2024 19:20:42 +0200
Message-ID: <20241023172044.98572-1-cgoettsche@seltendoof.de>
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
 libsepol/include/sepol/policydb/policydb.h | 12 +++++-
 libsepol/src/policydb.c                    | 21 ++++++++++
 libsepol/src/policydb_validate.c           |  4 +-
 libsepol/src/write.c                       | 46 +++++++++++++++-------
 4 files changed, 64 insertions(+), 19 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index f73e21fc..ccff4d71 100644
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

