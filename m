Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA48C33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 15:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C712081E
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 15:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="XoDCa2aE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgAGPoS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:44:18 -0500
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:31083 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGPoS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 10:44:18 -0500
X-EEMSG-check-017: 63384113|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="63384113"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jan 2020 15:44:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578411855; x=1609947855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=td1IlHwKtTHObDpe2uWJl6Ms76XtUpY7stdlViMvWFQ=;
  b=XoDCa2aErjmnE7yOuiS88A79umsCaSaziaSZHfKKJhJj8t2fJVa3R/8K
   iAN7MYjXd29i3ozc5ILmIPHXmH/cOzJHW2s/kB29KBvqj9oCxLahruLjS
   2PuMgYhjqSofquE9Q/BBDXhmlPxrmB01hWdHzW4YLqnJtGQifya4MpZ3u
   gJHCbQ7rPu5vloLCUQsYdwLaD5oOBQeFLMJlpjy1WczVd1Cr1iKKDb5Qh
   d9iAPhcmCUBsZ070C+EAxyraTsrKY32rvHE1d3wpITBivBIWtJLNgP/7D
   GB/1WDnQQieb3JPZHF2ROlkp48HawzsbWIOrvwvbZuJzkq4WnAv4leIS3
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="31672195"
IronPort-PHdr: =?us-ascii?q?9a23=3AWOcY8hzVigjDbwPXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2u0fIJqq85mqBkHD//Il1AaPAdyAragZ16GN6ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe61+IRW5oAneuMQanJZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxDmkicHMyMy/n/RhMJ+kalXpAutqhx7zoLRZoyeKfhwcb7Hfd4CRW?=
 =?us-ascii?q?RPQNtfWSJCDI27YIQBAPEMMfpbooTnu1cDtweyCRWqCejyyjFInHj23agi3u?=
 =?us-ascii?q?o8DQHJwhQgH9IQv3TSsd77KaISXvqxzKnM0zrCb+5d1DDm6IfVaRAsuu2MXL?=
 =?us-ascii?q?JsfsrRzkkjDQXFjk6KpoD/MDOV0foNvnGd4uF9Vuyvk3Yqpxx+rzWg3Mship?=
 =?us-ascii?q?TFipgLxl3L6yl12ps5KNulQ0Bhe9GkCoFftySCOotzRcMtXn9ntT4hyr0DpZ?=
 =?us-ascii?q?67ZC8KyIk7xxLHa/yIbYyI4hX7WeaNOzh4nnNleK+khxqo8EigzOP8Vs6v0F?=
 =?us-ascii?q?lUsiVJiMXMt3AR2BzT7ciLUP198Vu62TmTzQzT7+BEIUQsmaraLZ4u3KIwm4?=
 =?us-ascii?q?IOvUnMESL6gkX7gLKMekk69eWk9f7rbqj+qp+ZLYB0iwX+Mqo0msy4BOQ1Kh?=
 =?us-ascii?q?MOUHWA+emnyL3i/VH2QLVNjvEslKnZq4rVKd4Upq6+HQ9Zypwj5AqnDze6zN?=
 =?us-ascii?q?QYmmEKLFZEeBKBkojoNEjCL+3/DfijmFmsjjhryO7cPrH7AZXCMGLDkLH/cr?=
 =?us-ascii?q?Z58UJczxAzzd9H7ZJOFr4BOO7zWlP2tNHAEhA5NBa0zP35B9VhzY4eXWyOAq?=
 =?us-ascii?q?mDPKPUr1CI+volI/OQa48NpDb9N/8l6ubpjX88nl8dZq+p0oELZ3+mBflmOV?=
 =?us-ascii?q?uWbmfsgtgbDWcGpBYxTOvviFeaSz5ce26yX74g5jE8EI+mFpnMRoSsgLyHwS?=
 =?us-ascii?q?e6EYZbZn5JCl+SC3fkbYaEVOkWaCKUPMBhliYIVb+7S48uzRuurhP1y6J7Lu?=
 =?us-ascii?q?rI/S0VrYrj28Jo5+3Xjhwy7SZ7D9mZ022USmF0mWQIRyUo06xlvUN9zVKDgu?=
 =?us-ascii?q?BEhKlAHMFXz+tATwN/MJnb1eE8ANf3CSzbedLcc0qrWtWrB3kKS9s1x9IfKx?=
 =?us-ascii?q?JmF86KkgHI3y3sBaQc0bOMGspnoernw3HtKpMlmD793647ggxjH5pC?=
