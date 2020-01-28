Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA746C2D0DB
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE34214AF
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 17:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DqB99196"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgA1RZO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:25:14 -0500
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:8115 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1RZN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jan 2020 12:25:13 -0500
X-EEMSG-check-017: 74384030|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,374,1574121600"; 
   d="scan'208";a="74384030"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Jan 2020 17:25:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580232312; x=1611768312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VrgDLN6gDgBiIP7uksz8It4M0JrWn9bWqko8HQhAnkw=;
  b=DqB99196dHJlCcQpNu+k53jrAbnSwy4qOzbpzsNUmD6FXRNLKPhCFBTM
   dI118hApolehohtSlXAJen+k9VRru6ntqMrCOXTe5Lr1NIZVQd1petHts
   B4pmeYOBXl7a3VQUSN3Yi00plpfS6AItaX4cZe7A/LRGCrbYAIEPduXmK
   Dunv2fvEaQR7IJDn042ObW8yglhFciosY1qmAG/BhlCzAs8956ASZYcZz
   pHdW2cs3EM0IWuB+pmJ6dC5rqV56h9SzUKIgDxyLWtcSJ1CJv6INAeCWD
   T616LFAyJIKaOR3l8vktjPoyj4zBkEVTf9ygMIrrwX5WsTVcbzi/g9A27
   w==;
X-IronPort-AV: E=Sophos;i="5.70,374,1574121600"; 
   d="scan'208";a="32415031"
IronPort-PHdr: =?us-ascii?q?9a23=3A5kJizxT4wcAUVyTDUXZt1lXL/Npsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa69bRyN2/xhgRfzUJnB7Loc0qyK6vymAjBLsMrJ8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HHr3ZHdOhbwWxlLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcUMlRTShBCZ6iYYUJAeQKIOJUo5D9qlYKqBezAxSnCuHyxT9SnnL43bM03f?=
 =?us-ascii?q?kvHw/F2wIvEN0AvW/IoNj2LqoeTfq4wLXUwTjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBetDmaOpNrTs4tTGxkoiY3xqActZ?=
 =?us-ascii?q?KlcyUG1o4rywPZZveaaYaH+AjjW/yUITpggXJlf6+wiAiq/Ei7z+38StG00F?=
 =?us-ascii?q?FXripZitXMtm4C1xjU6sWfVvty5F2h2TeS1wDI8O1EIEY0laTcK5463LE/io?=
 =?us-ascii?q?AfsVjDHyDqmEX2i7WadkM49eiz9+vreLDmpp6YN4NsiwH+NLohmtCnDOglPQ?=
 =?us-ascii?q?UDUHKX9OSh2LH540H0T6tGgucrnqXBtZDVP8Ubpqq3Aw9P1YYj7g6yDyy739?=
 =?us-ascii?q?QDhnQHMFJEdw6Hj4juIV3OJuv4Au2lj1Sjlzdr2ejKPqf9DZXVMnjDjLDhcK?=
 =?us-ascii?q?5m60FCzAozzNZf549bC7waPvLzVVH+tMbCAh86LQO02eDnB8t51o8EXmKPGK?=
 =?us-ascii?q?CZY+vutgqT6+YuJfScTJEatSy7KPU/4fPqy3gjlgwzZ66siKALZWi4E/IuGE?=
 =?us-ascii?q?CQZX7hk59VCmsRlhYvR+ztzluZWHhcYGjkDPF03S0yFI/zVdSLfYuqmrHUmX?=
 =?us-ascii?q?rqEw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2C7AgAPbjBe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?Vk/VCESKo0XhmIZAwaBMwGJcpFJCQEBAQEBAQEBARsIFAEBhECCTDgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIU3DII7KYMoCwFGgVGCZz8BglYlrwwzhUqDMYE+gTiHQ?=
 =?us-ascii?q?YR3eYEHgRE2gxuKNwSNWASId4Enl16CQ4JMijqJJQwbgkiMT4tkAZ1ZjiUig?=
 =?us-ascii?q?VgrCAIYCCEPgycJRxgNjikXiCGGICMDMItvLYE1XwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 28 Jan 2020 17:25:11 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00SHOQs6199066;
        Tue, 28 Jan 2020 12:24:27 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol,checkpolicy: support omitting unused initial sid contexts
