Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A445C43217
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829EC60EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhJKQ2a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhJKQ23 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BD0C061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z20so69827934edc.13
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lplp4nrdJoR0RZEqBm7YvdG3+pwtN0xfF2+Xd6xX3YE=;
        b=pnEz81ILGDIoH84kB5e1flC5WThgP5aM+vhW6ACyjCHQyO1Q3x24oRswXQZefqOpLf
         +L7QpijzmGAAKjG1Y7wOiRW6wjH3MmyzEkvTZrgIGMD4PWiQwoAi/W4qq7zzlX4RHbme
         7BRWj8jG/quPYSvdf00cybUwiqgLRTScAV4Iqgci71C8VQaL6XDFdxc3eUoLwJXhE3hd
         cp8BF1ruVMAT5aowjQUa/YW0x4gWW6tnDKwyhiCvL50fe9y6uLyn2XErDioFQoOtjdRC
         leBbLUXJ3vH6nc6S+cEReGTbZrEekPTFvL8HMzHWaaof1HLt+uu+VOJR+uhLihZw+Jmc
         G/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lplp4nrdJoR0RZEqBm7YvdG3+pwtN0xfF2+Xd6xX3YE=;
        b=JCt6wn0PILHKDooiVkfs/pOqqVv2rogFjJcpj+rDcSXl0fKGs9JBXPP8z4Tp6mNscV
         C19sBUKkZZ4Ptm1CKCyYlE/6JKQWoiyiPn1F0bopWI8HOT152kWaMs9K9ZBhe1Esh4LF
         FXhAmdbG9IPMIv6iQg+PL3x17cOzRC2Kfs4g0Vera0DqVIXi4LEO3wXWxmZ7CQgZA/0B
         OkkPtbAwpHixU8kzDD+WtOEim7G+z1vp9aMtYk1ZHfeyCk1wwVITIrBGE+2yh/AIWI2j
         KEmoLAI67uGY6ZYd6/gJafkR8d4zLiIBk5YgISLCtE5swUYzVOwIezX6YjF8We08uom7
         +eYQ==
X-Gm-Message-State: AOAM5311/AUaqwG31Wcgti+0wE/ViHWGqwaA6Qlwnl8w7nRlwPvwhwu2
        0GtSBd/QgYMlh/qWQEXvToS51lCxaKQ=
X-Google-Smtp-Source: ABdhPJy5DBzz8h/djt/JPnhx/RvjWrBLkma9jKz1NA1OB8AJpWP8HXiehqyhGaxB+ptAG8oNVAUEfw==
X-Received: by 2002:a17:906:660f:: with SMTP id b15mr27364950ejp.491.1633969587694;
        Mon, 11 Oct 2021 09:26:27 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 12/35] libsepol: clean memory on conditional read failure
Date:   Mon, 11 Oct 2021 18:25:10 +0200
Message-Id: <20211011162533.53404-13-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Free the local access vector list on failure as it does not get moved
into the policy structure.

    Direct leak of 16 byte(s) in 1 object(s) allocated from:
        #0 0x52596d in malloc (./out/binpolicy-fuzzer+0x52596d)
        #1 0x5b30d2 in cond_insertf ./libsepol/src/conditional.c:682:9
        #2 0x5ac218 in avtab_read_item ./libsepol/src/avtab.c:583:10
        #3 0x5b21f4 in cond_read_av_list ./libsepol/src/conditional.c:725:8
        #4 0x5b21f4 in cond_read_node ./libsepol/src/conditional.c:798:7
        #5 0x5b21f4 in cond_read_list ./libsepol/src/conditional.c:847:7
        #6 0x576b6e in policydb_read ./libsepol/src/policydb.c:4436:8
        #7 0x55a1fe in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:24:6
        #8 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #9 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #10 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #11 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #12 0x7f47abeb87ec in __libc_start_main csu/../csu/libc-start.c:332:16

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/conditional.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index 9a10aae1..50cb5395 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -724,8 +724,10 @@ static int cond_read_av_list(policydb_t * p, void *fp,
 	for (i = 0; i < len; i++) {
 		rc = avtab_read_item(fp, p->policyvers, &p->te_cond_avtab,
 				     cond_insertf, &data);
-		if (rc)
+		if (rc) {
+			cond_av_list_destroy(data.head);
 			return rc;
+		}
 
 	}
 
-- 
2.33.0

