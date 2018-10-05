Return-Path: <SRS0=ExXx=MR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B1EC00449
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D5B20834
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D5B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeJEVFh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:05:37 -0400
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:3047 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJEVFg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Oct 2018 17:05:36 -0400
X-EEMSG-check-008: 598851734|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,344,1534809600"; 
   d="scan'208";a="598851734"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Oct 2018 13:57:08 +0000
X-IronPort-AV: E=Sophos;i="5.54,344,1534809600"; 
   d="scan'208";a="19089842"
IronPort-PHdr: =?us-ascii?q?9a23=3Ar4Fihh1iyKZAx9sJsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8Zse0SIvad9pjvdHbS+e9qxAeQG9mDtLQc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYQhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb5Q6o0WT?=
 =?us-ascii?q?C/5Kl1ThHmhjoMOzog/G3JlsB8iaRWqw+jqRNi2Y7ZeIGbOuRjcK3Tft0UQm?=
 =?us-ascii?q?hOXshKWiBdHo+xdZcDAvAdMepEqYT2ulsArQG5BQmpHO7hziVHhnro0q0hzu?=
 =?us-ascii?q?8sDxvJ3BY8H90QqnTfsdL4NKUcUO+p1qbI1ynDY+1N1Dfh6InHbhAhofaWUb?=
 =?us-ascii?q?J2asre01MjFwzCjlWOsIHoOS6e2OcVs2WD8uZtWu2ih3Qnpg1suDSj2Mghhp?=
 =?us-ascii?q?fTio4IzF3P6D93z5wvJdKiTU52edukEJxNuC6EL4Z2WcYiQ31wuCY9170GpY?=
 =?us-ascii?q?a3fCgUx5QjwB7Sc+CHfJKS4hLiSeaROi10hG5leb2jhxay9lKsyuvgWcmvzF?=
 =?us-ascii?q?lGtC9FktjItnwV1hzT7NaISudl80u81juC2Brf5+FZLUwui6bWJIAtzqQtmp?=
 =?us-ascii?q?YLtETMBC72mEH4jK+McUUk//Cl6+bpY7r6vJCcLZN0hh/lP6Qyms2wHeQ4Mg?=
 =?us-ascii?q?8UU2id4uSzzqfv/UL+QLVUlvE2iLXWsIjGJcQHoa60GxRV3Zgn6xa+CTemzd?=
 =?us-ascii?q?sZkGIZLFJKZh2HlZLlO1LQL/DiC/ewnVCsnC1sx/DcMb2ySqnKe2POlLbnYK?=
 =?us-ascii?q?ZV9UFR0kwwwMpZ6pYSDasOc9zpXUqkltXdAwRxGAWu3+v9QIF/yYgXQ37VKr?=
 =?us-ascii?q?OIO6PV91mT76QgJPfaN9xdgyr0N/Vwv62mtnQ+g1JIOPPx0A=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2A6AABdbLdb/wHyM5BjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VsqgWUojAmMJkwBAQEBAQEGiiSNb4F6IBgBgz+BAQKELCE0DQ0BAwEBAQEBA?=
 =?us-ascii?q?QIBbCiCNiSCYAaBCVFXGYJiP4F1DaVchHeFHIcThB6BEIEHg3aFeYULAoEoA?=
 =?us-ascii?q?Zw5BgOQOwsXgT2ON5coOIFVKwgCGCmBaIFOkHEjMHsBAY1PAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Oct 2018 13:57:10 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w95Dv6Kw003753
        for <selinux@vger.kernel.org>; Fri, 5 Oct 2018 09:57:10 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/4] libsepol: Add two new Xen initial SIDs
Date:   Fri,  5 Oct 2018 09:57:29 -0400
Message-Id: <20181005135729.13998-5-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005135729.13998-1-jwcart2@tycho.nsa.gov>
References: <20181005135729.13998-1-jwcart2@tycho.nsa.gov>
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

