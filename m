Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C2FC4161D
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 12:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A3A2064A
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 12:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A3A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJKUMg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:12:36 -0400
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:16711 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeJKUMg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 16:12:36 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2018 16:12:28 EDT
X-EEMSG-check-008: 173518700|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Oct 2018 12:35:25 +0000
X-IronPort-AV: E=Sophos;i="5.54,368,1534809600"; 
   d="scan'208";a="19290039"
IronPort-PHdr: =?us-ascii?q?9a23=3Ak5BUeR89zSXeXP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B41+IcTK2v8tzYMVDF4r011RmVBdqds6oMotGVmpioYXYH75eFvSJKW713fD?=
 =?us-ascii?q?hBt/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFR?=
 =?us-ascii?q?XjLwp1Ifn+FpLPg8it2O2+55/ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyh?=
 =?us-ascii?q?zHontJf+RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKW?=
 =?us-ascii?q?E169b1uhTFUACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMsPsTbAwRD?=
 =?us-ascii?q?+s8aFlRhH1gysDLjI17n3bhsl2galGohyuugZ/zpbUbo+LKfRwcKDTc9QYSm?=
 =?us-ascii?q?pPRctdSzBND5mgY4YVE+YNIeBVpJT9qVsUqhu+ABGhCuf1xT9NmHD2xrAx3v?=
 =?us-ascii?q?o7HgHcwAwvAcgOu2nTodX3OqYdTfq6zLPUzTnddP5WxTf855TIchAmu/2MW6?=
 =?us-ascii?q?lwftDLxUkgEAPFkEydpIr4ND2WzuQAq3WX4uVvWO61i2Mrtht9riagy8sykI?=
 =?us-ascii?q?XFm4QYwU3e+ypj2oY6P9i4RVZ+Yd6jDZRfqTmXN5BzQsM+W2Fovzs6yqEetZ?=
 =?us-ascii?q?67YicKzJMnygbDa/OdaYiI4w/jVP2LLTdkhHNqZLK/hxGo/Uim1uL8TdW73E?=
 =?us-ascii?q?xPripEltnArnEN1xrN5cibUvZx40is1DmV2w3T9+1IO144mKXFJ5I737I8jp?=
 =?us-ascii?q?8Tvl7CHi/ylkX2lqiWdkA89+iq5eXofq/ppoWAN4NqkQz+LqQvldC/AeQ/KA?=
 =?us-ascii?q?QOWXOb9v6m2L3s+k35Xq1GjucqnanBrJDaOcMbq7aiAwBL1oYj6hC/Dyqp0d?=
 =?us-ascii?q?kDg3kHI0xKeAidg4jqJV7OOvb4Aum7g1i2lzdr3f/GbfXdBcDWI3zClqrxVa?=
 =?us-ascii?q?hy5lQaywcpy91boZVOBeIvOvX2D234sdHDRjQwKRC52a6zCsp235kCA0qTE6?=
 =?us-ascii?q?SZN+XUqlbO6eUxdbrfLLQJsSrwfqB2r8XlimU0zBpHJaQ=3D?=
X-IPAS-Result: =?us-ascii?q?A2B+AQAkQ79b/wHyM5BiHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VkqgWUomEFMAQEBAQEBBoo1j3ogGAGDP4EBAoRVITcKDQEDAQEBAQEBAgFsK?=
 =?us-ascii?q?II2JIJgBnkQUVcZgmE/gXUNp06Ed4RihyWEIIEQgQeDdoV5hQsCgSgBnGcGA?=
 =?us-ascii?q?5BJCxeBQI5Rl2oigVUrCAIYKYFogU6QcSMwewEBi2QBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Oct 2018 12:35:24 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9BCZNWs028160;
        Thu, 11 Oct 2018 08:35:23 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov
Subject: [PATCH 4/4] libsepol: Add two new Xen initial SIDs
Date:   Thu, 11 Oct 2018 08:35:49 -0400
Message-Id: <20181011123549.14875-5-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011123549.14875-1-jwcart2@tycho.nsa.gov>
References: <20181011123549.14875-1-jwcart2@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Xen uses the initial SIDs domU and domDM in its toolstack, so it makes
sense to add these to xen_sid_to_str[] in kernel_to_common.h

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/kernel_to_common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index dacfe97e..8aa483fa 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -57,6 +57,8 @@ static const char * const xen_sid_to_str[] = {
 	"iomem",
 	"irq",
 	"device",
+	"domU",
+	"domDM",
 };
 
 #define XEN_SID_SZ (sizeof(xen_sid_to_str)/sizeof(xen_sid_to_str[0]))
-- 
2.17.1

