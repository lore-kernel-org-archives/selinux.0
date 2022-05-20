Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E140FC433EF
	for <selinux@archiver.kernel.org>; Fri, 20 May 2022 13:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348176AbiETNQS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 May 2022 09:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbiETNQR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 May 2022 09:16:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E9036313
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:16:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j28so10715215eda.13
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lV8O79/Kc3S4qYSuPDaaYf24H33sEXpwne6dROztJo8=;
        b=S2Qz2HgcqSp6pIg9s7Q2d4q8VuaXnrbRvpN9lqzlxGzB+M9mKuw43rPOagjBdXtzW7
         AkzYh/pmHnGoeYWRpoSaCJ1PjZHZDltQEb+p8MPIHEajgIkdWee7HlcKfmjHqkLRfjgk
         G7OZGsbpHKWa+knQlOByQHENVDYdRvRrDmD7wtZNboZOjaqd/Sm4sNcheg8Vx+L+6BkZ
         D477ghW4zsD2XvLksm/ArJ3dgIdUMfyGYi3J298VCZQGep1Auh1kHIqmWGkCu8WuOvyl
         oxSvsK2pwNAuRMH1oZ4mPPqxAEaMowPHWnSe2wj/m9bx0mBJTSNcA7qzhOcfizgLJqGH
         h+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lV8O79/Kc3S4qYSuPDaaYf24H33sEXpwne6dROztJo8=;
        b=wgTZnRwVn9zcqRs91NcEFrzHJCaElOx8ziPiIi8UbE4qJh47D/jYQ0oAH07sISf8pK
         SWSVAklTNH6V6BrTXUFlLlzkCD+EEJOJE6hd8On4aSdvTnwaRo6ZpdIPdqPKmvW2Zpge
         ZiQu9K7JL5Fa2YiTkE3GVywqQzBlE/kdxe7BogQ3l06BYzkyRoyrPm7ZW8LeI/juBkEc
         O//BthMy0NA7cWFfhu2CGJMrTZexcquSO5HRy6Fn+x97WV4U5euPX6l2YPTj8KweJaq7
         3lYF8tc/JUX49XvmgzewnlBxS2Ug43lP9iiFUtWir5MKlfl9b2GqqGuMfQBAso03LZ9f
         6UUQ==
X-Gm-Message-State: AOAM530YPwMOHrgcbJwFN286QtIb97AdHgMrJBmfg4simWruHgagls4k
        /l9pOJdT2nEc9u0ZZg15HkG2ANXVNvk=
X-Google-Smtp-Source: ABdhPJxF696E/Tb01X2v7bhiFY0trdfmhyRY6IVdxDMG3ebeKzp755+S75cg1a6XL24CUGwG45Lf0A==
X-Received: by 2002:aa7:de8a:0:b0:42a:b51a:554c with SMTP id j10-20020aa7de8a000000b0042ab51a554cmr11141658edv.318.1653052574167;
        Fri, 20 May 2022 06:16:14 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-251-125.77.8.pool.telefonica.de. [77.8.251.125])
        by smtp.gmail.com with ESMTPSA id b26-20020a170906729a00b006f3ef214e0esm3193388ejl.116.2022.05.20.06.16.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 06:16:13 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: declare return value of context_str(3) const
Date:   Fri, 20 May 2022 15:16:10 +0200
Message-Id: <20220520131610.11867-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

context_str(3) returns a string representation of the given context.
This string is owned by the context and free'd on context_free(3).
Declare it const, as already done in the man page, since it must not be
free'd by the caller.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/context.h |  2 +-
 libselinux/src/context.c             |  2 +-
 libselinux/src/get_context_list.c    | 11 ++++++-----
 libselinux/src/query_user_context.c  |  2 +-
 policycoreutils/newrole/newrole.c    |  2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/libselinux/include/selinux/context.h b/libselinux/include/selinux/context.h
index 949fb1e1..82f4e690 100644
--- a/libselinux/include/selinux/context.h
+++ b/libselinux/include/selinux/context.h
@@ -25,7 +25,7 @@ extern "C" {
  * for the same context_t*
  */
 
-	extern char *context_str(context_t);
+	extern const char *context_str(context_t);
 
 /* Free the storage used by a context */
 	extern void context_free(context_t);
diff --git a/libselinux/src/context.c b/libselinux/src/context.c
index b2144c7c..9dddbc5a 100644
--- a/libselinux/src/context.c
+++ b/libselinux/src/context.c
@@ -116,7 +116,7 @@ void context_free(context_t context)
 /*
  * Return a pointer to the string value of the context.
  */
-char *context_str(context_t context)
+const char *context_str(context_t context)
 {
 	context_private_t *n = context->ptr;
 	int i;
diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index cfe38e59..d774b9cf 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -143,6 +143,7 @@ static int get_context_user(FILE * fp,
 	char *linerole, *linetype;
 	char **new_reachable = NULL;
 	char *usercon_str;
+	const char *usercon_str2;
 	context_t con;
 	context_t usercon;
 
@@ -257,20 +258,20 @@ static int get_context_user(FILE * fp,
 			rc = -1;
 			goto out;
 		}
-		usercon_str = context_str(usercon);
-		if (!usercon_str) {
+		usercon_str2 = context_str(usercon);
+		if (!usercon_str2) {
 			context_free(usercon);
 			rc = -1;
 			goto out;
 		}
 
 		/* check whether usercon is already in reachable */
-		if (is_in_reachable(*reachable, usercon_str)) {
+		if (is_in_reachable(*reachable, usercon_str2)) {
 			context_free(usercon);
 			start = end;
 			continue;
 		}
-		if (security_check_context(usercon_str) == 0) {
+		if (security_check_context(usercon_str2) == 0) {
 			new_reachable = realloc(*reachable, (*nreachable + 2) * sizeof(char *));
 			if (!new_reachable) {
 				context_free(usercon);
@@ -278,7 +279,7 @@ static int get_context_user(FILE * fp,
 				goto out;
 			}
 			*reachable = new_reachable;
-			new_reachable[*nreachable] = strdup(usercon_str);
+			new_reachable[*nreachable] = strdup(usercon_str2);
 			if (new_reachable[*nreachable] == NULL) {
 				context_free(usercon);
 				rc = -1;
diff --git a/libselinux/src/query_user_context.c b/libselinux/src/query_user_context.c
index b8125c96..29a1b360 100644
--- a/libselinux/src/query_user_context.c
+++ b/libselinux/src/query_user_context.c
@@ -115,7 +115,7 @@ int manual_user_enter_context(const char *user, char ** newcon)
 	int mls_enabled = is_selinux_mls_enabled();
 
 	context_t new_context;	/* The new context chosen by the user     */
-	char *user_context = NULL;	/* String value of the user's context     */
+	const char *user_context = NULL;	/* String value of the user's context     */
 	int done = 0;		/* true if a valid sid has been obtained  */
 
 	/* Initialize the context.  How this is done depends on whether
diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index ae37d725..c2afa37e 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -842,7 +842,7 @@ static int parse_command_line_arguments(int argc, char **argv, char *ttyn,
 	char *type_ptr = NULL;	/* stores malloc'd data from get_default_type */
 	char *level_s = NULL;	/* level spec'd by user in argv[] */
 	char *range_ptr = NULL;
-	char *new_con = NULL;
+	const char *new_con = NULL;
 	char *tty_con = NULL;
 	context_t context = NULL;	/* manipulatable form of new_context */
 	const struct option long_options[] = {
-- 
2.36.1

