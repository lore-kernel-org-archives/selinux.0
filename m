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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A6DC4743E
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F9461359
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhFHQBh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbhFHQBg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:01:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FB9C061795
        for <selinux@vger.kernel.org>; Tue,  8 Jun 2021 08:59:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s6so25101701edu.10
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ajv1hM5YLUTNdAQtkPwqq/cIlRV37J5hP+Mm8XMZO6g=;
        b=YSMBP7zDzWuZSS4gDKOZmcagXykyzZ0TFvFtq/S0iqxx3r3ub5tpcuSvO9b0Ks4wtN
         p++7zH6COHC5/fmYG0CDPjPVcMdweV2BKHGuR36I81z6T7w1J9ZPCW8dEYaur4Q7VvUl
         Xft5LhJZCoDXBUYkdFVfnbiPz9mpB01w+kdXHHmkLQSvCEZryU865f5bHkKDJ0H0yuxr
         PJS5/cr51BvWfEZBPqEzXSKig87hx5Hv5f2wSfTSUigUXJ4TwrdPHI97poK5ciGPP4DW
         ryjkZKag+4jW63dJtFNzg71t/jhCR8KNzl1//az9uMxzPhkwbrixWWm7N+PjBJWCuyyU
         cthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajv1hM5YLUTNdAQtkPwqq/cIlRV37J5hP+Mm8XMZO6g=;
        b=cXun2UwD8nVlU7o7FH3pgVUuo1oT8vqdMTsPSlrdDiUqy3QKyUF6yK0fLkeo72565g
         FkVSQtl3DOrc9G2EifN7vfZJ9VQy8rts22VyJR58uE2bha5Vkt+YY9ffr14SUviD1qC7
         LuOgMaHpok0qdnXZdM/uCtbe0lVoGKYYgJ0Q6TJxVSLzBBz7n2iRD7iHnVkKdHfUwvo0
         LWL1IHo8Oq8ymKWtXVG5V5YwqS6q0OHOXrumFmEgxcLyJmVKNRorK2ikduuvUknE+5dA
         ch+RzKLFEamALKQ2AwcsGLDCZKN1OUuyBSa/T7QJGEnfF0b9Grb+Yi1zenY0nk5HeNbX
         Ufnw==
X-Gm-Message-State: AOAM5336CaDhKxEajpdWD14qODFbbxZjwCDUUFvQpPCDyb6PuIz0CRls
        hxsf0hSJaGiJxG+Q2/dGQ/94j4DkwL8=
X-Google-Smtp-Source: ABdhPJzsWbwv/QSIDghRBEfjXE0G+b2s+SB/pSr4gLfNgIU9t8Ao7X7Koo/+x8zUUfaI+hAcgc3Jsw==
X-Received: by 2002:aa7:da58:: with SMTP id w24mr17896733eds.127.1623167968803;
        Tue, 08 Jun 2021 08:59:28 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:28 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 17/23] libsepol/cil: drop dead store
Date:   Tue,  8 Jun 2021 17:59:06 +0200
Message-Id: <20210608155912.32047-18-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

../cil/src/cil_binary.c:2230:24: warning: Value stored to 'cb_node' during its initialization is never read [deadcode.DeadStores]
        struct cil_tree_node *cb_node = node->cl_head;
                              ^~~~~~~   ~~~~~~~~~~~~~

Found by clang-analyzer

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 85094b01..601fe8d1 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2227,7 +2227,7 @@ int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 	int rc = SEPOL_ERR;
 	struct cil_args_booleanif bool_args;
 	struct cil_booleanif *cil_boolif = (struct cil_booleanif*)node->data;
-	struct cil_tree_node *cb_node = node->cl_head;
+	struct cil_tree_node *cb_node;
 	struct cil_tree_node *true_node = NULL;
 	struct cil_tree_node *false_node = NULL;
 	struct cil_tree_node *tmp_node = NULL;
-- 
2.32.0

