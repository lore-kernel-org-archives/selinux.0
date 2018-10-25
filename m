Return-Path: <SRS0=7H0L=NF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E716C46475
	for <selinux@archiver.kernel.org>; Thu, 25 Oct 2018 19:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BAA20834
	for <selinux@archiver.kernel.org>; Thu, 25 Oct 2018 19:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BAA20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJZE1a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:27:30 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:53503 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeJZE1a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Oct 2018 00:27:30 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2018 00:27:29 EDT
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8BD345612C1
        for <selinux@vger.kernel.org>; Thu, 25 Oct 2018 21:46:04 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] Fix snprintf truncated error
Date:   Thu, 25 Oct 2018 21:45:48 +0200
Message-Id: <20181025194548.21505-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Oct 25 21:46:04 2018 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Mr Stid <stidofficiel@gmail.com>

Link: https://github.com/SELinuxProject/selinux/pull/106
Signed-off-by: StidOfficial <stidofficiel@gmail.com>
---
 libsepol/src/kernel_to_cil.c  | 8 ++++----
 libsepol/src/kernel_to_conf.c | 8 ++++----
 libsepol/src/module_to_cil.c  | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index d173144ef618..2c12ae9bf7f1 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -536,7 +536,7 @@ static int write_sids_to_cil(FILE *out, const char *const *sid_to_str,
 	struct strs *strs;
 	char *sid;
 	char *prev;
-	char unknown[17];
+	char unknown[18];
 	unsigned i;
 	int rc;
 
@@ -550,7 +550,7 @@ static int write_sids_to_cil(FILE *out, const char *const *sid_to_str,
 		if (i < num_sids) {
 			sid = (char *)sid_to_str[i];
 		} else {
-			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
+			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
 			sid = strdup(unknown);
 		}
 		rc = strs_add_at_index(strs, sid, i);
@@ -2498,7 +2498,7 @@ static int write_sid_context_rules_to_cil(FILE *out, struct policydb *pdb, const
 	struct ocontext *isid;
 	struct strs *strs;
 	char *sid;
-	char unknown[17];
+	char unknown[18];
 	char *ctx, *rule;
 	unsigned i;
 	int rc = -1;
@@ -2513,7 +2513,7 @@ static int write_sid_context_rules_to_cil(FILE *out, struct policydb *pdb, const
 		if (i < num_sids) {
 			sid = (char *)sid_to_str[i];
 		} else {
-			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
+			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
 			sid = unknown;
 		}
 
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 7e04a13bd1ff..219a2489feba 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -434,7 +434,7 @@ static int write_sids_to_conf(FILE *out, const char *const *sid_to_str,
 	struct ocontext *isid;
 	struct strs *strs;
 	char *sid;
-	char unknown[17];
+	char unknown[18];
 	unsigned i;
 	int rc;
 
@@ -448,7 +448,7 @@ static int write_sids_to_conf(FILE *out, const char *const *sid_to_str,
 		if (i < num_sids) {
 			sid = (char *)sid_to_str[i];
 		} else {
-			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
+			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
 			sid = strdup(unknown);
 		}
 		rc = strs_add_at_index(strs, sid, i);
@@ -2358,7 +2358,7 @@ static int write_sid_context_rules_to_conf(FILE *out, struct policydb *pdb, cons
 	struct ocontext *isid;
 	struct strs *strs;
 	char *sid;
-	char unknown[17];
+	char unknown[18];
 	char *ctx, *rule;
 	unsigned i;
 	int rc;
@@ -2373,7 +2373,7 @@ static int write_sid_context_rules_to_conf(FILE *out, struct policydb *pdb, cons
 		if (i < num_sids) {
 			sid = (char *)sid_to_str[i];
 		} else {
-			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
+			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
 			sid = unknown;
 		}
 
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 7fc29cbda2de..4cb44e0ee657 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2562,7 +2562,7 @@ static int ocontext_isid_to_cil(struct policydb *pdb, const char *const *sid_to_
 	struct sid_item *head = NULL;
 	struct sid_item *item = NULL;
 	char *sid;
-	char unknown[17];
+	char unknown[18];
 	unsigned i;
 
 	for (isid = isids; isid != NULL; isid = isid->next) {
@@ -2570,7 +2570,7 @@ static int ocontext_isid_to_cil(struct policydb *pdb, const char *const *sid_to_
 		if (i < num_sids) {
 			sid = (char*)sid_to_string[i];
 		} else {
-			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
+			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
 			sid = unknown;
 		}
 		cil_println(0, "(sid %s)", sid);
-- 
2.19.0

