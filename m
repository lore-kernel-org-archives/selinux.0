Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3A3C46466
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 12:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D97A2085B
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 12:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D97A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJKUCV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:02:21 -0400
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:32072 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeJKUCV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 16:02:21 -0400
X-EEMSG-check-008: 345164707|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Oct 2018 12:35:19 +0000
X-IronPort-AV: E=Sophos;i="5.54,368,1534809600"; 
   d="scan'208";a="19290030"
IronPort-PHdr: =?us-ascii?q?9a23=3A7a1mLBLbkwBR3hV6kNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgRLvTxwZ3uMQTl6Ol3ixeRBMOHs60C07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwdFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9Qr4uWT?=
 =?us-ascii?q?Sm8qxlVhnmhikaPDI96W3blNB8gKddrRm8pRJw3pTUbZmVOvRgY63Tc9AUS2?=
 =?us-ascii?q?1DUcZfTCFNHp+wYpETA+cbIepUs4/wrEYOoxukAgmsAfvixDtSiX/zw6I6yP?=
 =?us-ascii?q?kqHB/c0ww6A9IBrm7Up8jyOacQX+G60LPHzS/fb/9Iwjr99IjJfQwhofGLR7?=
 =?us-ascii?q?5wd9HRxlM1GwPKiVWQt5XoMjWI3eoOq2iW9/dsWO2ghmI9qwx9vyKjytkjh4?=
 =?us-ascii?q?XXnI4Z11bJ/jhjzokvP923Ukt7bMahEJtXqi6VKZN7QtgnQ2F0oCY6zaAGuY?=
 =?us-ascii?q?KjcCgK1psnwxnfZuSbc4eS+BLjVfuRISxiiHJ5eLOwmxay8U+6xu36Ssa0y0?=
 =?us-ascii?q?pFojBAktnNsnABzx3T6s6ZRfth5kqtxDmC2g/J5uxEPEw4j7TXJpE/zrIqi5?=
 =?us-ascii?q?YfqUHDETX3mEXygq+WbEIk+u2w5uTlbLTpuoWTN5Voig3gKakuhsy+Dvg4Mg?=
 =?us-ascii?q?gJRWSb//+826f58U32R7VKkOU6krPFv5DCOcQbuqm5DhdO0ok97xa/DjGm0M?=
 =?us-ascii?q?kXnHQcMlJFdwyIj5LzN1HNPv/4F/G/jEqokDtxwPDGJLLhUd3xKS3YnbPge6?=
 =?us-ascii?q?ttw1BTxRB1zt1F4Z9QTLYbL6HdQEj04f7RCxIieye92frqEp0p1JwVUHiTWI?=
 =?us-ascii?q?eFIajSthmO/etpLO6SMtxG8A3hIuQosqa9xUQynkUQKOzzhZY=3D?=
X-IPAS-Result: =?us-ascii?q?A2C6AAAkQ79b/wHyM5BiHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VkqgWUomEFMAQEBAQEBBoo1iReEaYF6IBgBhEAChFUhNgsNAQMBAQEBAQECA?=
 =?us-ascii?q?WwogjYkgmAGeRBRVxmCYT+BdQ2nToR3hGKHJYQggRCBB4lvhQsCgSgBnGcGA?=
 =?us-ascii?q?5BJCxeQESyXLwgpgVUrCAIYKYFogU6CJheONCMwewEBi2QBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Oct 2018 12:35:18 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9BCZHD8028155;
        Thu, 11 Oct 2018 08:35:18 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libsepol: Create policydb_sort_ocontexts()
Date:   Thu, 11 Oct 2018 08:35:42 -0400
Message-Id: <20181011123543.14822-2-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011123543.14822-1-jwcart2@tycho.nsa.gov>
References: <20181011123543.14822-1-jwcart2@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create the function called policydb_sort_ocontexts() that calls
the internal function sort_ocontexts() to sort the ocontexts of
a policydb.

The function sort_ocontexts() is already used by
sepol_kernel_policydb_to_conf() and sepol_kernel_policydb_to_cil()
when converting a binary policy to cil or policy.conf format.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/include/sepol/policydb/policydb.h | 2 ++
 libsepol/src/policydb.c                    | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 271a82c9..591ce6e0 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -640,6 +640,8 @@ extern void policydb_destroy(policydb_t * p);
 
 extern int policydb_load_isids(policydb_t * p, sidtab_t * s);
 
+extern int policydb_sort_ocontexts(policydb_t *p);
+
 /* Deprecated */
 extern int policydb_context_isvalid(const policydb_t * p,
 				    const context_struct_t * c);
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index dfedfafe..a6d76ca3 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -51,6 +51,7 @@
 #include <sepol/policydb/util.h>
 #include <sepol/policydb/flask.h>
 
+#include "kernel_to_common.h"
 #include "private.h"
 #include "debug.h"
 #include "mls.h"
@@ -4301,3 +4302,7 @@ int policydb_set_target_platform(policydb_t *p, int platform)
 	return 0;
 }
 
+int policydb_sort_ocontexts(policydb_t *p)
+{
+	return sort_ocontexts(p);
+}
-- 
2.17.1

