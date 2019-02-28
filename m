Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2AEC10F0C
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B07D218AE
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qz6SU0DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfB1WoQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:16 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:36508 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728394AbfB1WoP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393853; bh=D46jH1NzMuCKPDROaZjQDTvHqgXO7BOSHaSWxaZtxc8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qz6SU0DCmIGMZkN1UYcY5Oav3kckLekCt6FE1qWTbyG7e+mhRC1LBn35pR30p74wC/4Rtg8U6kswxCtm569gWtc4Ov2WgAMAK9i9iloXjCAUq6SgTf8+4XXVHSP0Qt1wT/e8XNqLtEAHgakGKOmKlEiIbW2ZR0VNnd0r/gM51YSUntkuMogxdkyLXBgW6iU2ftEFfQL0sLKDY/75gaE97dIEzsQKVzo2EKvx+5Up8yFxnwvmxx8GaIyCa8TtyyuZmgSeHBP1MlX9eFRXK+i65/gMOMlVn6PBy9VsCHLS620COzORpPxTxGixFSI08FmwaH4H86cSDkuKCDqm7+kwRQ==
X-YMail-OSG: zpq3x9kVM1kZUkVlasbn09i4IDlKWZcSZxNhqXQ_m_ol_I004U4k4ueusbehZDi
 Z299h.yjHJNAegN5GNN.76k5QAJgwC8oqZQv6OQiBMIsQo5oIbLN0xr5VyQrvEIak6nw7UayhJ57
 aUgIjW6VAmdn9luAWQTgO1s6JnG6xysCXaegg91SwvL5mHFRsvU0L4qzcbTLHKJOcsH1R_br3qRL
 ELQRarjSkLTJM0ID4..EwZfxzUKPfrS7cxPvy2I79ZUd1FpKIm3jrlpFJ.mwkOQIJv90xYtKsFrG
 7QcaTTCermb1_uK9PYnSvz5Vp3O6nsOY9R5n8abvSY3NYgXXOH.pIOYSE9oy6c1kDIAEiwvTap.c
 lTxUrtTZ7Q0jaPW69gvJyJT4mQuZM_nG.6RxNwuMia.FHUzc3ESZ1qGDClp8rKpxRTKAyhM3TadO
 tsuYLXX5l7aQyURJHNYLdRUqXf5h62fxsDgZhR7JZVTCY68fh5Qi7ETy9XPodAC8zubJdSp3kKbA
 nwwhI5pHBUAwFYt_Uq6_vJNBStEHC3GS4joqvZUzVxMOp1FG5yZ2183qISj5SLihRyiYj94eIeme
 rWEhFGfrd6h.yTparI3IE7cLPNG6ctTvIHSnFvwGu3rsnCj98Gz2MgFY.TvMSOGC_0b4Kqk5jRUL
 noEZwFVl9ZrVaBoitSv2.PtGkechsyoDGm.b1yiLlVTQ._SM79A_3SnfAQhsHnXyUorHpWkPAwNL
 5CsRxrXjfgiTvISjGKcAsNNQpld6O1gKx14_eaphDHvQK7gYw6TK4L0h7sJ65S.xv67VbEGMJMw8
 2aNpj_uI8xB.z2KOYnfzoRhIbWFVgKo43RWVC5G2ZnK8FjeT32hzaWddl5CZ3cJ_pphcFgixjkiE
 Gke7sBmF8EV0RM7.yrEKDPJTvW3t8hZTYHMDBCSUt_vHWPeuuRcTaeP6JqeWyIAZG5uDUGTX0LII
 wXXZJrKK0Qxd1Q0fQ_UJvLHdXvxXVoNMQLgVTw_qQ0gtJW._mkfKz1ktbgYpouSqxk6vNsK.zlL0
 IOciJtfFET47WOHpN1gNm4W3PNtTKML_kjzMPBtUMHt_4Pygz6qfxftpNHucQ3kieze8U.k9p5NC
 huw3ryiZC03xuin_OkqpZZlUQGoUbmdihYdlX1o7ITxqG_Rk3iGbQv0w-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:13 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 731ec5e129ec3fdeedd3a533970a7e62;
          Thu, 28 Feb 2019 22:44:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 76/97] LSM: Use full security context in security_inode_setsecctx
