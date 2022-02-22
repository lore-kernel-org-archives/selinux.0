Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4A5C433EF
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 13:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiBVNwS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiBVNwQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 08:52:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8884590FFD
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:51:50 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x5so36979786edd.11
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AeOBKwplGWTadx7LbtcLnRBBLdCt5vU5//tyI2TJmac=;
        b=Y4yRU4tbFUGA6d3nInL3arkjhHZJtxKUWmwrGXmRCzMobIU1PDTekYvuHqKenZEgN7
         PLN0hPmCh15mn4Ubhqq6CEirrwJ/d6VYcdEB9P272eGBROB9pt/gJoV6ENivUr0ThpP1
         M1xy1NNHghN3iht4+KyVl8k+jZDnLgoNJmxC6c5QSPadh+dV+F2t4FtpK2ezOVX5xV2f
         Dg71Ks8nVNvotKZCD6Lt9jttifAOHZY1fTzCJI0Gsk5wy34kN+xMkri9WGd/AD+dDTsQ
         N0v0XEgmnwYztplCfqFjg7KHKBHp5ykN8d7E2ce3yvIYiXqG8bZIZ7Mk0CiuAYmZwZUq
         ohJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AeOBKwplGWTadx7LbtcLnRBBLdCt5vU5//tyI2TJmac=;
        b=wKZvFNcJafL9W5tjRYS9xGvRnLepvzd1CfA23rUMRNG5xhRZTrD1JzNsd5NNgPkm2c
         xG2frHujHf6dgmxW8/ju9GPRrTp7HerS19H/cr/dTZ+GQs0GYq+W3P/9h4CkfnA+9uIl
         v9mgHLyd/EHHzpQaHom2HrHraPtySy9sHC/dstXbXsCh3HGCFOUvSTZRudo9JqqcAXhm
         4TFx843ssyImnYQ+Tb1rk0AWfh1RHR8MGe9mVrVsl1tWRaZSSBQOxEdNIpQZIoKVbkYG
         S03frBZ9INK0kGwlM+NS5IT/eTTxMZJCU+QiAIVPwI7487uCK/PVsuRPZqCpWbCcEP4N
         pkZQ==
X-Gm-Message-State: AOAM532TVXQKg9XYjiP46lV8klWCavAhpWoypcPQRspirZ3L5BjvBq3M
        UtU0/WxoBAqkCUCOZ49M9iksTFIQ6VI=
X-Google-Smtp-Source: ABdhPJyTk1vYY+75aL7eCTL9PXXZO286+5B0uC5k6u3TTbhA8DVb7fh5OeM1CmVsXon3Qdl0ClhAvw==
X-Received: by 2002:aa7:c047:0:b0:40b:488:547c with SMTP id k7-20020aa7c047000000b0040b0488547cmr26123147edo.76.1645537909090;
        Tue, 22 Feb 2022 05:51:49 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-065-014.77.3.pool.telefonica.de. [77.3.65.14])
        by smtp.gmail.com with ESMTPSA id eg42sm8266916edb.79.2022.02.22.05.51.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:51:48 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/4] newrole: ensure password memory erasure
Date:   Tue, 22 Feb 2022 14:51:43 +0100
Message-Id: <20220222135143.30602-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222135143.30602-1-cgzones@googlemail.com>
References: <20220222135143.30602-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Compiler can optimize calls to memset(3), due to the as-if rule, away if
the object is not accessed later on.  Use a wrapper using volatile
pointers to ensure the memory is guaranteed to be erased.  Also erase
the encrypted password.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 781f99b6..ae37d725 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -333,6 +333,14 @@ static int read_pam_config(void)
 
 #define PASSWORD_PROMPT _("Password:")	/* prompt for getpass() */
 
+static void memzero(void *ptr, size_t size)
+{
+	volatile unsigned char * volatile p = ptr;
+	while (size--) {
+		*p++ = '\0';
+	}
+}
+
 /* authenticate_via_shadow_passwd()
  *
  * in:     uname - the calling user's user name
@@ -351,6 +359,7 @@ static int authenticate_via_shadow_passwd(const char *uname)
 	struct spwd *p_shadow_line;
 	char *unencrypted_password_s;
 	char *encrypted_password_s;
+	int ret;
 
 	setspent();
 	p_shadow_line = getspnam(uname);
@@ -371,12 +380,15 @@ static int authenticate_via_shadow_passwd(const char *uname)
 	errno = 0;
 	encrypted_password_s = crypt(unencrypted_password_s,
 				     p_shadow_line->sp_pwdp);
-	memset(unencrypted_password_s, 0, strlen(unencrypted_password_s));
+	memzero(unencrypted_password_s, strlen(unencrypted_password_s));
 	if (errno || !encrypted_password_s) {
 		fprintf(stderr, _("Cannot encrypt password.\n"));
 		return 0;
 	}
-	return (!strcmp(encrypted_password_s, p_shadow_line->sp_pwdp));
+
+	ret = !strcmp(encrypted_password_s, p_shadow_line->sp_pwdp);
+	memzero(encrypted_password_s, strlen(encrypted_password_s));
+	return ret;
 }
 #endif				/* if/else USE_PAM */
 
-- 
2.35.1

