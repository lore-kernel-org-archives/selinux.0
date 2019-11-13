Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B33C43141
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7B1206EF
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uZRwzA+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfKMSZu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:25:50 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:34975
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728590AbfKMSZu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 13:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573669549; bh=NcVBp7gG9OmyqrvKJzXmDANHTV0iHKZa6J3Ph3JS0Bg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=uZRwzA+xSR8SSbYI1sd43uxK4Drs3bz8HLR+I85wxZ2h5SWKuxVKOtwHokMclwHx5ufIMoSFZTSE9gbNuzzs0Kd1RFNxgb/F2KmEIIsju5GF3oAmiVhIUQmnS6jkgORXU2cL4LxbcGpCqSuFF211JTlGWHyn9/gaxDQyVjzSR/UpgS45ZsP+oUtkSynXc4LsmByKIbSqpEN+xPJtumMAnvwf+1uH6u76xc/6vG7saCV3TdUnd+wBSck6YBDdx8RlClJhLKr48H2BsGVG9ck3pzs9cVtX52OcXgehfg0XgOCKiX+lSNirSGvcthsz94PIa8rB0hn/VUao6KS5iaUysQ==
X-YMail-OSG: 3YKIobIVM1mXQrYDZOx33227.zdZLiIpMgd9KokIeH8I2ddWAndxIgbmbcyHLuE
 mc4b4azl1ISUnoUU0VAOWHeX1ZONhHxZ.33myyw1UpTUCsB_aTt5CEf79c6A7Iqut.4uXPUaX9uK
 0TSITeTqmk9wpk6Kyic3kfoBW5Hi2U5KT8770Aen3mM4dAMI9iCSwAWT0DaPqq2tzzwmg3bEadaq
 bcG4m2pTkSqfxu5n_fNNPgY3Cdq42XiMy8VCKFOMjXTVnnE8KX3fyFOeIlFPwkLX3yJR.bNcmWr7
 VPGDpPzyP67hEC1e_TEl3GrXXWY819tAGn.xY6_Pt7OTrwF8N4X3qSfUDu6m.yOkZhFrXGek_ueE
 Afsci4CyRrYzNlphy3KTDfMYBWXyn_hhzhD3m8h6dipONZvWxKuHi9QssPMnKI2X2gHrf3_hcUMG
 Ti79y.iq8UOiCs6tWY7r2JzAOuYVHDMwF1f1RXYolnGc.0nKhT3jZTI64d6g37gHbpIIzmbsiNTH
 YXU3hCZ5WcdJdNekonu1v7f302ZzVlXaN4JMIBseC2M9TVA7BPILA7G.OZJn4DuUekXbADNf1VX8
 rcpFyxNIQZln.m.SmZkgkKszWwXohtPcefdfTsTAn1Ct7f7ST_0XSSoQIarNGyNHkqsfDjvkf0El
 bZD5YcKzJvCnoF98vyyEf4rL3WP2pb2BMEkcsx5i_PlPY9FAXsVJkVO7UO6QfhoKQOZ2x.o8SXts
 va.kQyXVpyfsH1zoKLZcb.jFJrGONiwh8co.RnqlATSLztow0HtTn6t8plWqI5IIPATqz1S7fFuR
 .1F7rcpZgOFksO83XOHarG6c95HQ6brQS8jxbRRKSEB1COnO6fXVYqUQop5RcT7c2_Lf7za.pYNN
 FZhE4vaZBUiqEVG_85yasHILrG8szBgyvctAygy8Re128nK5FYr3yxastmMAKVB30.UvS2V9M2lt
 IZta0hROZUbSaklTPNUqNwx.YkzbnCp_JWUwn4M6q131QN7V6NyN0fvitre0CRANVxrXNvfviT8P
 AlBPEYvK1xaBT73QcULiFlBlp6.F1emX.PLNFBnUmrRBYGcYSs5aGL0GCU7hVmp876ZNxHH25xQc
 BNmtalxYh9WQ6PiLDObaC2D7yUH4fxIxlCgI5tAN3cxsROD9uUuAfrf7Im3lxJn5Kxa6F8GF0.uk
 _A81P3ie4Nx8rSSSZ0npc0qaeH1umP0HxGiyu3gUqUhhZGW9PcIfKMKzgC3fyvvh6NnRSTFegTCx
 o3042jYI89ut811wZHaTi2wdCvPmaglwEamW.fJEv3zIvCVT2XaXQ.mXaFKUEn3K51_QoUZTj7KD
 vCun0oZd7r_6WTQrc0UT9nocwuWozNfATnPQj25k1.iW27GVDfzBRC8Yy2C6R.BzU1Hz.QBZMiw_
 JAbTiAZT.bZU9ERxCtLK1EwnGhMbQ4Tuss38ZWgIDmfdsVJ7kRknODCT5EoAhP75nO9HZfYl8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 18:25:49 +0000
Received: by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 12d4900c069877a28331491f4321a926;
          Wed, 13 Nov 2019 18:25:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v11 24/25] LSM: Add /proc attr entry for full LSM context
Date:   Wed, 13 Nov 2019 10:25:05 -0800
Message-Id: <20191113182506.2580-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113182506.2580-1-casey@schaufler-ca.com>
References: <20191113182506.2580-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add an entry /proc/.../attr/context which displays the full
process security "context" in compound format:'
        lsm1\0value\0lsm2\0value\0...
This entry is not writable.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-api@vger.kernel.org
---
 fs/proc/base.c      |  1 +
 security/security.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 950c200cb9ad..d13c2cf50e4b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2653,6 +2653,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/security/security.c b/security/security.c
index f1fefa187ef8..7e5353f98988 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2099,6 +2099,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2126,6 +2130,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 		return -ENOMEM;
 	}
 
+	if (!strcmp(name, "context")) {
+		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
+				     list) {
+			rc = hp->hook.getprocattr(p, "current", &cp);
+			if (rc == -EINVAL || rc == -ENOPROTOOPT)
+				continue;
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
+					cp, rc);
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+		}
+		if (final == NULL)
+			return -EINVAL;
+		*value = final;
+		return finallen;
+	}
+
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
-- 
2.20.1

