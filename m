Return-Path: <SRS0=s25y=DF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121F7C4346E
	for <selinux@archiver.kernel.org>; Mon, 28 Sep 2020 02:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C726222262
	for <selinux@archiver.kernel.org>; Mon, 28 Sep 2020 02:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UozSKZZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgI1ChF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 27 Sep 2020 22:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1ChF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 27 Sep 2020 22:37:05 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086CFC0613CE
        for <selinux@vger.kernel.org>; Sun, 27 Sep 2020 19:37:05 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id a4so7104581qth.0
        for <selinux@vger.kernel.org>; Sun, 27 Sep 2020 19:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TVNm4pI4fws86sAFM44OFBx6mnlgfpbO2FEonlvXvcw=;
        b=UozSKZZApf4rTWRXG2/cf7z+VaiwuK8hUjiA1IY8LRZ0xh2r3lP0fzyjsMpZCIwhJZ
         zdEVqStllfSV2fUjIeck9r7GPx4dCIUaYDwQLi1WxBQMaIN6wF+uAAAkuNLGz6IMUKrW
         ykfjum9fiHJAtv2GCv5dW6k2dtPFS9Yqjm8ABaAQQ4VS5ga+Q9U/1sd4t4gFYoHrV84a
         NvxrRirBwvnfByX7VMWz25KEv3PP6xDArPB6GzsAVveiMVptxg1Jeo3/tIndF0z+8Neb
         9XlpvtOzV+LRtgN4nxXVShsjX14TlKlhIVvXFaiyDdivg4BDdM+beGW2mokGYzIJ7UXB
         MF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=TVNm4pI4fws86sAFM44OFBx6mnlgfpbO2FEonlvXvcw=;
        b=Xpg4Hi2EtFSaeRCwSV0n9OwcS+VUJ8APSbgaYkzu/hqT0fNfcwdxHVXbH7b429i/2f
         IZ1L2oWU3LKzXLhuGLrAi3Xxk9+GhtdKXKV4am62uweDNyYFgiJ2XcUh1YLujbyOMOTi
         fRZ8q+L3IkJCSAqDbXLlKffePEcZ317zygKaOEBKC0dC0AbGG0QIQZocH+vaHLw+A2kb
         wla6oUz1s4ekWRuRl54/uLYuZ8CmNrhJ/I9JNebq5H55t5EjIoQRS8ZFHJMMsDb7/4Ww
         OrakQF3Pd6lX/z7pFCGUuzJ0AeDNeLlUSm942T7XPZjHILoPDmHwglZEBZ+5f50l90TY
         GHUQ==
X-Gm-Message-State: AOAM5337hoECjZz8Js2xvyB1xHbURxjQiePklS6ju2lh0JF7+9szII7J
        ZKs9QEoEPK4vfagQiG/Y3q7DnWe6kXlg
X-Google-Smtp-Source: ABdhPJwwPq5zYMMIcuwG1lGo69Q83wn3Eok9EIU8pKuu4UPLk1FKRKa67PSfyRZv75dWQTX0h64oTA==
X-Received: by 2002:ac8:3704:: with SMTP id o4mr9922761qtb.330.1601260623099;
        Sun, 27 Sep 2020 19:37:03 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id p192sm8362109qke.7.2020.09.27.19.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 19:37:02 -0700 (PDT)
Subject: [PATCH] selinux: provide a "no sooner than" date for the checkreqprot
 removal
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Sun, 27 Sep 2020 22:37:01 -0400
Message-ID: <160126062161.7010.15501362260483844999.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We marked /sys/fs/selinux/checkreqprot as deprecated in Linux v5.7,
but didn't provide any guidance as to the timeframe.  Considering
the state of checkreqprot, it seems like one year should be enough
time.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 .../ABI/obsolete/sysfs-selinux-checkreqprot        |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot b/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
index 49ed9c8fd1e5..ed6b52ca210f 100644
--- a/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
+++ b/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
@@ -15,7 +15,7 @@ Description:
 	actual protection), and Android and Linux distributions have been
 	explicitly writing a "0" to /sys/fs/selinux/checkreqprot during
 	initialization for some time.  Support for setting checkreqprot to 1
-	will be	removed in a future kernel release, at which point the kernel
+	will be	removed no sooner than June 2021, at which point the kernel
 	will always cease using checkreqprot internally and will always
 	check the actual protections being applied upon mmap/mprotect calls.
 	The checkreqprot selinuxfs node will remain for backward compatibility

