Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54BFC433EF
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 02:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhKXCLQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:11:16 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:34614
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234906AbhKXCLG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 21:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719676; bh=Lvy7RjRBj+rVstpaWkxhmABunUEyo3MdTDjhwV0z1KM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=PE8o57+cOqactK1nImPS9nal5gKQvyF4ECjeDMiHUAdp/ab8trkYWXVrogyXR32P3btZKo3vtPp3+z/z/9+Ct2caPsL1JtnUqCR+GAtfUmfT1QT1xncLVRn/1Vod4Ksl55BTToe1aVNIIo+8ja9957gQsZJBzxZKvYbxVeV14vrnJtWJZRyrdrctIhm8KoHtJPLyboWZ4tlUfgKS1tNnm+SI/HpX4hswcaOlOzL7wmg3Cnh4YST371Sgc9tCs6j3l811QeZCB1fym5aR2ULuTRNfvm7aEL2mXys0g5rcrepPP+xg498/q9lu751ozoKrKpCKtTcIOW53emw3Vg7Efw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719676; bh=V30PPQSM4bpTLcwavNa7y+eHfzTkzJTmtMuh49dtaji=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=oVLXCZ8m3XOUHuChNBVUo5e2J6zUdqvTQ5pKMSAmd2Vq5jzTDOrTwb/GANQENZGlMN7g0zUHg/wG3x0fHWdBgRiiV7opi5nolGMvWQOedfpQK7egpKXnMIRuei8OBFTazoVi+LqmDz+5lnhj97NFeqM8szPp/9t45GxJpUqnUoJ+ML8/egMqOnFTKA1BZCfbU4o1FL38OsLC3YcTc/N1A5cvPLOrhMRiRlzWPrfvKFM3alaAVGiE9VUf3RW/Ae4TaiMjq/rHlVS5Yi2mCDHobQoRXZrF3J8OWtg5rWjbLOPxBIpS+H91PC1Wulx+B/aXHkqCJX/UPvL4Gt65U9Ic+A==
X-YMail-OSG: DdiEiu0VM1kugg1MifJw3OiMgA2X5wfhuLsBzBkiIkvVNtYG9mdUR7YzigxsmpB
 y7eILzBGNFtTq7RcdS9d8RJ0HgiMj30ys6un2MoH0.GkRzwaVeiSbiY0ZFXR9STJ1j6hl_6l9.sd
 oIJA.jIl8euVAtDPY8qCUA8.1d.SkjSqRWLm1AB_Z8RQgOoD3PqKY_wmBJb4pvF4avlkL1WsKIgA
 3Aq71sxQ4QccObBGuQXqMrSGLW4_KdL2fivtzADUk3irn37Cn_yfEkysHDQLoqyQcF0K.Ss4ale5
 B55N8bzxslAkOcWTg_24557nVN0zg4ulOzWElaJ9MnOP.Y_QPN9warQ241Afs8jWB8hJxWjZFCIx
 DjhFEpPEcHF2s7upClscv2ZD.W4trzLpD51tr6bUcGNVl2Oo8qy.5zN4tj0dU6LSUJhpEttPE1zX
 RnBmpR_YIrC.hYeMfyOl0uG56TVmMTtyhH0TZttbwGoY0LO8VXwzBvraSjxnrdZXjV34cXnGVPVH
 xM1r2UGx5iuveJCTW7yu9HHuX1.F9Ut.ymFK5v0FAMs3igXNTMhxCCarXZHOncT9o3PPken3sUIM
 3ZQgSiorh.uXWGgx5MQzCa02gOe9GoArem4qZ3NiJDcFsZ0V1BsuQ_gqugwVDw2qn1JGxYhLLkUy
 48AnSqxLocSwmQhAihEJwMcEDkzrp1ujlijCD4LPNI3bRP6KmbCXm8rBHCGD2aEHZjoiihpl_Dhk
 CoibN5knZ_B_4949AXwuAPP12fNGBWmf8xlGCZU_ey6SB8ACZcw3rcMum7zNBApQDU2D9ExJiVBn
 rAOloWp6M4IuhCShwFS5PJOEL2B.BtkJPLyo.PPxV3JN1WvebB0sykd7Yl2sv243TAtXWY4Ef8gc
 uqXCKt8QhaUsIRFzcc6pXY5pF6kzMiZOnoAR1MADT2MUYss2wNftOzjH9kdg67rboJcgxfSgI0jP
 1i7NcTTYPuk.nP0LYMvpsyf6gj4vuuCDRfYuMuS0JDymphd2M5_cAjajd3FHgnLyccpTZSJPtSVo
 x0y5LB2QbQBQpuWsrW2ZgKkJTpyejRX10F35HT3YJizp0mrSbTZqqNwhCMNzOKF8sA1hPMaYbMqG
 tZU5vh.RIHIITmQdqIu7upAwxeSXVlj38kqkq7IKe6NUZWPY5k9KciJu14NlbZADJm.PmTZMZ0OJ
 39XeeOJ1Ibja0J6B6fMUBbAFb.RREilg7XnitzwVKPxUg4ylJYh7h1SPMEyrvBerlv9CkZ4SYYUx
 Vq29IfGNhZqq8FeDOTYV_Dsq3..S6zGPs98kMR.SwoxfMZ0mnuelksSz0eGes1R_pIE3WqCmjZ54
 VET4XKX3O9X2_Zc4.3vJfUVot8mX4Eo3TkDF2NN1wdmapakPFgi8ttXIygZHozNByoG_4QRq2mwI
 NXUADa1VW_bCiukY8zWICJGavelSSb5nhKBnbDz0futaJQepARcz5LbptsDxR2Y6eIA9SfX6AL4d
 XOK.QrLbi6Al050CzQ6hfi8y1dvxdyditLE6MKIEwLRRoCmkTsELOhNXUFis_NxuL8aNPYdDCBT1
 7IFF4vNocVVeM_D.DnKeDjo_xDpICgHR0BwZsBoy5jbM4MwrJ9Yu.N6NiIGuG.27M5srMRQyZ9ci
 Fe2yO75K4RaLXq3Hm.T_WAM6BFAdYliRSy42K0ioOTBYogaO39rHOOfoo3jhjVKSbEH83EJluJ6e
 0fmPYcLG8S.56H8A6x1Yoarw19JVuWwErsjLRDRC1OKbsOaqKBZy.gFdVF_wpVf76Hdw.7NQ3Pny
 waPcc4O_7HS9CN_52dIRRAr54o_cxpxwDFvaWAYGFcmWXeKqDDGho7gs8wb28eQ1PBT8LpKXN4yE
 ZnxIuhvEPo1ntZyAWyV_8OkYcDrhPME1MmCRWO5ECnmEtkUEjzZ73SsuEaMb7BvX.ULUIev2oKbz
 9dTDoO_85gIvdNmmQe9w8SSMXkxDiAEtuMPwBgSj06tlXbQJb9FvLmJ3lba.nTGwr6nrSUfniTaO
 KrGBNO.xqCY69CpoJ1kOCFeDh9DOak5UxWsDkucS51MeNIREMCDqXIzZal_LEGanbjzoTH2lxJAI
 cwvblIK0o_whJRHz5UDa6e_M44g43xGt9dcQXAXohRLLd59BlM53F79AwGHPzd3XMP9aHXiY0DrR
 t49jSFv1kvvSTIcK7YYHKWDDpdLrqTw4fJXXfN74jivkU7NIpxh.4tb5zH_1txYMkV0N72KFVl7P
 Gi4s0DE71wgVPwLAooL5.TT8YPKUZjTNJsKzY5pw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 02:07:56 +0000
Received: by kubenode503.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d78d12be2dc33b4943994887cd31af7e;
          Wed, 24 Nov 2021 02:07:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v30 22/28] Audit: Keep multiple LSM data in audit_names
Date:   Tue, 23 Nov 2021 17:43:26 -0800
Message-Id: <20211124014332.36128-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
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
 kernel/auditsc.c | 22 ++++++++--------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 527d4c4acb12..a2fca1134519 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -82,7 +82,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		lsmblob;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ded4e8740fa2..0d0351dc0c52 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -691,17 +691,16 @@ static int audit_filter_rules(struct task_struct *tsk,
 					 * lsmblob, which happens later in
 					 * this patch set.
 					 */
-					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								&blob,
+								&name->lsmblob,
 								f->type,
 								f->op,
 								&f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-							&blob, f->type, f->op,
+							&n->lsmblob,
+							f->type, f->op,
 							&f->lsm_rules)) {
 							++result;
 							break;
@@ -1528,13 +1527,12 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -2236,17 +2234,13 @@ static void audit_copy_inode(struct audit_names *name,
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

