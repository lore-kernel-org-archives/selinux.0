Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD65C433DB
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 16:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7A423884
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbhAHQCS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Jan 2021 11:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbhAHQCR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Jan 2021 11:02:17 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A963BC06129C
        for <selinux@vger.kernel.org>; Fri,  8 Jan 2021 08:00:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lt17so15203968ejb.3
        for <selinux@vger.kernel.org>; Fri, 08 Jan 2021 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0dlHlvKve3+VATWKa4c5mKTOHPfeNXWKJcTF2Y90mw=;
        b=CKzNRqF+NdJxaL1VpzK1UuXS8l1B3ujVQyaLTnuCYknIkjPXQTKNhUghA5UFCyuOxD
         N2U7dvlg70YyjLk1LJ7mMTmq/C9dNkIvMrLXlMOlhbqsvnbAHOTRBC0Y+Qljr57XgUkM
         WyT61K6W/kc8uPmwDNq/hCVas2Z+SHIz1ZW8sageBIbkn+8YwjdINghHnMRzlRL6xjKI
         B/6B1gHEsCjLeiYADsejkw/gllkLXqCgVxnF9sriMXHXWgI/hqZFCsQQtF1kpwIKiRcF
         F1m0KrOTaPYopP5MN1r1GZSTh2SpbKA2Rz5xdTRu6ys2A20yfDikMM0ijtlRVL6ckHLg
         IIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0dlHlvKve3+VATWKa4c5mKTOHPfeNXWKJcTF2Y90mw=;
        b=YoTxcqhLxP0N1c0YaUzcDQMtqJNHyXOO88L8+0iJRNET07hQa4Zr5lE80wvsfW1ko9
         cK33PjbEyLSEA7/M7ICUeivvZJcY/4JCCcsu19UvN6i0ZH0e+r9PiYZXR1IwYb42HSjX
         cpDi/kAmhaSNrXpcl6XCz2LYYf61GofyPykRImy3e4pF2EVhAppP+vFaLMBJX6vmqbsH
         O8FA/M9PKWqV3lepOUGqDdt/IJCvGvb9/LPwvZ0ZKxlk+p+PJ+PWMvGWCANB4QuaEOov
         4VoXneeDq3RQIEofr7UW61ets2E26ygLgNhPTzAtf6fd49llyq2Y0oJUbKtz1ErM2aUo
         D9XQ==
X-Gm-Message-State: AOAM533IABql9v3Q5VSGaE98IW29QLYSOi9No5D6ogSR21a6WUONzvSc
        H0hS65zSpxJMG73we9eJ1FCE6nq+GSI=
X-Google-Smtp-Source: ABdhPJyxq3XnlJ4a25yNO1Wa7Bpc8gUiH4VgekkRHAvGIaWMOe6YcCe6qXrUqO7Y409tnxX1uQYoGQ==
X-Received: by 2002:a17:906:c254:: with SMTP id bl20mr3042561ejb.336.1610121655357;
        Fri, 08 Jan 2021 08:00:55 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-252-188.77.0.pool.telefonica.de. [77.0.252.188])
        by smtp.gmail.com with ESMTPSA id rk12sm3650687ejb.75.2021.01.08.08.00.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 08:00:54 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libselinux: accept const fromcon in get_context API
Date:   Fri,  8 Jan 2021 17:00:47 +0100
Message-Id: <20210108160048.67386-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Rework the APIs in <selinux/get_context_list.h> to take a constant
string as from context.

The passed string is not modified currently but not declared const,
which is restricting callers (who care about const-correctness).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/get_context_list.h | 12 ++---
 .../man/man3/get_ordered_context_list.3       | 12 ++---
 libselinux/src/get_context_list.c             | 49 +++++++++----------
 3 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/libselinux/include/selinux/get_context_list.h b/libselinux/include/selinux/get_context_list.h
