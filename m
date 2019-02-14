Return-Path: <SRS0=aI9x=QV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771EBC43381
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 19:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437C821B24
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 19:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YFFmRLzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfBNTHc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:07:32 -0500
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:2142 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395480AbfBNTHb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Feb 2019 14:07:31 -0500
X-EEMSG-check-017: 199700140|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2019 19:07:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550171244; x=1581707244;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T8aHGyYofku5/W7mtES06C5W7CiWS1RvVyT0XmSJsNk=;
  b=YFFmRLzv3M8Wi01Fbt0ZfwnMjuWyHTg/nGb4woJW9oxHL1jBTq2TAyEf
   IRqkl2vTsYbKrbFZgAb9ck3K758NSchyln6sj2Jcx47ltPfeXEDRxU9gr
   93a+RcKvBGmameofXBYV6k49cKQi7qBRzUYKVn35dY2T1D8nhxozqlPbO
   nlG8VSwFlBJQdblD3YIVRdaSklroi1r8aE+ya/VT6MQqJZTFynmN8+YY3
   J0waXSKjRS90mQDVyafZ928/8EkGc8NpKaofQ4XJQKP79MlWYAmdKYFQf
   EqiZq6xlt3YTR0AMLAwjQ6An8X8hhGrS0hdR4gJHPoViXJwGCN3YwwpuC
   g==;
X-IronPort-AV: E=Sophos;i="5.58,369,1544486400"; 
   d="scan'208";a="23947043"
IronPort-PHdr: =?us-ascii?q?9a23=3AaduQfxLJf6TgNPVssdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeKPnxwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9Qr4uWT?=
 =?us-ascii?q?Sm8qxlVhnmhikaPDI96W3bl9B8gKddrRm8pRJw3pTUbZmVOvRgY63Tc9AUS2?=
 =?us-ascii?q?1OUcheTCFNHoCxYpETA+cbIepUs4/wrEYOoxukAgmsAfvixCJUhnDoxa060/?=
 =?us-ascii?q?ouEQfb1wI9GtIBqnDUrNHrO6YSTOu4y7LIwijYb/5NxTf86JTHchAmof2WW7?=
 =?us-ascii?q?JwatDexVMgFwPCkFWdsIroNC6b2OQKtmiU9etgVeS3hm4oqgFxvjivxto3hY?=
 =?us-ascii?q?XTmo0VzVXE+CNky4g2Pd21UFN3bNGrHZdKtyyWKpF6Tt0tTm12oio217sLso?=
 =?us-ascii?q?OhcicQ0pQo3RvfZuSCc4iP/x3sSv6cISx9hHJ5YLK/gAuy8VS4xu38SMa01F?=
 =?us-ascii?q?FKozJZktbWrHAN1gHT6tOdRvth/kauxTaP1wfJ5uFCPU80jrbUJ4Qkwr4xkp?=
 =?us-ascii?q?ofqUXDHinol0XqlKKaa0op9+ey5+nnf7nqvIGQOoBqhg3kL6gigsm/Dv45Mg?=
 =?us-ascii?q?gKUWib4+O81Lj78E3iXbpKleY7krXZsZ/GJcQbobS1AwlO0ok58Rq/ADCm0M?=
 =?us-ascii?q?oAkXkdMF1FYA6Hj5TuO1zWO/D3E/O/g1WqkDd2yPHLJaPhAprTIXjZirvhfq?=
 =?us-ascii?q?hy61RayAUtydBT/ZVUCqsOIPjrQE/+qMTYDgMlMwyz2+vnEM9y1p4aWW+UGq?=
 =?us-ascii?q?+WKr7SsVuR6uIqJOmMY5UVtyjnJ/c54P7uiCxxpVhIZaC02bMPYW28W/FhJF?=
 =?us-ascii?q?+UJ3Hrh4QvC2AP6zEiQfTqhVvKajtaY3K/Tupo/T0gIJ63BofEAIa2ifqO2z?=
 =?us-ascii?q?ntTc4eXXxPFl3ZSSSgTI6DQfpZLXvKLw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BSAADXu2Vc/wHyM5BaCh0BAQUBBwUBgVEIAQsBgVkpZ?=
 =?us-ascii?q?4EDJ4wgi3FNAQEBAQEGim2OWxSBZyAQCAGDekaDZSI0CQ0BAwEBAQEBAQIBb?=
 =?us-ascii?q?BwMgjopgyABOwuBUYJjPQGBZQ0PrByFRIR0iAOEQRd4gQeHQQKBLgEHCwFsh?=
 =?us-ascii?q?RMCiXuHS1qRDgmHOosODBmBblaEfoswAYtJhDSOGzhlcSsIAhgIIQ87gmwJh?=
 =?us-ascii?q?gGECIZpIQMwgQUBAY0Xgj4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Feb 2019 19:07:23 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1EJ7M54025481;
        Thu, 14 Feb 2019 14:07:23 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: fix userspace, refpolicy, and mailing list
Date:   Thu, 14 Feb 2019 14:07:21 -0500
Message-Id: <20190214190721.1074-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update the URLs for the selinux userspace and refpolicy releases,
and the email address for the selinux mailing list.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 README.md | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index cf90ef6..26784f8 100644
--- a/README.md
+++ b/README.md
@@ -79,12 +79,12 @@ integrated into the `coreutils` package, with support for the `chcon` and
 If the base distribution does not include the SELinux userland, then the
 source code for the core SELinux userland packages can be obtained from:
 
-* https://github.com/SELinuxProject/selinux/wiki/Releases
+* https://github.com/SELinuxProject/selinux/releases
 
 If the base distribution does not include a policy configuration, then
 the reference policy can be obtained from:
 
-* https://github.com/TresysTechnology/refpolicy/wiki/DownloadRelease
+* https://github.com/SELinuxProject/refpolicy/releases
 
 ### Optional Prerequisites
 
@@ -182,7 +182,7 @@ to help identify the cause.  When run by hand, the test script displays the
 expected number of tests, a status for each test, and any error messages from
 the test script or its helper programs.
 
-Please report any failures to the selinux@tycho.nsa.gov mailing list,
+Please report any failures to the selinux@vger.kernel.org mailing list,
 including a copy of the test summary output, the raw output from test scripts
 that failed, a description of your base platform, and the particular release
 of SELinux that you are using.
-- 
2.20.1

