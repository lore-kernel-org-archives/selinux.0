Return-Path: <SRS0=Lh2G=7C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C66FC433E1
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 15:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073B8206F1
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 15:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgETPZ7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 11:25:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:54150 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgETPZ4 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 20 May 2020 11:25:56 -0400
IronPort-SDR: yKTvXD9LgL1EbKhG8KOOIuN0tlXNyTOF/WTVCD8Yay1HMbmxLKGzqf7K3DiviLOy2zKiVTYO+v
 7+r8fkGkflsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 08:25:44 -0700
IronPort-SDR: qRwSzJ7DAjLy2g+7TEioQUAsS+nUHl1m+k5Qu2tVi+o8vq1KCPt2tLDX3+1XXTn+3YvhPBOoSt
 9FkT6USTWTqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="255047564"
Received: from wyueh-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.255.231.134])
  by fmsmga008.fm.intel.com with ESMTP; 20 May 2020 08:25:43 -0700
From:   william.c.roberts@intel.com
To:     selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] README: Add kernel-modules for SCTP
Date:   Wed, 20 May 2020 10:25:38 -0500
Message-Id: <20200520152538.23184-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Some Fedora images, notably the Fedora 32 cloud image, do not have the
kernel modules package installed by default. Thus SCTP isn't available.
Add the proper kernel-modules package for the running kernel.

Note: This applies to selinux-testsuite.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 README.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 1bec9fe85c91..1a4c70c40d56 100644
--- a/README.md
+++ b/README.md
@@ -77,7 +77,8 @@ following command:
 		kernel-devel-$(uname -r) \
 		quota \
 		xfsprogs-devel \
-		libuuid-devel
+		libuuid-devel \
+		kernel-modules-$(uname -r)
 
 #### Debian
 
-- 
2.17.1

