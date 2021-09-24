Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2853CC433EF
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0917561241
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348058AbhIXSUw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:20:52 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:33843
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346279AbhIXSUv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 14:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507558; bh=UCL4F/BNOtkI9N2W2xUHLJGVdatrhATCeOUgKdWa1nc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HHKrfgF3cPNkEU28qgjAvf+S78nBt0Oo8TfEkhr2q187gUT7qVzI7mVS/ucz773sZ3yL/Z/zOrxjcDzuisES83XIriKxmUQpN+zt913lnHsQqjJjqjMMbiQFkxh+vJWOlyLJ+ET1uMCRISX5GPr+fGwb00JyeXP7RYN36aYoTAd8owSESev67cgoth7lrDazRFusmPk2oJfGT5uraYoGxHkPofhiGPTSzTwnC8CjP2DaDdtB9JYC7QvaFsgi236yZa6hfhFMYq2xW0rEVi7s8tQFOdqrnjpyJbn/tpbZI4YTb1ComPSbhVwV2dCrCpEqBMT50CVN/bBe22xkSYfbow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507558; bh=5KFmHfxOQ+KGU3M66lknUR0Wm4LlNZyA6mXfbh6pzvq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GBEHDwWjyjVLj2NqJWqpmFkLgPoI/37OVpNMw4REzbVZOBzPy6A/Da8pnBg741ZyUqRjfnoyD35vZS49WDQjqSx45KwpasH43iQmuadW9CoC2foV5p6Rl/cuU3M8XseDBchG08GGxoJcytzQj/jwCZAUHBYrB4126JYw0mZ6ci+jCKPdTVkJG7VgqqZNMnC1SExNZ437qPkVCP18N3S9A3njRBHaSgdb0NNqlJW8pgD4pfP8cm54vWflfX2nrfomrBZGjr4YYQ19nRPPFS4PAENoD0Hj0KlTH88LF7k7+MNBA1Yv1jg6/NuqwDROmJsRLsV2LZ3OByf7GWOuluVtHQ==
X-YMail-OSG: E5AZbDkVM1nr2Mf4cy8E.NQjxLOUe34CNg4IEvQpk9yvatg3oYZOHZ3cQbOw6iz
 1NJhvQ_wHHrMQ_wtE..u_yElyXGEjq9aqYHFrqKw_mPxrgMH234pXMwX08xzAKfgdxKZE.LBT3JV
 4h.o5V75.OQFiwzJj7YrD4AN6F0ki8a7JXWVrZd1lpe0jr1fb7jESBs2o8yBFJl94yrggYMHUIj6
 hnFXDlYo5AItUHVkf.m7qY.umKhCvoWAdWBUaR2Lr9Goq5RKXUYorHIFCnqBunOAF.GR56gjCBt_
 8_eYzYIB1D77XErTSwoGsxkaapjxhWEhnmWrs2NAu9sb5mLm5qoBcTDBhHBe.7zC88lPUcpFvlfZ
 v8.JxoLPBndtsxVlFbBYXe_tH__eJgDWQR3SG5PyBiQn8mBvyQzLyckGgPC_i1SLoGgl1EVKT2w4
 gSFK__hkMBSyDrDpl5EM64tj9men0Pq03K0dsUI.VujAC9nLXPzVUWzv5FLs3btPKz48u3XrH4qJ
 Fa9LCXfJO0kAR8AOcP4ZdR.vZeMIiLJPPGGZwqdsj9hYjZIdipbhRuYiyRhk8wPxlyyR5d1xmrWb
 MyWpT_LW69OIcORDx5dyd2CbEaYmZmjn5NvYUL1ufJc1l22lId1N6.FePqVDqMzOtX0srLQpTYuX
 VTvIl1R1bZ7HE8tdABS7SDa3wZgJ9T7.94nOymKo_hsdaIbhHDwA47Y8UQXQ1edMn5BEeTFa4NLu
 xtwzYToqogqrmI9LGzktGWXjn2weRR5YYjKi2_qjPriGfGs6PhyH86EvpCgnf9jXBmCJXzpbxmuG
 Of7AHv4n8dyvNEq7gf_zO2nWitFyt8iLTVasqOEQvk_QlSyKgzNU88EOMChX328110evm5clBTKe
 2g3zCgP.lv7Uo4o2J_zPxJ1Mj1zGsSo8CWpP0SAjEXjNXh6kRxh4d6go2AH3_wmQuGXXaLv099KT
 st3b.1_uond0QwOM_OC751Thdsn8ZcUW7LMtzg_X0GfBNZPp7rx_g5s_qA5_0PU_sOeytKzr17S4
 jGA_Sq2RClNwuqXBpQir54lc9OemG6iU1rPFurHPV0Hqzxs.a.HTI5NNfp714_ZuyrXPdwSlCnht
 70PZQATSvLQ3Hv0bPhfYRRLALQV0KPi6I1.aFjxv5PxkRQUyhSW_VFvnt7ZWzBQIl8A.sSzAppJT
 UA6G6rwPGo1Bg_0oaA1wXG8uRVquM5UVjyjl0mQdmhvNLvEhjrc14TqBZJ_4F5JF2ttbcXkydH.I
 tXUfDD4ZyLKibyCMXGAqbQw2HIrVymUaYnbwdichjOeYCQiiLR_k5kGezlH3Yo9DAhXvQK99bMAR
 phR2U8kzrrWQ.4ZpBSUWkd1sLsHMFr5ZB9z0rSAM_c2Qxevp9XW.tOCvf7RBHA_r1W4tw.ohyyIu
 BI.h28eIpN8eK3fsNie64wGDl_Uz9E_uTWmzpZN8MpxMqDlLJiYU_Pb4ZUY1Qc0dA0xYgHW1pc9C
 kaS.tcwlSfRPdd4LplSf0ZqCWncYtmTcUxu9MXJzdV38jM84iLmHv1OtSi6l7ZQQxAgZTBSPNlGt
 _I3uqMxmDwHh_6arkNXuhvoGqloF6V6wpl4EjSnZwKVadYznxX1pmXmui6Om5on_Lad5BMMfdXYL
 9tNycvaDwLZcFgUt3wr1zf3KC6sO8v20BPu0Q_MKwQJDyj6vEvRgnbHGZN.CGLYQr9JJCV8iMdNd
 iQKoczM1osKFhT4jeFY7u0vVCKOS2wVck1ru2Y9q2rKj4CGOMr4knK6cFteHZD.Kgdz95WKOz6xw
 V74xJGspLm13fPvlhtEMTQYjY3Lt1n_ff6_P4GikVzFe1NvX5MOMUeURzmrqFSJNzOmm6zWnmIHc
 u3EfKZwnTlw88P8ArtlC27d8rGYLw5EqbRae9SHduJlawaaNWrTN6H8DlcwYqN5S8W6YbInDyU.G
 ucx2UvNcPjPIprcalM9Zd4pTGwK8OWligTU6Dg0e3yi5ylHPkFUzXdnNFBsNpgr8sHkp6O7kj8kf
 qc4lMdf1AO_.hkRUHrPUszCXn7EHgrNw1koQ0LeTwMFrsOZmjnikp7P8WfwJm52FT12M5PrCnT2.
 jHqIZBGdbZEqhQd90mpw2uOVj3nO7PSOiJnYC_vUpuC.LhfTkDWD45xW05YW_zGkRXJOosmCkAAe
 54B56fSsmp5.dS3WUWtMTAbQEHeuaMpySpjhbQm7_XzEvGU0i_xBGMKbQBzQEMIg1DhehzKBTFtQ
 sKa8staeWgElujB18YSyJ7cjKIkDkt0tBI3rLwaTQ6evE7VwzaN6bf65sA3lV3qBS__xxI15WNby
 F2es4Jwf29wuB0lHvMi32iUHRNTOIV1g-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:19:18 +0000
