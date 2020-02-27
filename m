Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0679CC3F2C6
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 22:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6170246A1
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 22:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdRJ0xNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgB0WrR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:47:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36884 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgB0WrR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 17:47:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so438773pgl.4
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 14:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iw+fQiJKcr1mJeeZ2eFCadPICQqWKug3kWzDCk6Shlg=;
        b=qdRJ0xNaQvBOq7rbUVC0DGF71V2XiPGXycfbNURUu94/Yo5/BWo7op+U8oMjJqzOGo
         NKBKXh0I2hoqTvuoTU80BPTU9Bnkz2i1zf3YONEgwSDiir/hVI/BWcFEguIoZVnvD/yK
         5VNLx7/IJh5BSh2POO9BKVZ41GsbqhoXvdSYiR6mdMKqJnuGlZMrgvwdVkB+t3VJBppu
         eeAE6iAfQ0yQra6RW4XOC/THMU4+7lpRRs6aQjvQ/FE/hzq/JalUIbP1xfSkIo4k/GtI
         R04MT2MqCsNIT7I26rKvDvFTx6NocdVCpfg/kupx+BhXChv0GwBqVJzrXsMBNvCRmo77
         9LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iw+fQiJKcr1mJeeZ2eFCadPICQqWKug3kWzDCk6Shlg=;
        b=Q1fcjRFxIe++/6u2Ls69+CrmsW0NOYAJyHmQRkhEuJ+EpN6Sa1ny9bjUdsoBigPkFD
         bmJjBgkgpQLK/wzeI6w17BGWUEtKQ+4DG1pBLyHOsY5VSVGFU9fmdLtDLyydcSg8wpRf
         AAO1aUya/2qZlwlhw/vo8P4bhFfqyoiesnoI3zW1AcRh3j5uGOCC+Ue3IkiOZkECJjrp
         PgJiAlexAio0FzRa22y6Zd4JNtzm+YCyL6bOwGLqHasBdY8w+oFiB7NVuOc/gbIDwijw
         bAtEzzwdb5Z6qOFLfGIYmzv5REM2pNWOb1wH1x03Q+T29upIH03aCtY28op5FcNNrLcd
         t7gg==
X-Gm-Message-State: APjAAAXFUPhkuj1sJvHKH5Z8KU8s6lp4UhwVXv4IZMDwyPtF0zHsNvjW
        Rt7aChoonH51tVp0I3Jra1PU9l7z
X-Google-Smtp-Source: APXvYqxVAU2T6kOwds1uegYvLYeRtoLlnh25Mc6hmhNyy5zXGDThnnRInpaBc76qF+pZYAd6x6C/gA==
X-Received: by 2002:a63:131f:: with SMTP id i31mr1576887pgl.101.1582843635729;
        Thu, 27 Feb 2020 14:47:15 -0800 (PST)
Received: from localhost.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id w11sm8245960pfn.4.2020.02.27.14.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 14:47:14 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] libsemange: add missing header sepol/policydb.h
Date:   Thu, 27 Feb 2020 16:47:06 -0600
Message-Id: <20200227224706.29892-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Fix below compilation issue:
direct_api.c: In function ‘semanage_direct_commit’:
direct_api.c:1466:13: error: implicit declaration of function ‘sepol_policydb_optimize’; did you mean ‘sepol_policydb_to_image’? [-Werror=implicit-function-declaration]
    retval = sepol_policydb_optimize(out);

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsemanage/src/direct_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 1088a0ac6165..92f0a17b0156 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -23,6 +23,7 @@
 #include <sepol/handle.h>
 #include <sepol/cil/cil.h>
 #include <selinux/selinux.h>
+#include <sepol/policydb.h>
 
 #include <assert.h>
 #include <fcntl.h>
-- 
2.17.1

