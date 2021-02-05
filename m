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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A942DC433E9
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 20:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5803364FB1
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 20:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhBETJK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 14:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbhBETIw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 14:08:52 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649D5C061793
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 12:49:43 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h16so5973081qth.11
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 12:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LYIiTjf5ZQCVHn/yHlJYXIwl6j+U0AzGr1zWacF+0cU=;
        b=szXKjSS6XpIqgekTRyEkOyBTwJGUL3ZKFCYQ9Pa2139kriRoFBEHLmDwDIbvOrBVY0
         aN/5K2qs5WaIgwpmcUuxFKG3I+mJbNoJx/cUas8v8MLOuHGxIvJpywFARKdAYENknaCm
         cBxqp3lm7j3GVZZyCX5dLgYXNXsRUA1onNG2bRyaRh40i94k8Gxe5W8fuGVjLf6EhlBG
         APf7LnQYpV2C80dzt/SizPT4N9ykI51oeCbJBF2rnfscZ/0d9UyWyxVLswQLTEhMf+7t
         ZrI9RSZbqMo7vNc37E2MY/p6ozoemSfHv0FVOzAGuOYsS5u0IlYFYrWFMvCBV8HIsaoh
         LTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LYIiTjf5ZQCVHn/yHlJYXIwl6j+U0AzGr1zWacF+0cU=;
        b=c6HRhlY/DLN2jZJGgpzWzqXRfP1OLoKMQOss41Lc2fD+TmJoq7k440/THH2WdT2dj+
         /xG5YBX2BCV3oL+BUgA9w7uNWYXaZgWfw1TmAMSILQq+uyMp36hUHI2tBjBpC9Eg+Q9w
         EYJ3RFAg/G05b/OVFn4CojEzIgVBgc36bg0ZCdqkkC96QVcnULrbXl95IbdAasL3JZ/R
         PRyFAFj7MbyHH2kkQtsk+svgu33xctfJg4hBglUBWP2tlfuE80nkR6NrR4Ooz5VyXPZs
         Fj+i7vDnut1x7r9XY7opV3qaCKPz3SaGAUrPJtxkkNfqV2bMRA+zFigAhELexL/s/3de
         3Z4Q==
X-Gm-Message-State: AOAM533JP58yKdIHfYfD9iXzgUjnx7zH0uNPVhJJaVgmZK8asZd7xat6
        541IvT6QUw586beRJetmh9o3gT3cG9sAzw==
X-Google-Smtp-Source: ABdhPJzHG283regdLP1LuVjjZPAowjY1kOyEvmKU2wilc8uYdWEefJRgIaeSNuAI2UyXmP2lUt8Y1g==
X-Received: by 2002:ac8:5e12:: with SMTP id h18mr6000212qtx.335.1612558182462;
        Fri, 05 Feb 2021 12:49:42 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id 133sm10541850qkg.38.2021.02.05.12.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 12:49:41 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Eliminate gaps in the policydb role arrays
Date:   Fri,  5 Feb 2021 15:49:34 -0500
Message-Id: <20210205204934.314141-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since the kernel binary policy does not include role attributes,
they are expanded when creating the policy and there are gaps
in the role values written to the policy. When this policy is
read from a file and the policydb is created there will be gaps
in the p_role_val_to_name and role_val_to_struct arrays.

When expanding a policy into a new policydb, copy the roles first
and then copy the role attributes. When writing a kernel binary
policy, update the nprim of the role symtab by subtracting the number
of role attributes. Now when that policy is read and its policydb is
created there will be no gaps in the role arrays.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 40 ++++++++++++++++++++++++++++++++--------
 libsepol/src/write.c  |  6 ++++--
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index eac7e450..ea1b115a 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -789,19 +789,15 @@ static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 	return 0;
 }
 
-static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
-			      void *data)
+static int role_copy_callback_helper(char *id, role_datum_t *role, expand_state_t *state, unsigned int copy_attr)
 {
 	int ret;
-	char *id, *new_id;
-	role_datum_t *role;
+	char *new_id;
 	role_datum_t *new_role;
-	expand_state_t *state;
 	ebitmap_t tmp_union_types;
 
-	id = key;
-	role = (role_datum_t *) datum;
-	state = (expand_state_t *) data;
+	if ((!copy_attr && role->flavor == ROLE_ATTRIB) || (copy_attr && role->flavor != ROLE_ATTRIB))
+		return 0;
 
 	if (strcmp(id, OBJECT_R) == 0) {
 		/* object_r is always value 1 */
@@ -878,6 +874,26 @@ static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	return 0;
 }
 
+static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
+			      void *data)
+{
+	char *id = key;
+	role_datum_t *role = (role_datum_t *) datum;
+	expand_state_t *state = (expand_state_t *) data;
+
+	return role_copy_callback_helper(id, role, state, 0);
+}
+
+static int role_attr_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
+			      void *data)
+{
+	char *id = key;
+	role_datum_t *role = (role_datum_t *) datum;
+	expand_state_t *state = (expand_state_t *) data;
+
+	return role_copy_callback_helper(id, role, state, 1);
+}
+
 int mls_semantic_level_expand(mls_semantic_level_t * sl, mls_level_t * l,
 			      policydb_t * p, sepol_handle_t * h)
 {
@@ -3014,6 +3030,9 @@ int expand_module(sepol_handle_t * handle,
 	/* copy roles */
 	if (hashtab_map(state.base->p_roles.table, role_copy_callback, &state))
 		goto cleanup;
+	/* copy role attrs */
+	if (hashtab_map(state.base->p_roles.table, role_attr_copy_callback, &state))
+		goto cleanup;
 	if (hashtab_map(state.base->p_roles.table,
 			role_bounds_copy_callback, &state))
 		goto cleanup;
@@ -3074,6 +3093,11 @@ int expand_module(sepol_handle_t * handle,
 		    (decl->p_roles.table, role_copy_callback, &state))
 			goto cleanup;
 
+		/* copy role attrs */
+		if (hashtab_map
+		    (decl->p_roles.table, role_attr_copy_callback, &state))
+			goto cleanup;
+
 		/* copy users */
 		if (hashtab_map
 		    (decl->p_users.table, user_copy_callback, &state))
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 84bcaf3f..95a2c376 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -2321,8 +2321,10 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 		if ((i == SYM_ROLES) &&
 		    ((p->policy_type == POLICY_KERN) ||
 		     (p->policy_type != POLICY_KERN &&
-		      p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB)))
-			(void)hashtab_map(p->symtab[i].table, role_attr_uncount, &buf[1]);
+			  p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB))) {
+			hashtab_map(p->symtab[i].table, role_attr_uncount, &buf[1]);
+			buf[0] -= p->symtab[i].table->nel - buf[1];
+		}
 
 		buf[1] = cpu_to_le32(buf[1]);
 		items = put_entry(buf, sizeof(uint32_t), 2, fp);
-- 
2.26.2