X-IPAS-Result: =?us-ascii?q?A2CRBADmpRRe/wHyM5BmHgELHIFxC4F9gW0gEiqNDIZsB?=
 =?us-ascii?q?oslj02BewkBAQEBAQEBAQEbHAEBhECCDzQJDgIQAQEBBAEBAQEBBQMBAWyFQ?=
 =?us-ascii?q?4I7KYMzAUaBUYJjHhcKglMlrgWJAIE9gTaHQIRzeYEHgRE2gxuKFSIEjTqKJ?=
 =?us-ascii?q?ZdAgkCCRZNLDBuaXgGrLjmBWCsIAhgIIQ+DJ1AYDZt2IwMwjl0BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Jan 2020 15:44:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 007Fhbsp114828;
        Tue, 7 Jan 2020 10:43:40 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] Documentation,selinux: fix references to old selinuxfs mount point
Date:   Tue,  7 Jan 2020 10:44:50 -0500
Message-Id: <20200107154450.25961-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selinuxfs was originally mounted on /selinux, and various docs and
kconfig help texts referred to nodes under it.  In Linux 3.0,
/sys/fs/selinux was introduced as the preferred mount point for selinuxfs.
Fix all the old references to /selinux/ to /sys/fs/selinux/.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++----
 security/selinux/Kconfig                        | 7 ++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..565d84760e48 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -511,7 +511,7 @@
 			1 -- check protection requested by application.
 			Default value is set via a kernel config option.
 			Value can be changed at runtime via
-				/selinux/checkreqprot.
+				/sys/fs/selinux/checkreqprot.
 
 	cio_ignore=	[S390]
 			See Documentation/s390/common_io.rst for details.
@@ -1245,7 +1245,8 @@
 			0 -- permissive (log only, no denials).
 			1 -- enforcing (deny and log).
 			Default value is 0.
-			Value can be changed at runtime via /selinux/enforce.
+			Value can be changed at runtime via
+			/sys/fs/selinux/enforce.
 
 	erst_disable	[ACPI]
 			Disable Error Record Serialization Table (ERST)
@@ -4349,8 +4350,8 @@
 			0 -- disable.
 			1 -- enable.
 			Default value is set via kernel config option.
-			If enabled at boot time, /selinux/disable can be used
-			later to disable prior to initial policy load.
+			If enabled at boot time, /sys/fs/selinux/disable can
+			be used	later to disable prior to initial policy load.
 
 	apparmor=	[APPARMOR] Disable or enable AppArmor at boot time
 			Format: { "0" | "1" }
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 580ac24c7aa1..1014cb0ee956 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -58,7 +58,8 @@ config SECURITY_SELINUX_DEVELOP
 	  kernel will start in permissive mode (log everything, deny nothing)
 	  unless you specify enforcing=1 on the kernel command line.  You
 	  can interactively toggle the kernel between enforcing mode and
-	  permissive mode (if permitted by the policy) via /selinux/enforce.
+	  permissive mode (if permitted by the policy) via
+	  /sys/fs/selinux/enforce.
 
 config SECURITY_SELINUX_AVC_STATS
 	bool "NSA SELinux AVC Statistics"
@@ -66,7 +67,7 @@ config SECURITY_SELINUX_AVC_STATS
 	default y
 	help
 	  This option collects access vector cache statistics to
-	  /selinux/avc/cache_stats, which may be monitored via
+	  /sys/fs/selinux/avc/cache_stats, which may be monitored via
 	  tools such as avcstat.
 
 config SECURITY_SELINUX_CHECKREQPROT_VALUE
@@ -85,7 +86,7 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
 	  default to checking the protection requested by the application.
 	  The checkreqprot flag may be changed from the default via the
 	  'checkreqprot=' boot parameter.  It may also be changed at runtime
-	  via /selinux/checkreqprot if authorized by policy.
+	  via /sys/fs/selinux/checkreqprot if authorized by policy.
 
 	  If you are unsure how to answer this question, answer 0.
 
-- 
2.24.1

