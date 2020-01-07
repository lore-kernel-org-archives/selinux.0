Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA62C33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 16:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D812087F
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 16:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="c3SfWxHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgAGQe3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:34:29 -0500
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:13653 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgAGQe2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 11:34:28 -0500
X-EEMSG-check-017: 63425745|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="63425745"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jan 2020 16:34:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578414867; x=1609950867;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j1H0EUqfk9QhhRoQ1hxpf+n7LkYwwZNy8OQ54/iClc0=;
  b=c3SfWxHL42Tx6NaZDgIRNh3C3TvX1Fvw4ntDSmVBn/f5VC9Y7eyRel/j
   0pBNg6gwTbCUZHgQhpxY6OcghxcpPNMphArYuz2t9/SUXHJOpjs1qYY6+
   6Z88gDpy+1djxUHYFv9DipVBgA1hOkhN2ElHHOhDTCit0EPgphz7PsMdj
   JymjCg0deBVzEJahL+fFtKtF8WRoBnpTTRHe9/VPgJodBYJ/r1RVnlc/x
   PiuLCXclBkoc/bS50sKs4J0G0Fg3CswSEPp1TV/W9V8ScrwABNc6O+RQC
   GLFxOVruWuMdt6/q7j90zIegcquUV466x6nOL1fqYeGFk8rW5DjaNHYfn
   g==;
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="31676773"
IronPort-PHdr: =?us-ascii?q?9a23=3ATDp4YRUn3fylz7i36fskHnhxlinV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbROOt8tkgFKBZ4jH8fUM07OQ7/m7HzZdvd3d6jgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajIttJ6o+xR?=
 =?us-ascii?q?bFvGZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+27ZkMxwiL9QrgynqRJx3oXYZJiZOfp6c6/Ye94RWG?=
 =?us-ascii?q?hPUdtLVyFZAo2ycZYBAeQCM+hfoIbzqEADoQe9CAS2GO/i0CNEimPw0KYn0+?=
 =?us-ascii?q?ohCwbG3Ak4EtwTrHTbss31NKcMXuCz0aLG0DDDYOlS2Tf59ofJcg0qrPaXXb?=
 =?us-ascii?q?1tasrc0lUvFgPZgVWQrozpJTWV1v8XvGSB4OpgUvyvhnchpgpsoTav3t8hhp?=
 =?us-ascii?q?TGi48a0FzJ9Th1zJwrKdC3VkJ3e8OoHZ1NvC+ALYR2WNktQ2RwtSY/zb0JpI?=
 =?us-ascii?q?C0cTARyJQi2x7fc/uHc5WU4h77VOaePzN4hHV9dbKjnRmy60mgyvDnVsWu0V?=
 =?us-ascii?q?ZKqCRFkt7Xtn8TyxPf8NSHS/th8Ueh3jaDzQbT5f1fIU8oj6bbLp8hwroomp?=
 =?us-ascii?q?oSt0TMADP2lV3rgKKZeUgo4Oil5/n9brn4qZKQKZV4hhzmPqQrgMO/AOA4Mg?=
 =?us-ascii?q?YUX2ic/OSxzKbj8lDiQLhRkv03krXWsJDdJcgBoK65GBVa3pws6xa4ETeqyM?=
 =?us-ascii?q?4YkmUfLFJZZBKHiJDkO1XPIPD+EPe+jE2gnypsx//aJbDhHJrNIWbZkLv7fr?=
 =?us-ascii?q?Zy9VRcyAwtwtBb/Z5UDasBIP3rUE/rqNPYFgM5MxCzw+v/FNp90ZkeVnmRDa?=
 =?us-ascii?q?+FK67StVGJ5uQ1L+mKeoAVpC73K+I56P72kX85hVgdcLGu3ZsSb3C4BfJmLF?=
 =?us-ascii?q?+FbnXymdoBC3kFsRc+TOPwlF2OSyJcZ3G3X6gk/DE0FJqmDZvfRoCqmLGBxz?=
 =?us-ascii?q?m0HplXZmBAF1CNHmzld5uLW/gSciKeOMxhnSIeVbinVYAh0QuitAjgy7poNu?=
 =?us-ascii?q?DU4DEXtYr/1Nhp4O3ejQky+iZpD8SZyGyNV3t7nn4MRzMv2aB/pkt9yk2d3q?=
 =?us-ascii?q?Rin/NYEtlTtLt1VVIiPIPY5/RzFtS3XwXGZNrPQ1GjEfu8BjRkdc48298DZQ?=
 =?us-ascii?q?5GHtymih3Sl36xD6Q9i62ABJty9LnVmXf2OZAumD79yKA9ggx+EYN0Pmq8i/?=
 =?us-ascii?q?s6qlne?=
X-IPAS-Result: =?us-ascii?q?A2BPAACgsRRe/wHyM5BmHQEBAQkBEQUFAYFoCAELAYF8g?=
 =?us-ascii?q?W0gEiqMLGCGbQaLJY9NgXsJAQEBAQEBAQEBGxwBAYRAgg80CQ4CEAEBAQQBA?=
 =?us-ascii?q?QEBAQUDAQFshUOCOymDMwFGgVGCYx4XCoJTJa4tiQCBPYE2AYc/hHN5gQeBE?=
 =?us-ascii?q?TaDG4oVIgSNOooll0CCQIJFk0sMG4JHmBcBkBubEzmBWCsIAhgIIQ+DJ1AYD?=
 =?us-ascii?q?YlRkiUjAzCOXQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Jan 2020 16:34:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 007GXmxc143023;
        Tue, 7 Jan 2020 11:33:52 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] Documentation,selinux: fix references to old selinuxfs mount point
Date:   Tue,  7 Jan 2020 11:35:04 -0500
Message-Id: <20200107163504.29769-1-sds@tycho.nsa.gov>
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
While we are there, update the description of the selinux boot parameter
to reflect the fact that the default value is always 1 since
commit be6ec88f41ba94 ("selinux: Remove SECURITY_SELINUX_BOOTPARAM_VALUE")
and drop discussion of runtime disable since it is deprecated.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 ++++-----
 security/selinux/Kconfig                        | 7 ++++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..eed51293d6cf 100644
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
@@ -4348,9 +4349,7 @@
 			See security/selinux/Kconfig help text.
 			0 -- disable.
 			1 -- enable.
-			Default value is set via kernel config option.
-			If enabled at boot time, /selinux/disable can be used
-			later to disable prior to initial policy load.
+			Default value is 1.
 
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

