Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D4FC433F5
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3730611EF
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbhI1PtA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhI1PtA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 11:49:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D4BC06161C
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id bd28so23413521edb.9
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PNvuTizLv0cwOxbk8m3l9W44wpXZgEFiGyrOuxwwRBc=;
        b=P4FumdAl5RrkGbIIeHVkx8UMLVwh0PCc0zLqDI746X+LLM8YY7QDo7TyoKK9jVIAJ3
         sbqm5IDeP8IxxAZFm4Dov0n6083Af1YZHzgs10/c31Rb9l/hDY2+tV7kWNux4UvnvXXC
         OSN23nraC4DT2bpjSlPfP+m5iSrWX7naa3/wsJU/+vT6ou8RVRXpw/yPPIGUgS/wiZBS
         rsNIav/VMH1oAjldBgxHctaXL+hDO+14qri9G3TmDGn9MXZXAl4o/w1kn3/TAXfsxHgP
         22UoByzICDaUUgGLUo+pQ1krRT1N+YKWfDctqcrE+EhDZccLDDU4huHjYOvYoi7R2rVr
         I2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNvuTizLv0cwOxbk8m3l9W44wpXZgEFiGyrOuxwwRBc=;
        b=FfE6SAwJg364PMH6Lp2ZOINp9Kp9U5V42DrU/uXJsDAskxxj4VRxNDRUxN8wfHwWsZ
         p2Jrqn3IqBXEGv9xUxrREVgy92zy7GE75PavGIwMCeVvEpTh9hXrVr5b+x4FcalXU0+E
         KDGkqlTfOimHBSv5Ob+z2zS+Xyik6deLbx3IMGDsGaq5mL1AqLdIBKgy5Y3GrrCxBLlr
         BG/r8Gxxo+uV95A/ST6stpI8YNZIJ4QFmMU1yMNc1h3dJtn84BJE1Qiz2eHj76Ug4Qj6
         HeuYbvZZFc+m6YXMzuL8FyfY3c7mA47/BBbkHNMck/1sZSwIZOecWemmO/siXHSYz/KN
         RroQ==
X-Gm-Message-State: AOAM530oQ17MwHYv9813xEk/tiiuv0+ZQTdGjb/yC7e4qHt8t7IQqRxC
        XGrPRkU5LjwGZUxzvtxbmQNRuT42pTE=
X-Google-Smtp-Source: ABdhPJxdSAshw82xWeXHVJzvckPnQGjQMjB/Bhs3RbPkd5n9hLrJTk/yS0snDyrbV8swuZdMJYQuog==
X-Received: by 2002:a17:906:498b:: with SMTP id p11mr7178815eju.295.1632843986340;
        Tue, 28 Sep 2021 08:46:26 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-152-081.95.112.pool.telefonica.de. [95.112.152.81])
        by smtp.gmail.com with ESMTPSA id l18sm13403834edw.78.2021.09.28.08.46.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:46:26 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 6/9] checkpolicy: print reason of fopen failure
Date:   Tue, 28 Sep 2021 17:46:17 +0200
Message-Id: <20210928154620.11181-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928154620.11181-1-cgzones@googlemail.com>
References: <20210928154620.11181-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Print the reason why opening a source policy file failed, e.g:

    checkpolicy:  unable to open policy.conf:  No such file or directory

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/parse_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/parse_util.c b/checkpolicy/parse_util.c
index 1795e93c..8c1f393c 100644
--- a/checkpolicy/parse_util.c
+++ b/checkpolicy/parse_util.c
@@ -36,7 +36,7 @@ int read_source_policy(policydb_t * p, const char *file, const char *progname)
 {
 	yyin = fopen(file, "r");
 	if (!yyin) {
-		fprintf(stderr, "%s:  unable to open %s\n", progname, file);
+		fprintf(stderr, "%s:  unable to open %s:  %s\n", progname, file, strerror(errno));
 		return -1;
 	}
 	set_source_file(file);
-- 
2.33.0

