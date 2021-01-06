Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD004C433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82987205F4
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbhAFNgK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbhAFNgK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 08:36:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D124BC06134C
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 05:35:29 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qw4so4960381ejb.12
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 05:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3D2C3u8BMyJb9GOZ9/Gdatg+ayFEgr6HmerDrsFyoJc=;
        b=cwqodgdkWceU8h9eiMiQKcH0RREH3vx7djtsvwU214UuiX+GeTLnsg640Wf9uso6VJ
         D3pmJhnD0+DQx3nEPe6YtBb7t+oGJelJlq9UOsw7QnRi3eJ8YJvwfY6pVh5/llvvC4KK
         b/ROqkCPAmvJlxAXhBHPnlQUO7DCh+OrVIX3ziNVRbOjyFlwdurNG5A6adnSObHdogUv
         ma08gOvt/2rpb7oLyn6htSZNLpbbgo4EFaUruVVkUJePqmDm/8nlxBuhneryP+i0e9AY
         oROpXlMaS6fZUoRmqm51H6RRhNyT0QsoDJtzITqHk9RIXFEE+pQ/CSGm15/XEV9aHqi1
         NGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3D2C3u8BMyJb9GOZ9/Gdatg+ayFEgr6HmerDrsFyoJc=;
        b=J78UchBq+VIC7zbh/RrL0qZDPVKmWUogPElAQc03iad+vedQvHt/ayhYJLzxgHMfH9
         Y6s1XpXrAqPbrlwvAglKwh855pEWdeb3fXlW9swlFRzrERVTyMbav1DsCPCIp3I02Hxg
         sAkwljwGIRUw8TQGoZOwnMUDX7bNZlMGbCTY/NZDh2jDVGt4wwV5bk8iQMf6esBHqjjj
         HyAyvwl9SSn9X1TVcYZBJj7rR+Do+9NJ++JK6GdyuBCZhtxq5mkXPS31QsgBeQ4t3Hlw
         0jPEb46oeYMqoglfQayMQm3iD2GkKpKk1DmED9DpjHXqNnIBTeaKXAsqhySo17kcrvHg
         OX8A==
X-Gm-Message-State: AOAM5321vRj5VbRPpUXxDM9IoJ5jMvEqdoM/+eBN6kJXJAlgB3t4FX2K
        81NQzJcoiwSbDf/hpkbsQP4JZZUfmaMTpQ==
X-Google-Smtp-Source: ABdhPJypHx3J0UfSYOKmAnHxKk/H+id6+mzM6n8+6m5XZ5CltSBQ16CHVPfMxcGCqC5dpFrEcNquQw==
X-Received: by 2002:a17:906:40c1:: with SMTP id a1mr2836944ejk.520.1609940128631;
        Wed, 06 Jan 2021 05:35:28 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-033-127.77.8.pool.telefonica.de. [77.8.33.127])
        by smtp.gmail.com with ESMTPSA id i4sm1266100eje.90.2021.01.06.05.35.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:35:28 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] newrole: preserve environment variable XDG_RUNTIME_DIR
Date:   Wed,  6 Jan 2021 14:34:49 +0100
Message-Id: <20210106133449.193940-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

XDG_RUNTIME_DIR is required for systemctl --user to work.
See https://github.com/systemd/systemd/issues/15231

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 36e2ba9c..500969e0 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -466,7 +466,7 @@ static int extract_pw_data(struct passwd *pw_copy)
  * Either restore the original environment, or set up a minimal one.
  *
  * The minimal environment contains:
- * TERM, DISPLAY and XAUTHORITY - if they are set, preserve values
+ * TERM, DISPLAY, XAUTHORITY and XDG_RUNTIME_DIR - if they are set, preserve values
  * HOME, SHELL, USER and LOGNAME - set to contents of /etc/passwd
  * PATH - set to default value DEFAULT_PATH
  *
@@ -478,9 +478,11 @@ static int restore_environment(int preserve_environment,
 	char const *term_env;
 	char const *display_env;
 	char const *xauthority_env;
-	char *term = NULL;	/* temporary container */
-	char *display = NULL;	/* temporary container */
+	char const *xdg_runtime_dir_env;
+	char *term = NULL;		/* temporary container */
+	char *display = NULL;		/* temporary container */
 	char *xauthority = NULL;	/* temporary container */
+	char *xdg_runtime_dir = NULL;	/* temporary container */
 	int rc;
 
 	environ = old_environ;
@@ -491,6 +493,7 @@ static int restore_environment(int preserve_environment,
 	term_env = getenv("TERM");
 	display_env = getenv("DISPLAY");
 	xauthority_env = getenv("XAUTHORITY");
+	xdg_runtime_dir_env = getenv("XDG_RUNTIME_DIR");	/* needed for `systemd --user` operations */
 
 	/* Save the variable values we want */
 	if (term_env)
@@ -499,8 +502,12 @@ static int restore_environment(int preserve_environment,
 		display = strdup(display_env);
 	if (xauthority_env)
 		xauthority = strdup(xauthority_env);
-	if ((term_env && !term) || (display_env && !display) ||
-	    (xauthority_env && !xauthority)) {
+	if (xdg_runtime_dir_env)
+		xdg_runtime_dir = strdup(xdg_runtime_dir_env);
+	if ((term_env && !term) ||
+	    (display_env && !display) ||
+	    (xauthority_env && !xauthority) ||
+	    (xdg_runtime_dir_env && !xdg_runtime_dir)) {
 		rc = -1;
 		goto out;
 	}
@@ -518,6 +525,8 @@ static int restore_environment(int preserve_environment,
 		rc |= setenv("DISPLAY", display, 1);
 	if (xauthority)
 		rc |= setenv("XAUTHORITY", xauthority, 1);
+	if (xdg_runtime_dir)
+		rc |= setenv("XDG_RUNTIME_DIR", xdg_runtime_dir, 1);
 	rc |= setenv("HOME", pw->pw_dir, 1);
 	rc |= setenv("SHELL", pw->pw_shell, 1);
 	rc |= setenv("USER", pw->pw_name, 1);
@@ -527,6 +536,7 @@ static int restore_environment(int preserve_environment,
 	free(term);
 	free(display);
 	free(xauthority);
+	free(xdg_runtime_dir);
 	return rc;
 }
 
-- 
2.30.0

