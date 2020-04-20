Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F9DC3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C8720775
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCPb1ezw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgDTPqU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgDTPqT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:46:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26150C061A0F
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a32so13530pje.5
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LOHtashYMoC2LM7s1Gr3sElALlN26IIpG8KhKdYwP18=;
        b=KCPb1ezwho92TYVXYl4I4KoOL+U/e+ttuvk/WqBVt6eX4QUl4eOoeocPSmlBwD+m9H
         31xDUg6RdybGQXmRg+mCwXXG0SvEOwgJfVfM5rnz8PVHn1u43iufw+aNJplmLc7VyuO5
         txSLDtPbCi6j21wH17x8f9V+8d6ZAi4XzZ2tPAUVRcNZjyiOq5cy9rsMZpdXymnyzidR
         Jp8KjwXAeUKowUxO/xp+tLCSSsAP9iOa5U+ROL+8uDRZtl5LttQfitwB3eoprow7SsiN
         Js2hcDQ0UdZgMCMDoKl2QqaIyvIKpM64Cc6zlSP9onTeOtSBbzQYI1q5DZm3Si4gvbhu
         c7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LOHtashYMoC2LM7s1Gr3sElALlN26IIpG8KhKdYwP18=;
        b=IqATqLvgpuft38Jf7BhvsOp0O4Eg2uKs9bflRB9zFONYI7pwjKlrEa106Ph+WqTIzf
         Q+cTrKe7XxNl/4DcYp1YwuFbZmuqH1i2sWRcMfN7488vzGkBuIzgJdMRK7/M57alFNse
         ZJ/TPIeXxMQt8DVjXNXyqc1ERB6cDcbzKnpTvlNSNuPduOVMCql4csbYJKKBSouNb94g
         2j+GGdtLleQhnq05sVkst3jlNLC9ezY/qyQpB3DB430c392cMepSqjYeIb2vd27fhO+g
         b8wI86/V0f1jTM6Nz6cbJytrejRvmedH9wz/lMSZMrNP0mG1DKKxcNyNGe1n4885XXv1
         1WHA==
X-Gm-Message-State: AGi0Pua8oWmzsu3iruplo8AtzoXWl57x7C5/0Raz/eWh1AiSZwkwj/6c
        k5PeyQktHPSM7ZcoTuVdqow=
X-Google-Smtp-Source: APiQypJqcK9tpzMhMK3yN7ibogYQ5aQq0QV4Qq8LT6cCk2ryY6dM+BduJrqCSBCHBE6MkO7LZHBAtw==
X-Received: by 2002:a17:902:9048:: with SMTP id w8mr16945214plz.24.1587397578618;
        Mon, 20 Apr 2020 08:46:18 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:46:18 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 16/19] selinux_check_passwd_access: annotate deprecated
Date:   Mon, 20 Apr 2020 10:45:34 -0500
Message-Id: <20200420154537.30879-17-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Update the one internal tree caller in the same file to
call selinux_check_passwd_access2.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 7 ++++++-
 libselinux/src/checkAccess.c         | 7 +++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 5633cf40607d..aaf28ffdf9be 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -630,7 +630,12 @@ extern int selinux_check_access(const char * scon, const char * tcon, const char
 
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
-extern int selinux_check_passwd_access(access_vector_t requested);
+extern int selinux_check_passwd_access(access_vector_t requested)
+#ifdef __GNUC__
+  __attribute__ ((deprecated("Use selinux_check_access")))
+#endif
+;
+
 extern int checkPasswdAccess(access_vector_t requested)
 #ifdef __GNUC__
    __attribute__ ((deprecated("Use selinux_check_access")))
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 677e2ecd7df4..555d7ff3cca5 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -64,7 +64,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
        return avc_has_perm (scon_id, tcon_id, sclass, av, NULL, aux);
 }
 
-int selinux_check_passwd_access(access_vector_t requested)
+static int selinux_check_passwd_access2(access_vector_t requested)
 {
 	int status = -1;
 	char *user_context;
@@ -99,8 +99,11 @@ int selinux_check_passwd_access(access_vector_t requested)
 	return status;
 }
 
+int selinux_check_passwd_access(access_vector_t requested) {
+	return selinux_check_passwd_access2(requested);
+}
 
 int checkPasswdAccess(access_vector_t requested)
 {
-	return selinux_check_passwd_access(requested);
+	return selinux_check_passwd_access2(requested);
 }
-- 
2.17.1

