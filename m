Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BB0C32788
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 12:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BFE2077C
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 12:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BFE2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJKUCU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:02:20 -0400
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:32072 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeJKUCU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 16:02:20 -0400
X-EEMSG-check-008: 345164706|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Oct 2018 12:35:18 +0000
X-IronPort-AV: E=Sophos;i="5.54,368,1534809600"; 
   d="scan'208";a="19290029"
IronPort-PHdr: =?us-ascii?q?9a23=3ATb9W3BZIFYsIyZ88Vk0OqnP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMi+bnLW6fgltlLVR4KTs6sC17KJ9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa/bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?us9adrTALjhjkBOTA37WrbjtV8gLxHrB6koRF03ozab5yPNPdmfq3TY84US2?=
 =?us-ascii?q?RCUMhWTCFNHp+wYpETA+cbIepUs4/wrEYOoxukAgmsAfvixDtSiX/zw6I6yP?=
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
X-IPAS-Result: =?us-ascii?q?A2CQAAAkQ79b/wHyM5BiHgEGBwaBUQkLAYFZKoFlmGlMA?=
 =?us-ascii?q?QEBAQEBBoo1jgCBeiAYAYM/gQGEVyE0DQ0BAwEBAQEBAQIBbCiCNiSDX1aDX?=
 =?us-ascii?q?D+BdQ2nTolZhyWEIIEQgQeDdoV5hQsCgSgBnGcGA4lnhmILF5ARl1Q4gVUrC?=
 =?us-ascii?q?AIYKUqBHoFPgk2OIyOBKwEBi2QBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Oct 2018 12:35:18 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9BCZHD7028155;
        Thu, 11 Oct 2018 08:35:17 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov
Subject: [PATCH 0/2] libsepol: Add ability to sort ocontexts in libsepol and add option to use it in checkpolicy  
Date:   Thu, 11 Oct 2018 08:35:41 -0400
Message-Id: <20181011123543.14822-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

[Resending because I originally only sent these to the new list]

ocontexts (initial sids, fs_use_*, genfscon, portcon, etc) are sorted by libsemanage when using policy modules and by libsepol when using CIL, but they are not sorted by checkpolicy when creating a policy from a policy.conf.

Checkpolicy's behavior allows control over the ordering which determines the matching order for portcons and other ocontext rules, but there are times when that specific control is not desired.

This patch set exposes an internal ocontext sorting function and adds a command line option to checkpolicy to sort ocontexts.


James Carter (2):
  libsepol: Create policydb_sort_ocontexts()
  checkpolicy: Add option to sort ocontexts when creating a binary
    policy

 checkpolicy/checkpolicy.c                  | 22 +++++++++++++++++-----
 libsepol/include/sepol/policydb/policydb.h |  2 ++
 libsepol/src/policydb.c                    |  5 +++++
 3 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.17.1

