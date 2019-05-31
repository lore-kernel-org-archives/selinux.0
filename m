Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5564BC04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265D926FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XnD83uXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfEaXOL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:14:11 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:44993 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbfEaXOL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344450; bh=NLJ9WRLN3mqnoEKmIr7GkqEF3TZIbdXheKniGVooL5g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XnD83uXYESVeQ+1hE5D1CQ2iWx/bCW/mkmRMGw0RsnTIyLO9/Ld9hKAUQymciimPiku1qMGPMjhR/3lVs4cYKYsowLL5F9Wl+QFIi1Gk2ot1fSKpawBIYS7AYWB7FvGF6vTvBTBqvpxdGYbxcbWUJnhZ56KxtZ/vl36mt5xu+5KJ/VJ1rPtMpn+y3/3NKEYRjrekBq1zMek/sWIq976gdTyPShCP+ZWQwztAg4x7sXyZi3UDVuz7HfS7sndsMnz7BD2NmM1Cbg/TAWKRaXX2b7MkAOwBMwxE9wEeIkeeW1/xXrPkVx+ChMklXKmYbIkH9YGUMNy4BxQfdEGsq2wk0w==
X-YMail-OSG: iocqQ4AVM1nfTdRqietGrAkRrLNo9bV9t9dcn4XV0xm2HCxSKRlsyvEH5tkWHOF
 5pbQpGggmHMAdARaohI8a.C4JwLdNN8l74BLprdwVxUnZwShWmhKaIQkVp9jozyNdWWcyO79JAPX
 YrPMDYtqJTRQTUj3fPma_mp9Ani7htknmAppYB0z9zdcoO3WWU51JA2hH1owKQ2VWyFHW67ysGUa
 4tTvPc.aifwEiXvLjtOuWGGgR6fZJrpx_zolBy1cuHlOVmnSGer3MUsbkAVyjsG5LJqfgmZCQ3Ks
 VoewT.crhFqX9Kb4hND33GGIlSkW1DH.UFMvFCdE_gJKtTf5nIHTj5FpGgeq9XReaE31P_2NyenY
 pqWcjleFjtaQgyguMIXYdtFo1.vkauJXQDmlF1kjWhMR7fgIp39N71AjbjPMhqTcBJayQmEkM._X
 McxJ4EKm5B76Xq0mS8bPfVMQTL_e_wgn1u7Ynlx1vcirp8YmRColj.2XEn8Aifgh.zYisS4S_T0o
 dGOPgzQFujXwzG5GzI.hYjWrO2iYg37WwdU_xzWeg0tsvKggm6QgKIYJBbvETyQFxFlRPKZMmuoF
 7Dm8TwcIkYxMAfWak2IZCOaum2s4Gw48UwsIIyLEYIDW2HII6rO1ombYnJ.QXfNyvyWu2Ja7HTfB
 5W8_ftIx1NDwvjxtuWEuVdZgDi8FVPh.A3fL6_hHsyd6hkDaAQQNwQZNN5jeKRqgtw3uB9i_9WfD
 Rv5.CK.CxXMWXE_i.NGHYb46dxhLE12woFrCXyuvrTkhy0UDGy_vCPOL2xxuJJI9uaywEFPK7LYH
 wO9u6sahMh9Q9Zb0TYzudZ_LfCfeZMP70p.iSIpsJcvPVPlxJuY3T6fUCTArdvd4X30J.ion37gM
 YZWN5HxNCk0CvgQxFETgfIaXlMIAGhf.yDTQgSlu7lUMuK67NzqSCFhBuU4cNM7Tzh3wY14Vwbxk
 U1BRCAPoxe2VonP3MBaX21tF12iRxLXaCvBNgMXdtQbz6t.EcqQdYk1Y7m45ZFO0QRG8jMDSeVNL
 JVhXnh9ZnfzHT9gMEodfqGtV_2OMjJd82eUW0Vi1M5WN0cv9pYk3.sykCrxIZlRYwJtrhEbAcs3S
 r5O.CASXNqJh8R4gNF7juBmScQKMiX8KD2ZdvtPjnK8RWbI0RgpE.T0pwSdZh0W5rgwjOxjmjEqg
 qfcBlGdzhIsJ.l26NrfvU2v9kCVjX_cXxH1JGgTnuSCls4W8FcY3BDgjXgVn9dv4sSl7jKbbbVxS
 gAKOTbBlrgmguWumndTOBgiXiH1BqvgZqn8qWTASM5K6eGb.qT7RERM6A
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:14:10 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 36cce48665e985747dedfe39c8f2f209;
          Fri, 31 May 2019 23:14:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 24/58] Audit: Convert osid to an lsm_export structure
