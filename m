Return-Path: <SRS0=YAEg=ZP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297A4C432C0
	for <selinux@archiver.kernel.org>; Sat, 23 Nov 2019 14:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E102071B
	for <selinux@archiver.kernel.org>; Sat, 23 Nov 2019 14:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvMsHXGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKWOm4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 23 Nov 2019 09:42:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33261 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfKWOm4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 23 Nov 2019 09:42:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id t26so8520475wmi.0
        for <selinux@vger.kernel.org>; Sat, 23 Nov 2019 06:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qyYPFTEg/ipVO2rXB3mq0j3tmwzQQ/s4czxZAWFUVEo=;
        b=tvMsHXGj4hrroRkgMk7LS+ViMv0DGrb4jgJDbElz87nh/brER1R5gbQIWhB7WuZmoh
         gfENLjnBnMJApivWowYV00JNMHOlFJPRFy72//BrxzWUghHdzD5KMEnd7zZu/uGky13c
         fr/vPN/84Hne2ultsFjMB7uJZOkRZl3yex5nmTDOrLAnoD1OgLD3y/higq0S9m3CJYJN
         dl7p3pvY+EkCUOyhXK6Izr/OvW1YUcbHJOt2rXqRlbVUU/GllwC6soehlpR6Nh3okd6q
         /tZRcz0sKIilYlwoS87Chbo/MCgcVJfrjkUGkdaMHgCGeIcBMuFVWjXncYeJ71dkqUlT
         hfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyYPFTEg/ipVO2rXB3mq0j3tmwzQQ/s4czxZAWFUVEo=;
        b=YqH2LYD0K4xaZZsbZ3xFhj8ipwmdgdu1YJEwIw+NWQpmfZU6/cNT16O2mUq4fisZoQ
         n30CRyUQ7leo+Se3LB2mJFgxvi6ntFpMOr+EvJ1TzvZcbEgIpEcn8Ag68ld1SzzcqJNj
         7XOl8lfbnoVwY6H8NhXio9p9Agrt/yGbEG15t7BOvgyuspKHYAUqWq9sBBQjWeeqWkjM
         jF7hphZ7aKtqoj9/L88mNCzsW/EQh3SsDd7mh0Qb9fdDi8GbrfR8GcOS/oEJyVyTTL/9
         wvQSXdVHjqzWcm2eNH3w4jNyKi0IpAakTWk851Cuj/kzNwrMog/N0OzLDnD2HThI8rT4
         KQpg==
X-Gm-Message-State: APjAAAUp+wSAXNmM76eJ8GdvJULBYd0VZ5atE89WFywIRek+CmaYlNvg
        gSQAoaaegLcErmjBV/CDQt2vjhla
X-Google-Smtp-Source: APXvYqyXt9jkGi2tEreQ3zgfSgWAe2nmBhCs0gf5uE74rrhVM4YCJst+MvAQ337XO3tO+Jq/XvFLPQ==
X-Received: by 2002:a05:600c:2257:: with SMTP id a23mr22277157wmm.143.1574520173878;
        Sat, 23 Nov 2019 06:42:53 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id o187sm2112090wmo.20.2019.11.23.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 06:42:53 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dac.override@gmail.com>
Subject: [RFC 3/3] cil: qualify roles from symtable when resolving userprefix
Date:   Sat, 23 Nov 2019 15:42:45 +0100
Message-Id: <20191123144245.3079306-4-dac.override@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191123144245.3079306-1-dac.override@gmail.com>
References: <20191123144245.3079306-1-dac.override@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This ensures that the role in the userprefix statement is valid. Idea and implementation by Gary Tierney.

Signed-off-by: Dominick Grift <dac.override@gmail.com>
---
 libsepol/cil/src/cil.c             |  7 +++++--
 libsepol/cil/src/cil_internal.h    |  1 +
 libsepol/cil/src/cil_resolve_ast.c | 10 ++++------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index de729cf8..aa3057ad 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -1218,6 +1218,7 @@ int cil_userprefixes_to_string_nopdb(struct cil_db *db, char **out, size_t *size
 	struct cil_list_item *curr;
 	struct cil_userprefix *userprefix = NULL;
 	struct cil_user *user = NULL;
+	struct cil_role *role = NULL;
 
 	*out = NULL;
 
@@ -1230,7 +1231,8 @@ int cil_userprefixes_to_string_nopdb(struct cil_db *db, char **out, size_t *size
 	cil_list_for_each(curr, db->userprefixes) {
 		userprefix = curr->data;
 		user = userprefix->user;
-		str_len += strlen("user ") + strlen(user->datum.fqn) + strlen(" prefix ") + strlen(userprefix->prefix_str) + 2;
+		role = userprefix->role;
+		str_len += strlen("user ") + strlen(user->datum.fqn) + strlen(" prefix ") + strlen(role->datum.fqn) + 2;
 	}
 
 	*size = str_len * sizeof(char);
@@ -1241,9 +1243,10 @@ int cil_userprefixes_to_string_nopdb(struct cil_db *db, char **out, size_t *size
 	cil_list_for_each(curr, db->userprefixes) {
 		userprefix = curr->data;
 		user = userprefix->user;
+		role = userprefix->role;
 
 		buf_pos = snprintf(str_tmp, str_len, "user %s prefix %s;\n", user->datum.fqn,
-									userprefix->prefix_str);
+				   role->datum.fqn);
 		str_len -= buf_pos;
 		str_tmp += buf_pos;
 	}
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 30fab649..e52a4285 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -481,6 +481,7 @@ struct cil_userprefix {
 	char *user_str;
 	struct cil_user *user;
 	char *prefix_str;
+	struct cil_role *role;
 };
 
 struct cil_selinuxuser {
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 87575860..28f3b418 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -952,7 +952,7 @@ int cil_resolve_userprefix(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_userprefix *userprefix = current->data;
 	struct cil_symtab_datum *user_datum = NULL;
-	struct cil_tree_node *user_node = NULL;
+	struct cil_symtab_datum *role_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	rc = cil_resolve_name(current, userprefix->user_str, CIL_SYM_USERS, extra_args, &user_datum);
@@ -960,15 +960,13 @@ int cil_resolve_userprefix(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	user_node = user_datum->nodes->head->data;
-
-	if (user_node->flavor != CIL_USER) {
-		cil_log(CIL_ERR, "Userprefix must be a user: %s\n", user_datum->fqn);
-		rc = SEPOL_ERR;
+	rc = cil_resolve_name(current, userprefix->prefix_str, CIL_SYM_ROLES, extra_args, &role_datum);
+	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 
 	userprefix->user = (struct cil_user*)user_datum;
+	userprefix->role = (struct cil_role*)role_datum;
 
 exit:
 	return rc;
-- 
2.24.0

