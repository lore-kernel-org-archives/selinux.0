Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B939C433FE
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7A561183
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhKEPsg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhKEPsg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBE8C061208
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o8so34461618edc.3
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3vb583Si8gIdzKyyXYtEEZm4k8y5qoiEdtNtg7j4mW0=;
        b=BnB9U1a4q3qr15FOD1kuEE6R9/EFJ0yDQnEwCsr5wsvO0KbLDDBZFtQO7aeAGXCKDE
         61d2nm2G/BDwRxFqrir0ruAd/l3LlB4BqNk33fXdBANVpfHua8hNRQwiK/R4+PJf26SG
         PgnDbThiZbpv4hE9Fzg9hOCyoogtx7V0dgW+MR0+tYYhxKW9IhMbWsZ5K0Buri3l3lm1
         /siJkcWAuxm6FSm9Jhx/0ge3/ZHC84tikw5mRPoXsnFZ5iGfkdnC0q9S31BDdBdSPLBr
         CSauezvOHhcH8j4uikpOLKFeKqyqL/jGhD4BozqSHiaxJ5iy0ZnaqVRk6v52v4ntQAhk
         JLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vb583Si8gIdzKyyXYtEEZm4k8y5qoiEdtNtg7j4mW0=;
        b=hIhFCWVLafTFtMMIUgJTQ+WRirDf8bTQkbegpS0fqwwz9CPWLRn2uUiEjRm303+l0O
         XeF2Scv4SeMz2bQisSBTahYSmX4o/8NAjBpaYNNksqay8w3fKxFnGkFLn9LFWFi03QFA
         B4VQwALb5+VZ3kwChJ7Gasdn5UmOowMkNKnEVB5oPhdqQbG4njF9hXk6bXgrZC2iUPKF
         w5hIDG9hhA9BFWQbUEXvye1unKSSrhOp1oZgdqSmTbUiuKyf3DaoZArKeBqEKe3hjsP8
         oV/Qu1HUI/YZqWBXTLWslrSr7bjZS0vX4mldHN399A5LI+GPO7g+0SKqCHgqCD5cWJ1T
         BYug==
X-Gm-Message-State: AOAM533oNotmxv/971iNxzGqRLrQTRKYxbuDd07p5Y/yFEjGw9QRgVxj
        DxK6XR0gMQPUFAp7KpvGtY5kxrxF7B4=
X-Google-Smtp-Source: ABdhPJzR6SdbJBepvK5e+EdliZCD8ZHgyhPBui013nXHxaZhoB6cAwEnUF1z+8JakzklVkCk107hqA==
X-Received: by 2002:a50:9548:: with SMTP id v8mr78842877eda.34.1636127154309;
        Fri, 05 Nov 2021 08:45:54 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:54 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 14/36] libsepol: reject invalid filetrans source type
Date:   Fri,  5 Nov 2021 16:45:16 +0100
Message-Id: <20211105154542.38434-15-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid integer underflow on invalid filetrans source types.

    policydb.c:2658:47: runtime error: unsigned integer overflow: 0 - 1 cannot be represented in type 'unsigned int'
        #0 0x4cf4cb in policydb_filetrans_insert ./libsepol/src/policydb.c:2658:47
        #1 0x4d221a in filename_trans_read_one_compat ./libsepol/src/policydb.c:2691:7
        #2 0x4d221a in filename_trans_read ./libsepol/src/policydb.c:2842:9
        #3 0x4d1370 in policydb_read ./libsepol/src/policydb.c:4447:7
        #4 0x4b1ee3 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:35:6
        #5 0x43f2f3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #6 0x42ae32 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #7 0x430d5b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #8 0x45a1f2 in main (./out/binpolicy-fuzzer+0x45a1f2)
        #9 0x7f8b8923a7ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #10 0x407aa9 in _start (./out/binpolicy-fuzzer+0x407aa9)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 1868af5b..ab303ce6 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2683,7 +2683,10 @@ static int filename_trans_read_one_compat(policydb_t *p, struct policy_file *fp)
 	if (rc < 0)
 		goto err;
 
-	stype  = le32_to_cpu(buf[0]);
+	stype = le32_to_cpu(buf[0]);
+	if (stype == 0)
+		goto err;
+
 	ttype  = le32_to_cpu(buf[1]);
 	tclass = le32_to_cpu(buf[2]);
 	otype  = le32_to_cpu(buf[3]);
-- 
2.33.1