Date:   Tue, 28 Jan 2020 12:26:00 -0500
Message-Id: <20200128172600.12896-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove restrictions in libsepol and checkpolicy that required all
declared initial SIDs to be assigned a context.  With this patch,
it is possible to build and load a policy that drops the sid <sidname>
<context> declarations for the unused initial SIDs.  It is still
required to retain the sid <sidname> declarations (in the flask
definitions) in order to preserve the initial SID ordering/values.
The unused initial SIDs can be renamed, e.g. to add an unused_
prefix or similar, if desired, since the names used in the policy
are not stored in the kernel binary policy.

In CIL policies, the (sid ...) and (sidorder (...)) statements
must be left intact for compatibility but the (sidcontext ...)
statements for the unused initial SIDs can be omitted after this change.

With current kernels, if one removes an unused initial SID context
from policy, builds policy with this change applied and loads the
policy into the kernel, cat /sys/fs/selinux/initial_contexts/<sidname>
will show the unlabeled context.  With the kernel patch to remove unused
initial SIDs, the /sys/fs/selinux/initial_contexts/<sidname>
file will not be created for unused initial SIDs in the first place.

NB If an unused initial SID was assigned a context different from
the unlabeled context in existing policy, then it is not safe to
remove that initial SID context from policy and reload policy on
the running kernel that was booted with the original policy.  This
is because that kernel may have assigned that SID to various kernel
objects already and those objects will then be treated as having
the unlabeled context after the removal.  In refpolicy, examples
of such initial SIDs are the "fs" SID and the "sysctl" SID.  Even
though these initial SIDs are not directly used (in code) by the current
kernel, their contexts are being applied to filesystems and sysctl files by
policy and therefore the SIDs are being assigned to objects.

NB The "sysctl" SID was in use by the kernel up until
commit 8e6c96935fcc1ed3dbebc96fddfef3f2f2395afc ("security/selinux:
fix /proc/sys/ labeling) circa v2.6.39.  Removing its context from
policy will break kernels < 2.6.39.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 checkpolicy/test/dismod.c     |  6 +++--
 libsepol/cil/src/cil_binary.c |  4 ++-
 libsepol/cil/src/cil_verify.c | 10 -------
 libsepol/src/expand.c         |  8 ++----
 libsepol/src/policydb.c       | 51 ++++++++++++++++++++++++-----------
 5 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 8d6be2ff9522..49d610d94b00 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -441,11 +441,13 @@ void display_initial_sids(policydb_t * p, FILE * fp)
 
 	fprintf(fp, "Initial SIDs:\n");
 	for (cur = p->ocontexts[OCON_ISID]; cur != NULL; cur = cur->next) {
+		if (!cur->context[0].user)
+			continue;
 		user = p->p_user_val_to_name[cur->context[0].user - 1];
 		role = p->p_role_val_to_name[cur->context[0].role - 1];
 		type = p->p_type_val_to_name[cur->context[0].type - 1];
-		fprintf(fp, "\t%s: sid %d, context %s:%s:%s\n",
-			cur->u.name, cur->sid[0], user, role, type);
+		fprintf(fp, "\tsid %d, context %s:%s:%s\n",
+			cur->sid[0], user, role, type);
 	}
 #if 0
 	fprintf(fp, "Policy Initial SIDs:\n");
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index f8e20d32f9f1..e52b6679c289 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3067,9 +3067,11 @@ int cil_sidorder_to_policydb(policydb_t *pdb, const struct cil_db *db)
 		struct cil_sid *cil_sid = (struct cil_sid*)curr->data;
 		struct cil_context *cil_context = cil_sid->context;
 
