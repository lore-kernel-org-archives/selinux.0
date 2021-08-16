Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E3AC4338F
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 16:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D79604DC
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 16:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhHPQzf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPQze (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Aug 2021 12:55:34 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A769C061764
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 09:55:03 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 18-20020a05620a0792b02903b8e915ccceso13599338qka.18
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KkDvzB/VWPbGdu3xxjneXBEZXwDfCn2XS83lhKdRYGA=;
        b=aFFW5gRhxfXWoT77OIJFwiscFaeiOra0m4jcttrktXdjPS4SoXWephpz4yQVjyqMPE
         6xMFZUrrTe34vjw+zoW9N0ffrmmUlpGeCnVACyssioFCGFPirVWiKGQrU/elrSe2t4bq
         j8VVZjYkXFdU10rdprTwgzLXt7SdEVfqV2JEgjJyQdd2B9ARbBhrDUOHNCjaxklROoh4
         p7FgDoJwYzbNNITMgifM73eJWPU5s5a4SX3e5a4LVb2D979cBxiFb/LctQR608ThwuQD
         /4YkjSQ1o8Smrvqjj1qEw2K8LRKVsnjT1iQsVkz7480605a9ySzsGWL4TYcMuhL6YQnA
         Re9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KkDvzB/VWPbGdu3xxjneXBEZXwDfCn2XS83lhKdRYGA=;
        b=AEIQzukkhfV2XT62ZNz3dUUAWcus5tkr+iXEpusz47bRuYVw2rJPNnABKVIVgxGWbp
         1AZ0ZZgHh93t3mQ9qfbBLwvHlV5CFikoWH8P1PyhJ7FSLW0IOaQ8JP8Ymc+npS9szlPL
         /D29xq6Z8VmPtgCplaYSy6Ncpc+LnzW69HPItDvuLUNH2JP9DSH9GqFwDX8Rt6CsRXEQ
         KdNOBBEC2hzzB4oIypR5AUGXAI7beilmbnLJTxzsGrHcmL4/9vZKt1XvGcmRk8CgTbLv
         2g7ap8HAyzoM6RmEjzSAwDofD4RibeVIuMJEWmsUeLRFHbAEvR/+seXJ9Mt23D7D58yD
         1eKQ==
X-Gm-Message-State: AOAM5301lUEbWCMbKu9lv633iWsPcvq10llTqTwNmEL5EtveKiqzkHEy
        hTzCEQL7c4BwJXkii7ofZ52f0JXrrzyQx0whWaRJr48TRj6ImcHl59QIrjl44GMiwq7FPCViQIz
        V92Nns+ebyymXF5CNkBcOSSHHSNxKAKLjrxXJc8ClziD7UkqAHaJ0FcvgyZtqJE2m4Rm6VDhRS+
        px
X-Google-Smtp-Source: ABdhPJxjCCDJky91Zcq0Ba32TFEQt4SZP586aEptvUrg32/LtDmA9tMUz2xsK3w4Zy6u9Gk+KGqXICp1iKCgYsGpGw==
X-Received: from zhangkelvin-big.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:6214:8c6:: with SMTP id
 da6mr16911395qvb.18.1629132902188; Mon, 16 Aug 2021 09:55:02 -0700 (PDT)
Date:   Mon, 16 Aug 2021 09:54:59 -0700
Message-Id: <20210816165459.1741490-1-zhangkelvin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH] Improve error message for label file validation
From:   Kelvin Zhang <zhangkelvin@google.com>
To:     selinux@vger.kernel.org
Cc:     Kelvin Zhang <zhangxp1998@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kelvin Zhang <zhangxp1998@gmail.com>

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 libselinux/src/label_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 56f499fa..2e28d047 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -188,6 +188,9 @@ static int load_mmap(FILE *fp, size_t len, struct selabel_handle *rec,
 
 		str_buf[entry_len] = '\0';
 		if ((strcmp(str_buf, reg_version) != 0)) {
+			COMPAT_LOG(SELINUX_ERROR,
+				"Regex version mismatch, expected: %s actual: %s\n",
+				reg_version, str_buf);
 			free(str_buf);
 			return -1;
 		}
-- 
2.33.0.rc1.237.g0d66db33f3-goog

