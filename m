Return-Path: <SRS0=m98w=3S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FA9C2D0DB
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 15:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA58920720
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 15:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="N7aUjlgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgA2PAs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:00:48 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:20587 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgA2PAs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jan 2020 10:00:48 -0500
X-EEMSG-check-017: 74744632|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="74744632"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Jan 2020 15:00:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580310018; x=1611846018;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4KalWw1HTJePpk2mfUszOJY3CILUDfISYo0yAMgjj9Q=;
  b=N7aUjlgFSvBDtckIf0+nBQhg+Y/2vlg0mTdfggOQ3lE5pGdng5ywkFAX
   7lB4tvBp/EhU8zb1yGQPtgufw9JluwNItB3JAqsf62J+XrsiUzfEMj799
   jyh4rT0+XZhGhl3hdrFAFXEMpF//Uqniyi7KPC+QNfT8TWy3Ss2Uef230
   1wzh7H263GYJez/Al7oOC2GKmrR0SnFDss5HUT/RD9nW9UfkLBujEvYVV
   U3KSxha6FchWp5ai6c0qOVdNJqyBZMOCUMium589zGm9o8IsIGvWcoA2M
   wwa9jDLrwZLDiIJQQFSpBLMBEFNhX7by6wADNyntQV5Rn/NeFq0sjFUbk
   g==;
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="32452496"
IronPort-PHdr: =?us-ascii?q?9a23=3AqYT/TRcbEzDMRvW/JDerxa3zlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcuzbB7h7PlgxGXEQZ/co6odzbaP7+a7Bydesd7B6ClELMUXEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/Jas90B?=
 =?us-ascii?q?XEr3pHd+lXxm5jOFafkwrh6suq85Nv7ipdt+g9+8JcVKnxYrg1Q6FfADk6KW?=
 =?us-ascii?q?4++dfltQPETQuB53scVnsZnx9VCAXb7x/0Q4n8vDLiuuVyxCeVM8v2TaspWT?=
 =?us-ascii?q?u59KdkVAXoiCYcODEn9mzcl9F9g7haoBKloBx/3pLUbYSIP/dwYq/RYdUXTn?=
 =?us-ascii?q?dPUcZLUyxKH52yYY0BAeEcOepUtonwql8LoRa4GAKiBv7gyiVQi3H2w6M0zu?=
 =?us-ascii?q?ovHwLB0gMvENwDq2jYodbvOasOS+250LXEwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VTryGXL5Z6T8wtTm1yuCs216cKtY?=
 =?us-ascii?q?C0cSQU0pgr2hjSYOGdfYeS+BLsTuORLC99hHJiZb2wmQ6/8VOlyu3gTsm010?=
 =?us-ascii?q?tKrjZdntnMqH8N0xvT59CbSvRn5Eeh2CuP1xvJ5uFFJ0A0m63bK4U/zbEsjJ?=
 =?us-ascii?q?YTrUTCETP2mEXxlqOWcFkr+vO05Oj9Z7Xmp5ucO5d1igH4LKsuhtSyDfk3Pw?=
 =?us-ascii?q?UBRWSW+fmw2Kf98UD2XrlGlOA6nrHcsJ/AJMQboqC5AxVS0oYm8xu/FCqp0M?=
 =?us-ascii?q?8DkHkbLFNKZBKHj4/zN1HIO/D3F+2zg1urkDd13/zGJKHuAo3RLnjfl7fsZa?=
 =?us-ascii?q?195FBYyAoyy9Bf+p1VB6ofIPL8REDxrsbUDhwnPAyuxeboFtF92pkZWWKVDa?=
 =?us-ascii?q?/KeJ/V5ESF4uMpPvmkeoAYonD+JuIj6vqoimU2ynEHeqz85ocacHC1GLxdJk?=
 =?us-ascii?q?ydZXf9yoMaHXwiohs1TOusjkaLFzFUeSDhDOoH+jgnBdf+Xs/4TYe3jenEgX?=
 =?us-ascii?q?a2?=
X-IPAS-Result: =?us-ascii?q?A2DXAgCEnTFe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?Vk/VAEgEiqNF4Y+HAaBMwGJcpFJCQEBAQEBAQEBARsIFAEBhECCUDgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIU3DII7KYMoCwFGgVGCZz8BglYlrhUzhUqDKoE+gTiHQ?=
 =?us-ascii?q?oR4eYEHgRE2gxuKNwSNWASId4Enl16CQ4JMijqJJQwbmn+dWY4lIoFYKwgCG?=
 =?us-ascii?q?AghD4MnCUcYDY4pF4ghhiAjAzCMBi2BNV8BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 29 Jan 2020 15:00:09 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00TExNc8082610;
        Wed, 29 Jan 2020 09:59:25 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     jwcart2@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] libsepol,checkpolicy: support omitting unused initial sid contexts
