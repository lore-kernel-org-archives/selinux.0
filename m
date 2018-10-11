Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BFBC32788
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 12:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBFB2064A
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 12:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBFB2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeJKUMd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:12:33 -0400
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:16711 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeJKUMd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 16:12:33 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2018 16:12:28 EDT
X-EEMSG-check-008: 173518698|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Oct 2018 12:35:25 +0000
X-IronPort-AV: E=Sophos;i="5.54,368,1534809600"; 
   d="scan'208";a="19290038"
IronPort-PHdr: =?us-ascii?q?9a23=3A71R++xfmlybHuybiUvpjxLqXlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcu+bB7h7PlgxGXEQZ/co6odzbaO7Oa4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahY75+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+t4b1rSBv1gykZMTA3/nzchshpgK5FvB6tohpyyJPWbo6ILvpzZqPTc80HS2?=
 =?us-ascii?q?RPXchfUC5OAo2nYocTE+YMJ/pUopPhq1cSqxa1GAmiBPnoyj9NnnL42bc10+?=
 =?us-ascii?q?E/HgHdwQctAcgBsG7IrNrrLqcZTOe4zKvGzDrfdfxWwyv95JbTfxA9ofCDQb?=
 =?us-ascii?q?Jwcc3LxUkpDAPKlE+cqYPiPzOLz+kAtXWQ4el4Ve+3lmIqpA58riKvy8sxkI?=
 =?us-ascii?q?XFmI0Yxk7e+Slkxos+OMe2R1RhYdG+FZtdrySaN4xrTcw8W2xooyM6yqEeuZ?=
 =?us-ascii?q?68YSgK1Iwrxx7BZPyDdIiF+g7jW/yLITd5mXJlY6izhwqy8Ee8yu38UdO40F?=
 =?us-ascii?q?BWoSpejtbArHUN1x3X6sSfS/t9+Fmu2SqX2gzO5exJLlo4mKrGJ5I73LI9mY?=
 =?us-ascii?q?QfvV7eEiPunUX5lq6WdkEq+uiy7OTnZ63rpp2SNoBokA7+KLgultKkDOQkMg?=
 =?us-ascii?q?kBQ2ib+eOm2L3l5k32Wq9GjvIxkqnHqJzaP9gUpralAw9J1YYu8w2/ACmi0N?=
 =?us-ascii?q?QZm3kHMV1EdQmZj4jmJV7OOur0DfShjFS2ljdk2fTGMqfmApXXIXiQ2IvmKK?=
 =?us-ascii?q?1w709a1Rob099S/dRXB6sHLfa1XVX+5/LCCRpsEQWxzv2vI9xnyo4EETaNHa?=
 =?us-ascii?q?SQKr+ImUOZ7eIoZe+XbckavyireKtt3OLnkXJswQxVRqKux5ZCLSrgEw=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2C6AAAkQ79b/wHyM5BiHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VkqgWUomEFMAQEBAQEBBoIviAaOAIF6IBgBhEAChFUhNgsNAQMBAQEBAQECA?=
 =?us-ascii?q?WwogjYkgmAGJ1IQUVcZgmE/gXUNpxszhHeEYoclhCCBEIEHgRKCXQeLBAKBK?=
 =?us-ascii?q?AGNCo9dBgOQSQsXkBGXWwQtgVUrCAIYKYFogU6CJheONCMwewEBi2QBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Oct 2018 12:35:24 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9BCZNWr028160;
        Thu, 11 Oct 2018 08:35:23 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov
Subject: [PATCH 3/4] libsepol: Check that initial sid indexes are within the valid range
Date:   Thu, 11 Oct 2018 08:35:48 -0400
Message-Id: <20181011123549.14875-4-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011123549.14875-1-jwcart2@tycho.nsa.gov>
References: <20181011123549.14875-1-jwcart2@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When writing CIL from a policy module or when writing CIL or policy.conf
from a kernel binary policy, check that the initial sid index is within
the valid range of the selinux_sid_to_str[] array (or xen_sid_to_str[]
array for a XEN policy). If it is not, then create a unique name
("UNKNOWN"+index) for the initial sid.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/kernel_to_cil.c    | 42 +++++++++++++++++++++++++--------
 libsepol/src/kernel_to_common.h |  4 ++++
 libsepol/src/kernel_to_conf.c   | 42 +++++++++++++++++++++++++--------
 libsepol/src/module_to_cil.c    | 25 ++++++++++++++------
 4 files changed, 86 insertions(+), 27 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index c2a733ee..d173144e 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -529,23 +529,31 @@ exit:
 	return rc;
 }
 
