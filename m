Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA64C46466
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 12:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A75D2077C
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 12:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A75D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJKUC0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:02:26 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:4588 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeJKUC0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 16:02:26 -0400
X-EEMSG-check-008: 634564353|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,368,1534809600"; 
   d="scan'208";a="634564353"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Oct 2018 12:35:21 +0000
X-IronPort-AV: E=Sophos;i="5.54,368,1534809600"; 
   d="scan'208";a="19290037"
IronPort-PHdr: =?us-ascii?q?9a23=3A4hJ9PhYUFcRZ/IpyotobFuX/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMiybnLW6fgltlLVR4KTs6sC17KJ9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa/bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?us9adrTALjhjkBOTA37WrbjtV8gLxHrB6koRF03ozab5yPNPdmfq3TY84US2?=
 =?us-ascii?q?RCUMhWVSNBDJixY5cTA+cbIepVtZXxq0cIoBCjBQesHuTvyjpQi3Hyx6I61v?=
 =?us-ascii?q?ouERrb1wE+Bd0OqmjUo8vvNKwPVu21zqfJwinZYPNMxTfx9pPFcgwhoP6QXb?=
 =?us-ascii?q?JwdtDdyU80FwzflFmQpovlPy2M2+kLrmOV7PJgWPqyh2MopAx9uDiiyto2ho?=
 =?us-ascii?q?XXiY8Z1ErI+Th/zY0oP9O3UlR7bsShEJZIsiGaMJZ5Td06TmFzvSY61qUGuZ?=
 =?us-ascii?q?mmfCgW0JgnxwDQa/iAc4WQ/hLsTvyRITZlhHJ+Yr6/mxaz/lSgyu37TMW01k?=
 =?us-ascii?q?pFrjFZndXWs3AN1hjT5tCGSvt74EihxS6C2x3c5+xLO0w5lbfXJ4Q/zrM/iJ?=
 =?us-ascii?q?Yfq1nPEjfzmErsja+Wcksk+vKv6+TierjmpJGdOJNuhQHkLqQihNeyAfg4Mw?=
 =?us-ascii?q?cSX2ib/v6w1Lv4/ULjWrlKgfo2krfBvJDAOcsbvrK5AxNS0os78BawETOm0N?=
 =?us-ascii?q?UenXkaI1NIYwyHj4f3NFHUOvz4Dumwg06qkDh1w/DKJLrhAo/CLiuLrLC0Zr?=
 =?us-ascii?q?t56khB2CItwt1FoZFZELcMJLT0QECimsbfC0obOgm52K7MAc9h25lWDWCQCa?=
 =?us-ascii?q?aDLPn6rU6D5uVpJfKFIoASpmCueLAe+/fygCphyhcmdq6z0M5SMii1?=
X-IPAS-Result: =?us-ascii?q?A2B+AQAkQ79b/wHyM5BiHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VkqgWUomEFMAQEBAQEBBoo1jhSBZiAYAYRAAoRVITcKDQEDAQEBAQEBAgFsK?=
 =?us-ascii?q?II2JIJgBnkQUVcZgmE/gXUNp06Ed4RihyWEIIEQgQeBEoJkhRRlhQsCgSgBh?=
 =?us-ascii?q?ziVLwYDkEkLF5ARLJc+IoFVKwgCGCmBaIFOgiYXEY4jIzB7AQGLZAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Oct 2018 12:35:23 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9BCZNWq028160;
        Thu, 11 Oct 2018 08:35:23 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov
Subject: [PATCH 2/4] libsepol: Eliminate initial sid string definitions in module_to_cil.c
Date:   Thu, 11 Oct 2018 08:35:47 -0400
Message-Id: <20181011123549.14875-3-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011123549.14875-1-jwcart2@tycho.nsa.gov>
References: <20181011123549.14875-1-jwcart2@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since the initial sid strings are defined in kernel_to_common.h,
module_to_cil.c can use those and its initial sid string definitions
can be removed.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/module_to_cil.c | 59 +++---------------------------------
 1 file changed, 5 insertions(+), 54 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index dcf6ebb1..8ab0dfce 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -52,6 +52,7 @@
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/util.h>
 
+#include "kernel_to_common.h"
 #include "private.h"
 
 #ifdef __GNUC__
@@ -2546,7 +2547,8 @@ static int context_to_cil(struct policydb *pdb, struct context_struct *con)
 	return 0;
 }
 
-static int ocontext_isid_to_cil(struct policydb *pdb, const char **sid_to_string, struct ocontext *isids)
+static int ocontext_isid_to_cil(struct policydb *pdb, const char *const *sid_to_string,
+				struct ocontext *isids)
 {
 	int rc = -1;
 
@@ -2602,41 +2604,7 @@ static int ocontext_selinux_isid_to_cil(struct policydb *pdb, struct ocontext *i
 {
 	int rc = -1;
 
-	// initial sid names aren't actually stored in the pp files, need to a have
-	// a mapping, taken from the linux kernel
-	static const char *selinux_sid_to_string[] = {
-		"null",
-		"kernel",
-		"security",
-		"unlabeled",
-		"fs",
-		"file",
-		"file_labels",
-		"init",
-		"any_socket",
-		"port",
-		"netif",
-		"netmsg",
-		"node",
-		"igmp_packet",
-		"icmp_socket",
-		"tcp_socket",
-		"sysctl_modprobe",
-		"sysctl",
-		"sysctl_fs",
-		"sysctl_kernel",
-		"sysctl_net",
-		"sysctl_net_unix",
-		"sysctl_vm",
-		"sysctl_dev",
-		"kmod",
-		"policy",
-		"scmp_packet",
-		"devnull",
-		NULL
-	};
-
-	rc = ocontext_isid_to_cil(pdb, selinux_sid_to_string, isids);
+	rc = ocontext_isid_to_cil(pdb, selinux_sid_to_str, isids);
 	if (rc != 0) {
 		goto exit;
 	}
@@ -2865,24 +2833,7 @@ static int ocontext_xen_isid_to_cil(struct policydb *pdb, struct ocontext *isids
 {
 	int rc = -1;
 
-	// initial sid names aren't actually stored in the pp files, need to a have
-	// a mapping, taken from the xen kernel
-	static const char *xen_sid_to_string[] = {
-		"null",
-		"xen",
-		"dom0",
-		"domio",
-		"domxen",
-		"unlabeled",
-		"security",
-		"ioport",
-		"iomem",
-		"irq",
-		"device",
-		NULL,
-	};
-
-	rc = ocontext_isid_to_cil(pdb, xen_sid_to_string, isids);
+	rc = ocontext_isid_to_cil(pdb, xen_sid_to_str, isids);
 	if (rc != 0) {
 		goto exit;
 	}
-- 
2.17.1