Date:   Fri, 31 May 2019 16:09:46 -0700
Message-Id: <20190531231020.628-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert osid to be an lsm_export structure
instead of a u32 secid. Clean out the associated
scaffolding. Change the name to olsm to be
descriptive.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c   |  4 +---
 kernel/audit.h   |  4 ++--
 kernel/auditsc.c | 36 ++++++++++++------------------------
 3 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 5226e2af9498..d83d1f05c95d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2073,12 +2073,10 @@ int audit_log_task_context(struct audit_buffer *ab)
 	char *ctx = NULL;
 	unsigned len;
 	int error;
-	u32 sid;
 	struct lsm_export le;
 
 	security_task_getsecid(current, &le);
-	lsm_export_secid(&le, &sid);
-	if (!sid)
+	if (!lsm_export_any(&le))
 		return 0;
 
 	error = security_secid_to_secctx(&le, &ctx, &len);
diff --git a/kernel/audit.h b/kernel/audit.h
index e2e6fa911f9c..7d2fcdf0bc94 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -91,7 +91,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsm_export	olsm;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
@@ -165,7 +165,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsm_export	olsm;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 75d181029d40..d64775f4bb1b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -645,17 +645,15 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
-					lsm_export_to_all(&le, name->osid);
 					result = security_audit_rule_match(
-								&le,
+								&name->olsm,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsm_export_to_all(&le, n->osid);
 						if (security_audit_rule_match(
-								&le,
+								&n->olsm,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -667,8 +665,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsm_export_to_all(&le, ctx->ipc.osid);
-				if (security_audit_rule_match(&le,
+				if (security_audit_rule_match(&ctx->ipc.olsm,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -1187,19 +1184,17 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->socketcall.args[i]);
 		break; }
 	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
+		struct lsm_export *l = &context->ipc.olsm;
 
 		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (osid) {
+		if (lsm_export_any(l)) {
 			char *ctx = NULL;
 			u32 len;
-			struct lsm_export le;
-			lsm_export_to_all(&le, osid);
-			if (security_secid_to_secctx(&le, &ctx, &len)) {
-				audit_log_format(ab, " osid=%u", osid);
+			if (security_secid_to_secctx(l, &ctx, &len)) {
+				audit_log_format(ab, " osid=(unknown)");
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", ctx);
@@ -1346,14 +1341,12 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
+	if (lsm_export_any(&n->olsm)) {
 		char *ctx = NULL;
 		u32 len;
-		struct lsm_export le;
 
-		lsm_export_to_all(&le, n->osid);
-		if (security_secid_to_secctx(&le, &ctx, &len)) {
-			audit_log_format(ab, " osid=%u", n->osid);
+		if (security_secid_to_secctx(&n->olsm, &ctx, &len)) {
+			audit_log_format(ab, " osid=(unknown)");
 			if (call_panic)
 				*call_panic = 2;
 		} else {
@@ -1907,16 +1900,13 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode, unsigned int flags)
 {
-	struct lsm_export le;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &le);
-	lsm_export_secid(&le, &name->osid);
+	security_inode_getsecid(inode, &name->olsm);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
@@ -2266,13 +2256,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
-	struct lsm_export le;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &le);
-	lsm_export_secid(&le, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &context->ipc.olsm);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.19.1

