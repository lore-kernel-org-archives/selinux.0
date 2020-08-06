Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA45CC433E0
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 16:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370DF2086A
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 16:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/9jxcsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgHFQw3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbgHFQvD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 12:51:03 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671BAC0A889E
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 07:50:14 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p25so4670082qkp.2
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48+7DHkL90+0u+P7hsR0hg8O3/7hsYxqJczfzF0Shbc=;
        b=d/9jxcszAA3vqgWX2ieEsduNpsdCHcPbIl84c2Fq0sExlqm25LQMFlwjxUQ3OTXzRr
         VDeLryGPACTLY3Yqt1F2FcKTRUkSKLGjp4cfNYVTX6sL2uh3nW+l3Q4Ko4bHHWnsbJ32
         p+Wf9WiQdsv0TbQT3yQQpgNofMlGLvEzdu0Zd915kDhzkDdigufL0P2lTZ0+PcnT6exm
         JHj+H+/vWWXbAxE/t7jfmg7Sqo8wPScuSaR9SVB6eza5AY5GJifsWzvuuEaypx1LOx2f
         QM73qlId3oBxql4k0Hby9oLZFqxqJIw6FehxAQT/u388+oTqv60zgZJ5882z7+tOJtsS
         97JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48+7DHkL90+0u+P7hsR0hg8O3/7hsYxqJczfzF0Shbc=;
        b=Q6wrUelaiLVE8jO5+ARmp1r7twoTUO8/ZNcdqmWLBE8pTAl0xlK+EV3nsAAJyLCqck
         DG0WmFTJeV6mFdFqHaz7GegOvAIc9FXfytbqm3izihrrzH1+Hxc2uEBjE5esPPEuD84p
         XKENkvD3WLzcYODIAHLsGnbZ1SGG3w3NefxeJyhFxMLSBUV+wiigerQ/44KizLe8s/jl
         SRVJxK6zPXFZ49hGhrMVT2UxgJAsH3RIv+hRzftDN0AB2laIU77ziKR7xe52U/hwHAxO
         vWqThhoKzVmtxZ3nEm8vwpsauI3bkeKJR6P9RZckSqYy9vjHEJjr/D/HSY0NS7tSxClF
         9KmQ==
X-Gm-Message-State: AOAM5326tEGSfHc+wPNS+jm5zygn2+kfqDxKNQRqkIm5uUbpnGDu/JX+
        7b2e2Tauy593viB9W2jDE/BnQfbt
X-Google-Smtp-Source: ABdhPJyVTO+0zErFrlMGIkGxRmjTJoatrtqc+FkeQKKzlGyFzgaCLJB5ZalWkSvGf5nSa8ln4zkfyw==
X-Received: by 2002:a37:8c02:: with SMTP id o2mr8392451qkd.461.1596725413357;
        Thu, 06 Aug 2020 07:50:13 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id z14sm4805830qtn.92.2020.08.06.07.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 07:50:12 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: fix build order
Date:   Thu,  6 Aug 2020 10:49:46 -0400
Message-Id: <20200806144946.42125-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We need to install the include files before we try to build the source.
Otherwise, make DESTDIR=~/obj install can fail if there are older
headers under /usr/include.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 16531fe9..6a43b243 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -1,4 +1,4 @@
-SUBDIRS = src include utils man
+SUBDIRS = include src utils man
 
 PKG_CONFIG ?= pkg-config
 DISABLE_SETRANS ?= n
-- 
2.25.1