+		/* even if no context, we must preserve initial SID values */
+		count++;
+
 		if (cil_context != NULL) {
 			ocontext_t *new_ocon = cil_add_ocontext(&pdb->ocontexts[OCON_ISID], &tail);
-			count++;
 			new_ocon->sid[0] = count;
 			new_ocon->u.name = cil_strdup(cil_sid->datum.fqn);
 			rc = __cil_context_to_sepol_context(pdb, cil_context, &new_ocon->context[0]);
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 018514dc1bb9..0367a8e58273 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -428,22 +428,12 @@ int __cil_verify_ordered(struct cil_tree_node *current, enum cil_flavor flavor)
 int __cil_verify_initsids(struct cil_list *sids)
 {
 	int rc = SEPOL_OK;
-	struct cil_list_item *i;
 
 	if (sids->head == NULL) {
 		cil_log(CIL_ERR, "At least one initial sid must be defined in the policy\n");
 		return SEPOL_ERR;
 	}
 
-	cil_list_for_each(i, sids) {
-		struct cil_sid *sid = i->data;
-		if (sid->context == NULL) {
-			struct cil_tree_node *node = sid->datum.nodes->head->data;
-			cil_tree_log(node, CIL_ERR, "No context assigned to SID %s declared",sid->datum.name);
-			rc = SEPOL_ERR;
-		}
-	}
-
 	return rc;
 }
 
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 796121cf5ad8..5f8e75c38632 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2159,6 +2159,8 @@ static int ocontext_copy_selinux(expand_state_t *state)
 	for (i = 0; i < OCON_NUM; i++) {
 		l = NULL;
 		for (c = state->base->ocontexts[i]; c; c = c->next) {
+			if (i == OCON_ISID && c->context[0].user == 0)
+				continue;
 			n = malloc(sizeof(ocontext_t));
 			if (!n) {
 				ERR(state->handle, "Out of memory!");
@@ -2172,12 +2174,6 @@ static int ocontext_copy_selinux(expand_state_t *state)
 			l = n;
 			switch (i) {
 			case OCON_ISID:
-				if (c->context[0].user == 0) {
-					ERR(state->handle,
-					    "Missing context for %s initial sid",
-					    c->u.name);
-					return -1;
-				}
 				n->sid[0] = c->sid[0];
 				break;
 			case OCON_FS:	/* FALLTHROUGH */
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 745e546baa3a..03360c88e7d3 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1610,10 +1610,8 @@ int policydb_load_isids(policydb_t * p, sidtab_t * s)
 
 	head = p->ocontexts[OCON_ISID];
 	for (c = head; c; c = c->next) {
-		if (!c->context[0].user) {
-			ERR(NULL, "SID %s was never defined", c->u.name);
-			return -1;
-		}
+		if (!c->context[0].user)
+			continue;
 		if (sepol_sidtab_insert(s, c->sid[0], &c->context[0])) {
 			ERR(NULL, "unable to load initial SID %s", c->u.name);
 			return -1;
@@ -2020,12 +2018,8 @@ static int mls_range_to_semantic(mls_range_t * r, mls_semantic_range_t * sr)
 	return 0;
 }
 
-/*
- * Read and validate a security context structure
- * from a policydb binary representation file.
- */
-static int context_read_and_validate(context_struct_t * c,
-				     policydb_t * p, struct policy_file *fp)
+static int context_read_no_validate(context_struct_t * c,
+				    policydb_t * p, struct policy_file *fp)
 {
 	uint32_t buf[3];
 	int rc;
@@ -2049,6 +2043,19 @@ static int context_read_and_validate(context_struct_t * c,
 		}
 	}
 
+	return 0;
+}
+
+/*
+ * Read and validate a security context structure
+ * from a policydb binary representation file.
+ */
+static int context_read_and_validate(context_struct_t * c,
+				     policydb_t * p, struct policy_file *fp)
+{
+	if (context_read_no_validate(c, p, fp))
+		return -1;
+
 	if (!policydb_context_isvalid(p, c)) {
 		ERR(fp->handle, "invalid security context");
 		context_destroy(c);
@@ -2797,6 +2804,7 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
 	unsigned int i, j;
 	size_t nel, len;
 	ocontext_t *l, *c;
+	context_struct_t tmpc;
 	uint32_t buf[8];
 	int rc;
 
@@ -2807,6 +2815,22 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
 		nel = le32_to_cpu(buf[0]);
 		l = NULL;
 		for (j = 0; j < nel; j++) {
+			if (i == OCON_ISID) {
+				rc = next_entry(buf, fp, sizeof(uint32_t));
+				if (rc < 0)
+					return -1;
+				context_init(&tmpc);
+				if (context_read_no_validate
+				    (&tmpc, p, fp))
+					return -1;
+				if (!tmpc.user)
+					continue;
+				if (!policydb_context_isvalid(p, &tmpc)) {
+				  ERR(fp->handle, "invalid security context");
+				  context_destroy(&tmpc);
+				  return -1;
+				}
+			}
 			c = calloc(1, sizeof(ocontext_t));
 			if (!c) {
 				return -1;
@@ -2819,13 +2843,8 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
 			l = c;
 			switch (i) {
 			case OCON_ISID:
-				rc = next_entry(buf, fp, sizeof(uint32_t));
-				if (rc < 0)
-					return -1;
 				c->sid[0] = le32_to_cpu(buf[0]);
-				if (context_read_and_validate
-				    (&c->context[0], p, fp))
-					return -1;
+				memcpy(&c->context[0], &tmpc, sizeof tmpc);
 				break;
 			case OCON_FS:
 			case OCON_NETIF:
-- 
2.24.1

