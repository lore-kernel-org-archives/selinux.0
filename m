Return-Path: <SRS0=ExXx=MR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB263C65BAA
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7FD20834
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7FD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeJEVGN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:06:13 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:63163 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJEVGN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Oct 2018 17:06:13 -0400
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Oct 2018 17:06:13 EDT
X-EEMSG-check-008: 322824829|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Oct 2018 13:57:10 +0000
X-IronPort-AV: E=Sophos;i="5.54,344,1534809600"; 
   d="scan'208";a="19089838"
IronPort-PHdr: =?us-ascii?q?9a23=3Ac5oGHxWkuPlUajYLWDG+2xmTo0LV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYxCDt8tkgFKBZ4jH8fUM07OQ7/i/HzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9wIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KhlUh/ojDoMOSA//m/Zl8d8iLtXrAy9qxB6xYPffYObO+dkfq7Ffd0UW3?=
 =?us-ascii?q?dPUMhSWSJGGY6wc5cDAvAdMetCs4Xxu10Dpga+Cwm2A+PvzydFiHvs0q0/ze?=
 =?us-ascii?q?shChzN0RI6ENIUrHTbss/1P7oVXOC3wqjH0S/Mb+lK2Tvj84XIbhAgru2MXb?=
 =?us-ascii?q?J3a8bRz1IvGBnfglWfrozlISqY2+IQuGaY9+ptTf+jhmEopg1rojWj290ghp?=
 =?us-ascii?q?fGi44L0FzI6CN0y5svK9KiUk50e9ukHYNVtyGdKoR5XNsvQ3ptuCYm0r0Gvo?=
 =?us-ascii?q?O7fDQSxJQn2RHfb/uHfpCU4h35TuaRICp4hGl/dLKjhxe97UigyurmWsmyzF?=
 =?us-ascii?q?lKtTZKnsPJtnAM0xzf8smHSv1j8Ue9wTuDyg/e5+5eLU00iKbXMYAtz7Eump?=
 =?us-ascii?q?YJrEjPBir2l1/3jK+SeEUk4O+o6+H/b7XkqJ6TK5V7ihviMqgwgcG/HeQ5PR?=
 =?us-ascii?q?QOX2ic4+i80qbj8lfjTLVFif02jLHVsIrGKsQDuq65HwhV35446xmhCzem0d?=
 =?us-ascii?q?IYnWQILV9eZhKHgJbmO0vULPD7E/i/mVKsnylvx/zcOb3hGJrNfTD/l+L6cL?=
 =?us-ascii?q?J87VNM4BQ8wMoZ5J9ODLwFZvXpVRzfrtvdWz0wNgGvi83uEslwzMtKW32EC7?=
 =?us-ascii?q?WFaovOoFSI4aQpOODKa4gL7mWuY8M57uLj2Cdq0WQWerOkiN5NMH0=3D?=
X-IPAS-Result: =?us-ascii?q?A2A5AABdbLdb/wHyM5BjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VsqgWWMMYwmTAEBAQEBAQaKJI1vgXogGAGIbiE0DQ0BAwEBAQEBAQIBbCiCN?=
 =?us-ascii?q?iSIEj+BdQ2lXIR3hRyHE4QegRCBB4N2hXmEaSICgSgBhy6FRo9FBgOQOwsXj?=
 =?us-ascii?q?3SXKDiBVSsIAhgpgWiBT4IlFxGOIyOBKwEBjU8BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Oct 2018 13:57:09 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w95Dv6Ks003753
        for <selinux@vger.kernel.org>; Fri, 5 Oct 2018 09:57:06 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH 0/4] libsepol: Cleanup initial sid handling when writing CIL and policy.conf files
Date:   Fri,  5 Oct 2018 09:57:25 -0400
Message-Id: <20181005135729.13998-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

- Removes some redundent definitions of initial sid name strings
- Adds range checking when looking up an initial sid name string for an index
- Adds two new Xen initial sids

James Carter (4):
  libsepol: Rename kernel_to_common.c stack functions
  libsepol: Eliminate initial sid string definitions in module_to_cil.c
  libsepol: Check that initial sid indexes are within the valid range
  libsepol: Add two new Xen initial SIDs

 libsepol/src/kernel_to_cil.c    | 78 +++++++++++++++++++++------------
 libsepol/src/kernel_to_common.c | 10 ++---
 libsepol/src/kernel_to_common.h | 16 ++++---
 libsepol/src/kernel_to_conf.c   | 78 +++++++++++++++++++++------------
 libsepol/src/module_to_cil.c    | 78 +++++++++------------------------
 5 files changed, 136 insertions(+), 124 deletions(-)

-- 
2.17.1

