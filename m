Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CF0C77B7F
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 10:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbjELKXl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 06:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbjELKXj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 06:23:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F295810E49
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96ab81aa68dso42465466b.3
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683887010; x=1686479010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVU8k4HYuv/EE7iiYZ5Uk1I4ExtS/sXPDlX59CJgtAI=;
        b=nJo/xJH13mdsHxbiLlzvJxrevFHWBLtfKKhC34zqt1NDREWeH1SpQI7aYJogEVERR5
         SeX8aRx2q0uVGTkge/hQRUbO0khuQlx/YBxwL43rjTiblfbfUTC3+aNGvNaShw2AgJSc
         7JTBH7ENPtMEgLev5Mit0yVOsDiYVQL2cI3fBxgWATWe+lX37uj2k854kP7zbeh/h0YR
         g7SgQl20+qIaTWGnnc6IzhDM97jF4lFQ/fLSogt4ZuQ0pnEu5YaDf5umSM/JBd3kRCyJ
         rMw5mKfHrdCm+BfL8x9AGdL5YKXWdyGEJVEQt1KQn883ijMzRAI0Bt65OpizRarFZ6qd
         0ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887010; x=1686479010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVU8k4HYuv/EE7iiYZ5Uk1I4ExtS/sXPDlX59CJgtAI=;
        b=fCKxNPwGoQZowj2otBianJ+XpqNAHo0B/0k9YVUQ0GqSi5lAGZVxGMA9GMBw4g51lU
         +6meFOoWemET4Lyal7xbeR/J934OFTA+abPeWSSNHL1ZLd46F+83uNESnQzmUYzsQmO0
         MBventDaV+EDIepjvIe5KEM34CT3qmKee5mJVNmja0QWxrUwYLPsHx7rwxJh3LobWaq3
         vu7ZhoO4ii9wxDsHpj0VJAHI8HZ6S9XHOy8LfPo4bPZSprlcI0OUiibQSD8do5XEeMq2
         7nobzdQ2vuR8zlsaVdK7KvS32LtzFp7BcF+6qbz1DINAcU5h2W4e1EAbBNCFV184bMKB
         QyEg==
X-Gm-Message-State: AC+VfDzLTD8r7HmPXJDRAr/ggxXKa3fYMKN1JwCPM2CGKL86pwILrcVr
        sZv0RRo59GA1rcSV1H24mCJ+mnHTTcdOGw==
X-Google-Smtp-Source: ACHHUZ5YlKuPPuHUC+0tMklm2QGKFMKI1GZyfAnwxZcIaa17vzlQA8QL9ESSLAKBqhvC/vrXKPgF0g==
X-Received: by 2002:a17:907:a0c:b0:966:2123:e0ca with SMTP id bb12-20020a1709070a0c00b009662123e0camr18231856ejc.34.1683887010265;
        Fri, 12 May 2023 03:23:30 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id gz4-20020a170907a04400b009571293d6acsm5202920ejc.59.2023.05.12.03.23.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:23:29 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 5/9] libselinux: explicitly ignore return values
Date:   Fri, 12 May 2023 12:23:18 +0200
Message-Id: <20230512102322.72235-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512102322.72235-1-cgzones@googlemail.com>
References: <20230512102322.72235-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Tell GCC, see [1], to actually no issue warnings about explicitly
ignored return values.

Also explicitly ignored return values in cleanup handlers.

    togglesebool.c: In function ‘rollback’:
    togglesebool.c:18:17: error: ignoring return value of ‘security_set_boolean’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
       18 |                 security_set_boolean(argv[i],
          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       19 |                                      security_get_boolean_active(argv[i]));
          |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    load_policy.c: In function ‘selinux_init_load_policy’:
    load_policy.c:329:17: error: ‘security_disable’ is deprecated: SELinux runtime disable is deprecated [-Werror=deprecated-declarations]
      329 |                 rc = security_disable();
          |                 ^~

    booleans.c: In function ‘rollback’:
    booleans.c:332:17: error: ignoring return value of ‘security_set_boolean’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
      332 |                 security_set_boolean(boollist[i].name,
          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      333 |                                      security_get_boolean_active(boollist[i].
          |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      334 |                                                                  name));
          |                                                                  ~~~~~~

    checkAccess.c: In function ‘selinux_check_access’:
    checkAccess.c:42:16: error: ignoring return value of ‘selinux_status_updated’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
       42 |         (void) selinux_status_updated();
          |                ^~~~~~~~~~~~~~~~~~~~~~~~

    avc.c: In function ‘avc_has_perm_noaudit’:
    avc.c:761:24: error: ignoring return value of ‘selinux_status_updated’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
      761 |                 (void) selinux_status_updated();
          |                        ^~~~~~~~~~~~~~~~~~~~~~~~

[1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc.c            | 2 +-
 libselinux/src/booleans.c       | 2 +-
 libselinux/src/checkAccess.c    | 2 +-
 libselinux/src/load_policy.c    | 2 +-
 libselinux/utils/togglesebool.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 634badf9..2cb6366f 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -757,7 +757,7 @@ int avc_has_perm_noaudit(security_id_t ssid,
 		avd_init(avd);
 
 	if (!avc_using_threads && !avc_app_main_loop) {
-		(void) selinux_status_updated();
+		(void)! selinux_status_updated();
 	}
 
 	if (!aeref) {
diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index e34b39ff..30733564 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -327,7 +327,7 @@ static void rollback(SELboolean * boollist, int end)
 	int i;
 
 	for (i = 0; i < end; i++)
-		security_set_boolean(boollist[i].name,
+		(void)! security_set_boolean(boollist[i].name,
 				     security_get_boolean_active(boollist[i].
 								 name));
 }
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 022cd6b5..1df0c8ad 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -39,7 +39,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
 	if (rc < 0)
 		return rc;
 
-	(void) selinux_status_updated();
+	(void)! selinux_status_updated();
 
        sclass = string_to_security_class(class);
        if (sclass == 0) {
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 17918e8b..c3ac18e2 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -238,7 +238,7 @@ int selinux_init_load_policy(int *enforce)
 	 * Get desired mode (disabled, permissive, enforcing) from 
 	 * /etc/selinux/config. 
 	 */
-	selinux_getenforcemode(&seconfig);
+	(void)! selinux_getenforcemode(&seconfig);
 
 	/* Check for an override of the mode via the kernel command line. */
 	rc = mount("proc", "/proc", "proc", 0, 0);
diff --git a/libselinux/utils/togglesebool.c b/libselinux/utils/togglesebool.c
index 4a7c830e..d8cee287 100644
--- a/libselinux/utils/togglesebool.c
+++ b/libselinux/utils/togglesebool.c
@@ -15,7 +15,7 @@ static __attribute__ ((__noreturn__)) void rollback(int argc, char **argv)
 	int i;
 
 	for (i = 1; i < argc; i++)
-		security_set_boolean(argv[i],
+		(void)! security_set_boolean(argv[i],
 				     security_get_boolean_active(argv[i]));
 	exit(1);
 }
-- 
2.40.1

