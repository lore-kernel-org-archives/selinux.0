Return-Path: <SRS0=Cb3q=OG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4363C43441
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 20:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEAA20645
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 20:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEAA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbeK1HKG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:10:06 -0500
Received: from upbd19pa10.eemsg.mail.mil ([214.24.27.85]:17219 "EHLO
        upbd19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeK1HKG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Nov 2018 02:10:06 -0500
X-EEMSG-check-008: 183320651|UPBD19PA10_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2018 20:10:59 +0000
X-IronPort-AV: E=Sophos;i="5.56,287,1539648000"; 
   d="scan'208";a="21046855"
IronPort-PHdr: =?us-ascii?q?9a23=3AxVKNTR3S61IWkjZNsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8Zse0VLfad9pjvdHbS+e9qxAeQG9mDu7Qc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYAhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb5Q6o0WT?=
 =?us-ascii?q?C/5Kl1ThHmhjoMOzog/G3JlsB8iaRWqw+jqRNi2Y7ZeIGbOuRjcK3Tft0UQm?=
 =?us-ascii?q?VOUMlKWiBdAY6xdZcDAvAdMepEqYT2ulsArQG5BQmpHO7h1yNIiWHu3a06ze?=
 =?us-ascii?q?shFxzN0hElH90UtHTUqMv6NacPWu2y16nH0C7DYuhK2Tb99IfIchchreuKXb?=
 =?us-ascii?q?Jra8Xd00YvFwTbjliJr4HuIjCb1vwVvmSG4OdtWvijhm46pw1rvDSiydkghp?=
 =?us-ascii?q?PUio8T11vK7z92wJwvKt29UEN7ZNmkH4ZOuCyCLIt2R98iQ3lvuCYn1r0KoZ?=
 =?us-ascii?q?67czYOyJQg3xPfd+aIc5KJ4hL+T+adOyt4hXJ5d7K/gBa+606gxfHnVsaoyl?=
 =?us-ascii?q?pKqytFkt3UunAM0Rzc9NSHR+Ng8kqu1juDzQDe5vxeLUwqmqfXNYQtzqMomp?=
 =?us-ascii?q?oWq0vDHyv2mEvsjK+Rc0Up4vOo5Pn8Yrj9up+dN5N7igH5Mqg0nMy/Gv43Ph?=
 =?us-ascii?q?IBX2ic5+SwzKfj8lHhQLVWkv02lbHUsIvEKsQfp665BRJV04k45hahADepzs?=
 =?us-ascii?q?4YkWMELF1bYhKHiZbmO1XULPD/F/e/jAfkrDA+3P3CP7v8Er3TIXXZ1rTsZ7?=
 =?us-ascii?q?Bw7whb0gVg48pY4sdvFrwZIP/1EnT0vdjcAw5xZxe42M77Gd590cUYQmvJDa?=
 =?us-ascii?q?iHZvCB+WSU7/4idrHfLLQevyzwfr1/v/M=3D?=
X-IPAS-Result: =?us-ascii?q?A2BDAAAJpP1b/wHyM5BjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VopgWgnjBGMB1IGilKOI4F6IBgBhECDGiI0CQ0BAwEBAQEBAQIBbCiCNiSDG?=
 =?us-ascii?q?wFGgVGCYj+BdQ2nUIVAhHCHYoQrF3iBB4lxhQ4CkBePdQmRJQsYgUqPQAGZf?=
 =?us-ascii?q?TiBVSsIAhgIIQ+DJ5B5IQMwgQUBAY0GAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Nov 2018 20:10:58 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wARKAvlQ031861;
        Tue, 27 Nov 2018 15:10:57 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: enable multiport netfilter match for sctp tests
Date:   Tue, 27 Nov 2018 15:13:12 -0500
Message-Id: <20181127201312.29827-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is used by tests/sctp/iptables-load

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/defconfig b/defconfig
index c48d3cc..ff0704f 100644
--- a/defconfig
+++ b/defconfig
@@ -21,6 +21,7 @@ CONFIG_NETWORK_SECMARK=y
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
 CONFIG_NETFILTER_XT_TARGET_SECMARK=m
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m # used for testing sctp
 
 # Filesystem security labeling support.
 # Only need to enable the ones for the filesystems on which you are testing.
-- 
2.19.1

