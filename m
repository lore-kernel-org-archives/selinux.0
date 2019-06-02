Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E4BC28CC5
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F47E2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Uo/GwInd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfFBQy2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:54:28 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:42514
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbfFBQy1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494466; bh=cP6y4hrQLvKO7rVafzTnUGAgt8Nk7i9nw+ffKlms2R0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Uo/GwIndgAFwKamLNXPpQ93CcF4yRqfOXnxFRiMxhOoskKPM7IXL9lVAVOKLyWoLw1ap9ELvqWkqbcWmKJOa0KAj3KuLw5ElnxoreguVzxy5nZXYL7ncnnw0DNT1Xj8JyhVzwSIOe+Qjwp6Tk+OTGBI3/evNDNF9zEeB5gDx7f9JpFjBTsoCHX1vLO1YdgkA/gpmzkURC1RLbm9Oltkvb6RPx2ym+Jbf2iUvN69GhCYPWm+tE0ixdxBXwanoMFYes+yzw9hV1i0UW9r2Xz+Bw7b9h9lLQRKl0lL3gLOBahaTJ4m/bl0mSFKOtgjX1vsV+MB7ZfAPb7oWvDg69pgPog==
X-YMail-OSG: fGIdiMQVM1nANqCGQk_a8h1ICBuptiwks.4teHBLSFw.bbE5pxAAJ9R8J.sFg_R
 rqKo9aSjGkT45zMopfTOOKxwBvwY_fPiKySjWoiYCp_C4U4.CGbEyQb25vMT.xPiNFrdJuVwlhvr
 ZyRhpGaI0CXeA3z0IBU8ZWcRwYd.cgxYR9AmjYUbQH09h86fo1nc_Jgn_d0yQ8gV6pZu6g4iasHq
 vAzJRgu8TRSdBKNjJivXcjIBCM78lVcWF1AlRbAFIVZo5UGlJ14DEP8S7l8oHN0JusOMJECshqpo
 ZlmoNIz2SysxMzEjBZM.zB1g2HN6QRJanOn7Z839p9uRhcRePGDR79D8VWB2YDtevqquEwND_Ihm
 OrSKzKQIRzxwGpO6LGoSKJMh5S.lrZUrJt2qDyAk7jv.gJO5Fb307Ul6nqM2nYHXnDRP4jnsDz95
 SyleiPCWJhFWzZfaaMZShbGMR6qlppySDMrW0_kG9kmp247Jr3oN_SWr.jPo8EPHtgTCeguGfwmJ
 U.T.TeENk8iC_k_8Cv3fJh7vy3MpM1ICJctB5PBOtlvezr0cYHUNSK2ai26P3F2McsQsyL2XKvyY
 R18l7pqPm7eWmhp7DgjvbH9Bd2H29utl8X0B7WXBjf.wZv22qsPIsIMNMc25CUC7l8ld5ZN051.h
 wJCZF1Tk5gzHDzSGa5x2xiblVJXuusoPoAgTs8Gf2UwkhvHTsi15ngAVp3PIgEfjDb_0ENW4OFx2
 lwC6BR1LtZnQSYOcWkCeXRU3c0P3wfWQnl_aokuqowpFSA.BxueaZ51J7W2s8VnRygg.eDbfG_85
 jF2lFVHBf3tjteE28HVAtgB0Y96UQc3BEVNqhzzOqIOEIe.ZSugfcOsENVj2WSX1N5ORRwxB_5SJ
 9Uc_BKnqQxOJayXFPC38onTFrKglTnc3qn7EGent5WDKbVTGLUavdM_RoYcYmMQfA8ZZPxavCB1n
 0Qq5vJyEISSfF2aAEPnelB24VLYHseLVwONzTfvGArc0j9QbhK4L25NmUDzmaZvIc6lt1X6wsbVH
 U5Vs0FaE9cqzdMEP0EVcCqkdpMA467j69pPTV7mMjBvtud8YoTUeBe_S57BbosSF7NJxXA._iy_v
 NQvDD0bj2Z8B2mJZV3VoCQRzWOYZYmJknDGUi9Laxns2sK0M.4.7eCcLwjQzYmvNFdYRVLHMkb3W
 IYfVtug7F7ao8ykrzhe1FA0SkzeVxLUg2GNDBcDUUBEONdzs0.UeoRSIEZMJz4eTfw12fa6oGuJT
 kIpxZKqI73j9h2uPzGg9IpJTIl0jc7uTOh6w2HGYITXUk8AQVfNcb50j1mlc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:54:26 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp418.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0b8226328c4965373e1d598ce42fc97b;
          Sun, 02 Jun 2019 16:54:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 55/58] LSM: Special handling for secctx lsm hooks
Date:   Sun,  2 Jun 2019 09:50:58 -0700
Message-Id: <20190602165101.25079-56-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a special set of LSM hooks for the translation
to human readable security data.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 10 ++++++++++
 security/security.c       | 32 ++++++++++++++++++++++++--------
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 088985d10a69..d90d953c8ef4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2032,6 +2032,16 @@ struct security_hook_list {
 	char				*lsm;
 } __randomize_layout;
 
+/*
+ * The set of hooks that may be selected for a specific module.
+ */
+struct lsm_one_hooks {
+	char *lsm;
+	union security_list_options secid_to_secctx;
+	union security_list_options secctx_to_secid;
+	union security_list_options socket_getpeersec_stream;
+};
+
 /*
  * Security blob size or offset data.
  */
diff --git a/security/security.c b/security/security.c
index ae43735575d6..b05265ec24f0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -420,6 +420,9 @@ static int lsm_append(char *new, char **result)
 	return 0;
 }
 
+/* Base list of once-only hooks */
+struct lsm_one_hooks lsm_base_one;
+
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
@@ -436,6 +439,25 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	for (i = 0; i < count; i++) {
 		hooks[i].lsm = lsm;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+
+		/*
+		 * Check for the special hooks that are restricted to
+		 * a single module to create the base set. Use the hooks
+		 * from that module for the set, which may not be complete.
+		 */
+		if (lsm_base_one.lsm && strcmp(lsm_base_one.lsm, hooks[i].lsm))
+			continue;
+		if (hooks[i].head == &security_hook_heads.secid_to_secctx)
+			lsm_base_one.secid_to_secctx = hooks[i].hook;
+		else if (hooks[i].head == &security_hook_heads.secctx_to_secid)
+			lsm_base_one.secctx_to_secid = hooks[i].hook;
+		else if (hooks[i].head ==
+				&security_hook_heads.socket_getpeersec_stream)
+			lsm_base_one.socket_getpeersec_stream = hooks[i].hook;
+		else
+			continue;
+		if (lsm_base_one.lsm == NULL)
+			lsm_base_one.lsm = kstrdup(hooks[i].lsm, GFP_KERNEL);
 	}
 	if (lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
@@ -714,14 +736,8 @@ int lsm_superblock_alloc(struct super_block *sb)
 
 #define call_one_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
-			break;					\
-		}						\
-	} while (0);						\
+	if (lsm_base_one.FUNC.FUNC)				\
+		RC = lsm_base_one.FUNC.FUNC(__VA_ARGS__);	\
 	RC;							\
 })
 
-- 
2.19.1

