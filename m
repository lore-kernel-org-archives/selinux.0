Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DB8C55178
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 00:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3835520825
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 00:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CfZFa4At"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbgKEA5s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:57:48 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:37540
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732099AbgKEA5p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 19:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604537863; bh=U5bKWCQ1u99Nru5o24TB+6IKzAJnsO7yXV4aGiXz6j8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=CfZFa4AtkOxc9/v1plpCg1CMq7ETS/GY3o+nUgeP3xU+ybAhbQsHu89F3Xnt3sWF29KZWejMYPKUqAUgx1mdIBfX+hlI9OCuyLvzycP4TXE48Zxd5OhmGEfihsdXC6YYBTRSZkcUDb1HhxZhzucoM8AIR7vEO3PnITaLPFf2fcNz/L7cnPF4gLfR1rmQpFdlsj/0k30pYLjApmyC36gqfh8/VuVnnzMfurffR6JZL9D3UDlY07YXw6MxtWUkvOYsRJepWsrscQ0vUJhp0WbZBDCVUFRkF4eatJY0o8vE81wWCeGCOIWBnW4/4SSgdnVmaxYNscZwAYW/X5E+5t7mqw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604537863; bh=iAh/VVbax+d7+hk+d1eyxd2ButG3Bxb6+bDtoDBjY5P=; h=From:To:Subject:Date; b=KLrNwKWUb7SzIeKJIkFTQJQaA8ltkHX0Y5mRjRdq3Ux/OLrbzcE+pOZi34M5Gq1A9RCwFocdSddguDp29683wOXyynZuU5XhBicQHD6CGuwBFb8WH66htymaxkayb3QG408y0+4B2iXp7C5ClMB3m+bX0Tp6yWB3aN0axgi5Hp1smMGK4FZxy51mZeX0tZjY1fGCktnzDLt8YgspyIeMnvESbq++uUDf8WR8cmS80EeYLKDWmZbCfqGzY3kE4Ztc94wRbL4u3z9+uP9Rf768/szm9TuY4ZM2LtDknSME/kHOaVcAHumvAuSVhtcjDUIpIWCkiHJSUlae8za3ymzh2g==
X-YMail-OSG: ERZ.FZUVM1kaasmE96o3aBGEGFsZGuk8jBOARffVuaQKaEFpuzDa1H6Ehrd0EiP
 vHQM7c3qcEhiouVA8nCIwiZoqFeh7QLubjw8QzDbLvEMFjVKtzqSDOBmobLYkolpZ3Z1UDkk.bNF
 DYF7RB7K9t2E6ZIfhGTgxzAntUkhwCDMm_hHZh5jVk47KDPqXQk4ya0JEwB8Noa2Kr5vgNGZzY6s
 bdC.lifdwXjDNFpWgC46CdR5VPFhOeQE4.6mi7xamBZvdPi0xkxPNFRBol0OlW2RpNKvY.wq1sjv
 yeYcjl64g6KMwY9mrmtLnCbtw37f0eSbNXDbcyUnWynDD71LbfDs8D6hCR.50FBE8Ku4bubtsxqn
 ffeg0XliyCoFTGL9fAqpI9BDmO6xrCRMDGII6bydO.0xREiik1sz.hIap4UgUPTWFHfiRJj7xKIV
 fyFrGqSt9ibtmY2ClxemvG4.0PRjnVColAsI_JcozRZnKqIOQ.v7BJN4AKsVjUU_ESkjg8k1tsUe
 I3IapU.X5.mBAikzsje7.WPnCYojqnCHTVF4oJWfyX6z.X5AgE.cDMooW6b2DGC06.6pm7kczcrq
 GnBuhWfQVU4PKFHQVUuIiQUg3cRHaxZSFnjdmQplPTY3y7mAkxN1vRV.2yW6Mdoad_.7I6kX.WT7
 IDghNoRPubF931sYoRJvWMnLqd4qDiMfqpxEHTc9tC_fX_LG9gbzuSFzCzNQDYRWSRldBztQzcBa
 P8Wuq5Vx6wUU9zHzJwDwuC6BNtN8vAj0L6tvp_U9iyhM8tf6cnwOdq2WpKYjCcZTjvcYWeXQmgEt
 cVSQPo.0uBsev7kiQTa2khTni55GjNJj3tulLYwMJEGNFV13T1oSwiH2oEkNfsmNdLKzlh4mYsPR
 WPPpY0KYAxYtW3bM2UkOUfcRIb_tK.RadGIg6ird6o_bWYTAT1GdWlAXUAedHYYRrptxqQaCjUwZ
 ryEnuPFQDcq5XyyCuBxAVSp96w8fSGxmVFOkBLzcB_B.F8TrH6qSIFyYnR0r3MfLjEZSTb6sKamf
 NP.ktHbgkiK9NiQRrb8VyhtL.sQfwtTsIgcx6nij9.cck_W8dN0AGtEuvPTDaJKAyYq9KnXMngFA
 VBXneS1._bZAalpxyWBajO_zVBgea6bSISC5lS5cdjoHFK3e97qDS8noK7b.c_K9XYjeDGTD5bn7
 O6eVrLKHc1EiMTocKwI2h2oEUo48GP5EFxuc.0NvMrpiW2.YRSt55OFVZbhe4C9oT2DOuesWpak7
 7o_DOrlD8ieyuSbcrczynZiuS1KOYie43cdIqhnhVL9OyICNzhc6CAqET8sxQ5Np5XNAToLJ2itW
 9ZjBmmIFg.m3PtapYM0dxU0pMGxHyGcwc31QS9RHHeagZAgttwpxmmuTAIHSWT2AXkfoz61S.w9C
 51oYybCtUaOJZdhfDdelPYHFLQUgiwQLoQ.ZjbOqVxgmIfk2.sCZ51D77E9Vy.u2hlWDbbTD0lKD
 ThsHM8SRgO_pmaS6FjYxksaKW5WSJL6hiCRjLmz5ImejN3HZu6HzpnVtFs8nNJgyg09coL28Tv3a
 I00ePerApKahZAAHIBRFdafY35Wc0pHw10IkuN4Z1E_gc3KaFSmWFS7DM27yFtyyRhEaCSx5tz0t
 UINjVUy5lgTPxBf2J8a_REsnKal4vH4kz7_x7_BR_DcHxS1B2LYFVVc0LXpcdJUxzacVtudl.vrN
 PX8tVkkPeJ2WuPJPKa.PQl08PBiUa7xvhYVBYvDZaQQQL2q09dOMJmWnfNP8RcylQnSkK74gkGnV
 Bumn5Z1PhFe62HHM0GB935EkxZgD3hmeJfjJvvdybXUwIG2WfKpjLfrtwu6DpCRI3vVVSDPfAvyj
 Ad5WeDfv1kf3t0jC1x5tcLOYxScvRZrEtP.pW.f6ju2Ea6g9WBBa.22t98xnZ8dAtIPw3txuzG5p
 SlESJgZ6RW753fZi3hO22C52l4sYigTpcqFvO2KT9rsl5BKpiQhXCBy0HQqoJFdJHlWk1cBKiBW3
 72mPxgDMHbDvmFaOMHLE.q5U05MN3jmq4JlCwPxXDTQ6tFtec17gfXAeD3julEqtaWX6Krgjeg1L
 vdVvherXH82E2utEyXH_6eLPBhmf_WUOoBUxIZY6nFkUU5cQrvk.jWPPQX7jfYXPnJrjC6iDZkhj
 81XMd4vWNpepd_0W5YQeqt.Ndf0IccZYAfHct9vKRYY4gX2daBCkBjdJTssY35K2CC5ycj2JCaEB
 7koex3yawtXCPsT0WPgQ9ixhJr.QP4QZipzCJTO1zNh.6ZSfAT.hS6dSPFF1H1oDscWwtmeEZ3JY
 DVoRJqi2QsjqSvlQpPa2g5kyPuW27VFRWMrqBkNxSsq.I5oi5leOCY5gQ3yF4KN65j0_jeDiQsfk
 J4S43BOKOswbBZ67uIV89YZeoZDYhPqONCZrXNTZ9YJYtcuGer78lYeeVr2cXjVFhxIjSw2OQuuX
 gzNQKcE5NubgcDZbcxGHtIuXUf.g0uiDLZVwyAb.bZuhn.O3HLWY9Bi_R9BUR9_X1DtuRp5zjAfv
 JELVM07LoXh0pEOUrR2WpawauIqAm7_aDRxcDLQZymXoLcp8DGhwBONhAzQE8Km8W5_IJpR07otq
 g6a6hV.zoLIXj1kJD9Vbbku4uSqgFrD8JFUkL7_X87r18RGRMBABjoiRfmq9wRz5vl9cKut7_T.H
 vmWjO1.xKrH.bH.2syaPu6mH6ZAJP3H1NDeq.xGwmcWynIWlXw5xoYDjEVXjfxk.lSlARHDYYW.J
 hqwNTOBF8Xxm.YfTYiToNkA6FjkkDfcULsgKdhgFYpztGLdmRv9wBWGy3VssbFMm0J3XtgrMZTNS
 TqqGoNKQ0lS2.p.HcpB6oek8j3WM_K9ZvHVRpGJR7ZuuRF20uN86bvSryBUCxQ4KTFpFlbOu4BBv
 .j4QckGZOuAMdq6XpNIv.J6oMVOafItJmasWsJRhfDhx1zweaUTjZnxDAfqS2gaVgfZid1K3g7AW
 Yjm8PZrAj8J_3saYK48oknhVBokp8K0pJcE0Xzno_2V1S4qxSRgy__6qBhr4KWpFCu1JTMp0dA_d
 yjQq98SsEPfK1D8TMb8hK9_BuLhgOBSGhcKlCIf8mgIEwH9psZJIjLAlXTmaOGHQjWIMMkAEROJu
 .qJ7gFBcxEOm7_A4KclEakIhM7qauqR8SSAlf_O2R_7BkYSdesOpZypX80o9gnn58YMzG_gOew4L
 DPjcor.JIPj7QFUi_TTuPPmFULIgumU8jRw6odGIbeVL1aOqRcRx8zCPA0tQLZFPha61mkpxHWJ7
 fp.WRhuYbbb50YEfML6YW1FU.M6OJ3xOkBiqLhmwn3olh_SjHi1K0Egn_HNDbueUVH4d_.jQ6hju
 wenYF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 00:57:43 +0000
Received: by smtp412.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0f801c19fdf8e714d7c3077c3b87be14;
          Thu, 05 Nov 2020 00:57:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v22 07/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed,  4 Nov 2020 16:49:08 -0800
Message-Id: <20201105004924.11651-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There may be more than one LSM that provides IPC data
for auditing. Change security_ipc_getsecid() to fill in
a lsmblob structure instead of the u32 secid. The
audit data structure containing the secid will be updated
later, so there is a bit of scaffolding here.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  7 ++++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index fad361bf320e..be8db737da74 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -499,7 +499,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1228,9 +1228,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 5f9bdd62f78d..35d6bd0526a2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2341,11 +2341,16 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &blob);
+	/* context->ipc.osid will be changed to a lsmblob later in
+	 * the patch series. This will allow auditing of all the object
+	 * labels associated with the ipc object. */
+	context->ipc.osid = lsmblob_value(&blob);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index ea927a00de18..9c1098ecea03 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1882,10 +1882,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.24.1

