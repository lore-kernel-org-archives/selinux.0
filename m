Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E309C2BB41
	for <selinux@archiver.kernel.org>; Tue, 16 Aug 2022 06:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiHPGuP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Aug 2022 02:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiHPGtu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Aug 2022 02:49:50 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D602AE14
        for <selinux@vger.kernel.org>; Mon, 15 Aug 2022 18:58:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id cb8so7227197qtb.0
        for <selinux@vger.kernel.org>; Mon, 15 Aug 2022 18:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:from:to:cc;
        bh=t/JmZmaBgMo1VbFS+IDv9IqKCnrbySZ35BOsym3YnPU=;
        b=GCGy9L6jiFOah1mv6mHSa6YvQlN0DpPSYc/KCrS7p/MGONo58nEkqlftUtndE0rOUq
         rP7giPuSYz3g1mBHdTq5LbBtkte6m7rNcoGYJ8VH65i9Dw6syA3ym5M9K2+pel+Uutvx
         QghiL4lVEIVPIUD0+fdVqLQqP9lIN/0sGEZhNzCeC01DqhEaw098QkEbBtsBp4GtrH33
         b4mqI6/RAT7/Qf20q+FcX48FaGIK9i6HVtgkRQxM3+/9uzEVFBFUWNDe+1L7A1l3Xff7
         KMfJw/EmihiMOMOON6sdFGueqSISdLvbSIdda1gsLpgpNdv2FvZeNjhvY0BO2Sn9Ls8I
         //Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:x-gm-message-state:from:to:cc;
        bh=t/JmZmaBgMo1VbFS+IDv9IqKCnrbySZ35BOsym3YnPU=;
        b=vw0tX3Q5yGi6UZmwLMsKUJdCcanO78SEPZcVKq04+XHrCyLIzGmEwwut6f4As7O+LT
         MsMbMrA5El5x3B/NMi86qCAP2ynRc7CgWyRC2P7JXWypGZGzTjj1WgzndyEd3YYcRsxi
         aTQ2WHJR2goiAXI5cFiPThIrqWMglwpUOo30I4SID4T9Dh24yCuwqlUsEXFhwVCDZMfD
         Nc8vo0NzUsPOi1sRgwZfcpvmjC0ysnSEeK0RfnIh4HDvACUdXRJOYiWkSTGEQzRGcAHm
         dezDI2E/I5Lmi9O4vMLcXLvk5c1sAeeifyD5LPZ5a4xNNp0T69KyloqUUDN+nUVfUMqQ
         wgTw==
X-Gm-Message-State: ACgBeo00AGD2cyyY8Z93mtUMGnkzdY+M+S6b9Seog9CFD24f5SpOQSWX
        j9EF5UismPUIISStMFF7Jm0jMREgibzK
X-Google-Smtp-Source: AA6agR5/TDFFsX+FiQB/Cp6BpBlHwqUurfXOnmeHGK5LndI29fS6qsWZs2NmsLIXRx/1zkwD7kVyug==
X-Received: by 2002:a05:622a:3cc:b0:343:7396:4824 with SMTP id k12-20020a05622a03cc00b0034373964824mr15014789qtx.680.1660615105557;
        Mon, 15 Aug 2022 18:58:25 -0700 (PDT)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a400a00b006bb4494ebd9sm3555363qko.62.2022.08.15.18.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 18:58:25 -0700 (PDT)
Subject: [selinux-testsuite PATCH] tests/binder: remove stray flag files with
 'make clean'
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 15 Aug 2022 21:58:24 -0400
Message-ID: <166061510477.614432.940552725841920786.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Failed or incomplete test runs can leave temporary test files in
the binder test directory, remove them with 'make clean'.

  mkfifo: cannot create fifo \
    'binder/manager_flag': File exists
  mkfifo: cannot create fifo \
    'binder/service_provider_flag': File exists

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/binder/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/binder/Makefile b/tests/binder/Makefile
index e78ad16..b89d4db 100644
--- a/tests/binder/Makefile
+++ b/tests/binder/Makefile
@@ -18,6 +18,6 @@ endif
 all: $(TARGETS)
 
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) manager_flag service_provider_flag
 
 $(TARGETS): $(DEPS)

