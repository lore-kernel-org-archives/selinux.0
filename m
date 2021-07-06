Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B285C11F67
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD3B61C44
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhGFR5X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhGFR5X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CC3C061574
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m17so7584261edc.9
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1MEIpjRB+BUPTBDiEods8jPK/TxPB9V/ZU1g8xBx+7E=;
        b=RyJKhjM/+zTus/ha0MXE3onpAvg8fcvLTCqFN9lHRKlzXe36BWUHxGpWjRv3Uh2pGH
         02fG703E/MewlRiFYxiRlkiXKqQG/i8mueowzPD2WoUJUKY8u2s7Ss6z9PIRUUbdbJEa
         VLPuArQo6V1vdKTMom9xTGstYAeEnan9P15XK0ucPoEkQK66muEDzFy8EHm29pNoNIop
         ZbOV1WYXuZ5pCK9SMuu6p0jVjr8u9pIEI1gi6duYNCUK6jdLDHNm9GaC/hveDSm6/nO4
         bIuS+3hZNndqtas2QedoohFB2zKmZOLpzfjdm5zwIzp0pVpVOinYgQ8Kyo8BWfHdX5Ls
         Au1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1MEIpjRB+BUPTBDiEods8jPK/TxPB9V/ZU1g8xBx+7E=;
        b=RTv39AtFmye+xDfL492Zm2RIgHSXEKhL19yvO7a5oIrcdhW5oe7Q9ZmkaEHDTApUcb
         CjIsSV6ILbc7UvtqgP2svkJHKiJL2YLynPEMb31PRoaJwOMECv77PQI81ewSIfI6PDtE
         FA1q2WlVQJpz5xvbk9+TojQMG0myR7E1EDdhTig/i+98ongKZOYMWk+E+eupNpfXUXCg
         jRc+8hntZJoiUsl/Ja+EYTRFUlapOfvnIeu/VYK7451costq2eTXjXJetvWnFvxxM9ew
         Jw2ENTFkZi7Yp5SvizsmOpu7aVdlVDbIN4XrUgxBikaQq1O5PCO/HaPSDQdluPsg/hsU
         OMlw==
X-Gm-Message-State: AOAM530F49bS1K8NbxheDy6/ZayUSSAzE8fEFr77AKjOMtxVphM8cfLq
        G9jkeWNkcgNQHXUnfgwtbsBeERuy0Ic=
X-Google-Smtp-Source: ABdhPJyzACE/ntnKxM/HW66ey4tKNTStLTNtFCrt3GOOclhlpBgP3WiBOKiVZGg2Jl6xtx//yYMxDA==
X-Received: by 2002:a05:6402:40c3:: with SMTP id z3mr23835051edb.375.1625594083103;
        Tue, 06 Jul 2021 10:54:43 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 06/13] checkpolicy: follow declaration-after-statement
Date:   Tue,  6 Jul 2021 19:54:26 +0200
Message-Id: <20210706175433.29270-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706175433.29270-1-cgzones@googlemail.com>
References: <20210706175433.29270-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Follow the project style of no declaration after statement.

Found by the GCC warning -Wdeclaration-after-statement.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkmodule.c   | 6 ++++--
 checkpolicy/policy_define.c | 3 ++-
 checkpolicy/test/dismod.c   | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 40d0ec99..316b2898 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -288,14 +288,16 @@ int main(int argc, char **argv)
 	}
 
 	if (policy_type != POLICY_BASE && outfile) {
+		char *out_name;
+		char *separator;
 		char *mod_name = modpolicydb.name;
 		char *out_path = strdup(outfile);
 		if (out_path == NULL) {
 			fprintf(stderr, "%s:  out of memory\n", argv[0]);
 			exit(1);
 		}
-		char *out_name = basename(out_path);
-		char *separator = strrchr(out_name, '.');
+		out_name = basename(out_path);
+		separator = strrchr(out_name, '.');
 		if (separator) {
 			*separator = '\0';
 		}
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 7eff747a..22218c07 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1904,8 +1904,9 @@ int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
 {
 	char *id;
 	struct av_ioctl_range_list *rnew, *r = NULL;
-	*rangehead = NULL;
 	uint8_t omit = 0;
+	
+	*rangehead = NULL;	
 
 	/* read in all the ioctl commands */
 	while ((id = queue_remove(id_queue))) {
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index fadbc8d1..b1b96115 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -697,8 +697,8 @@ int display_avblock(int field, policydb_t * policy,
 {
 	avrule_block_t *block = policydb.global;
 	while (block != NULL) {
-		fprintf(out_fp, "--- begin avrule block ---\n");
 		avrule_decl_t *decl = block->branch_list;
+		fprintf(out_fp, "--- begin avrule block ---\n");
 		while (decl != NULL) {
 			if (display_avdecl(decl, field, policy, out_fp)) {
 				return -1;
-- 
2.32.0

