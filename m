Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD33C10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FF020851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="h71uFiFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbfB1WU2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:28 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:39329
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731928AbfB1WU1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392426; bh=1XElOFnX0SWyB3Pfzpq0lWLsE8uqoo3/Ln03nYB82X8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=h71uFiFzjlNEHDt/+BXvS1anQUtKGT4420kSTZjs+FoAPsX4Q6ZR/FfanfxSdXFD82PxjR73wNBW0MimdddzkVf+KGAUNsBneqWERq/KE1seUs9JWqhhMR3HiY+ath0w6FqUbqVM9F7XkLZpX+SFBVSYXehkxnlfvBdX5Q8vS9jJfD4C6YDrgo19EfZ81jzh+rdxRvnP1HpfWKtWAS6iWI1b/iHbKRFyIYCY12apKY0Rjq87jEzNbT7x7aY4MX/TdnAYtM69NgbsDJ0ApTr6Pcdbi/NY7/lNxDh8RXBg91pkS5v13gkOhNksqn9i7rstNUV5Dnks2iliGsyfouhvjg==
X-YMail-OSG: c2bm09IVM1mPT1F4G40gxsiBAqRY9DyiQsvlJpqjRi.6WxW33v3iS2guqys3nY6
 .98.9fi395W5dKRYDMOvoVY4arGATraC3fOlxS.UJEvUGD9x4BaAoHO62ukFYn9tTyCAZ64Iol7M
 KGnxiAH5lDkUQJGpjvJ8Av91Ud4fz0p.BcD_2qi1V4Y7MLj9SWs2Nh0KRFSb0prYhMzVd.op_1EL
 eqZ8MrVpefDkqfaAWgdEfHPHWCdCAFmOgzA9TuqEkQs73rUBWeU3lbHeub01cwJwO5EDk.kbyFSo
 go1r4xHHDvkmZf4etgqMCS75dSOLI4DTJh_6AhvsVDuuqc4CMPOwyBtdqabgPntcpTnEhhPbZpBF
 0iaaSMg2.JKdyxLtTwkPYDoeHAaaDLnptFlJd.VoQKNFnTMSGvE1o7xhedexuPX.Y.nOnkfWby0n
 T7x7dRboiU_m5n8iB5W70XOUZWpGJUxx995XtFkfXrNPfPHWQV4_n9PTXxDDWAiaCnXAtsca.ltJ
 oeZR_sSODF8SJqjdjdmI33ZW8UrApoJTb.WuRi.kjTQ4vEz5YiujZdvEROMs4MNSiTmyCEhKzOTP
 Js1IRB.rONg.znXDKNQcuGNTxXJFDhs_XCdc_ouJsEK1KkYPbrlj7NMlrtiA3bhTd6tLsslAdCNV
 ZIrwZGHQEhRAiRxrheKFF2.Jl8xWlMhO12BP7j9Jg7MFssa6tx.gUBisUffnGTNoEKLm82q7qtZG
 W_soBSrkeq6gaoyokchL9686fvg6Xz.W1gqHG0fcaF3Av9cQ7dfBlPLVW86_g3ntruA2M5aelHQM
 e4QP8_UvQpVN4navimpwWTpyeH.wtAkCM_4Ysz61j9311LyYuNXgGZb54bx620d6pomjQxDfrJay
 8Hf2gW042qkFprzY1r8FHVQCLku5SAc66.uXoFr0Xpg7ZPaOaK_oV0LoHrlY68Qm0gJpMkZ946Dk
 rWuVxhFYfdt6vUhW9L9IF7fzkvuRLJYMYEonEe4Ese4rlXK3zt5zGFtbv2FooMW.LBTpV7V0hPNd
 x5NYFei_zhnN0thMK.9AZ1Jh2qex.KQNuV0EqiV28FWl6w.g5Er97BxH219bU7z1QCqAGVDZVhlC
 j9iIzgl6N9c7VZmd4MzuZaIvhfk6NHYjZY3at5iOm8PR.ti0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:26 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d90148b291d74b44c78573c559ceeae0;
          Thu, 28 Feb 2019 22:20:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 60/97] kernfs: remove lsm_context scaffolding
Date:   Thu, 28 Feb 2019 14:18:56 -0800
Message-Id: <20190228221933.2551-61-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the parameters to kernfs_node_setsecdata from a
data/length pair to a lsm_context struct as both the function
it calls and the function that calls it want that.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/inode.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 6db050b7c6ab..3d47fd74cc8c 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -135,20 +135,15 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	return error;
 }
 
-static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
-				  u32 *secdata_len)
+static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs,
+				  struct lsm_context *cp)
 {
-	void *old_secdata;
-	size_t old_secdata_len;
+	struct lsm_context old_context;
 
-	old_secdata = attrs->ia_context.context;
-	old_secdata_len = attrs->ia_context.len;
+	old_context = attrs->ia_context;
+	attrs->ia_context = *cp;
+	*cp = old_context;
 
-	attrs->ia_context.context = *secdata;
-	attrs->ia_context.len = *secdata_len;
-
-	*secdata = old_secdata;
-	*secdata_len = old_secdata_len;
 	return 0;
 }
 
@@ -363,7 +358,7 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 		return error;
 
 	mutex_lock(&kernfs_mutex);
-	error = kernfs_node_setsecdata(attrs, (void **)&lc.context, &lc.len);
+	error = kernfs_node_setsecdata(attrs, &lc);
 	mutex_unlock(&kernfs_mutex);
 
 	if (lc.context)
-- 
2.17.0

