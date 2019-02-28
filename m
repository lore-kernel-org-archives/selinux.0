Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF085C10F06
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33AA206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eWIHgKqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfB1WoL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:11 -0500
Received: from sonic302-10.consmr.mail.bf2.yahoo.com ([74.6.135.49]:42233 "EHLO
        sonic302-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727908AbfB1WoL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393849; bh=4BfO/VPF2tKOCjMpfXoHzygB4AwQ3ldLj2gvJyvC7C4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=eWIHgKqMWKww88vUScNJaLVE8gcGF7fduP8yu4WH7aohJt5tzxRqhkedPmo1R0v7tnjG1ORAiiL2kKWzv1GBo4LHWG0B6ZAACSDjV+o9XqYO+G0+FeoJ0qRErKMrmvMPbK4+KOPHkH6cESZfPQ8NoG8t8/RQwDu98u1fZ6vELRJI5EKgZGLmQ6asQ5PgilGeg2j/JKn9pDa5F4uOw5znvy7+iUgs+oR5LKyIRNDfVEHx8zQ20m0YGO6WU00SCagZEhp3ZIG7QJXM/siRR1Jcs7fqW/WfGsp5uFVVyFrw16deiH7B5wTann3s/3OYJ2L2ynPTYy8HY3xRXmJURsCX+Q==
X-YMail-OSG: Vl9nKA4VM1kOCtrmz_.6Lu8MVEoeQlWkkEtqYFyeGhbxiqC791EG4yyu6juDLaw
 3CQlfXp.gqoLyA31xT9uoN9vdahmgr06PODoI4k3jZ9z0TNhhlFqzG7bx5SiZpu7nnvFBh96lUB6
 eTdkHWOhR7cDWVIJJ3L7yu5MhyoOaR6FhnGRzyMhSXcJScHwxJZHGUNU1Nd3EjnJH7g9A_wTRLJt
 2cCyvV6DLahx5TaB07AQtw6yGZ7ru4U5sTFSg_omZxZL6BoacT2BbLi9ivmMX.FDHZjl.GV2.qQh
 K_Y_aR_mw50jISxbXUhfBkN355enhuPagHm1Cl6B0d8UjtgkjNg3oVqsMFAWc9T0LVSCEtaHquzm
 NSvrsBxjtLHbD.joGtDFzhyOYveaTfjLKyGkSt37KVH0oODzgMZdjLTb4u7VgtyjTAozKDGiStov
 DK2g6hwE3eWLIb9LxiRRqCKvFhESkMcmylxRylMKDUvqNlIaJAn4XP4btjb9AeynCidKv_VLAh1D
 xPNn8_TvgJCayJcwL6KPKXCditcdqS7Eh9YdYOw0me5z5I7QoZTair_RKboL1Qx4.CQ3svoJCNUr
 HQLDQvT1VrKijeM_62e4A6kdlJh.QYfj.rDIB7kUDL3bnGeK4EOBjl01oPsg.NMhMSBPp1rg913e
 3I9stXR_o_5sOaXjTBPbwgZVyKkaSserfOfTTZkbLYas9t74ZfAdZWrTDRtqvTi9ySqzJNyGHKXO
 WRF.tbtqUuequauiQqBZKWWVQgShydU4uj070pkP55J4wqvDW_oLfXIIr4i3HiFBdhIK.BE_k91k
 M5IFSt1qjNcrdDTDF.x1ij3ObrKnoS9cAMvKoU7o9dGgV6xEX6jrIxVu8yC.cV6weBnjuf7Yn_z8
 ycJYvU_0Bw8E.iyGkXSBGligpiRR4tZ_OquTo25m2dFWm799qS4Xax_HPpAUd1MFMRBsw9qV1_gz
 R5I2g2k19jrJFEb4JBqnQosm15YqzyWKZM4FxOwnUJ0C4lzZa2I.vEzVkP3jmvcpm3zZb1TdCVnM
 PKFeoPouHuNkg7mTtO0_dXnK_YXQzabXs.k2awaDQzGQF5ru96OKmmVANaS2U1PE48vOmcJEOuPu
 VqxJVMU6G3EFjA2uf6PBzxYhdtppmlolTNFp3K0.sUnQQ.w_.x2y92ubM
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:09 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 731ec5e129ec3fdeedd3a533970a7e62;
          Thu, 28 Feb 2019 22:44:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 73/97] LSM: refactor security_setprocattr
Date:   Thu, 28 Feb 2019 14:43:32 -0800
Message-Id: <20190228224356.2608-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Break the common code for setting the lsm_one hooks into
helper function.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 120 ++++++++++++++++----------------------------
 1 file changed, 43 insertions(+), 77 deletions(-)

diff --git a/security/security.c b/security/security.c
index fc446af4c3bf..66bc1a580d48 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2016,12 +2016,31 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	return -EINVAL;
 }
 
