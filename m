Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F879C54E7E
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB8521841
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6Jp5DX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEHPmh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgEHPm0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:26 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F6C061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:26 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b1so801788qtt.1
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0meoboseqO03Hr9Mio+DICdbqDpITH6inUJXkgltF/0=;
        b=h6Jp5DX74l184KC0sdwmAP7m05WI4SDjhqBeGuBMAdgoAactDrlqeNzYWkzW3zTTHx
         AMYo7RVNs1dk+lz8FdOhjpEYU7M9PlxU5xhMiYkIfLtJg7z7eeeFPKxd35T45PXEf6RE
         1XRBWiWf4vgyhAHmkcl+QwAReAn57BmVCx443Xf+bd8+HHiwtOor1s3FWh6gYprLFIOr
         e45xGq/uPkVxQSlnc5q4BIs5RAjSPPn6ef4O36rR2jmbEYsnAEorlCgmViWUV/ZEaXd1
         jPZB1IAUjdxlm6gzfqDWGSuoxGggKcXOwp5B/VxPdYNdRmxXelz95FVsft2sHlq723FY
         58yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0meoboseqO03Hr9Mio+DICdbqDpITH6inUJXkgltF/0=;
        b=mJwSWpL9ludxX+iuleXZ6gpuBGuhLL9pYa/S4xGl0ermGKo6NQGpgdgYhRupHol+zx
         3Df9EssN4N9ap8YyqMvrfNVmMl3BiWGXRtoGTUgg2TxIhgUdS32lBozNAFZzE/Yf6R3m
         dU2SxK+uSRA208ixrsT1WhSVRfmHIR8WNELVxt+oiEsRuwIz4r8rqg2mBHRZpPU12/Hr
         Lqiw6x8nbHhxfValFPnJc84euU6caX7jN37m7R0T4vRWzRRUl5vZNo7K+Zr20Xxc/YYm
         NwD/u2cA892JUhDU8rRU7OZa+lpRv6B3UeRdNPAoItqoCB7zzzlZ6KnW4/ALYvvksZ/7
         0itw==
X-Gm-Message-State: AGi0PuZyEpLank4ufIETNFlzRjn1bcyRxgg26aebU+il2GGpnBF5asRu
        Zxs7EYIBZhJW//WhF9XpnSEo+7a6
X-Google-Smtp-Source: APiQypJrEKEQFh5HRTGQ62RlkRVS+Oi+B6RyKDcxSZuJI3Oh4LM8R5FdY3CWb/Ay2epHHWMgEGBVnA==
X-Received: by 2002:ac8:4897:: with SMTP id i23mr3772068qtq.184.1588952545588;
        Fri, 08 May 2020 08:42:25 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:24 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 10/15] policy: Add defaultrange rules for overlay tests
Date:   Fri,  8 May 2020 11:41:33 -0400
Message-Id: <20200508154138.24217-11-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Some of the overlay tests assume that files inherit their MCS/MLS
labels from the parent directory rather than the process.  This is
true on Fedora which defines defaultrange rules for this purpose but
not in refpolicy.  Add the defaultrange rules explicitly to the test
policy as a CIL module to provide consistent behavior on Debian.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/Makefile                      | 2 +-
 policy/test_overlay_defaultrange.cil | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 policy/test_overlay_defaultrange.cil

diff --git a/policy/Makefile b/policy/Makefile
index 8f43427..17e9da3 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -36,7 +36,7 @@ SUPPORTS_CIL = n
 endif
 
 ifeq ($(SUPPORTS_CIL),y)
-CIL_TARGETS = test_mlsconstrain.cil
+CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
 ifeq ($(shell [[ $(MAX_KERNEL_POLICY) -ge 32 && $(POL_VERS) -ge 32 ]] && echo true),true)
 # If other MLS tests get written this can be moved outside of the glblub test
 ifeq ($(POL_TYPE), MLS)
diff --git a/policy/test_overlay_defaultrange.cil b/policy/test_overlay_defaultrange.cil
new file mode 100644
index 0000000..d1c18db
--- /dev/null
+++ b/policy/test_overlay_defaultrange.cil
@@ -0,0 +1,7 @@
+(defaultrange file target low)
+(defaultrange dir target low)
+(defaultrange lnk_file target low)
+(defaultrange chr_file target low)
+(defaultrange blk_file target low)
+(defaultrange sock_file target low)
+(defaultrange fifo_file target low)
-- 
2.23.1

