Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A7BECE588
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0D3218DE
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="c9vdEsuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbfJON07 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:26:59 -0400
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:24961 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfJON07 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 09:26:59 -0400
X-EEMSG-check-017: 35822915|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="35822915"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 13:26:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571146018; x=1602682018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z8nREZGaVnUA652l+HFvKUEvHHF1XC95j8oDcGQ2XyY=;
  b=c9vdEsuwhIZrAsNbzxYaUsMIPDo5+nNwla1ALPcAKWPasmHyYmq/+WEq
   ZtkGTaGmC64rKMpad+D68QHwJCsq+okmmMrHfS7yTNpOjmYdKudgfTOX/
   yMH7Pxh0t8IqdqvUcKwA2wl1TPyWjNQvuKOYckOA7qo8tQt842pXh6/Sd
   SazOvhNH/ZTYiUyqGH19vBy/HJsiP83A8Zu/MOJbt0dh/tNvUqVyTgZbM
   IxEB9eOnwRB8IExLPoeEVxMRhWILudTcOpMJ1C/5kaag2ZcdiQZm37hbS
   e+D037344g9Ps5M6jAUg4w4ialZeWUKR++ShpVZBuup1SZMD+oOdH5H8V
   A==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="28980470"
IronPort-PHdr: =?us-ascii?q?9a23=3AX41FwR3iRq9XwXUKsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIWLvad9pjvdHbS+e9qxAeQG9mCsLQb0KGL7ejJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe7F/IRu5oQjRt8QdnJdvJLs2xh?=
 =?us-ascii?q?bVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3UbJXAjImM3?=
 =?us-ascii?q?so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RT?=
 =?us-ascii?q?Kv5LplRx/yjCcMKiA3/mfZhMdtiK5XuRKsqhh6z4PSfYqbNudxfrnFcN0aW2?=
 =?us-ascii?q?RPQ8hfWS9GDIy+YYsAAOUPMP1Eo4T+vVYCsQGzCRWwCO7p1zRGhmX23ao/0+?=
 =?us-ascii?q?k5DA/GwBIvH8oOsHvKqtX+KbocUeWvw6nMyTXMcfNX0ir65YjTbx8huuqBXa?=
 =?us-ascii?q?5wcMXNyUkvEBnJjlOLqYP/JT+V2eMNs3aC4udmSOmhiHYnphlsrjWgycogkI?=
 =?us-ascii?q?nEip8Pxlza+ih13pw5KcC+RUVme9CrCoFQuDufN4ZuR8MiRHxntzgix70dvJ?=
 =?us-ascii?q?67YDAKyJM6xx7Dc/CHc5aH4hbkVOuJPTd3nmhleLOihxap60Sg1u39WdW00F?=
 =?us-ascii?q?ZNtCZFlMXDtmsR2BDJ78iHS/998l+g2TaJyQ/T9vlJLV07mKfUMZIswqM8mo?=
 =?us-ascii?q?ANvUnMACP6glj6gLeTdko+++io7+rnYq/hpp+ZL4J0kRzxMr81l8yjAeU3Lg?=
 =?us-ascii?q?gOX2+B9eS6z73s51f1QLpNjv0oiqXZqozVJdwHpq6lBA9Yyp4j5AyiDzeiy9?=
 =?us-ascii?q?kYhWMILE9BeB6eiojpPFbOIOrmAvuln1uslzJrzejcPrL9GpXNMmTDkLD5cL?=
 =?us-ascii?q?Zm9UFczAszzdZC55NbEbwBPv3zVVHrtNDCDR82LRa0w+D5B9V5zI8eXniPAq?=
 =?us-ascii?q?DKeJ/V5ESF4uMpPvmkeoAYonD+JuIj6vqoimU2ynEHeqz85ocacHC1GLxdJk?=
 =?us-ascii?q?ydZXf9yoMaHXwiohs1TOusjkaLFzFUeSDhDOoH+jgnBdf+Xs/4TYe3jenEgX?=
 =?us-ascii?q?a2?=
X-IPAS-Result: =?us-ascii?q?A2CwAgAXxqVd/wHyM5BmHQEBAQkBEQUFAYFqBQELAYFzL?=
 =?us-ascii?q?IE/ATIqk1MBAQEBAQEGiy6RLwkBAQEBAQEBAQEbGQECAQGEQAKCayQ3Bg4CD?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshTmCOimCaQYyAUYQUVcZgmM/glMlsFOFTYMwgUiBN?=
 =?us-ascii?q?AGHNIRZGHiBB4RhhA2BBIUfBK1KgiyCMZJeDBuZQal8I4FYKwgCGAghD4MnU?=
 =?us-ascii?q?BAUkDElAzCBBgEBjW2CVAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Oct 2019 13:26:58 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FDPV4G010187;
        Tue, 15 Oct 2019 09:26:57 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 02/10] selinux: support multiple selinuxfs instances
Date:   Tue, 15 Oct 2019 09:25:20 -0400
Message-Id: <20191015132528.13519-3-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015132528.13519-1-sds@tycho.nsa.gov>
References: <20191015132528.13519-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Support multiple selinuxfs instances, one per selinux namespace.

The expected usage would be to unshare the SELinux namespace and
the mount namespace, and then mount a new selinuxfs instance.  The
new instance would then provide an interface for viewing and manipulating
the state of the new SELinux namespace and would not affect the parent
namespace in any manner.

This change by itself should have no effect on SELinux behavior or
APIs (userspace or LSM).

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 3873946f4dd8..a69381f94d37 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2006,7 +2006,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int sel_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, sel_fill_super);
+	return get_tree_keyed(fc, sel_fill_super, current_selinux_ns);
 }
 
 static const struct fs_context_operations sel_context_ops = {
-- 
2.21.0