+/*
+ * The use of the secid_to_secctx memeber of the union is
+ * arbitrary. Any member would work.
+ */
+static bool lsm_add_one(union security_list_options *hook,
+			struct hlist_head *head, char *lsm, size_t size,
+			bool was)
+{
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, head, list) {
+		if (size >= strlen(hp->lsm) && !strncmp(lsm, hp->lsm, size)) {
+			hook->secid_to_secctx = hp->hook.secid_to_secctx;
+			return true;
+		}
+	}
+	hook->secid_to_secctx = NULL;
+	return was;
+}
+
 int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
 	struct security_hook_list *hp;
 	struct lsm_one_hooks *loh = current_cred()->security;
-	bool found = false;
 	char *s;
 
 	/*
@@ -2032,80 +2051,31 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 		*s = '\0';
 
 	if (!strcmp(name, "display")) {
-		union security_list_options secid_to_secctx;
-		union security_list_options secctx_to_secid;
-		union security_list_options socket_getpeersec_stream;
-		union security_list_options secmark_relabel_packet;
-		union security_list_options secmark_refcount_inc;
-		union security_list_options secmark_refcount_dec;
+		struct lsm_one_hooks o;
+		bool found = false;
 
 		if (size == 0 || size >= 100)
 			return -EINVAL;
 
-		secid_to_secctx.secid_to_secctx = NULL;
-		hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
-				     list) {
-			if (size >= strlen(hp->lsm) &&
-			    !strncmp(value, hp->lsm, size)) {
-				secid_to_secctx = hp->hook;
-				found = true;
-				break;
-			}
-		}
-		secctx_to_secid.secctx_to_secid = NULL;
-		hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid,
-				     list) {
-			if (size >= strlen(hp->lsm) &&
-			    !strncmp(value, hp->lsm, size)) {
-				secctx_to_secid = hp->hook;
-				found = true;
-				break;
-			}
-		}
-		socket_getpeersec_stream.socket_getpeersec_stream = NULL;
-		hlist_for_each_entry(hp,
-				&security_hook_heads.socket_getpeersec_stream,
-				     list) {
-			if (size >= strlen(hp->lsm) &&
-			    !strncmp(value, hp->lsm, size)) {
-				socket_getpeersec_stream = hp->hook;
-				found = true;
-				break;
-			}
-		}
-		secmark_relabel_packet.secmark_relabel_packet = NULL;
-		hlist_for_each_entry(hp,
-				&security_hook_heads.secmark_relabel_packet,
-				     list) {
-			if (size >= strlen(hp->lsm) &&
-			    !strncmp(value, hp->lsm, size)) {
-				secmark_relabel_packet = hp->hook;
-				found = true;
-				break;
-			}
-		}
-		secmark_refcount_inc.secmark_refcount_inc = NULL;
-		hlist_for_each_entry(hp,
-				&security_hook_heads.secmark_refcount_inc,
-				     list) {
-			if (size >= strlen(hp->lsm) &&
-			    !strncmp(value, hp->lsm, size)) {
-				secmark_refcount_inc = hp->hook;
-				found = true;
-				break;
-			}
-		}
-		secmark_refcount_dec.secmark_refcount_dec = NULL;
-		hlist_for_each_entry(hp,
-				&security_hook_heads.secmark_refcount_dec,
-				     list) {
-			if (size >= strlen(hp->lsm) &&
-			    !strncmp(value, hp->lsm, size)) {
-				secmark_refcount_dec = hp->hook;
-				found = true;
-				break;
-			}
-		}
+		found = lsm_add_one(&o.secid_to_secctx,
+				    &security_hook_heads.secid_to_secctx,
+				    value, size, found);
+		found = lsm_add_one(&o.secctx_to_secid,
+				    &security_hook_heads.secctx_to_secid,
+				    value, size, found);
+		found = lsm_add_one(&o.socket_getpeersec_stream,
+				 &security_hook_heads.socket_getpeersec_stream,
+				    value, size, found);
+		found = lsm_add_one(&o.secmark_relabel_packet,
+				    &security_hook_heads.secmark_relabel_packet,
+				    value, size, found);
+		found = lsm_add_one(&o.secmark_refcount_inc,
+				    &security_hook_heads.secmark_refcount_inc,
+				    value, size, found);
+		found = lsm_add_one(&o.secmark_refcount_dec,
+				    &security_hook_heads.secmark_refcount_dec,
+				    value, size, found);
+
 		if (!found)
 			return -EINVAL;
 
@@ -2120,13 +2090,9 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 
 		if (loh->lsm)
 			kfree(loh->lsm);
+
+		*loh = o;
 		loh->lsm = s;
-		loh->secid_to_secctx = secid_to_secctx;
-		loh->secctx_to_secid = secctx_to_secid;
-		loh->socket_getpeersec_stream = socket_getpeersec_stream;
-		loh->secmark_relabel_packet = secmark_relabel_packet;
-		loh->secmark_refcount_inc = secmark_refcount_inc;
-		loh->secmark_refcount_dec = secmark_refcount_dec;
 
 		return size;
 	}
-- 
2.17.0

