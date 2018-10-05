Return-Path: <SRS0=ExXx=MR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA74C00449
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D5420834
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D5420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJEVF0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:05:26 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:58863 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJEVF0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Oct 2018 17:05:26 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Oct 2018 17:05:26 EDT
X-EEMSG-check-008: 632997570|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,344,1534809600"; 
   d="scan'208";a="632997570"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Oct 2018 13:56:58 +0000
X-IronPort-AV: E=Sophos;i="5.54,344,1534809600"; 
   d="scan'208";a="16565609"
IronPort-PHdr: =?us-ascii?q?9a23=3AecBPNxKYvkYNmuMfjdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgRLvjxwZ3uMQTl6Ol3ixeRBMOHs60C07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwdFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9Qr4uWT?=
 =?us-ascii?q?Sm8qxlVhnmhikaPDI96W3blNB8gKddrRm8pRJw3pTUbZmVOvRgY63Tc9AUS2?=
 =?us-ascii?q?1aU8pNSyBMGJ+wYpETA+YdO+tTsonzp0EJrRu7HQSiAPngyjpWiX/twKY3zf?=
 =?us-ascii?q?4uERva3AM+BdIFrXPZrNf7NagOS++11rXIwSvYYvNK2Tby9IjIchc7rfGKRr?=
 =?us-ascii?q?J/a9DdyUYoFwPbl1idr5HuMTCN1ukVrmSW4OVtWfivhmI6sQ19vDeiytk2ho?=
 =?us-ascii?q?XUgI8e10rK+j9jwIkvIN21UEt7Ydm5H5ROryyaLI52Qt86Q2FvpSY61qUKuZ?=
 =?us-ascii?q?6lcygOz5Qq3wLfZOadc4iJ/xLjT/ydISt4hX15eLK/gAy+8U68xe3nSsa4yl?=
 =?us-ascii?q?NKritBktXUt3AN0QLc6tSfR/dg8Uqs1iyD2gDO5u1eP0w5mrTXJ4Q8zrIok5?=
 =?us-ascii?q?ocq0XDHiv4mEXsi6+Wc10p+uqm6uv7eLrmvIOcO5FvhwHiMqUhhsy/AeMiPg?=
 =?us-ascii?q?gIRGiU4/6w1LLk/U3nWLlKlOE5krHFsJDGIsQWvrW5DBFR0oYi7Ra/Ejin3c?=
 =?us-ascii?q?8GnXkIMl1FYgiLj4v3NFHUJvD3E/O/j06rkDdxyPCVdoHmV47AKnnFjafJY7?=
 =?us-ascii?q?lw8QhfxRA1wNQZ4IhbWZ8bJ/emeEb0uceQJRYjLwGui7LlF950zJ9EcX6eCa?=
 =?us-ascii?q?+edqXJuBmH4fx5cLrEX5McpDuoc6tt3PXpl3Js3AVFcA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BgAACbbLdb/wHyM5BjHgEGBwaBUQkLAYFbKoFlmFdMA?=
 =?us-ascii?q?QEBAQEBBookjW+BeiAYAYM/hS8hNA0NAQMBAQEBAQECAWwogjYkhDWDXT+Bd?=
 =?us-ascii?q?Q2lXooThxOEHoEQgQeDdoV5hQsCgSgBnDkGA4ldhl4LF490lyg4gVUrCAIYK?=
 =?us-ascii?q?YFogU+CTY4jI4ErAQGNTwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 05 Oct 2018 13:56:57 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w95Duv8n003745
        for <selinux@vger.kernel.org>; Fri, 5 Oct 2018 09:56:57 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH 0/2] libsepol: Add ability to sort ocontexts in libsepol and add option to use it in checkpolicy  
Date:   Fri,  5 Oct 2018 09:57:18 -0400
Message-Id: <20181005135720.13943-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

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

