Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31039C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35D8217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Vp93SoQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfDSAtV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:21 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:37264
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727055AbfDSAtV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634960; bh=AFDO0iF9+OgK65IBpuL1G9CHqioHua8PTEYc/McmVKI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Vp93SoQfGoRjotdCMwW1W63+N8zlGmq6F0afcGGHnmIbLIIEBxQqEI0gikgNn1OTs+0IEe4WTDdb3RrfTSywuPDSeRfWdzxeKPJTd0uqjuN0Pp3sAins0iHoqhHAVAMxZy1QmHEuz0nbHPRJCVZElWmpspYzG2s+g7Tt2O9y5q5wWxKSei7bbvXHLi8zk2q4/jq5afJ09GPFq3Tg4XkgCeafpiCNuXdQS6ykRdop5N3qRNVVqLQ8OQrmfBioadwy0ngrtTOJczOE1f6YWeF9c5miPAVhxOUrl2GnQj+gv2CoAugzm2nB/Kl1h8y4rox7NhwswbGPjK59QDK7ojYY3w==
X-YMail-OSG: RyQ7E5gVM1nb8ED_Kvl6e6I8vKetjq7lsWhSaVgvcW7ZQHNu_KjXsFHjWlk7gCY
 ov6Mw44NQPr9AuMu09b3SEE.SAI5qkORBYb6pKZA3RAr.zdQgJtQvaWBebdkXrVCx7V125LBuQIh
 IsDRUSlPSr4iyqZY4p0yzL2zM44.AnGZGvc1I5QXggd0VSHz5s7PNXzUXhbttVjislCZ2sTaFRKq
 dOYmSrgX13zP3lZGA3oRrwxWbA.amJrYIsasR_HmiHrPzw3CijVUaK0yDSGAWzDG8aZKbpcWvGKe
 bhEs5.npt76yr.tTuiiIRGxSIZPomJr7xTFeHLRCn6EbAu7Y5rxwrwVk79moCjlqG2ACSNPelaw9
 n_W35B5LPUff2AtTR.yj63ZmCn4gr54nufmIfU8FDCBbb7nf2tu0fJn5gi.g.xhSwWSvgx5Kmzxu
 fdIT_LuyHma296KIHua4tabR30F35ZykcfC1L3yiZNiay7z1P0Q6tnff4U93g9DQPhSfjudkVPtP
 uUthIxNNBhpuQx6gppW8.k1MIAJA7A6hIGYIRzY89Gt3YKIYzTAHtCHJ5hnmXZXR1d9DzgpzfkaY
 NzhkalFbkt7MgrYAAHQqU072orSlzVwsKgdFKtC8wTV568eKWNR6ZL99nUwOm12SO8X9U26mo2Dw
 wMFFVQAaCUkZ7r0VbyncZ25kmNQVSE5MsT50HZXepOlVYHMds5kdjO_7CH9OskMq0J3Mf5yV0wz6
 l1tBcfpf13VqAW.uobrec99I8Hdso3HjkY4YJShZBYU9OvJsmhy_Yhj2uNEuySRN7vwC9L1bTxos
 j6iSffmZNN8WUYoZUWT9Y2eTHgQjcprod.ingpcwU4OeOjou8ZzRjSsc3fRkKSXhhXHM9LYkDJ6Y
 cnHAAiC.T6zcQXQeOa2ChjVWiPlrjpDuPQ3LsGcfCNsH72r7Y7SUrBY1XTnqedqBbVBAsvtVnjxo
 E5.ErS7B0KXEhWB81dHNICYCZ4iZWcggNu1aJ2FIf31LKXD3v.zK.gh0Fh7gxnn3Qn3W1CLoD_Rv
 6Ohb2DwnWtcyArR754xwmYCLEBAv8w26X2yyr07XhnIc8wcv1lgzyEPHpi8mwartuuLdg8F2xcPl
 jCQIdDOm9UonbFqR5TfsH0z4lSNVXjZENWBu7JCRoqWHbZQGx.4eXqbXFni0J6dRmZN6D1cy63d7
 MhBnAp5e0shn5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b2fce6e68c800904f23626e111be9fc8;
          Fri, 19 Apr 2019 00:49:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 76/90] Smack: Set netlabel flags properly on new label import
Date:   Thu, 18 Apr 2019 17:46:03 -0700
Message-Id: <20190419004617.64627-77-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ensure that all netlabel flags are correctly set on the
netlabel attribute of a newly imported Smack label.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smackfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index abaa5325c32f..0abfa4315fb1 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -931,6 +931,9 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 		smack_catset_bit(cat, mapcatset);
 	}
 
+	skp->smk_netlabel.flags = NETLBL_SECATTR_DOMAIN |
+				  NETLBL_SECATTR_MLS_LVL |
+				  NETLBL_SECATTR_SECID;
 	rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
 	if (rc >= 0) {
 		netlbl_catmap_free(skp->smk_netlabel.attr.mls.cat);
-- 
2.19.1