index db8641a4..6b2f14f3 100644
--- a/libselinux/include/selinux/get_context_list.h
+++ b/libselinux/include/selinux/get_context_list.h
@@ -17,14 +17,14 @@ extern "C" {
    If 'fromcon' is NULL, defaults to current context.
    Caller must free via freeconary. */
 	extern int get_ordered_context_list(const char *user,
-					    char * fromcon,
+					    const char *fromcon,
 					    char *** list);
 
 /* As above, but use the provided MLS level rather than the
    default level for the user. */
 	extern int get_ordered_context_list_with_level(const char *user,
 						       const char *level,
-						       char * fromcon,
+						       const char *fromcon,
 						       char *** list);
 
 /* Get the default security context for a user session for 'user'
@@ -35,14 +35,14 @@ extern "C" {
    Returns 0 on success or -1 otherwise.
    Caller must free via freecon. */
 	extern int get_default_context(const char *user,
-				       char * fromcon,
+				       const char *fromcon,
 				       char ** newcon);
 
 /* As above, but use the provided MLS level rather than the
    default level for the user. */
 	extern int get_default_context_with_level(const char *user,
 						  const char *level,
-						  char * fromcon,
+						  const char *fromcon,
 						  char ** newcon);
 
 /* Same as get_default_context, but only return a context
@@ -50,7 +50,7 @@ extern "C" {
    for the user with that role, then return -1. */
 	extern int get_default_context_with_role(const char *user,
 						 const char *role,
-						 char * fromcon,
+						 const char *fromcon,
 						 char ** newcon);
 
 /* Same as get_default_context, but only return a context
@@ -59,7 +59,7 @@ extern "C" {
 	extern int get_default_context_with_rolelevel(const char *user,
 						      const char *role,
 						      const char *level,
-						      char * fromcon,
+						      const char *fromcon,
 						      char ** newcon);
 
 /* Given a list of authorized security contexts for the user, 
diff --git a/libselinux/man/man3/get_ordered_context_list.3 b/libselinux/man/man3/get_ordered_context_list.3
index 3ed14a96..2a1e08f0 100644
--- a/libselinux/man/man3/get_ordered_context_list.3
+++ b/libselinux/man/man3/get_ordered_context_list.3
@@ -7,17 +7,17 @@ get_ordered_context_list, get_ordered_context_list_with_level, get_default_conte
 .br
 .B #include <selinux/get_context_list.h>
 .sp
-.BI "int get_ordered_context_list(const char *" user ", char *" fromcon ", char ***" list );
+.BI "int get_ordered_context_list(const char *" user ", const char *" fromcon ", char ***" list );
 .sp
-.BI "int get_ordered_context_list_with_level(const char *" user ", const char *" level ", char *" fromcon ", char ***" list );
+.BI "int get_ordered_context_list_with_level(const char *" user ", const char *" level ", const char *" fromcon ", char ***" list );
 .sp
-.BI "int get_default_context(const char *" user ", char *" fromcon ", char **" newcon );
+.BI "int get_default_context(const char *" user ", const char *" fromcon ", char **" newcon );
 .sp
-.BI "int get_default_context_with_level(const char *" user ", const char *" level ", char *" fromcon ", char **" newcon );
+.BI "int get_default_context_with_level(const char *" user ", const char *" level ", const char *" fromcon ", char **" newcon );
 .sp
-.BI "int get_default_context_with_role(const char *" user ", const char *" role ", char *" fromcon ", char **" newcon ");
+.BI "int get_default_context_with_role(const char *" user ", const char *" role ", const char *" fromcon ", char **" newcon ");
 .sp
-.BI "int get_default_context_with_rolelevel(const char *" user ", const char *" role ", const char *" level ", char *" fromcon ", char **" newcon ");
+.BI "int get_default_context_with_rolelevel(const char *" user ", const char *" role ", const char *" level ", const char *" fromcon ", char **" newcon ");
 .sp
 .BI "int query_user_context(char **" list ", char **" newcon );
 .sp
diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index b43652ff..cfe38e59 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -13,7 +13,7 @@
 
 int get_default_context_with_role(const char *user,
 				  const char *role,
-				  char * fromcon,
+				  const char *fromcon,
 				  char ** newcon)
 {
 	char **conary;
@@ -56,23 +56,24 @@ int get_default_context_with_role(const char *user,
 int get_default_context_with_rolelevel(const char *user,
 				       const char *role,
 				       const char *level,
-				       char * fromcon,
+				       const char *fromcon,
 				       char ** newcon)
 {
 
-	int rc = 0;
-	int freefrom = 0;
+	int rc;
+	char *backup_fromcon = NULL;
 	context_t con;
-	char *newfromcon;
+	const char *newfromcon;
+
 	if (!level)
 		return get_default_context_with_role(user, role, fromcon,
 						     newcon);
 
 	if (!fromcon) {
-		rc = getcon(&fromcon);
+		rc = getcon(&backup_fromcon);
 		if (rc < 0)
 			return rc;
-		freefrom = 1;
+		fromcon = backup_fromcon;
 	}
 
 	rc = -1;
@@ -91,14 +92,13 @@ int get_default_context_with_rolelevel(const char *user,
 
       out:
 	context_free(con);
-	if (freefrom)
-		freecon(fromcon);
+	freecon(backup_fromcon);
 	return rc;
 
 }
 
 int get_default_context(const char *user,
-			char * fromcon, char ** newcon)
+			const char *fromcon, char ** newcon)
 {
 	char **conary;
 	int rc;
@@ -128,7 +128,7 @@ static int is_in_reachable(char **reachable, const char *usercon_str)
 }
 
 static int get_context_user(FILE * fp,
-			     char * fromcon,
+			     const char * fromcon,
 			     const char * user,
 			     char ***reachable,
 			     unsigned int *nreachable)
@@ -345,22 +345,22 @@ static int get_failsafe_context(const char *user, char ** newcon)
 
 int get_ordered_context_list_with_level(const char *user,
 					const char *level,
-					char * fromcon,
+					const char *fromcon,
 					char *** list)
 {
 	int rc;
-	int freefrom = 0;
+	char *backup_fromcon = NULL;
 	context_t con;
-	char *newfromcon;
+	const char *newfromcon;
 
 	if (!level)
 		return get_ordered_context_list(user, fromcon, list);
 
 	if (!fromcon) {
-		rc = getcon(&fromcon);
+		rc = getcon(&backup_fromcon);
 		if (rc < 0)
 			return rc;
-		freefrom = 1;
+		fromcon = backup_fromcon;
 	}
 
 	rc = -1;
@@ -379,15 +379,14 @@ int get_ordered_context_list_with_level(const char *user,
 
       out:
 	context_free(con);
-	if (freefrom)
-		freecon(fromcon);
+	freecon(backup_fromcon);
 	return rc;
 }
 
 
 int get_default_context_with_level(const char *user,
 				   const char *level,
-				   char * fromcon,
+				   const char *fromcon,
 				   char ** newcon)
 {
 	char **conary;
@@ -405,12 +404,13 @@ int get_default_context_with_level(const char *user,
 }
 
 int get_ordered_context_list(const char *user,
-			     char * fromcon,
+			     const char *fromcon,
 			     char *** list)
 {
 	char **reachable = NULL;
 	int rc = 0;
-	unsigned nreachable = 0, freefrom = 0;
+	unsigned nreachable = 0;
+	char *backup_fromcon = NULL;
 	FILE *fp;
 	char *fname = NULL;
 	size_t fname_len;
@@ -418,10 +418,10 @@ int get_ordered_context_list(const char *user,
 
 	if (!fromcon) {
 		/* Get the current context and use it for the starting context */
-		rc = getcon(&fromcon);
+		rc = getcon(&backup_fromcon);
 		if (rc < 0)
 			return rc;
-		freefrom = 1;
+		fromcon = backup_fromcon;
 	}
 
 	/* Determine the ordering to apply from the optional per-user config
@@ -469,8 +469,7 @@ int get_ordered_context_list(const char *user,
 	else
 		freeconary(reachable);
 
-	if (freefrom)
-		freecon(fromcon);
+	freecon(backup_fromcon);
 
 	return rc;
 
-- 
2.30.0

