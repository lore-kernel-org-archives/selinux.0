Return-Path: <SRS0=ExXx=MR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D06C65BAA
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E8320834
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E8320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeJEVGQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:06:16 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:63167 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJEVGQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Oct 2018 17:06:16 -0400
X-EEMSG-check-008: 322824834|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Oct 2018 13:57:10 +0000
X-IronPort-AV: E=Sophos;i="5.54,344,1534809600"; 
   d="scan'208";a="19089840"
IronPort-PHdr: =?us-ascii?q?9a23=3AwOXwVhDftAoE3egEDbduUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPv/r8bcNUDSrc9gkEXOFd2Cra4c1KyO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhjexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs7Vy?=
 =?us-ascii?q?6i76N2QxH2jikJOSMy/GXOhsBukK5XpRSsrAF9zYHJeoGYLPpwcL3Ac90URm?=
 =?us-ascii?q?RPWcReVyJaD4+gc4cCFfYNMPxEo4XhoVYFsBuwBROrBOPq0jJGgmX53agk3O?=
 =?us-ascii?q?Q6DArLwhYvH8gSsHvKttX+KaAfUeK7zabU1zrDde9W1Snm5YjUchEuvfGMXb?=
 =?us-ascii?q?VqfcrX0kkgDRnJjlqXqYz7Jj6Y0PkGvWuD7+d4SO6ihGEqpxtxrzSy3MsglI?=
 =?us-ascii?q?bEipwPxlzZ8yhy3Zw7KseiSEFhZN6pCJ5QtyaHOIRoWs4iWGRouDoiyr0BpJ?=
 =?us-ascii?q?67YDAGyJQ5yB7bbPyKa5SI7Qj5VOaQPDd4n2hpeK6/hhmu8UigzffwVs+o31?=
 =?us-ascii?q?ZRsiVJiNzMtnEJ1xDL68iHTOVy/lu51DqS2A3e5ftILEApmabBNZIszaA8mo?=
 =?us-ascii?q?AOvUjbGy/5gkT2jKuYdkU+/eio7vzqYrfop5CALYB0kB3+Pro1l8yjAeU3Lg?=
 =?us-ascii?q?gOX2+B9eS6z73s51f1QLpNjv0oiqXZqozVJdwHpq6lBA9Yyp0j5Ai7Dzen1t?=
 =?us-ascii?q?QYgHYGIUlbeBKIkYfpIUvCIPPmAvelhVSjjjNry+rBPr37DZWeZkTExazseb?=
 =?us-ascii?q?d79l501gU+15Zc6ohSB7VHJ+j8CWHrs9mNLBY8Phf86O/9FNhnntccRmmGGL?=
 =?us-ascii?q?PDGL/Dul+PoOQ0Kq+DY5FD62W1EOQs+/O71SxxolQaZ6T8mMFPZQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2A6AABdbLdb/wHyM5BjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VsqgWUojAmMJkwBAQEBAQEGiiSNbxSBZiAYAYRAAoQsITQNDQEDAQEBAQEBA?=
 =?us-ascii?q?gFsKII2JIJgBoEJUVcZgmI/gXUNpVyEd4UchxOEHoEQgQeBEoJkhRRlhQsCg?=
 =?us-ascii?q?SgBhy6VCwYDkDsLF490LJZ8OIFVKwgCGCmBaIFOgiYXEY4jIzB7AQGNTwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Oct 2018 13:57:09 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w95Dv6Ku003753
        for <selinux@vger.kernel.org>; Fri, 5 Oct 2018 09:57:09 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/4] libsepol: Eliminate initial sid string definitions in module_to_cil.c
Date:   Fri,  5 Oct 2018 09:57:27 -0400
Message-Id: <20181005135729.13998-3-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005135729.13998-1-jwcart2@tycho.nsa.gov>
References: <20181005135729.13998-1-jwcart2@tycho.nsa.gov>
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

