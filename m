Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC1DEB64D9
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 13:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGFN5b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 09:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjGFN53 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 09:57:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C071BFF
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 06:57:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so1038874a12.0
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 06:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688651840; x=1691243840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9fGK0bHQ2gHTCshdX3jYBtF0K612inbodPaeRB4osA=;
        b=nnrW75UZmhc1+N/3J2ZOM6Ve6zOYUAywIIhPOZkjOEVKYDROMJaE9k+VWwESL3WABc
         AiT6xQPXSNfHbpVcNAqLF9Xl8kr+QOG9kBFBNPbAVLUOpjRCWU9WLDwuespTnjqEdv9e
         /NV/PJOqnRebYoH/kfUtnnakhgmYT9DgDDK+ykHel3m75BfwWmk96vHIvHHjqU4Oubgy
         gSyG1srHcjIvdQuwr+EogEVEgg56Bk9zZUEO3ROmgLl1jbUKOIYdAmFJnt7cbk6JwbEI
         WT4xF2XgeWF0AwNkb0gNi452maIohR9rDQRTLl0inbH03YESSj6zVWYwX+PUmVfg6Fa+
         gPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688651840; x=1691243840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9fGK0bHQ2gHTCshdX3jYBtF0K612inbodPaeRB4osA=;
        b=FHgbt95seG/l8OKgSWiRtdL9o+nX6wdpssHUvhG2nD/QW7jUvHLjRQJ2uxW1w3NF7/
         s/Jngq5oZhXN3YRtrfbG9cESCra2ahHsrtTxgB/UW5buhRNoUf5WdqzxI4bt5Me9+wSi
         O93UlgQ+yRDNvJ9GMmfqIIvgN02xiii8QAl68jQmLckfcWpiTBbDTHTS3jUfv62/tBb1
         BwwhutQiC5ihQB1PUTqk3BwrK8MMXCrBLeMyyBl9WRloDavkxPCcBKx61vN51UQ1oxxL
         O3VVXjC3IuIsda2I5at6vJCEZQNUxDaDWSQL4gYQGKEbr99aYFCex+nxDHSDVJtBfjet
         Q2sA==
X-Gm-Message-State: ABy/qLa0a02p/CuFdgjHHLdPB8IC3CJSoGaWIlnsbLKtaKeHQuNdNbiX
        MDDQsjbH6CWRCCjX+rdFYhlS7AgnPCV3DMgx
X-Google-Smtp-Source: APBJJlFMlVuTMgRkcfG8VPnaMEuU9qY7Elpf+FTuMi/T6m7HoJNzaeWwg3cyoBWH+KZbSmTiNE4Rdw==
X-Received: by 2002:a17:906:253:b0:978:6be4:7efa with SMTP id 19-20020a170906025300b009786be47efamr1523447ejl.18.1688651840233;
        Thu, 06 Jul 2023 06:57:20 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id bn19-20020a170906c0d300b00993a37aebc5sm843688ejb.50.2023.07.06.06.57.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:57:19 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: check for overflow in put_entry()
Date:   Thu,  6 Jul 2023 15:57:18 +0200
Message-Id: <20230706135718.44908-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

put_entry() is used during writing binary policies.  Avoid short writes
due to an overflow.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/services.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 062510ab..07ae051b 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1708,7 +1708,10 @@ int next_entry(void *buf, struct policy_file *fp, size_t bytes)
 size_t put_entry(const void *ptr, size_t size, size_t n,
 			struct policy_file *fp)
 {
-	size_t bytes = size * n;
+	size_t bytes;
+
+	if (__builtin_mul_overflow(size, n, &bytes))
+		return 0;
 
 	switch (fp->type) {
 	case PF_USE_STDIO:
-- 
2.40.1

