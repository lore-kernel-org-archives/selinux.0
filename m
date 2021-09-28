Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A21C433EF
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E4860F44
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbhI1Pst (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241676AbhI1Pss (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 11:48:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79C1C06161C
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y35so33884669ede.3
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=k5BYEuDbiZnzXVev7vparjhsdxXtKF0jUnwDdqEM4X8=;
        b=oczgiRvMPXKxYXQm5SDWsYVXfhds2MnkpFfnaYt3bs231XgNa6YJaSKw2VfyUTsQDg
         nfKoXGVhBZMsqaFiSrsVOEaL6f7+38bVBha1NuCF4u24IFn/iwtAB8DTxhgYbfOzaSl3
         2f4Cyk/q6sPkjiUNJ0LTst1YuJXJ/3hFPAwTDCji8vUhhaDgo6IHAlVXg7APo8XKfpO1
         4VG33VLcgrfTGLYly3kW4ELu7d+stDAn4eHXTOuHyTNY0b3EZQQ2I5l/OwOQ4oh/EtPY
         hG6ciNNQd2NOYotxO+NTbsNw/zaG9JaFPJV8/mVh+sxonA9/jVOArO0rYApkgciCn8wv
         3/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k5BYEuDbiZnzXVev7vparjhsdxXtKF0jUnwDdqEM4X8=;
        b=Jp6BjYOZvZLC8C0Aw908mRCyIfB8NOUJJDPcL6u0jh//HnggDXyRFtok/AKWcyAmj5
         c1dMw2i2dc9FP2bdc5ATboOLktj/bVHbTZE/9Vf5R8rJLTb020NuEr3GNR1Zj8kCRH3r
         /j798z/pMnkvyj9Gxjhvq7g837wYdguPmEp8EiQ7x3y4rW7udCuHmF5uF3r/+SXBQlxO
         sWowRs/1WcQdDUh96X9B5S9hGceaiu4JqdDbSzGJifqoSIvlOtzEVmPtjKEI3mMuXMLu
         pfxv0CmyJgnMK2AzWBseHM++FNyq7QJrA2rWEaBWunMb72dF604PI59S3P1Fe86qBP7c
         ZOtQ==
X-Gm-Message-State: AOAM530GWZPw+Cq9QLp2qqAmPCdcqKvaDJEUqstNiJNdTG+3HQe+RrMe
        3yqee1bx5zpe8ZkELuh9HZe+4erGEVo=
X-Google-Smtp-Source: ABdhPJx1itGXN5TMgNNbgaYl7rasGUrSVSNmLDcuganGNyBkkOXlZ/NN7H7KBH5PsZAKekkZzMFdxw==
X-Received: by 2002:a17:906:8496:: with SMTP id m22mr6243797ejx.357.1632843985713;
        Tue, 28 Sep 2021 08:46:25 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-152-081.95.112.pool.telefonica.de. [95.112.152.81])
        by smtp.gmail.com with ESMTPSA id l18sm13403834edw.78.2021.09.28.08.46.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:46:25 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 5/9] checkpolicy: policy_define: cleanup declarations
Date:   Tue, 28 Sep 2021 17:46:16 +0200
Message-Id: <20210928154620.11181-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928154620.11181-1-cgzones@googlemail.com>
References: <20210928154620.11181-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The variable curfile is nowhere used.

Static functions do not need to be forward declared if not used before
their definition.

The error buffer errormsg can be a simple scoped variable. Also
vsnprintf(3) always NUL-terminates the buffer, so the whole length can
be passed.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 185d5704..cda3337b 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -67,7 +67,6 @@ extern void yyerror2(const char *fmt, ...);
 policydb_t *policydbp;
 queue_t id_queue = 0;
 unsigned int pass;
-char *curfile = 0;
 int mlspol = 0;
 
 extern unsigned long policydb_lineno;
@@ -78,12 +77,6 @@ extern char source_file[PATH_MAX];
 extern int yywarn(const char *msg);
 extern int yyerror(const char *msg);
 
-#define ERRORMSG_LEN 255
-static char errormsg[ERRORMSG_LEN + 1] = {0};
-
-static int id_has_dot(const char *id);
-static int parse_security_context(context_struct_t *c);
-
 /* initialize all of the state variables for the scanner/parser */
 void init_parser(int pass_number)
 {
@@ -95,9 +88,10 @@ void init_parser(int pass_number)
 
 void yyerror2(const char *fmt, ...)
 {
+	char errormsg[256];
 	va_list ap;
 	va_start(ap, fmt);
-	vsnprintf(errormsg, ERRORMSG_LEN, fmt, ap);
+	vsnprintf(errormsg, sizeof(errormsg), fmt, ap);
 	yyerror(errormsg);
 	va_end(ap);
 }
-- 
2.33.0