Date:   Thu, 28 Feb 2019 14:43:35 -0800
Message-Id: <20190228224356.2608-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The security hooks security_inode_setsecctx and security_inode_getsecctx
need to maintain the context strings for any and all LSMs that
provide contexts. This information is internal to the kernel
and volitile. If only one LSM uses this information the raw form is
used.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 110 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/security/security.c b/security/security.c
index 16ff98c86414..bb0eea873a7e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -438,6 +438,9 @@ static int lsm_append(char *new, char **result)
 /* Base list of once-only hooks */
 struct lsm_one_hooks lsm_base_one;
 
+/* Count of inode_[gs]etsecctx hooks */
+static int lsm_inode_secctx_count;
+
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
@@ -455,6 +458,15 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		hooks[i].lsm = lsm;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
 
+		/*
+		 * Keep count of the internal security context using hooks.
+		 * Assume that there is a 1:1 mapping from inode_getsecctx
+		 * to inode_setsecctx in the security modules.
+		 */
+		if (hooks[i].head == &security_hook_heads.inode_getsecctx) {
+			lsm_inode_secctx_count++;
+			continue;
+		}
 		/*
 		 * Check for the special hooks that are restricted to
 		 * a single module to create the base set. Use the hooks
@@ -2162,15 +2174,109 @@ int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
+/*
+ * The inode_[gs]etsecctx functions need to proved a context
+ * for multiple security modules. If there is more than one
+ * LSM supplying hooks the format will be
+ *	lsm1='value',lsm2='value'[,lsmN='value']...
+ */
+static void lsm_release_secctx(struct lsm_context *cp)
+{
+	kfree(cp->context);
+}
+
 int security_inode_setsecctx(struct dentry *dentry, struct lsm_context *cp)
 {
-	return call_int_hook(inode_setsecctx, 0, dentry, cp);
+	struct security_hook_list *hp;
+	struct lsm_context lc;
+	char *full;
+	char *ctx;
+	char *quote;
+	int rc = 0;
+
+	if (lsm_inode_secctx_count <= 1)
+		return call_int_hook(inode_setsecctx, 0, dentry, cp);
+
+	full = kstrndup(cp->context, cp->len, GFP_KERNEL);
+	if (full == NULL)
+		return -ENOMEM;
+
+	ctx = full;
+	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecctx, list) {
+		if (strncmp(ctx, hp->lsm, strlen(hp->lsm))) {
+			WARN_ONCE(1, "security_inode_setsecctx form1 error\n");
+			rc = -EINVAL;
+			break;
+		}
+		ctx += strlen(hp->lsm);
+		if (ctx[0] != '=' || ctx[1] != '\'') {
+			WARN_ONCE(1, "security_inode_setsecctx form2 error\n");
+			rc = -EINVAL;
+			break;
+		}
+		ctx += 2;
+		quote = strnchr(ctx, cp->len, '\'');
+		if (quote == NULL) {
+			WARN_ONCE(1, "security_inode_setsecctx form3 error\n");
+			rc = -EINVAL;
+			break;
+		}
+		quote[0] = '\0';
+		if (quote[1] != ',' && quote[1] != '\0') {
+			WARN_ONCE(1, "security_inode_setsecctx form4 error\n");
+			rc = -EINVAL;
+			break;
+		}
+		lc.context = ctx;
+		lc.len = strlen(ctx);
+
+		ctx = quote + 2;
+
+		rc = hp->hook.inode_setsecctx(dentry, &lc);
+		if (rc)
+			break;
+	}
+
+	kfree(full);
+	return rc;
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
 int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, cp);
+	struct security_hook_list *hp;
+	struct lsm_context lc;
+	char *final = NULL;
+	char *tp;
+	int rc;
+
+	if (lsm_inode_secctx_count <= 1)
+		return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, cp);
+
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		rc = hp->hook.inode_getsecctx(inode, &lc);
+		if (rc) {
+			kfree(final);
+			return rc;
+		}
+		if (final) {
+			tp = kasprintf(GFP_KERNEL, "%s,%s='%s'", final,
+				       hp->lsm, lc.context);
+			kfree(final);
+		} else
+			tp = kasprintf(GFP_KERNEL, "%s='%s'", hp->lsm,
+				       lc.context);
+		security_release_secctx(&lc);
+		if (tp == NULL) {
+			kfree(final);
+			return -ENOMEM;
+		}
+		final = tp;
+	}
+	cp->context = final;
+	cp->len = strlen(final);
+	cp->release = lsm_release_secctx;
+	return 0;
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
-- 
2.17.0

