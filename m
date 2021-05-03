Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3FBC43619
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F8B6121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhECRzF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhECRy7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:59 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEB8C061763
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g14so7299147edy.6
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2qeqi96IaIbzo+rnEBgHFQ1xj4F2X71Y0Eph2jKqL2s=;
        b=mLfbEd1MlvS95Qd9R6wTmXQh1iIXaOlHLyK2jeVvnOX2GhKs29L5pfdoPb2DnmH9jn
         tmKtdMkESzDvnVGfWHQ9HbPWrQUgr9ux25CcnUhPGtb9JGMlRPAUnQokMLT5ZLrE4zXz
         10tjpou9qvn8Ilf/aAb7rxIeKcx/jMTXtPhMrKsfZX9BkNQbLKPfCAGhcm4hSo3dqnow
         Jwug1MJRB297vYqU+NQ0XhtChqUXHprEXL827Cg3/YX9cnbIUDf+gsuoldzjKDHoy6Pq
         2Rob9dvhK45YlPnXqAgS3hpRHVuXfSwHmOhowt/+E8iK75/6mcgYGB3Za6IJjvnl7MFo
         kceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2qeqi96IaIbzo+rnEBgHFQ1xj4F2X71Y0Eph2jKqL2s=;
        b=lONavvrRNkx6H1iCN9GwrLBa4ZG3bEzCcllmL/EizDpzCdaPiBbh7N9oyXBzo0fwKV
         a1+qZEWaemX3G2++nLOUjHMmV2+SeHt68dJdWyKimkkEy59OlD+8CUqS46hPdulWR/9T
         QoaEJGH/5eLtdb+OVyOQCdK0OEIwYgdCJWH2Lu9RAorkYcasluj0m4pjnRoJoVb0RhFn
         OyBm92jM41C+1OisL5tbgUKjdgmXdFLMGydWlBdr/Y8h6ANEIBb7uJyeQROnMVUv8vJG
         Gt1uE84LlJO+YxD8i2jjAW9HzinH6GpBf9JbZgHJI6a9HrzzbLvK5Qf3ymPehH9ItTSL
         2xWQ==
X-Gm-Message-State: AOAM531qFompPWyf9753o9y8of6ke1Jj0Rt3p/Fo5Yh5udvRVSTi3Gqs
        mQ06IQbQChLxnAin6xfcldx6NFZc7PdDcg==
X-Google-Smtp-Source: ABdhPJzl55fxmO7lY9W8Zr4+o7cW/m5xB4Pn7JaPl+xft/wgfvn7Bg/7riOGNRoIkpp2tJq20p5QMg==
X-Received: by 2002:a05:6402:51d4:: with SMTP id r20mr21255933edd.112.1620064442006;
        Mon, 03 May 2021 10:54:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.54.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:54:01 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 21/25] libselinux: label_db::db_init(): open file with CLOEXEC mode
Date:   Mon,  3 May 2021 19:53:46 +0200
Message-Id: <20210503175350.55954-22-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Open the file stream with the `e` flag, so that the underlying file
descriptor gets closed on an exec in a potential sibling thread.

Also drop the flag `b`, since it is ignored on POSIX systems.

Found by clang-tidy.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index fba96c92..94c05c6d 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -277,7 +277,7 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
 	if (!path)
 		path = selinux_sepgsql_context_path();
 
-	if ((filp = fopen(path, "rb")) == NULL) {
+	if ((filp = fopen(path, "re")) == NULL) {
 		free(catalog);
 		return NULL;
 	}
-- 
2.31.1

