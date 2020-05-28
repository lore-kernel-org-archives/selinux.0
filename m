Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DE0C433E1
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 12:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 094EC206F1
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 12:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fUz4+87S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbgE1Mvh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 08:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389873AbgE1Mvg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 08:51:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5550AC08C5C5
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 05:51:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k8so7080780edq.4
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yd0DKovFRxBXFZ2+vwZaXcz8nkW5Wky8QeVHusDzPGk=;
        b=fUz4+87S33JhBbcHo2vV89rQKo7NPoR30PBghjma476dyvX6wVxKDn3xl0WF9aUBRV
         ZkkX3rHq+HPUaQqyIWfjV0sbenOncbSKEsvkxTYnyz+dnDKmWFwlOQqkE2oNL9XOAduh
         NlxQS/yMFGkIzWQ2a3am6ZVKVGx8W07zGKmjt0WmPBCjQ8ncN8F4MRc684oRUhB9l5AO
         UOk7Ke5XtPKIbxAtsUItacY8LP4EnZTGOtPhe3NTn4EtfiUH7rbB93v31cSxZ2ow4/q5
         Lwk+Gb32SIuAJEiPM7zHpOpMKmI5tmuz9lNlRYJ1qFhnwCwJ2PajWF8rbscc8NinfWx0
         N17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yd0DKovFRxBXFZ2+vwZaXcz8nkW5Wky8QeVHusDzPGk=;
        b=VCfwSzO7wf3I8Jz002SJyLKz9bHXuChcjjgpe3johI1kkCy5aUo+knQdAe5JGqSVun
         vBWKjSXeA8BL/flkWxS2uBJDBpNl4qh4pxyLnRLXyXK4sVx6+nPqRwFAs1uTNJjSjOGn
         RZNVVEBDcdVo4WAFLbua3A9gq6t3lp8laN5k3QFDhrJ8KpEZKwlPWSIfxALBI79UO+vT
         ER0pnCZ8R1QNU9zVFyHQAkj29BU0V67hlQdDG1e2Wu2RoePoVnzRj2lPNEdijtqq+yr/
         QttYJmnu3e8x1fvjVMH/6aL8TXdJxY3qEjSOtlpk52e9tZe0oU2rUWwPlIj+meOw6Rv7
         V79w==
X-Gm-Message-State: AOAM531QPwUdeq/KRz0zicEYx1LyPAjoSfVIsNJhuhON1te9ZNt9s4Qx
        Ogj5WKQtrIM64/SMpEm4+aQ/NIT4
X-Google-Smtp-Source: ABdhPJwjTy8221DCbmK4xXQHpdUkEdncCUkXEKw3TOhHWUBmKgyZpZBEP9KLETPzTpFCYg/mxgp5cA==
X-Received: by 2002:a05:6402:19ae:: with SMTP id o14mr2916448edz.235.1590670294879;
        Thu, 28 May 2020 05:51:34 -0700 (PDT)
Received: from debianHome.localdomain (x4d03b0ba.dyn.telefonica.de. [77.3.176.186])
        by smtp.gmail.com with ESMTPSA id o59sm4537203edb.51.2020.05.28.05.51.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 05:51:34 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/3] refparser: add missing newline after error message
Date:   Thu, 28 May 2020 14:51:27 +0200
Message-Id: <20200528125128.26915-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.27.0.rc2
In-Reply-To: <20200528125128.26915-1-cgzones@googlemail.com>
References: <CAEjxPJ4qJj4-of0F=TKZ1wb-s82_wbMCYLbFPuxJ57dqbNRjeQ@mail.gmail.com>
 <20200528125128.26915-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 python/sepolgen/src/sepolgen/refparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index f3e0ae87..9f850990 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -1148,6 +1148,6 @@ def parse_headers(root, output=None, expand=True, debug=False):
             status.step()
 
     if len(failures):
-        o("failed to parse some headers: %s" % ", ".join(failures))
+        o("failed to parse some headers: %s\n" % ", ".join(failures))
 
     return headers
-- 
2.27.0.rc2