Date:   Wed, 29 Jan 2020 10:01:04 -0500
Message-Id: <20200129150104.50720-1-sds@tycho.nsa.gov>
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
policy will cause sysctl(2) or /proc/sys accesses to end up
performing permission checks against the unlabeled context and
likely encounter denials for kernels < 2.6.39.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 issues informational messages about missing initial SID contexts
so that policy developers can detect unintended inconsistencies,
and ensures that the entries are stripped before writing kernel policy
rather than accepting them when reading.  Something isn't quite right
here though; I see the messages when compiling monolithic policy with
checkpolicy but not with a modular build (even upon make validate) or
semodule -v -i of a modified base module that removes some initial
SID contexts.

 checkpolicy/test/dismod.c     |  4 ++--
 libsepol/cil/src/cil_binary.c |  4 +++-
 libsepol/cil/src/cil_verify.c |  3 +--
 libsepol/src/expand.c         | 24 ++++++++++++------------
 libsepol/src/policydb.c       |  4 ----
 libsepol/src/write.c          | 22 ++++++++++++++++++++--
 6 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 8d6be2ff9522..3408e9b6b767 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -444,8 +444,8 @@ void display_initial_sids(policydb_t * p, FILE * fp)
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
index 018514dc1bb9..d1a6538be651 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -439,8 +439,7 @@ int __cil_verify_initsids(struct cil_list *sids)
 		struct cil_sid *sid = i->data;
 		if (sid->context == NULL) {
 			struct cil_tree_node *node = sid->datum.nodes->head->data;
-			cil_tree_log(node, CIL_ERR, "No context assigned to SID %s declared",sid->datum.name);
-			rc = SEPOL_ERR;
+			cil_tree_log(node, CIL_INFO, "No context assigned to SID %s, omitting from policy",sid->datum.name);
 		}
 	}
 
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 796121cf5ad8..5738b598ee39 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2093,6 +2093,12 @@ static int ocontext_copy_xen(expand_state_t *state)
 	for (i = 0; i < OCON_NUM; i++) {
 		l = NULL;
 		for (c = state->base->ocontexts[i]; c; c = c->next) {
+			if (i == OCON_XEN_ISID && !c->context[0].user) {
+				INFO(state->handle,
+				     "No context assigned to SID %s, omitting from policy",
+				     c->u.name);
+				continue;
+			}
 			n = malloc(sizeof(ocontext_t));
 			if (!n) {
 				ERR(state->handle, "Out of memory!");
@@ -2106,12 +2112,6 @@ static int ocontext_copy_xen(expand_state_t *state)
 			l = n;
 			switch (i) {
 			case OCON_XEN_ISID:
-				if (c->context[0].user == 0) {
-					ERR(state->handle,
-					    "Missing context for %s initial sid",
-					    c->u.name);
-					return -1;
-				}
 				n->sid[0] = c->sid[0];
 				break;
 			case OCON_XEN_PIRQ:
@@ -2159,6 +2159,12 @@ static int ocontext_copy_selinux(expand_state_t *state)
 	for (i = 0; i < OCON_NUM; i++) {
 		l = NULL;
 		for (c = state->base->ocontexts[i]; c; c = c->next) {
+			if (i == OCON_ISID && !c->context[0].user) {
+				INFO(state->handle,
+				     "No context assigned to SID %s, omitting from policy",
+				     c->u.name);
+				continue;
+			}
 			n = malloc(sizeof(ocontext_t));
 			if (!n) {
 				ERR(state->handle, "Out of memory!");
@@ -2172,12 +2178,6 @@ static int ocontext_copy_selinux(expand_state_t *state)
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
index 745e546baa3a..5b289a523a94 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1610,10 +1610,6 @@ int policydb_load_isids(policydb_t * p, sidtab_t * s)
 
 	head = p->ocontexts[OCON_ISID];
 	for (c = head; c; c = c->next) {
-		if (!c->context[0].user) {
-			ERR(NULL, "SID %s was never defined", c->u.name);
-			return -1;
-		}
 		if (sepol_sidtab_insert(s, c->sid[0], &c->context[0])) {
 			ERR(NULL, "unable to load initial SID %s", c->u.name);
 			return -1;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 7e634510d038..1fd6a16a248b 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1293,8 +1293,15 @@ static int ocontext_write_xen(struct policydb_compat_info *info, policydb_t *p,
 	ocontext_t *c;
 	for (i = 0; i < info->ocon_num; i++) {
 		nel = 0;
-		for (c = p->ocontexts[i]; c; c = c->next)
+		for (c = p->ocontexts[i]; c; c = c->next) {
+			if (i == OCON_XEN_ISID && !c->context[0].user) {
+				INFO(fp->handle,
+				     "No context assigned to SID %s, omitting from policy",
+				     c->u.name);
+				continue;
+			}
 			nel++;
+		}
 		buf[0] = cpu_to_le32(nel);
 		items = put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items != 1)
@@ -1302,6 +1309,8 @@ static int ocontext_write_xen(struct policydb_compat_info *info, policydb_t *p,
 		for (c = p->ocontexts[i]; c; c = c->next) {
 			switch (i) {
 			case OCON_XEN_ISID:
+				if (!c->context[0].user)
+					break;
 				buf[0] = cpu_to_le32(c->sid[0]);
 				items = put_entry(buf, sizeof(uint32_t), 1, fp);
 				if (items != 1)
@@ -1392,8 +1401,15 @@ static int ocontext_write_selinux(struct policydb_compat_info *info,
 	ocontext_t *c;
 	for (i = 0; i < info->ocon_num; i++) {
 		nel = 0;
-		for (c = p->ocontexts[i]; c; c = c->next)
+		for (c = p->ocontexts[i]; c; c = c->next) {
+			if (i == OCON_ISID && !c->context[0].user) {
+				INFO(fp->handle,
+				     "No context assigned to SID %s, omitting from policy",
+				     c->u.name);
+				continue;
+			}
 			nel++;
+		}
 		buf[0] = cpu_to_le32(nel);
 		items = put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items != 1)
@@ -1401,6 +1417,8 @@ static int ocontext_write_selinux(struct policydb_compat_info *info,
 		for (c = p->ocontexts[i]; c; c = c->next) {
 			switch (i) {
 			case OCON_ISID:
+				if (!c->context[0].user)
+					break;
 				buf[0] = cpu_to_le32(c->sid[0]);
 				items = put_entry(buf, sizeof(uint32_t), 1, fp);
 				if (items != 1)
-- 
2.24.1

