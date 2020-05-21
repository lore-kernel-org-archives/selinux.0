Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA17C433E1
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 14:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469EE206F6
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 14:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7V2qExd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgEUO7p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 10:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgEUO7p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 10:59:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E01C061A0E
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 07:59:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g185so7467874qke.7
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+qRwHGrFUyhz90oDm9jm0dkU/a6AU7clsp8MbrwSTM=;
        b=F7V2qExdwqhTD8QvMlUYyLese74MGc1TvXAWnCC2h0wz5PaZhwbV3tcWWBVZgDT0GJ
         25cXD1ISCA+fg1pH8axMJ+D4Ve6PKmxsK9mziIlLQfURYxnzU9bhAoV/LGOYnCkx1sep
         XlEBmnb4w83Z4ORSPRfciXZPSr6AaI1v9vnwyfQy6aj8dwK8At38TjVeca++uBih1qhM
         TZ0SyMwIeE+SvkZVpeBw1G3LoSc3n0qkJdUc449vOWMGx6iNUZyZlm1WqPyq+omggDUn
         iCjpgxqS075eyraHnD2Wgm4vLpWPhJ5t53+NpCopB9N4IvL51w2YMpx3pdui3M+kikjI
         OMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+qRwHGrFUyhz90oDm9jm0dkU/a6AU7clsp8MbrwSTM=;
        b=dzS3tKv8T2fbjjhMjmj9CWg4ULr828rdQ/ikZkx8PXuawmuZ91/4jrbRoTSBz6lnuq
         ahtRH8gxWGai73PfjWtrr0KQh1MnQUdfReev8JUavXxH6auLgyJTmnqZet/aDTsH9GOf
         Of0GHU/CKNriMgl0x0ACYaxzh5nweGMdRBUD0QXylEOZ3aii+IqLqPyTUWvHQMDptc9h
         Bv7DPMKYRvSxkFGgpMq5Log7Ql8G1CEGDHuLjTZU6YNTM0V5pDnBqqHqGN+soYampRMT
         5oo+B0ZC0DNuq6PiMFjpttNYScujPeYXBk9WhokUpqPpJrRCr2FP/f6ZPakn3Fd5ql+H
         mAyA==
X-Gm-Message-State: AOAM533+37qMdLQwxDe4zlEgDYHrez0HtU5nyN1IAlIId5EVekMfl9Nr
        VF9R8zbnDcsRNJxe+L8cTaxKml09wrk=
X-Google-Smtp-Source: ABdhPJwYLMTGeotjLLixKBEC+MNvh/aZpDmqBRQYdhdeER3swCkuX2GWDCA+k+SdoH3G8Z18Ub9B1A==
X-Received: by 2002:a37:6c8:: with SMTP id 191mr10470414qkg.358.1590073184408;
        Thu, 21 May 2020 07:59:44 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id n42sm5297481qtf.51.2020.05.21.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:59:44 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH v2 2/2] libsepol: Fix type alias handling in kernel_to_conf
Date:   Thu, 21 May 2020 10:59:25 -0400
Message-Id: <20200521145925.143481-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200521145925.143481-1-jwcart2@gmail.com>
References: <20200521145925.143481-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Type alias rules are not written out when converting a binary kernel
policy to a policy.conf. The problem is that type aliases are not in
the type_val_to_struct array and that is what is being used to find
the aliases.

Since type aliases are only in the types hashtable, walk that to
find the type aliases.

Fixed the syntax of the typalias rule which requires "alias" to come
between the type and the aliases (ex/ typealias TYPE alias ALIAS;).

Fixes: 0a08fd1e69797d6a ("libsepol: Add ability to convert binary
       policy to policy.conf file")

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Fix typealias syntax

 libsepol/src/kernel_to_conf.c | 47 +++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 9de64832..bf82d9c3 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1353,34 +1353,55 @@ exit:
 	return rc;
 }
 
+static int map_count_type_aliases(char *key, void *data, void *args)
+{
+	type_datum_t *datum = data;
+	unsigned *count = args;
+
+	if (datum->primary == 0 && datum->flavor == TYPE_TYPE)
+		(*count)++;
+
+	return SEPOL_OK;
+}
+
+static int map_type_aliases_to_strs(char *key, void *data, void *args)
+{
+	type_datum_t *datum = data;
+	struct strs *strs = args;
+	int rc = 0;
+
+	if (datum->primary == 0 && datum->flavor == TYPE_TYPE)
+		rc = strs_add(strs, key);
+
+	return rc;
+}
+
 static int write_type_alias_rules_to_conf(FILE *out, struct policydb *pdb)
 {
 	type_datum_t *alias;
 	struct strs *strs;
 	char *name;
 	char *type;
-	unsigned i, num;
+	unsigned i, num = 0;
 	int rc = 0;
 
-	rc = strs_init(&strs, pdb->p_types.nprim);
+	rc = hashtab_map(pdb->p_types.table, map_count_type_aliases, &num);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	for (i=0; i < pdb->p_types.nprim; i++) {
-		alias = pdb->type_val_to_struct[i];
-		if (!alias->primary) {
-			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
-			if (rc != 0) {
-				goto exit;
-			}
-		}
+	rc = strs_init(&strs, num);
+	if (rc != 0) {
+		goto exit;
 	}
 
+	rc = hashtab_map(pdb->p_types.table, map_type_aliases_to_strs, strs);
+	if (rc != 0) {
+		goto exit;
+	}
+	
 	strs_sort(strs);
 
-	num = strs_num_items(strs);
-
 	for (i=0; i<num; i++) {
 		name = strs_read_at_index(strs, i);
 		if (!name) {
@@ -1393,7 +1414,7 @@ static int write_type_alias_rules_to_conf(FILE *out, struct policydb *pdb)
 			goto exit;
 		}
 		type = pdb->p_type_val_to_name[alias->s.value - 1];
-		sepol_printf(out, "typealias %s %s;\n", type, name);
+		sepol_printf(out, "typealias %s alias %s;\n", type, name);
 	}
 
 exit:
-- 
2.25.4

