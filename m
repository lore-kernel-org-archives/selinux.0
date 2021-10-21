Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ED9C433F5
	for <selinux@archiver.kernel.org>; Thu, 21 Oct 2021 14:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F716120F
	for <selinux@archiver.kernel.org>; Thu, 21 Oct 2021 14:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJUOIO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhJUOIM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Oct 2021 10:08:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6324BC0613B9
        for <selinux@vger.kernel.org>; Thu, 21 Oct 2021 07:05:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y12so1078577eda.4
        for <selinux@vger.kernel.org>; Thu, 21 Oct 2021 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X4GxyqEe7hwaJvw4Q4V9r8F2uKb7mFHmuZE0/SvZO+I=;
        b=MyuktRCWieUZFQZBLKwc/Qn6S75Sm4rSIVBJujD8Z7RPT3YvsgqTmcmZiSbIaZWXjS
         wZX92C7CBvbQ+p9FZund9ZA9wGsfh2S6mvWSyogwf+oA5085gUzgsn0JMTLtjI6nfcXK
         yuXNsqROoxfNOGFemCnbIgdR+s+xr0wG6V7NDkTUs2el4h7zjQhXffXJ2QBM4axZORxC
         YpXFI5XIqV/GzWLLVTSBGJ1lqBcpp7HC77hI2l2DZ9QwR8YPuytwjBD7nZ9nA1JMpeq+
         H51pVrCJjR7aw//RuWJHnYxcbcOh82eICEBg5sZ5bzqs2KFSIPckcp/Szgl9LqPrfrEE
         yUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4GxyqEe7hwaJvw4Q4V9r8F2uKb7mFHmuZE0/SvZO+I=;
        b=3oiJoW1j8i4vu/9RiQvo28or7lZFSyV8olmPOu3VW/pO+ctG4vaLVdwHEPqH9m99XY
         KI6xzM0SaHB/9/uTC5rtKbQVrk1YVmUd2/R/pUncTHkMltNECJFT5obKELCaH2Vn3dlP
         nZmBxT/gq/zHEn8Kh9LTwy3wOJeOE7fAHo0n4UurZpdWtFtUWvdpeVbSne+jTfwfMJZi
         kusj7Ppf1zkd/cYtgALeslz07C/eHIP0g9LQEX2RoNZV7VmUAIeLSUwm5ohQu7XWYhMd
         bTKouZTrsJewlKr/O3vwguyAnmsrcW5LPGn33dmj4wqMkTQUl7nberD+WB0kVa3lM4hP
         Tr9w==
X-Gm-Message-State: AOAM532iRRJjJcKtLSs+DdxQD7ENRiD9c9wkE0beDzEVMY80NLoV3za5
        SoQG5oWYaHFuReI2E3FvXXrFpr/TH7s=
X-Google-Smtp-Source: ABdhPJyUqkA87jW/1hekvKnZB96dzzKjzRwbNh/hjMyuaqEKBegYnSQNK+K6ZdaGx7JQc7cz2MUwjw==
X-Received: by 2002:a17:906:4452:: with SMTP id i18mr7234157ejp.374.1634825154548;
        Thu, 21 Oct 2021 07:05:54 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-131-102.95.116.pool.telefonica.de. [95.116.131.102])
        by smtp.gmail.com with ESMTPSA id t15sm2720915ejx.75.2021.10.21.07.05.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:05:54 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libselinux: use valid address to silence glibc 2.34 warnings
Date:   Thu, 21 Oct 2021 16:05:19 +0200
Message-Id: <20211021140519.6593-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015123100.15785-1-cgzones@googlemail.com>
References: <20211015123100.15785-1-cgzones@googlemail.com>
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
Use a pointer to a global object to please GCC.

Closes: https://github.com/SELinuxProject/selinux/issues/311
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/matchpathcon.c   | 2 +-
 libselinux/src/procattr.c       | 2 +-
 libselinux/src/setrans_client.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 1e7f8890..ea78a23e 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -356,7 +356,7 @@ int matchpathcon_init_prefix(const char *path, const char *subset)
 		mycanoncon = default_canoncon;
 
 	__selinux_once(once, matchpathcon_init_once);
-	__selinux_setspecific(destructor_key, (void *)1);
+	__selinux_setspecific(destructor_key, /* some valid address to please GCC */ &selinux_page_size);
 
 	options[SELABEL_OPT_SUBSET].type = SELABEL_OPT_SUBSET;
 	options[SELABEL_OPT_SUBSET].value = subset;
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 6552ee01..142fbf3a 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -68,7 +68,7 @@ void  __attribute__((destructor)) procattr_destructor(void)
 static inline void init_thread_destructor(void)
 {
 	if (destructor_initialized == 0) {
-		__selinux_setspecific(destructor_key, (void *)1);
+		__selinux_setspecific(destructor_key, /* some valid address to please GCC */ &selinux_page_size);
 		destructor_initialized = 1;
 	}
 }
diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index 52a8ba78..faa12681 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -272,7 +272,7 @@ static inline void init_thread_destructor(void)
 	if (!has_setrans)
 		return;
 	if (destructor_initialized == 0) {
-		__selinux_setspecific(destructor_key, (void *)1);
+		__selinux_setspecific(destructor_key, /* some valid address to please GCC */ &selinux_page_size);
 		destructor_initialized = 1;
 	}
 }
-- 
2.33.0

