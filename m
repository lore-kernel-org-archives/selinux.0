Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA50ECE588
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D39218DE
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZGCbF8q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfJON1D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:27:03 -0400
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:24971 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731966AbfJON1D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 09:27:03 -0400
X-EEMSG-check-017: 35822953|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="35822953"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 13:27:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571146021; x=1602682021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=35Mo9a6HxAk2Uv1LsXMaNKk4XVMrSE1dQBmilW3eWEQ=;
  b=ZGCbF8q2B5YX8ICgrQHrKp/62XAP+4lII8dJCEogRZSN/6mAwvTVbp70
   hXv04xYrwxqEljdxqVqvMs7QKZAFyrnZXGKkIlcfkKG6+/r/zLzcc0g2G
   8mQwLPJXDNRFQnYGv0ylASr1cFgdKswdemwsiKwxnM87D3aASXMj3ZTPH
   lqJeL0+VDKtW6HR8ZmP7mEXz0Rpf9dj0MuHYDkdFWf1xBjGM7l9S0Jaq5
   GsDoP9RNarVLPN2D+nl+GB2EsKqkBWQlNupjVY+7HR24tbomjl6pw0DQS
   zREhuFcudaLoAEUFlWxB48Pv2fKEArKhIkvoHsTGqN01AhdZER/ryESME
   g==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="28980477"
IronPort-PHdr: =?us-ascii?q?9a23=3A2OfI/x3mmwk+AzPWsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMXK/ad9pjvdHbS+e9qxAeQG9mCsLQb0KGL7ejJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe7F/IRu5oQjRt8QdnJdvJLs2xh?=
 =?us-ascii?q?bVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3UbJXAjImM3?=
 =?us-ascii?q?so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RT?=
 =?us-ascii?q?Kv5LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cS2?=
 =?us-ascii?q?VBRMJRXDFfDI26YYUEEu4NMf9WooT5olcDqwa1CwuxC+P10jJGhmH407A03e?=
 =?us-ascii?q?oiFg/J3gIgEN0BvnnPsNn4N70fXfyvwaXU0TnOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lp?=
 =?us-ascii?q?wPvkTYAiD6gkD2jK6Sdkk8++io7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9eik0b3s50z5QLFEjv0slanZtYjXJd8Gqa6iGAJVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2IHI0hfdBKIiIjpJUnCIOrkAvenn1SsjDBryujEPrL7B5XCMGPDnK3lfb?=
 =?us-ascii?q?pn7k5czxAzzcpe55JPEbwBJ+jzVVXtu9zcEBA1KRC7w+HiCN9lzIMRRXqPAr?=
 =?us-ascii?q?OFMKPVqVKI/vggI/SIZIIOoDbyMeUl5/r3gX88nl8derOp0oUNZH+kGfRmJl?=
 =?us-ascii?q?2TYWDwjdcZDWcKog0+QfTxiFKcVT5TZnCyX78z5zwgFoKmApnMRpq3jLyCwi?=
 =?us-ascii?q?i7BJtWaX5CClyWFnfobYqECL8wb3eJL8tglCEUfaauRpVn1hy0sgL+jb19Ib?=
 =?us-ascii?q?n64Cod4Kn/2cB16uubrhQ78Th5HozJyG2WZ31llWMPATkt1eZwplIrmQTL6r?=
 =?us-ascii?q?Rxn/ENTY8b3PhOSApvcMeHnuE=3D?=
X-IPAS-Result: =?us-ascii?q?A2BXAAAXxqVd/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWcHA?=
 =?us-ascii?q?QELAYFzLIE/ATIqjEeHDAEBAQEBAQaBNol4jzSBewkBAQEBAQEBAQEbGQECA?=
 =?us-ascii?q?QGEQAKCayQ0CQ4CDAEBAQQBAQEBAQUDAQFshTmCOikBgmgGJwsBRhAgMVcZg?=
 =?us-ascii?q?mM/glMlsCAziH2BSIE0AYc0hFkYeIEHhGGEDYEEhR8ErUqCLIIxkl4MG5lBL?=
 =?us-ascii?q?ak5OYFYKwgCGAghD4MnUBAUgVsXjj8lAzABgQUBAY1tglQBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Oct 2019 13:27:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FDPV4I010187;
        Tue, 15 Oct 2019 09:27:00 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, James Morris <james.l.morris@oracle.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 04/10] selinuxns: mark init_selinux_ns as __ro_after_init
Date:   Tue, 15 Oct 2019 09:25:22 -0400
Message-Id: <20191015132528.13519-5-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015132528.13519-1-sds@tycho.nsa.gov>
References: <20191015132528.13519-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: James Morris <james.l.morris@oracle.com>

This is a patch against the SELinux namespace work.

Mark the initial SELinux namespace pointer as __ro_after_init, to harden
against malicious overwrite by an attacker.

Signed-off-by: James Morris <james.l.morris@oracle.com>
[sds@tycho.nsa.gov: ported to v5.4-rc1]
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7a4ed553cec0..dc0b143ffa55 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7096,7 +7096,7 @@ void __put_selinux_ns(struct selinux_ns *ns)
 	schedule_work(&ns->work);
 }
 
-static struct selinux_ns *init_selinux_ns;
+static struct selinux_ns *init_selinux_ns  __ro_after_init;
 
 static __init int selinux_init(void)
 {
-- 
2.21.0