-static int write_sids_to_cil(FILE *out, const char *const *sid_to_str, struct ocontext *isids)
+static int write_sids_to_cil(FILE *out, const char *const *sid_to_str,
+			     unsigned num_sids, struct ocontext *isids)
 {
 	struct ocontext *isid;
 	struct strs *strs;
 	char *sid;
 	char *prev;
+	char unknown[17];
 	unsigned i;
 	int rc;
 
-	rc = strs_init(&strs, SECINITSID_NUM+1);
+	rc = strs_init(&strs, num_sids+1);
 	if (rc != 0) {
 		goto exit;
 	}
 
 	for (isid = isids; isid != NULL; isid = isid->next) {
 		i = isid->sid[0];
-		rc = strs_add_at_index(strs, (char *)sid_to_str[i], i);
+		if (i < num_sids) {
+			sid = (char *)sid_to_str[i];
+		} else {
+			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
+			sid = strdup(unknown);
+		}
+		rc = strs_add_at_index(strs, sid, i);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -577,6 +585,10 @@ static int write_sids_to_cil(FILE *out, const char *const *sid_to_str, struct oc
 	sepol_printf(out, "))\n");
 
 exit:
+	for (i=num_sids; i<strs_num_items(strs); i++) {
+		sid = strs_read_at_index(strs, i);
+		free(sid);
+	}
 	strs_destroy(&strs);
 	if (rc != 0) {
 		sepol_log_err("Error writing sid rules to CIL\n");
@@ -590,9 +602,11 @@ static int write_sid_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 	int rc = 0;
 
 	if (pdb->target_platform == SEPOL_TARGET_SELINUX) {
-		rc = write_sids_to_cil(out, selinux_sid_to_str, pdb->ocontexts[0]);
+		rc = write_sids_to_cil(out, selinux_sid_to_str, SELINUX_SID_SZ,
+				       pdb->ocontexts[0]);
 	} else if (pdb->target_platform == SEPOL_TARGET_XEN) {
-		rc = write_sids_to_cil(out, xen_sid_to_str, pdb->ocontexts[0]);
+		rc = write_sids_to_cil(out, xen_sid_to_str, XEN_SID_SZ,
+				       pdb->ocontexts[0]);
 	} else {
 		sepol_log_err("Unknown target platform: %i", pdb->target_platform);
 		rc = -1;
@@ -2479,11 +2493,12 @@ exit:
 	return ctx;
 }
 
-static int write_sid_context_rules_to_cil(FILE *out, struct policydb *pdb, const char *const *sid_to_str)
+static int write_sid_context_rules_to_cil(FILE *out, struct policydb *pdb, const char *const *sid_to_str, unsigned num_sids)
 {
 	struct ocontext *isid;
 	struct strs *strs;
-	const char *sid;
+	char *sid;
+	char unknown[17];
 	char *ctx, *rule;
 	unsigned i;
 	int rc = -1;
@@ -2495,7 +2510,13 @@ static int write_sid_context_rules_to_cil(FILE *out, struct policydb *pdb, const
 
 	for (isid = pdb->ocontexts[0]; isid != NULL; isid = isid->next) {
 		i = isid->sid[0];
-		sid = sid_to_str[i];
+		if (i < num_sids) {
+			sid = (char *)sid_to_str[i];
+		} else {
+			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
+			sid = unknown;
+		}
+
 		ctx = context_to_str(pdb, &isid->context[0]);
 		if (!ctx) {
 			rc = -1;
@@ -2531,7 +2552,8 @@ exit:
 
 static int write_selinux_isid_rules_to_cil(FILE *out, struct policydb *pdb)
 {
-	return write_sid_context_rules_to_cil(out, pdb, selinux_sid_to_str);
+	return write_sid_context_rules_to_cil(out, pdb, selinux_sid_to_str,
+					      SELINUX_SID_SZ);
 }
 
 static int write_selinux_fsuse_rules_to_cil(FILE *out, struct policydb *pdb)
@@ -2884,7 +2906,7 @@ exit:
 
 static int write_xen_isid_rules_to_cil(FILE *out, struct policydb *pdb)
 {
-	return write_sid_context_rules_to_cil(out, pdb, xen_sid_to_str);
+	return write_sid_context_rules_to_cil(out, pdb, xen_sid_to_str, XEN_SID_SZ);
 }
 
 static int write_xen_pirq_rules_to_cil(FILE *out, struct policydb *pdb)
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index 7c5edbd6..dacfe97e 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -43,6 +43,8 @@ static const char * const selinux_sid_to_str[] = {
 	"devnull",
 };
 
+#define SELINUX_SID_SZ (sizeof(selinux_sid_to_str)/sizeof(selinux_sid_to_str[0]))
+
 static const char * const xen_sid_to_str[] = {
 	"null",
 	"xen",
@@ -57,6 +59,8 @@ static const char * const xen_sid_to_str[] = {
 	"device",
 };
 
+#define XEN_SID_SZ (sizeof(xen_sid_to_str)/sizeof(xen_sid_to_str[0]))
+
 static const uint32_t avtab_flavors[] = {
 	AVTAB_ALLOWED,
 	AVTAB_AUDITALLOW,
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index a98b5ca9..7e04a13b 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -428,22 +428,30 @@ static int write_class_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 	return 0;
 }
 
-static int write_sids_to_conf(FILE *out, const char *const *sid_to_str, struct ocontext *isids)
+static int write_sids_to_conf(FILE *out, const char *const *sid_to_str,
+			      unsigned num_sids, struct ocontext *isids)
 {
 	struct ocontext *isid;
 	struct strs *strs;
 	char *sid;
+	char unknown[17];
 	unsigned i;
 	int rc;
 
-	rc = strs_init(&strs, SECINITSID_NUM+1);
+	rc = strs_init(&strs, num_sids+1);
 	if (rc != 0) {
 		goto exit;
 	}
 
 	for (isid = isids; isid != NULL; isid = isid->next) {
 		i = isid->sid[0];
-		rc = strs_add_at_index(strs, (char *)sid_to_str[i], i);
+		if (i < num_sids) {
+			sid = (char *)sid_to_str[i];
+		} else {
+			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
+			sid = strdup(unknown);
+		}
+		rc = strs_add_at_index(strs, sid, i);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -458,6 +466,10 @@ static int write_sids_to_conf(FILE *out, const char *const *sid_to_str, struct o
 	}
 
 exit:
+	for (i=num_sids; i<strs_num_items(strs); i++) {
+		sid = strs_read_at_index(strs, i);
+		free(sid);
+	}
 	strs_destroy(&strs);
 	if (rc != 0) {
 		sepol_log_err("Error writing sid rules to policy.conf\n");
@@ -471,9 +483,11 @@ static int write_sid_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 	int rc = 0;
 
 	if (pdb->target_platform == SEPOL_TARGET_SELINUX) {
-		rc = write_sids_to_conf(out, selinux_sid_to_str, pdb->ocontexts[0]);
+		rc = write_sids_to_conf(out, selinux_sid_to_str, SELINUX_SID_SZ,
+					pdb->ocontexts[0]);
 	} else if (pdb->target_platform == SEPOL_TARGET_XEN) {
-		rc = write_sids_to_conf(out, xen_sid_to_str, pdb->ocontexts[0]);
+		rc = write_sids_to_conf(out, xen_sid_to_str, XEN_SID_SZ,
+					pdb->ocontexts[0]);
 	} else {
 		sepol_log_err("Unknown target platform: %i", pdb->target_platform);
 		rc = -1;
@@ -2339,11 +2353,12 @@ static char *context_to_str(struct policydb *pdb, struct context_struct *con)
 	return ctx;
 }
 
-static int write_sid_context_rules_to_conf(FILE *out, struct policydb *pdb, const char *const *sid_to_str)
+static int write_sid_context_rules_to_conf(FILE *out, struct policydb *pdb, const char *const *sid_to_str, unsigned num_sids)
 {
 	struct ocontext *isid;
 	struct strs *strs;
-	const char *sid;
+	char *sid;
+	char unknown[17];
 	char *ctx, *rule;
 	unsigned i;
 	int rc;
@@ -2355,7 +2370,13 @@ static int write_sid_context_rules_to_conf(FILE *out, struct policydb *pdb, cons
 
 	for (isid = pdb->ocontexts[0]; isid != NULL; isid = isid->next) {
 		i = isid->sid[0];
-		sid = sid_to_str[i];
+		if (i < num_sids) {
+			sid = (char *)sid_to_str[i];
+		} else {
+			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
+			sid = unknown;
+		}
+
 		ctx = context_to_str(pdb, &isid->context[0]);
 		if (!ctx) {
 			rc = -1;
@@ -2391,7 +2412,8 @@ exit:
 
 static int write_selinux_isid_rules_to_conf(FILE *out, struct policydb *pdb)
 {
-	return write_sid_context_rules_to_conf(out, pdb, selinux_sid_to_str);
+	return write_sid_context_rules_to_conf(out, pdb, selinux_sid_to_str,
+					       SELINUX_SID_SZ);
 }
 
 static int write_selinux_fsuse_rules_to_conf(FILE *out, struct policydb *pdb)
@@ -2745,7 +2767,7 @@ exit:
 
 static int write_xen_isid_rules_to_conf(FILE *out, struct policydb *pdb)
 {
-	return write_sid_context_rules_to_conf(out, pdb, xen_sid_to_str);
+	return write_sid_context_rules_to_conf(out, pdb, xen_sid_to_str, XEN_SID_SZ);
 }
 
 
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 8ab0dfce..7fc29cbd 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2548,23 +2548,33 @@ static int context_to_cil(struct policydb *pdb, struct context_struct *con)
 }
 
 static int ocontext_isid_to_cil(struct policydb *pdb, const char *const *sid_to_string,
-				struct ocontext *isids)
+				unsigned num_sids, struct ocontext *isids)
 {
 	int rc = -1;
 
 	struct ocontext *isid;
 
 	struct sid_item {
-		const char *sid_key;
+		char *sid_key;
 		struct sid_item *next;
 	};
 
 	struct sid_item *head = NULL;
 	struct sid_item *item = NULL;
+	char *sid;
+	char unknown[17];
+	unsigned i;
 
 	for (isid = isids; isid != NULL; isid = isid->next) {
-		cil_println(0, "(sid %s)", sid_to_string[isid->sid[0]]);
-		cil_printf("(sidcontext %s ", sid_to_string[isid->sid[0]]);
+		i = isid->sid[0];
+		if (i < num_sids) {
+			sid = (char*)sid_to_string[i];
+		} else {
+			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
+			sid = unknown;
+		}
+		cil_println(0, "(sid %s)", sid);
+		cil_printf("(sidcontext %s ", sid);
 		context_to_cil(pdb, &isid->context[0]);
 		cil_printf(")\n");
 
@@ -2576,7 +2586,7 @@ static int ocontext_isid_to_cil(struct policydb *pdb, const char *const *sid_to_
 			rc = -1;
 			goto exit;
 		}
-		item->sid_key = sid_to_string[isid->sid[0]];
+		item->sid_key = strdup(sid);
 		item->next = head;
 		head = item;
 	}
@@ -2595,6 +2605,7 @@ exit:
 	while(head) {
 		item = head;
 		head = item->next;
+		free(item->sid_key);
 		free(item);
 	}
 	return rc;
@@ -2604,7 +2615,7 @@ static int ocontext_selinux_isid_to_cil(struct policydb *pdb, struct ocontext *i
 {
 	int rc = -1;
 
-	rc = ocontext_isid_to_cil(pdb, selinux_sid_to_str, isids);
+	rc = ocontext_isid_to_cil(pdb, selinux_sid_to_str, SELINUX_SID_SZ, isids);
 	if (rc != 0) {
 		goto exit;
 	}
@@ -2833,7 +2844,7 @@ static int ocontext_xen_isid_to_cil(struct policydb *pdb, struct ocontext *isids
 {
 	int rc = -1;
 
-	rc = ocontext_isid_to_cil(pdb, xen_sid_to_str, isids);
+	rc = ocontext_isid_to_cil(pdb, xen_sid_to_str, XEN_SID_SZ, isids);
 	if (rc != 0) {
 		goto exit;
 	}
-- 
2.17.1

