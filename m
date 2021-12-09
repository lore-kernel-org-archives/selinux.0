Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD79C433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbhLIQzv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhLIQzv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC2FC061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:17 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so21203018edd.13
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DFcvTQogy7Mo0rOVJpnyL0BQpY03Kba3KtoBQO4aBoE=;
        b=O8v2LAsNOZl54taIipL+14hZYss8r4ts13aWhauQmv97h1oh6tFInkXJBQ8DDxzfor
         LIDjLTw+uvC60L3HHVTikhabyNSTbqfjhLZHFmLIGE5co7xj0SFrmS0YvwIIfdxWWAbC
         RXTSyccMdPgbJhoU2TIp8y+VQaER4K5DHxHUmffmyRDvehMMTqh9+P1I3Meobjn2EO7Y
         6Q/Xfr1WEbRDdjZexWYAdkNU6vFl4zGT83WNulIaS21WZY9Wc195xDzLVHMZ2+RrElvS
         xCtftL7OaD+Y6NyDT464lURJ6VbuTIsGg2FsKfVGm0aOAvn7zG7RQS2Fj7mohkaDvDKz
         kt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFcvTQogy7Mo0rOVJpnyL0BQpY03Kba3KtoBQO4aBoE=;
        b=QqaFVckaUw6E7Lg+IN5zXnVa+2jdza9jQHem3xEzIcct3aRjKVK1RvPAosElg+twX1
         eD16Ya8OIJ3RfMfbuf3JkZtR3u7Sb1xStJbbBYeyAnFhOcHzP7SnM83DlcXGRjRhgjiA
         cPerDWY/iOyIixR5sYWr3dT/icktXeISpwkubVZcfMZwA3qebEDqgHHGJLlxYfBCwjQO
         LV2mEegl3ba2rAs4z9rC5rXKvyQbbguuU1bQvexzvuLUJp496rS1eGZ8ntbWV9uy1WsC
         wn5R6NL5vsRWizf0njOu7mTRPoPHk1Pi7JPFey/EQyB6pU4g1pgeY3mK1Ukggl3G8Kbj
         mTyg==
X-Gm-Message-State: AOAM533busHbmASN4xH4qd3jffPYMmU9VZZMrEqc+DqnYOQDfAvFEUyk
        XQozR7EPfyhzZ9RHDCmdPNqLr9eU9cw=
X-Google-Smtp-Source: ABdhPJxmOAs8OIMDnrXWQHQEsvV81Xt4HI7F9kjLQPpxeNXqsqayiQ0TIF1f5OQLCWid/puYpr9Xgg==
X-Received: by 2002:a17:906:c114:: with SMTP id do20mr17443161ejc.401.1639068584739;
        Thu, 09 Dec 2021 08:49:44 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:44 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 14/36] libsepol: reject invalid filetrans source type
Date:   Thu,  9 Dec 2021 17:49:06 +0100
Message-Id: <20211209164928.87459-15-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
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
index a3d34d30..25ffa07c 100644
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
2.34.1

