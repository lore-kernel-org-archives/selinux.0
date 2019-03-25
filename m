Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A8EC43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 08:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7791620830
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 08:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfCYIF6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:05:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37462 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbfCYIF6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 04:05:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so7927310wmf.2
        for <selinux@vger.kernel.org>; Mon, 25 Mar 2019 01:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PcR1QBkNoiAmBRocGma/MllV/iXwsi82EaYy80ZwgYs=;
        b=WpQ9iPYVL/w7gH9RqJrCuzZ7JCpchiYYDeP3PTpZ6iXrd0QySTxTKfC1AZC3lYAdek
         Z9QdAXNsR/s9mDeTiJjlds80f2Ytn3hhIOxp1rDKA2oEYyX+qOPEB/W7qBrfd+95J7Gm
         yIBBUMZe8D4FOQpfXfW4nc1LXSZXuLP8EoMFiDsuMPwJIMjKpox0bMOCPSgkiBSSTNOw
         38Q51veQo0I7ND87dYa8g9V1YLX8J7q2eRZgbWnUqxWHu+oXW+TORilAUG23JZPRTdux
         lSVbPE7n+M60VAI751cb+cp+aMC38of1y8JADFK+gxqfb6aGHxAQE+0I/YH0IZ9B4jBE
         EMPw==
X-Gm-Message-State: APjAAAVED+CvAlf7hgJjfDI9RfXc2Bc9Y790ajPXXFRShOFlXlkCGd6X
        ffoRHrMrxScUGmcEwoeuhypu/D+QkkCFhA==
X-Google-Smtp-Source: APXvYqwSlVMt5qiHqwVXIYSdPb4Dr7j39pImsILBmzmomuHOr92UzaYAXgY4K4P6ExwvpQzTevKD7A==
X-Received: by 2002:a1c:1d81:: with SMTP id d123mr4261572wmd.59.1553501156251;
        Mon, 25 Mar 2019 01:05:56 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s12sm14151530wmj.42.2019.03.25.01.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 01:05:55 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, kbuild-all@01.org,
        Ondrej Mosnacek <omosnace@redhat.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] LSM: lsm_hooks.h - fix missing colon in docstring
Date:   Mon, 25 Mar 2019 09:05:35 +0100
Message-Id: <20190325080535.19475-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <201903211834.Qtb0LJ32%lkp@intel.com>
References: <201903211834.Qtb0LJ32%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Apparently without it it is incorrect syntax and causes a warning about
undocumented struct field.

Fixes: b230d5aba2d1 ("LSM: add new hook for kernfs node initialization")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hooks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0dd5bda719e6..b987dc282d63 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -447,7 +447,7 @@
  *
  * Security hooks for kernfs node operations
  *
- * @kernfs_init_security
+ * @kernfs_init_security:
  *	Initialize the security context of a newly created kernfs node based
  *	on its own and its parent's attributes.
  *
-- 
2.20.1

