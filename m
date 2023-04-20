Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A49C77B72
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjDTPFy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjDTPFw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:05:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052884EEC
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:05:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b16so7154926ejz.3
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682003150; x=1684595150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XYmzet09TovA3hk6JVDaVysD3DndFA+WLI0ROK/kfzE=;
        b=gntlLpfyaZprhf+d5HkfEVPWG0lzNJsv+CO5NtzwSJEoHZ3MoJ+e/hBVXMYGD6Aywm
         VsM6fNxKVg+UVEXCAn5f3M+PmznDfSadICP7kJqFgVF04cMuFQ/GiW1mnNPNaWsBa/o7
         Va5Q/8qBnCDaqBjnvQzyCJ2jYqWHUY137dTLqKzWhTPZiJGjvtGfD1iPoPChW0bKMS8Z
         sFYgMzLXEAhBb7VBYrLYiKRDdb5Q3ud2jKmJce4DpqigyZtkh6zVhIfpo+7F19QrtG9s
         66CsgymfuUNfGZXPAsD2TF48GBPeajlUS+bvt0agerdJZF0v3J+vFMDAGp20NZYQ6MDK
         mGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682003150; x=1684595150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYmzet09TovA3hk6JVDaVysD3DndFA+WLI0ROK/kfzE=;
        b=bb2OI7+CsYIH4xWWjicqZ9PLDuDnvPn9CoE2beKPKQjFrkpcXJ+/S4vzMcrMRByPN8
         Kir71lDzzy/9icDLLGh6wZvPSt5UMwLsGdNOrUa/K6Q7ropX6oy1gAuJpWJMP6luWtfB
         YoGlMeo/P/Y04YXQd7MBK7vHqaToN8flc0dEzS3UmoynvubuHRtctDGjEgcaAI7WOPCc
         ojC0MT5h3mCYdUBMMT8VQnXA4Ji+JMBiVYDv8M/bx0fOM8p+QVph3t8ESdwkgu7w3XyW
         hf/OrcEqL/KmHyKbtTkjUSvoVwfTAQbTovHcxpqnSSjFSX/50JT+/cPX7VFVRyb/DnU5
         UkrA==
X-Gm-Message-State: AAQBX9dHNKXKrttHcKSsX7JOWuXLWIsgk70lOs9UBT1cQrp7iD6N55JR
        O4KGr0F6BOFoU5WdruwFJJc=
X-Google-Smtp-Source: AKy350bC/YFNWX3xvXGhTK9aUq5F5AvQl9l0csZjNHGfEtyRvY0DW7pS/07JO0vyh5lDudELIh1oMw==
X-Received: by 2002:a17:906:491:b0:94f:bdda:b29 with SMTP id f17-20020a170906049100b0094fbdda0b29mr1771094eja.77.1682003150392;
        Thu, 20 Apr 2023 08:05:50 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id jo2-20020a170906f6c200b009538cc79241sm827430ejb.56.2023.04.20.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:05:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Subject: [PATCH 1/6] selinux: do not leave dangling pointer behind
Date:   Thu, 20 Apr 2023 17:04:58 +0200
Message-Id: <20230420150503.22227-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In case mls_context_cpy() fails due to OOM set the free'd pointer in
context_cpy() to NULL to avoid it potentially being dereferenced or
free'd again in future.  Freeing a NULL pointer is well-defined and a
hard NULL dereference crash is at least not exploitable and should give
a workable stack trace.

Fixes: 12b29f34558b ("selinux: support deferred mapping of contexts")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/context.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index eda32c3d4c0a..44179977f434 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -167,6 +167,7 @@ static inline int context_cpy(struct context *dst, const struct context *src)
 	rc = mls_context_cpy(dst, src);
 	if (rc) {
 		kfree(dst->str);
+		dst->str = NULL;
 		return rc;
 	}
 	return 0;
-- 
2.40.0

