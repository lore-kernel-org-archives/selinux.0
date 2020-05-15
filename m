Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3253AC433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E66206D4
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgEOVVk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 17:21:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:59016 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgEOVVk (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 15 May 2020 17:21:40 -0400
IronPort-SDR: ra18dRaDrNtlrt1V1GpVsuxp4mC8X5ns6UEO6srOuOZWOhI5j5UTciGwm4iBrSrRPht16bCO6H
 5YvS/h53lTIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 14:21:40 -0700
IronPort-SDR: 3+zaFP/sut+y3EhhdrUWSEs2Euohrh5nNG08OvU6d+MTJmO3iLK6P1lbLdnonth4vTu4ncdIDg
 GR8CEsfUkYXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="372807728"
Received: from unknown (HELO localhost.localdomain) ([10.254.99.175])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2020 14:21:39 -0700
From:   william.c.roberts@intel.com
To:     william.c.roberts@intel.com
Cc:     selinux@vger.kernel.org
Subject: [PATCH v3] README: update kernel-devel package in dnf command
Date:   Fri, 15 May 2020 16:21:32 -0500
Message-Id: <20200515212132.24204-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515173042.12666-1-william.c.roberts@intel.com>
References: <20200515173042.12666-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

The README.md file in the selinux-testsuite states that kernel-devel
package is needed. However, for everything to work you need the
kernel-devel package specific to your kernel version.
Update the dnf command to include uname -r, so that a copy + paste
of the dnf command, results in a system with dependencies filled
for recent Fedora distro's like Fedora 32.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 1f7e5d92a100..1bec9fe85c91 100644
--- a/README.md
+++ b/README.md
@@ -74,7 +74,7 @@ following command:
 		attr \
 		libbpf-devel \
 		keyutils-libs-devel \
-		kernel-devel \
+		kernel-devel-$(uname -r) \
 		quota \
 		xfsprogs-devel \
 		libuuid-devel
-- 
2.17.1

