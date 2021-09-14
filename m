Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DC1C433FE
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B549360F58
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhINMwE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhINMwE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC063C061574
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c22so18310767edn.12
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nlvDZ/SHK6NzWFTCvnTe+yP7fLIc5O+De7SX0iB5krU=;
        b=CLovRqVTTQPTTrrcw6wom5elEB4ztOz8UaemdDgVo0Cbaydb946cPxzCMQd7T3Z7kX
         t5oGrejaph7/cMfVzkd9xw1f4NMKCGgA/rCGdXPgxjcLTfG9A40PD6xlwQsL9jMVk4tA
         GHueVqWfCe752sEeJ+Y2YpMaJCkcvr+/k8kN9PgixEOCNhxnfxFdIA1QD/MY3DeZ8/iM
         BatVYnTpIwwXeHwvWxD+e0EyS6GO6WiU1bwJvNY0Y/SsFjVyVs+p0xCUnrPDCVKo+thx
         VpWo1bJBgNm9uFnUd1E4P6oF7lB/uS6TrilGXzKz+FoKYun8GjSF6K7m1NQhtmnUtR4u
         Z1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlvDZ/SHK6NzWFTCvnTe+yP7fLIc5O+De7SX0iB5krU=;
        b=CahKcHbOdKVLPrbvB1ud7phOi8nhZ3YbJzr01sBgIAk4dFEl9ZtA4CIxLNzLfT8bmg
         qYDTEQqw1sPNvMhyIKZOIrTuwC3aLVH4ZLu0KbyKuzUQ2Kt7FpxUSB23RhAONQSTvsV5
         U+0tOey3a9BLkGDsQk3c7o/t2sNwMzW35uuS3LYr4sgDdn7ra0XmvWZC7GcsrUcDtbXv
         5rC/ulP3v0RTUfJn3oBcI5/gO9pID3lsKOpc+9b6GkaBOZduuLHXFjfS4Dkf1SRAniPz
         Y2FDry1jfTeXWhQXSTcxn9fSXduUDcSlu4CyOr+EBo/mXI5XyPTB7pCZGPP+RRvUKbe/
         zyMg==
X-Gm-Message-State: AOAM530aS02tNrm7dXHeHXjb8FzzNlGJH2kycXsZtCKZSvu0FCqZSM4y
        3apFjOjuM/3ra4i/kAXzkUkzeDZIUW4=
X-Google-Smtp-Source: ABdhPJxkK+IqN6gGnV35AqTZKZaWsoXv4ZM2nc1LiJWR9qz4drF0pyrW1n1FIOWI6KbshbMOA76bhw==
X-Received: by 2002:a50:e004:: with SMTP id e4mr10461899edl.164.1631623845364;
        Tue, 14 Sep 2021 05:50:45 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:45 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 05/13] checkpolicy: misc checkpolicy tweaks
Date:   Tue, 14 Sep 2021 14:48:20 +0200
Message-Id: <20210914124828.19488-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
References: <20210914124828.19488-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add missing argument in usage message.
Drop redundant includes `optarg` and `optind`, which are declared in
<getopt.h>.
Mark file local functions static.
Drop unused function declaration.

Check closing file streams after writing, which can signal a failed
write or sync to disk and should be checked.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkpolicy.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index e6cfd337..9459486b 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -92,9 +92,6 @@
 #include "checkpolicy.h"
 #include "parse_util.h"
 
-extern char *optarg;
-extern int optind;
-
 static policydb_t policydb;
 static sidtab_t sidtab;
 
@@ -112,7 +109,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	printf
 	    ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] "
-	     "[-c policyvers (%d-%d)] [-o output_file|-] [-S] "
+	     "[-c policyvers (%d-%d)] [-o output_file|-] [-S] [-O]"
 	     "[-t target_platform (selinux,xen)] [-E] [-V] [input_file]\n",
 	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 	exit(1);
@@ -297,9 +294,7 @@ static int identify_equiv_types(void)
 }
 #endif
 
-extern char *av_to_string(uint32_t tclass, sepol_access_vector_t av);
-
-int display_bools(void)
+static int display_bools(void)
 {
 	uint32_t i;
 
@@ -310,10 +305,10 @@ int display_bools(void)
 	return 0;
 }
 
-void display_expr(cond_expr_t * exp)
+static void display_expr(const cond_expr_t * exp)
 {
 
-	cond_expr_t *cur;
+	const cond_expr_t *cur;
 	for (cur = exp; cur != NULL; cur = cur->next) {
 		switch (cur->expr_type) {
 		case COND_BOOL:
@@ -345,9 +340,9 @@ void display_expr(cond_expr_t * exp)
 	}
 }
 
-int display_cond_expressions(void)
+static int display_cond_expressions(void)
 {
-	cond_node_t *cur;
+	const cond_node_t *cur;
 
 	for (cur = policydbp->cond_list; cur != NULL; cur = cur->next) {
 		printf("expression: ");
@@ -357,7 +352,7 @@ int display_cond_expressions(void)
 	return 0;
 }
 
-int change_bool(char *name, int state)
+static int change_bool(const char *name, int state)
 {
 	cond_bool_datum_t *bool;
 
@@ -412,7 +407,7 @@ int main(int argc, char **argv)
 	unsigned int reason;
 	int flags;
 	struct policy_file pf;
-	struct option long_options[] = {
+	const struct option long_options[] = {
 		{"output", required_argument, NULL, 'o'},
 		{"target", required_argument, NULL, 't'},
 		{"binary", no_argument, NULL, 'b'},
@@ -706,7 +701,10 @@ int main(int argc, char **argv)
 		}
 
 		if (outfp != stdout) {
-			fclose(outfp);
+			if(fclose(outfp)) {
+				fprintf(stderr, "%s:  error closing %s:  %s\n", argv[0], outfile, strerror(errno));
+				exit(1);
+			}
 		}
 	} else if (cil) {
 		fprintf(stderr, "%s:  No file to write CIL was specified\n", argv[0]);
-- 
2.33.0

