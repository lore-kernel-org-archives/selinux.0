Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4ADC282CB
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 16:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7592083B
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 16:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="fhz4EAOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfBEQuL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:50:11 -0500
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:6558 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBEQuL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 11:50:11 -0500
X-EEMSG-check-017: 640369670|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,564,1539648000"; 
   d="scan'208";a="640369670"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Feb 2019 16:49:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549385375; x=1580921375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aOTSiAN2MkCjUynu+lXdWeOmMvW6fVL52FEGVIlP1dI=;
  b=fhz4EAOO5rIZZpBY7q/cdR4HYccTmwkxa3ZtrntoOnqAKKLv+yn/rXkv
   G0VJkbKpf+4EpwE8ONCppmzHM+NLknN5vN4RaKHjxgALRiT6EUAiTOHju
   1SluwdB/XyDJRx5QzJx9Na+G5PPezT5sAlHZLyFLtVZoRu786iie9TWIW
   1XyAhRtCwphDkRCGT1q6lgakMYq/tDvf8oQJoHql+EwiVOlQs0Uon0Le/
   62pGFuXvjQsIG1U93CJlGEOLDEWOlvv+avwykXMc84TgoPKfE6Upf5kIi
   8czd6P2SFRiFUQzQ5RBntQrwhn8QxDrZNYeCIGwuEexPOgsDb51cvuopm
   A==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539648000"; 
   d="scan'208";a="23519914"
IronPort-PHdr: =?us-ascii?q?9a23=3AQjrzfxJz82bFtGcoZtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeLv3xwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9Qr4uWT?=
 =?us-ascii?q?Sm8qxlVhnmhikaPDI96W3blNB8gKddrRm8pRJw3pTUbZmVOvRgY63Tc9AUS2?=
 =?us-ascii?q?1OUcheTCFNHoCxYpETA+cbIepUs4/wrEYOoxukAgmsAfvixCJUhnDoxa060/?=
 =?us-ascii?q?ouEQfb1wI9GtIBqnDUrNHrO6YSTOu4y7LIwijYb/5NxTf86JTHchAmof2WW7?=
 =?us-ascii?q?JwatDexVMgFwPCkFWdsIroNC6W2OQVq2WX8uVtWO21h2Mntg19uCajy8gyho?=
 =?us-ascii?q?XTm44YzE3P+z9jz4YvP9K4TVZ2YdujEJRNqS6XL5B2QsY+Q2FwvyY616EGtY?=
 =?us-ascii?q?a7fCcUzJQnwAbSa+CdfIiS4xLjSf2RLS1khHNlZL2/hxGy/VKmyuLgTcm7zE?=
 =?us-ascii?q?xGri9EktnIrnwN1hrT5dabSvZl40us1jmC2xrT5+1ZO0w4i6XWJ4A7zrItjp?=
 =?us-ascii?q?YTtF7MHi7ymEX4lq+WcUAk9/Cz6+v6ebXrvYOcNo9ohQH+NaQigMq/Af8iPQ?=
 =?us-ascii?q?QUUGib/vq82KX5/ULlWLVKkuE2kq7BvZDdIMQbobW5AwlP3Yk/9RmyFC2m38?=
 =?us-ascii?q?oFknkHNl1FZAiLgJTuO1HLOPr4F+uwg0ywkDd3wPDLJqbhDYvJLnjClrfhYL?=
 =?us-ascii?q?l85lVCyAo8099f/YhYCrIfL/LpXE/+qtjYAgU+MwyuzObtEM992Z8GWWKTHq?=
 =?us-ascii?q?+ZN7vfsUeS6eIyJ+mBf5cVtyzgK/gh/vLuiHg5mVgHfaa3x5cYdHe4HvE1a3?=
 =?us-ascii?q?meNGLln9MpCW4Xuk87S+vwhRuJVjsASWy1WvcH+jwjCI+gRbzGT4Spja3JiD?=
 =?us-ascii?q?y3BbVKd2tGDRaKCn6ueIKaDaRfIBmOK9Nsx2RXHYOqTJUsgFT07AI=3D?=
X-IPAS-Result: =?us-ascii?q?A2DlAQC5vVlc/wHyM5BlHQEBBQEHBQGBVAUBCwGBWimBN?=
 =?us-ascii?q?wEyJ5gTTAEBAQEBAQaKapBWIBgBhECDFCI3Bg0BAwEBAQEBAQIBbCiCOimDF?=
 =?us-ascii?q?QsBRoFRgmM/gXUNrRkzhUSEcYgChEEXeIEHiXGFEwKJaIdPWJBvCZIzDBmSR?=
 =?us-ascii?q?gGdaSKBVisIAhgIIQ+DJ4IoF448IQMwgQUBAY1zAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Feb 2019 16:49:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x15GnXQD018578;
        Tue, 5 Feb 2019 11:49:33 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: fix avc audit messages
Date:   Tue,  5 Feb 2019 11:49:32 -0500
Message-Id: <20190205164932.8472-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

commit a2c513835bb6c6 ("selinux: inline some AVC functions used only once")
introduced usage of audit_log_string() in place of audit_log_format()
for fixed strings.  However, audit_log_string() quotes the string.
This breaks the avc audit message format and userspace audit parsers.
Switch back to using audit_log_format().

Fixes: a2c513835bb6c6 ("selinux: inline some AVC functions used only once")
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/avc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 33863298a9b5..8346a4f7c5d7 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -674,13 +674,13 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
 	audit_log_format(ab, "avc:  %s ", sad->denied ? "denied" : "granted");
 
 	if (av == 0) {
-		audit_log_string(ab, " null");
+		audit_log_format(ab, " null");
 		return;
 	}
 
 	perms = secclass_map[sad->tclass-1].perms;
 
-	audit_log_string(ab, " {");
+	audit_log_format(ab, " {");
 	i = 0;
 	perm = 1;
 	while (i < (sizeof(av) * 8)) {
@@ -695,7 +695,7 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
 	if (av)
 		audit_log_format(ab, " 0x%x", av);
 
-	audit_log_string(ab, " } for ");
+	audit_log_format(ab, " } for ");
 }
 
 /**
-- 
2.20.1

