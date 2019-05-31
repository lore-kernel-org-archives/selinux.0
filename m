Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98665C28CC4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD6F26FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sgcBv1a+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfEaXO3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:14:29 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:34632 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbfEaXO2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344466; bh=DXZobVlHba7NLExIjhRRZRkmastZlDIkiPrs42J8njM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=sgcBv1a+a9Um7OCnTtseaHU1QUGUadAHTYgFYFrRx/M4w+cE5PxJ95F7GirKt9GKsrYDDsooxk1nwhmv0BtyLUQ9Ra590GVDOYgLXXHU2aygntJfUBTAcT+NwIlX7qGqsuqu7khCmlY83qVBwv3ScJzwr37qlBurP4ag4n5+whg1sxezdjQaI7Cz1eScJVRprANtE5BISC4fxDBSLalcntXkSV8ixf2ncj6KCV6z3xjR/c3rZ53J2cwKWjVW1H/TCtwnjD5CQVR8sMcBC9t9GnVXKbH8f8CKAauFCs5uLsdoHr8bPS2Qj/ozaXHkGJE+ga2drbSae+47LRx7v7TgBg==
X-YMail-OSG: gk3jNI4VM1lRoA31vc9Eej_zJgfL9EaXtUeVuPY9pgSXQW7FoyVal3nRFv3vxbZ
 ACPfQ0CmXQu3tNDy4LSEeTlSrRC0uUyDjFHXkag873Me3.gurwsdPV4EwXpNxvX1dxVRgQeONdPv
 R5BEUU7hqIoRdthq68HA2Y9_FYXxzG7hw4l5hhsHTnpTTwUC0otpgyUaN0qQQICGApfHg1PaK1ko
 cvJPJbDmpHtfCvHYszyfuQ4T.PT140f5WD3ctr2gneYD6O8PDxd80gt.TDYxT1OlaJw6YP_YCWz_
 cxA12SZtoDzmj22EdMZ3JAgoYQsJGl_8AxuZ6cKXvvipNxE6dlTEKz33fF8uKKEcpWbNFjVQ5u1L
 kxVBBPbDAjumjRYpVH5ckMNbgCPZDnPgPtOaLzpY5TrKsO9XFozegbkU1A2kXtFpsZr_xbW.ESxy
 hBLT4cTpsMHRFNN9EzZ8pIU2Ce9zE717RGsRiA4C6Dcn5U0c1sI.vB_ViTgG1.jFl.ntcvNGQdPA
 jWabgHE8hBwLAvsE5Lei865Nh7DI6QzOQJ3SVisgFNfbB5wAbaiqRvfRX8M2Ur4mExLYlHmFRuSd
 ylosIDvVAN0eMk_qyBfaC9gR0ELJmozAZoXym9fQ77DzdKtx7es7jXAKrvRJGVkAq6M8UUde.Nhp
 yMQ4GSdQdeH87giq2.cHg3HI4NxhZaVBVoG7ls19FfTODDW70LClIZ.tZR31t4NW80_zUWXDdetQ
 vNmqpSJ9E0pxj2V.MBXEecdPuxtfZ1ch7Ahvnt3LlJ5DPcXsk8KBJAfMdQmkF_1_J_W6qVKMTvRX
 wOCsvXJCzFyoU.mqQazszSvZLJw0f.WzLXFkryR_gCO89EBO3jSZ6zaAqxKWG38Ype530tQkKAuP
 XGrPyc.hQq1fDQbAbDHBuJUU1XTrT3BtkPLlptgaIYNmLgLKXsy5shFv8ISBM6TNrv5GB29q8w09
 dabY8uaSUSd7M7fgPD0wUE80CRRJsHRb4SClJy44AIn3VD6P2B3HyA3F.fDeShzXmZOOQlLymOMZ
 lrEsIXYVJvIp5eou6tE1cScT6N_nclOjf3iTdkyVOztLoQqCxOOLujipZ4Vw4n95o17B2pGWr8Xp
 8DXatato7wxq8fwkuvScSMZSDnIchMxdRUFeXmU9Fsj.hSr_qD2T4iQny86qpAxmtbjP9UhyzHaH
 Yc2JIuRaK6PBpoSCY6ereEgnrtkZztmf8STLoSmQSTFSXNi6ZhJAH_L6qm28UEEHg.WTfXZz7Y6y
 6I4SaDt_vapDimdDn9.PKdkD5xJmR4hFh60kVmaaRSCC0aMyrTSDahr8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:14:26 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 93f12d8cf3f8020e3b32ef1a52c7253a;
          Fri, 31 May 2019 23:14:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 27/58] NET: Remove scaffolding on secmarks
Date:   Fri, 31 May 2019 16:09:49 -0700
Message-Id: <20190531231020.628-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the lsm_export scaffolding in xt_SECMARK.c
This raises an issue, in that Smack users have been
using SECMARK_MODE_SEL, which is suppoed to be exclusively
for SELinux. This is worked around in the code, but not
fully addressed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/xt_SECMARK.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 2def8d8898e6..9a2a97c200a2 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -55,6 +55,7 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
+	lsm_export_init(&le);
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx), &le);
 	if (err) {
 		if (err == -EINVAL)
@@ -63,7 +64,12 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
-	lsm_export_secid(&le, &info->secid);
+	/* Smack is cheating, using SECMARK_MODE_SEL */
+	if (le.selinux)
+		info->secid = le.selinux;
+	else
+		info->secid = le.smack;
+
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
-- 
2.19.1

