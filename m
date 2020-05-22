Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAB2C433E2
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 14:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E9A2072C
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 14:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CElpIbg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbgEVOvc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731019AbgEVOvb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 10:51:31 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D878C061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 07:51:31 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so8471389qtb.5
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5suHV3ldz+ePJT8SlrfPszOmzWrcmHMd0my/IAdhEX8=;
        b=CElpIbg4NkWdE92srFRDXKp8tsYpWJisQpKo7nnujNA3hTj5CLt4UESHf5yYhmCT6S
         Docjeq6tvEbWz+z0rFQWC5DDJpiJ264DI+4vv5CONOCfatKltxZLIZdoJI3eOXevDwUV
         Fm+Y7WQU4YkFfnon7DHrylYaK4J9ELWeHPAmaIKUa5z66OoJortwoSncRI/VO/SQCQEN
         Zzt9fVNzGTgxAuD1gGYz4Cn/kEcimfCu6UJV+yGZeEgfEVKFJg7wHiI4LDIfLFmnlU2E
         byygSyJRTUjYV8f1BcaEi8YpEvMjTjw4Ozff3svau70L+gtpTkGPUfcOT9WDzo0mpYkc
         QiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5suHV3ldz+ePJT8SlrfPszOmzWrcmHMd0my/IAdhEX8=;
        b=a8fQ1+IxSCA9gBNZQE+U877cqnGvuGTbGHzJXSG4HOYu6qGYwdhszw9jb7nGSVGDBd
         NB+8oCFpk5syOozCKFBrVdMZKoPYhGJErA3i1bBs+K4ph8YrE8SpixZbHNN13+PBuhzT
         BVOVpqjlStJlPAVpkZouKnBS6j9ja7UYLiBgAh4+pAdFuVibrUAj5qy4fCOPkjDlmnT6
         6+TgBQoPo/g+mB3kRSK1gan6c6AaH44yqY+WWIlHIW/H0I2UWX2pOi9Dm74B6pagGyXj
         ftz6hjpeiDvbbRM+FJckowrqfzSJ4BtN88/q7NKssPFtXY2Nj6AqeV1xG6FklxLpCMiw
         g1wQ==
X-Gm-Message-State: AOAM530MhKIiVkiq1mnO1n0/v9GHC8UGIkG2tFopL+w8a/vQv5QSTDAY
        +ohGcDZ9FeQQY/+ZYuhbnwSsRnRqJgI=
X-Google-Smtp-Source: ABdhPJz9LMg2IUUQAidXsQzmWGTYgHaEv/nIO9nZVfzn6sFRSRcsKRUPRenCmC4C384UOxpNQcYcVg==
X-Received: by 2002:ac8:3292:: with SMTP id z18mr15359188qta.32.1590159090112;
        Fri, 22 May 2020 07:51:30 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id v69sm3668805qkb.96.2020.05.22.07.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:51:29 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH v3 2/2] libsepol: Fix type alias handling in kernel_to_conf
Date:   Fri, 22 May 2020 10:50:38 -0400
Message-Id: <20200522145038.194209-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200522145038.194209-1-jwcart2@gmail.com>
References: <20200522145038.194209-1-jwcart2@gmail.com>
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
v3: Add "__attribute__((unused))" to unused parameters as suggested by
    Nicolas Iooss

 libsepol/src/kernel_to_conf.c | 47 +++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 9de64832..046d76a4 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1353,34 +1353,55 @@ exit:
 	return rc;
 }
 
+static int map_count_type_aliases(__attribute__((unused)) char *key, void *data, void *args)
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

