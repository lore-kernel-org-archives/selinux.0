Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CB1C433FE
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFFE2611BD
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241676AbhI1Psw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhI1Psw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 11:48:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538C3C06161C
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g8so85116210edt.7
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X8zL2j3g+qXuaPDq9umaJDB7DLVQOzlsMUznEwitkI0=;
        b=HSqok4NjPy+8EXveE3/En83jiiGcfZlxNAPKOyy14OHWeQ3TpgbEjhF3Mna9aiiFKm
         KTslyS4aPpEkdGt4Qq2zxlw/DRVQMi5kejDlMNjUjt6BBFNVTmNozWnWxP92p5VU7XxD
         UZxKhe121QP+MVBSC0UvVBCg6yIFG5tvEpFhbkvSwYIFDrhcEudbMJJevz/EBFtbMS+x
         8UfJuPu9G7jpAOcFQFSF2oK0/tmvFUM3doNyfmxARwZc+QEezVq6OivlD+bvIE+aGCeq
         jg+pIhvlTgGfS7as7ycROYX+YMHF0kx53kgcJMd6xckMVvcbepHYtQR/IL4ZiQbQ5xV/
         mUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8zL2j3g+qXuaPDq9umaJDB7DLVQOzlsMUznEwitkI0=;
        b=r9WGslP9XTOf5nxKi4eAhlLYbrh9V5m8O7P0cA9cKGjQbZFsf44iwoTlsg/SAlpmCs
         +4TLkEzEPvPlvjYrDW1yBVzig87JjQwD5H8ucM4HSjiUCk2GCgDPjHnr0Q6RoaKxjZlu
         r8kiCTR8+MAkbyea4d5WWNQSBjvCVAayz8FqsOvy2jGgYHqrKTFfeHd9IKcedGv3LOfH
         nXUl6tJHj6RgmuC4E+0J2uR9yHfq05Zgcq+gJx4bdaQ4rcbMgYaRRRRiiqm6uxuBUKD4
         HPev4SKOLKxHAuSRCubWZakBvAChbACnatLOvGX2/MO3F0azrKDcnzyXQFhKe/ekbShx
         MKoQ==
X-Gm-Message-State: AOAM5307QyrswFS1g4+mSzsygbPJ6yNPS0usEFYMvmD2yqhVYILhXe6S
        m+Bo+2j8mCAU8VV3rb2JBXi2toZdfS8=
X-Google-Smtp-Source: ABdhPJxBs8TPRFn1ejmuoAOJ5Wgy1ewQardKQUej3aw82hVq8ajkdgpUNPYcc83caPmITDh+sMCHRg==
X-Received: by 2002:a50:da06:: with SMTP id z6mr8291562edj.355.1632843984557;
        Tue, 28 Sep 2021 08:46:24 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-152-081.95.112.pool.telefonica.de. [95.112.152.81])
        by smtp.gmail.com with ESMTPSA id l18sm13403834edw.78.2021.09.28.08.46.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:46:24 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/9] libsepol: resolve GCC warning about null-dereference
Date:   Tue, 28 Sep 2021 17:46:14 +0200
Message-Id: <20210928154620.11181-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928154620.11181-1-cgzones@googlemail.com>
References: <20210928154620.11181-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

GCC reports a NULL dereference of the return value of stack_peek(). This
function explicitly returns NULL in case of 'stack->pos == -1'.

Error out on NULL returned.

    module_to_cil.c: In function ‘block_to_cil’:
    module_to_cil.c:3357:55: error: potential null pointer dereference [-Werror=null-dereference]
     3357 |         struct list *alias_list = typealias_lists[decl->decl_id];
          |                                                   ~~~~^~~~~~~~~

There are more occurrences of unconditionally dereferencing the return
value of stack_peek(), but the callers should ensure a valid stack, so
just silence this single warning.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/module_to_cil.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 3c8ba10a..16e4004e 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -3354,9 +3354,14 @@ static int typealiases_to_cil(int indent, struct policydb *pdb, struct avrule_bl
 	char *type_name;
 	struct list_node *curr;
 	struct avrule_decl *decl = stack_peek(decl_stack);
-	struct list *alias_list = typealias_lists[decl->decl_id];
+	struct list *alias_list;
 	int rc = -1;
 
+	if (decl == NULL) {
+		return -1;
+	}
+
+	alias_list = typealias_lists[decl->decl_id];
 	if (alias_list == NULL) {
 		return 0;
 	}
-- 
2.33.0

