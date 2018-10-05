Return-Path: <SRS0=ExXx=MR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2431CC65BA7
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E687C20834
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E687C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeJEVF2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:05:28 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:58863 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJEVF1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Oct 2018 17:05:27 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Oct 2018 17:05:26 EDT
X-EEMSG-check-008: 632997573|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,344,1534809600"; 
   d="scan'208";a="632997573"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Oct 2018 13:56:58 +0000
X-IronPort-AV: E=Sophos;i="5.54,344,1534809600"; 
   d="scan'208";a="16565610"
IronPort-PHdr: =?us-ascii?q?9a23=3AfnujURPZfJjWa616gGol6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0LfjzrarrMEGX3/hxlliBBdydt6obzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlKiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr86Qz?=
 =?us-ascii?q?Si67pgRgHuhikJKjU19HjbhtJsgK5eph+quh5xzJPOYIyNNPRwYL7Tc90ZS2?=
 =?us-ascii?q?RGXMlRWTdMDp+gY4YVE+YMJ/pUo5X7qlATrRW+Hw6sBOb3xzFMnHD22LM10/?=
 =?us-ascii?q?88GgzYxgMgBc4Ov2rOrN7oM6oSU+60w7XSwjXZc/Naxyzw6JTIcx89ofGMWq?=
 =?us-ascii?q?h8cczKyUY1DQ/FgVKQqZL8Mj6Ty+8DsHCb4vJ9We+ghGMrsQF8riW1yssyhY?=
 =?us-ascii?q?TFmJgZxk3C+C5k2og6P8e4R1R+YdO8FZtQsDyVOJVuT8M5RmFopD46yrobuZ?=
 =?us-ascii?q?6nZCQKyIooxxrYa/Gfb4iH+AjjVOeMITdjnn5lZLK+iAqy8Uin0OH8UNW70E?=
 =?us-ascii?q?1WoSZfl9nMt3QN2wTS6siBVPR94l+s1SuA2g3c8O1JIV04mbDFJ5Mu3LI8jI?=
 =?us-ascii?q?cfvVzGHiDsmUX2iKGWdl8j+uit8+nnYLvnqYOGOI9ulgHyLL8jmtC/AOskMg?=
 =?us-ascii?q?gOWHKX+eKn1LL550H5T7JKjuMunqnDrJ/aPdgbprK+AwJNyYYs9RK/Dzag0N?=
 =?us-ascii?q?QFkngKN0xFeB2ZgIjzIV3OI+73De25g1uylDdn3ffGPqfuAsaFEn+Wi7rlfL?=
 =?us-ascii?q?Bg+2ZCxwcpi9NS/ZRZDvcGOv2gdFX2sYn6Bxo0KESfyvz7Bc81goEBUmuVHv?=
 =?us-ascii?q?WxLLLZsVjO4PkmZeaLetlG637GN/E56qu23jcCklgHcPzsh8Ma?=
X-IPAS-Result: =?us-ascii?q?A2A6AACbbLdb/wHyM5BjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VsqgWUojAmMJkwBAQEBAQEGiiSJC4RkgXogGAGEQAKELCE0DQ0BAwEBAQEBA?=
 =?us-ascii?q?QIBbCiCNiSCYAaBCVFXGYJiP4F1DaVehHeFHIcThB6BEIEHiW+FCwKBKAGcO?=
 =?us-ascii?q?QYDkDsLF490LJZ8OIFVKwgCGCmBaIFOgiYXjjQjMHsBAY1PAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 05 Oct 2018 13:56:58 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w95Duv8o003745
        for <selinux@vger.kernel.org>; Fri, 5 Oct 2018 09:56:57 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsepol: Create policydb_sort_ocontexts()
Date:   Fri,  5 Oct 2018 09:57:19 -0400
Message-Id: <20181005135720.13943-2-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005135720.13943-1-jwcart2@tycho.nsa.gov>
References: <20181005135720.13943-1-jwcart2@tycho.nsa.gov>
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

