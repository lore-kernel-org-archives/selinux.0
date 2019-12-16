Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1987C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E5721739
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kQT7cKPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfLPWik (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:38:40 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:36328
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727833AbfLPWik (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535919; bh=GxEWr5HgHGsSBsXd9YqS3jNBdjUlWzqzucoAC9IGxLI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kQT7cKPX/MxpvBn2ugxIex7CsTmxoGJt/YhoQYX73ks9nrIuz7sNHIhIyhVdnUYY5BndCLejpK+0Yv26mujApUxqcWfO2gcIG8wt5WsgbJVpn5udHC8ylE+nyq0KuMDRMqDYyHdkXcuwpbISpm4ohT3W6yw9WguL5iS4+T8WWCJAaRtiTpLJHd7L2I8HdjVmD3ZYebksDtzLayZR+zRa2C1yOc+QsDaRgrd8odn/rnK5BPE7ET22OpTK9xTXvpqmYTDWW9COyEuR9n0+tXOVLtg5wz9KW/gyqdqlf3bKBweD4JZzha6bhUXZlAdI3kHqs5en/Taz4KGgXKwbVCymlw==
X-YMail-OSG: mMR0fP0VM1nDqP9IuhlaMurNVOtUH9NgHJHC99o2B_ltGegchxmKBKS9k.YbIQk
 y1WAPCdQ1si0MpbNHOT0tFgxOF1_4kQd3O3IdgSTcvzz8V4itQ8BvEI6Owo9Zs3zVCc9fIXtT.Vu
 ZMDxWdq_dVHyedpBeuXExQcvu823tUSels4bFNvgESTxn47BlWjmn.jGY.WOd0OQ4UN9twk.eQIl
 Ee6GV3_CZTUV6xREIrXBOVFBGBomJYCbo2Xrb8VdwCN9vqVERBa16f4PeIv8tLpp_bJ4AxuJn3Uq
 fcc8k9aUooZgCnU6LNXDH4fibWAcMmcJ4OV52eXeq8G_S58icilaGyqqerYvLBeP.kKfZTGA6CFB
 kH3GGh_ZpOidMA3oPhfNufEWFNJQ18Dg7vgAprU.bOhlyOHbgXA4Xs2N4Vk9UJ_Whk9wBlLCegHt
 InGHcTw5VIt7YEVCu99ezYvGU_hqQnvRU0C0xpNx3OVyT0zvx1HeRGTEKwSxZeeP.PjEz1y_zdHd
 Dg1142AXDOSzNDy9Aond0z4E4geas9WmLCKO_L7OD5tuZMELl2z8Z6hZUJQ9BcB2o29zQguHplFT
 h0Uh5Oo8ascQdlr6mThEDrXvII9YOgzaHJoep4nqFq6vW4nZDSjb0kdNbxkSHPQ2fpBRd7ZWIQ7L
 6U5CqhO2R8Y_eG496GlmV9ONcrIPxT92o5THlkMeZq6hpbCel9jj.tkqbGXDq2LhhS5UcczdJ_w6
 .BBDrvIZ81gjGEqTx8_bgzH_Lx17X9bSPe_M65nvpxiWKtkdmO6Wi2pVeqMT_hF5coNy0QM.8x1Z
 2hp_O2OKa_QhpwoYI9E72_P15Lut1X_wHQZ4OT8j9EtZFSOnYUgBgTnHB9tnCSywXw2SmJNgVOj2
 Bhgy.GH1O.bP3wGAPc7MQ4ydZJon0pUbao70sk5G98V7DCNFns.ck.yY1_DXKa5c9Ish6qBsSTAB
 XIoTU37DRqHAoX_i0m25u5YvpbiIT8vava1TdAhaSWGZ5mvyyrL7ZllV6BjXWZ2ijelUO7hQToaz
 to60uXzGswiJmCX18dvM8LmhAw4GYM3fHi1ozU4u9TsT_amlJgw4owQINktAFCZVBUlBUhwaY.aP
 V.SSu2G6CZMvkTHEz5YosIi7muD.FKk2oOmp54XtxdQFNjNr_CL93zSWRW2jMtWRutqc9WU.Toxm
 M2hQ5Ve5N7qrbgOhKQomFj9.I72yJx724cPukkK7uc_tcJamGBnoX5cLlOSIZ5yiG2sxYMc26XU0
 Horo0w_ueGAV_QSmHCHM4pdT1wrEFtYI6705K0SFgEWcaW9S1hJYMGnppvPDkheOcf.nEj0ARso8
 efoYNnKYfjxtF0_4VWfCgTRj.oODN5qwcFQv53eK7qZBm0UbFbZKUKN2uk88oY0Wq2REk1bxRrTU
 .nKFFoblQ9M0g5CA2ntkTbvJ1wFTZW4CnZLUAcfn7Lp_N9rESjAynljnO91Xnd8Om6wOeIw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:38:39 +0000
Received: by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8674306002fb398816baaa76923d69da;
          Mon, 16 Dec 2019 22:38:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 24/25] LSM: Add /proc attr entry for full LSM context
Date:   Mon, 16 Dec 2019 14:36:20 -0800
Message-Id: <20191216223621.5127-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223621.5127-1-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
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
index 1afe245f3246..e55789fc4cd3 100644
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