Received: by kubenode508.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1d3365360bf2498a624d7dcd82348a6f;
          Fri, 24 Sep 2021 18:19:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v29 22/28] Audit: Keep multiple LSM data in audit_names
Date:   Fri, 24 Sep 2021 10:54:35 -0700
Message-Id: <20210924175441.7943-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the osid field in the audit_names structure
with a lsmblob structure. This accomodates the use
of an lsmblob in security_audit_rule_match() and
security_inode_getsecid().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h   |  2 +-
 kernel/auditsc.c | 21 +++++++--------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index d43a08eabd86..f3ff2bd31459 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -81,7 +81,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		lsmblob;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e87f21cf9494..e960410cf4e4 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -698,17 +698,15 @@ static int audit_filter_rules(struct task_struct *tsk,
 					 * lsmblob, which happens later in
 					 * this patch set.
 					 */
-					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								&blob,
+								&name->lsmblob,
 								f->type,
 								f->op,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, name->osid);
 						if (security_audit_rule_match(
-								&blob,
+								&n->lsmblob,
 								f->type,
 								f->op,
 								f->lsm_rules)) {
@@ -1412,13 +1410,12 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
-		struct lsmblob blob;
+	if (lsmblob_is_set(&n->lsmblob)) {
 		struct lsmcontext lsmctx;
 
-		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
-			audit_log_format(ab, " osid=%u", n->osid);
+		if (security_secid_to_secctx(&n->lsmblob, &lsmctx,
+					     LSMBLOB_FIRST)) {
+			audit_log_format(ab, " osid=?");
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -1972,17 +1969,13 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
-	struct lsmblob blob;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &blob);
-	/* scaffolding until osid is updated */
-	name->osid = blob.secid[0];
+	security_inode_getsecid(inode, &name->lsmblob);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
-- 
2.31.1

