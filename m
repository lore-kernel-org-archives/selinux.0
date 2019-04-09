Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE60C282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E84C2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ALDg2c3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfDIVlx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:53 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:35709
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbfDIVlw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846093; bh=XFEQORQN/Rrt9xNIMHTY8NF01S7CWObpcTiWCO3b0pw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ALDg2c3CUkbVFhccDZctWNBq9mwPw3XxWgPvdt6/QvaXif9T4QdSw4DdtcEf56RxjTDZ6zC+8qcH5Dfl8SdsxrX2FVX7zSL2wQgH1NDcLm3BqToCMmCs4ud+vsBP7RVlYrYdmpVb1v/r6TPwiwq6Vtk34x3ZpaHAxn3FqSTaMQ6QZ85lI0/rdDTnRvDwFw4givNZ0ftW+KmkWuTjKGSo96KBjIb1OJVZbE1n+MXVr9gD6YUzJVwrHzVDYohy+038IpoYec8VMPzl7tGYGwh0rjlRJsG7SQGw6bNzMtNjV1bHesXZJohHA5OSJ+9FegYqSlGv2wMtBq4aSFUi3W83ig==
X-YMail-OSG: XG7Ojq4VM1luQgZ8Dr_1LlJmszDBVkPvTz6OcpWheNH2gXwGg2DvV_DtAibAoGh
 N6.AfQtUm8ho_g59GdbAyyHyFyT7fWybHygbKJSEtm8rLVo8XoJJ8Bb2KRuVk51RXcNpi0bKPmtN
 vgeRHPropGAFXL.O.D_t5tPKbRzJcOkr8Pka.EYw7bt3fvKKQ9ZssELiX38cu.OrEwL8JU5vvBpP
 CuufxCg8seecXve4TqTW4Rg8Xdbnd8wiKt9E1l9aHyVW0ZN1JcLUSbaZqrbquVk3KcdD4YWJNiKB
 LSNBFO3EKXgPTce7Q2psW2HTiomDCUA7DEBu6oho9.C.8xuVQPxFF4euAK7ko3jP04Abcu.RxSW5
 mtiBNHB2c1fi8TFTiGzfPo53MYJRblHQcY1tAWiqFalcyRhedLQclqtjWCGh4IZaGgWQhgiKXRlx
 DU1mWkKODC0znr_2qBo05WynlGK6lLD6atP1rOBZ7GA8RQ2_6gvGh5nh5KuRIiepmbNicVu6tCyM
 NgzZFepOay9VkurkTPtTQqMjubh6utQ0Cf0BEScrYYSdQoUGHNzNKs29aM3TPodET5614pWvb_WW
 rcVgrAG7H8ortwCIHHJRv9o3QRU0VB8lHoIDOlUaclcDe2rZPnfXrSx0Z2ICSCf6coxDGVA_ZCkZ
 7ymYb6TtGFI51P1SWqnZVaO8KKrhUYf2JJ9hi6PoO08mEz7925lEVlOfmIjD5cQZtRAyBrT24pBI
 P7QW9LT5Ssza0OeoOrfm4ahr3bUYBFh9FSut5wJ5ak4tvd67pmCr6ZyS02KeJMJkLc0DPUYgJpQ_
 j.hX9zkjDtKFbj9Z9RtPjbSoQtV37vniDHcJVoYAlYiaG38_9J1m0.SV6MS0t7gVw1hv4o1u8YkQ
 LH6Uyv89.m8UMZ5Z6hiEtfS8_T7A5vz6WaR2LerzFxESv8mlx20WXiwpY3EI5kWq0qHIacPutvQY
 .MrYjS.PMDQfpeJJ5EdqKrCoGrW_v5W8SeGG67XOE.OvAwVFQOonx1hkggU5fynDEW55VuM_zCYv
 pZuCR9xKrXOkfVwBBZobIicmIPHQ9xCrO6VPxvy7hLLa1Kt5cTlL2xpN2_n27sYcSNBSg_ehEFSK
 OlBV50dsDS9oQ4dngvyz8lvgeQCZaHjyx26RwoZrgTLp.UdtqitmqyrlzSkznUw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4c017142cf03fa35170466cff726262b;
          Tue, 09 Apr 2019 21:40:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 34/59] Smack: Restore the release_secctx hook
Date:   Tue,  9 Apr 2019 14:39:21 -0700
Message-Id: <20190409213946.1667-35-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The secid_to_secctx() hook has to be balanced with a release_secctx
hook for stacking. This hook does nothing.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 38ea48d22547..a837af153ed9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4470,10 +4470,11 @@ static int smack_secctx_to_secid(const char *secdata, u32 seclen,
 }
 
 /*
- * There used to be a smack_release_secctx hook
- * that did nothing back when hooks were in a vector.
- * Now that there's a list such a hook adds cost.
+ * There smack_release_secctx hook does nothing
  */
+static void smack_release_secctx(char *secdata, u32 seclen)
+{
+}
 
 static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
@@ -4713,6 +4714,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
+	LSM_HOOK_INIT(release_secctx, smack_release_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
 	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),
-- 
2.19.1

