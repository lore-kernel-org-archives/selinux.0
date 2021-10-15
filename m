Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C86C433EF
	for <selinux@archiver.kernel.org>; Fri, 15 Oct 2021 12:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABB36108E
	for <selinux@archiver.kernel.org>; Fri, 15 Oct 2021 12:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhJOMdn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhJOMdl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Oct 2021 08:33:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1F6C061570
        for <selinux@vger.kernel.org>; Fri, 15 Oct 2021 05:31:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z20so37633963edc.13
        for <selinux@vger.kernel.org>; Fri, 15 Oct 2021 05:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyApQozSX200HwnAI8pkJ1bhLO4qI2vHbgZYhs0AGnA=;
        b=UpwMNTHC4UFbx/APNlXycY5N9Yl3ct9vgImWT53zqVOpnN0oUXKvVuSmLq2KXbeQLy
         6dq/kDGf01gE5ANFXaWk8DsCvYtxLUa0Nz6phdJVazYZmNEsS+YSqRhraUCbV//+9zex
         Jq3s/81oWEMkqlWBfdbD309W+Ykehag7NtfQM5MS/KfRoy15oMNtBI8L9+zcVUveHr1s
         WazNdpZ0ExwiHiACNwMF+zm1h1VUVJIbgBSOUgSDZPsVHFKBAkqx3Pk9x5yWq93ZeRWN
         Vs2Sezg88J6+wyOKCSQfV+N0PhKlsSRrBxQUFxU2c4er6QrWnwSXeWK6LQKUEZerLdYx
         yvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyApQozSX200HwnAI8pkJ1bhLO4qI2vHbgZYhs0AGnA=;
        b=ri8Ft6+uWTeGWCvgducgcyWG8RtYpvDK7OsOK8mMGcYj4Nv0ZPnGFwvTZ9YsRrLbsv
         IewOomTJ+0vZXFo7UBlneUvPsgFxwHpBOtg8lJCMXWcyqWVo1qxwm2/wzsAuIBt2oxVA
         LpPj7nvj9UOgbngljZPVKGiu8Hirh+OF2EjAyEmBnKfB5QIkZIE/CVQk0lVZYNN2hwdE
         uYZeWcNHQLa2ruxWM+eNi/I0/TGO7wxUcvRlEJEpN0bB2vpiUpTlxXmbe9FsOQlVVSyZ
         qaTKgii0ZDQZt62nudC8yB3d7gLsImpgvDPbc5YhyUftDPW6Vtx3pfUQDXJQLYt9TmCe
         u9GQ==
X-Gm-Message-State: AOAM533G3pjTL7RO2x7uhh7zQHkiMbrgXBAPgM4o4gz+iAjTbT8CA8co
        ojgVfmJAEfrB1Hygawd8zXgY9+b4re0=
X-Google-Smtp-Source: ABdhPJw+ceVOVF/lvS2VXIbCMowED/n8IM+6/Xq1g9VDPqKmXrCBxicuA45Ld8JlfwGghFMN/mHFRA==
X-Received: by 2002:a17:906:9241:: with SMTP id c1mr6503963ejx.125.1634301093610;
        Fri, 15 Oct 2021 05:31:33 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-236-205.77.3.pool.telefonica.de. [77.3.236.205])
        by smtp.gmail.com with ESMTPSA id s3sm4180378ejm.49.2021.10.15.05.31.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:31:33 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: use dummy variable to silence glibc 2.34 warnings
Date:   Fri, 15 Oct 2021 14:31:00 +0200
Message-Id: <20211015123100.15785-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Glibc 2.34 added an access function attribute to pthread_setspecific(3).
This leads to the following GCC warnings:

    In file included from matchpathcon.c:5:
    matchpathcon.c: In function ‘matchpathcon_init_prefix’:
    selinux_internal.h:38:25: error: ‘pthread_setspecific’ expecting 1 byte in a region of size 0 [-Werror=stringop-overread]
       38 |                         pthread_setspecific(KEY, VALUE);        \
          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    matchpathcon.c:359:9: note: in expansion of macro ‘__selinux_setspecific’
      359 |         __selinux_setspecific(destructor_key, (void *)1);
          |         ^~~~~~~~~~~~~~~~~~~~~
    In file included from selinux_internal.h:2,
                     from matchpathcon.c:5:
    /usr/include/pthread.h:1167:12: note: in a call to function ‘pthread_setspecific’ declared with attribute ‘access (none, 2)’
     1167 | extern int pthread_setspecific (pthread_key_t __key,
          |            ^~~~~~~~~~~~~~~~~~~

The actual value and the validity of the passed pointer is irrelevant,
since it does not gets accessed internally by glibc and
pthread_getspecific(3) is not used.
Use a pointer to a (temporary) valid object to please GCC.

Closes: https://github.com/SELinuxProject/selinux/issues/311
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/matchpathcon.c   | 4 +++-
 libselinux/src/procattr.c       | 4 +++-
 libselinux/src/setrans_client.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 1e7f8890..b0ec1e8b 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -352,11 +352,13 @@ static void matchpathcon_init_once(void)
 
 int matchpathcon_init_prefix(const char *path, const char *subset)
 {
+	int dummy;
+
 	if (!mycanoncon)
 		mycanoncon = default_canoncon;
 
 	__selinux_once(once, matchpathcon_init_once);
-	__selinux_setspecific(destructor_key, (void *)1);
+	__selinux_setspecific(destructor_key, &dummy);
 
 	options[SELABEL_OPT_SUBSET].type = SELABEL_OPT_SUBSET;
 	options[SELABEL_OPT_SUBSET].value = subset;
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 6552ee01..24cee323 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -68,7 +68,9 @@ void  __attribute__((destructor)) procattr_destructor(void)
 static inline void init_thread_destructor(void)
 {
 	if (destructor_initialized == 0) {
-		__selinux_setspecific(destructor_key, (void *)1);
+		int dummy;
+
+		__selinux_setspecific(destructor_key, &dummy);
 		destructor_initialized = 1;
 	}
 }
diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index 52a8ba78..515d2d4d 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -272,7 +272,9 @@ static inline void init_thread_destructor(void)
 	if (!has_setrans)
 		return;
 	if (destructor_initialized == 0) {
-		__selinux_setspecific(destructor_key, (void *)1);
+		int dummy;
+
+		__selinux_setspecific(destructor_key, &dummy);
 		destructor_initialized = 1;
 	}
 }
-- 
2.33.0

