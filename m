Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B73C282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1872082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gIhL8ezG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDIVlP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:15 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:40449
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726875AbfDIVlE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846063; bh=DXZobVlHba7NLExIjhRRZRkmastZlDIkiPrs42J8njM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gIhL8ezGAimS0SOypVTcuu+w0h4akRQA2zkugJAtJEd9VLg4/wnsPXiPs+nqOh9acQOzNTn5WuZ03piWa0Z3ug8yFqwULG8dGORA0BKE7Or1l4gpCjUr2ZkSHW0Jlus83Ppu9PAhdO6K12jV/Sy1PBEgnQOm9j0A13q2JLQQDRDVPamC/38T1k6FWFSnZJgkfjRjp93HvLtcMsGC/SBP0poULHhHwSe0gny6TsdhQwXqDgDCw4LiMvZ5Lgoit56RUzHDSI4GBvKjkYdBSA8EdhWh964fwT7YDWJ0xJC3enGY0B1RY/fPI4rs8tQM/6bqKf9qba5hVrCY7UxeOphYzA==
X-YMail-OSG: dLy3Z7wVM1kwrF3sxuZW9Cv_QZy23tBqj7Ev0q8LNyVeuZ2Os2JDUWspMt1v2xB
 wJYegWM3uTv9Zqlw..a.YSHAWVbkjO4PEb99rVV9CqUXs9Nw9utiz6wXwIBvzj8AqKk7t0VoGekG
 RVsv6rpzk8S4CFo3eEHXo6DSKg4K1UEwauUxMWXCRIqcoLcL8W6CRnwZqrcDr_Le8HYqNhnoVfQ8
 Je30WqX_HNsSFERLKoqmEIRaqMl.TpSnNsGE2tSaaHyuxhidqcPnlMeV51dCqutVT8NOWCC8VzOp
 4XuBZ..x7f6Hpd19swc_4zM1qJfsR4HCN9clOKbyznrf.ZWLxkqT4IMHoN8vVUEDdBmGu9OvhAVn
 uHXykJBh5sb.22GcJYIbAsALDcvA1shyf3WvQffx1ddLEMl34KAhFrNoJcW7Ulst8SvTAuZwQRlW
 JnklfnWz9sO5ZwVwxwtTR123Nc6d.QAI3kXYgWOLANN3gqULxbNfXrSV3HH_7yMzxTQFiHTFAUU1
 hVfQsLpjJ_pYvA_m9jLlbMstHYnEgxydZD5v1JK0i3_Cu4JoQJktJvTyfo4Qt4b44Qs4N1MbqS.3
 rl_gWwOqh2KEi4_Nzz5Hh6L4do2IFxzxMLhus.CZ4ktKyY5_IpVX8ukm4avLRJhbNgkZHVDWD1en
 i3Od8j8IsX7vyt.xyxMiAytGpU8n3MDweB7Hb8qseW6vqHlfHHDE4KGfeXh7YH8maUz1rrcdSJag
 KqQcdJ9uE4MLwiWueyD71e.rqCd9wtO_Ha1c53WXqqDPtrLANhTa2l53dETU9QRC7V2Hq4miEgjQ
 uDzBwqpuActE81JqRitp3LW3tpGimr1whtYp6MEk7Yj6p37.Qet1v7Z9tzcrFNEPe3v5ReDV2QHL
 Y2OfG7Su1m7ZG8HISdmrfjQROOIRtbx6VG5uFyA0z.1KFc4zY_7HWRCP052R23uPfFwDUxML.0Ok
 lr6UROB4bxol8FWoGDowOvAXW9He8NthtXP5xzhVD2qCQo9O3em2EE3gKMoiXoSDcP2_yHTsG34g
 zXvpihlHw4SIPmclLc46GMUpGCSAaXoDrRr9ROmWPBIbkpg5j03WzirFvIq9Bt2BaRxcEC_DehP2
 iXAFvoWtKZrAwadh_nPKjWiym6hPu3pyambtCfRHuONCbpwmiHK7R4_22acnVcA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp407.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0f9fc43d6127678694d9e39aed29be56;
          Tue, 09 Apr 2019 21:40:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 28/59] NET: Remove scaffolding on secmarks
Date:   Tue,  9 Apr 2019 14:39:15 -0700
Message-Id: <20190409213946.1667-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

