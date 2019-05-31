Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A365AC04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776F726FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tg766CgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfEaXRs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:17:48 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:44636 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbfEaXRs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344666; bh=EacMflAD5VaKL1W6672XUiEDYF8wM5Kufsvl3z4Vcto=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=tg766CgVsKIGyCZl/T4d1zfVyaSEmn7XNqpJMhotK59NL2XbxCW9FeTLEyqNB8uOae7P/P/t+FtFQuTOKC/+fAXTfWO/5UN5ftUNG/PLhn3zRmQkgxxYzGMOD6cLuPKc3w7H1F1QEWAQqs59yGvH9NkILzFICQnZSN2JYwzVJO99IZ2h9dSpg7swYtHg9d8AzVibb6yhsYUmXkUiy8qDQwjwE7g2n8TwFbU4qsF0x7m6q2BLMIBs/23Nu/0n7mLcNtY4bBOoLK/4bigbGYZOYNR2zY3kYiJsRJtGuFJau8nkFcIPXsfgzWhkmLXD43VVLvMznoz7cHJN5rmj+1Q4Kw==
X-YMail-OSG: JPsoOJkVM1mzvubFscxYKNyzVU3_ieTvY7g_WC7fcFF96QpxbSye6ol.J_qAQ56
 JE_NGZTFpAtxWo2jA_ftw5YkJtXME4uEOX501G4Gnu68ZNGYRU3_UaAhDttY1G_IUvQyD4aQhoJD
 Lg6voqRO1XviXpATrShwc5QAg2dBTQQzqn._iwYDP29VI0ABsp_BYJymVd5UQAlgTiEZTNGGQutl
 OhZnzqkIM4jb2NzQ9JOO2bdunsM5YjENaWHwBiUMcBGnjPES0othpr8hf5XJPxc2wJRU8LK5Wtzx
 fhjo.H32ZJ3bYEJw4vNu7ZMdxNMXt5dgv2enPrx1kDb_i7eYEZKgZir1BdNv53DeAEVSOfkdbCnP
 birphedX6_OQdGfuNQ0K3ZaoiBC6SZ7hJyJhmt1IAzkVrihk06a6KmXt4etRCej0IrlzNNpuW2Yu
 lv4udorA0ywfbw7KMrjVQCZcYYR8Dfsngbm1QU49lV_J8Bf1s74QtIY9iVzu2t6XXi1kBnTcveJ1
 .YDdNATQ7kWzzwaKREm37edO4ED9W6ehcD1zQ2ngMUe6N7vIpZKzfArvN_tY5KiTtg1Yl7xtF7CH
 lm3g6Sne1NCsANA1aDcaYP1ymn1YvjNDmMTd7Q0q5LhW21EucaEdkLmtsCadSSD8E9_cwM888WbR
 PrFTrxLmXSX7r2t8amE__8arxXf9SCirVjAN06tWoa1hpKs2nn2bN9X8UCTtzcS0F_AO23SNmXhh
 gy2goAlurZYq7as9wsX4R06aFjVV0jZiXlR.0wIOvGHKNfCovsxObDagHIwpOjPYDDIwdFLVhw.9
 T4SvuWQpO.GSkyOJnzXwg5mzS6h0y8s4sn3Fz1CZ6g9BffEC0qlkFzaEVJXGwIFkuy1PuxVhIGzM
 BPQyefVOcIWSMvHK54L8EN3q9EsmRELeW_8ZTxqJgOfno1LX_1nshArffqeyIvppSHFqW4Dc1Fg5
 5rsFimG0VzqphAHKXq6VNfWDzsnz_yBypN25brGy0dO2DcUIWl0kjjZVyHDNB1cbDLqZqynhuqO2
 LbFd8ncNyk3HbdEoS5xtmqt4YXZ.GPyv49r6twN.DrWN_UbQgJ9oX6ybbCEQ2de_YjcM8C6M1To9
 ndHtcJDVkiJoSTt7PkMiDo6IejX0MuQfaIWfsQDEJUq8heStJ7KtEURS1Fhk2s93dJFIq8HCQJfW
 .uezCtapa9cyPBgfEA6dz0XGg8LP.FBesUyvW1elzS.5VWdTHMkgVboAgvdw48IcCiNDE.YoyI_w
 A777GhJaY79ATL.IpGOlRH6GHHKnR2.xtjNgTMhpqngqlZ0Bzogz0N4Bk
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:17:46 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c12209eaac0c3e6e8d2a068618591584;
          Fri, 31 May 2019 23:17:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 40/58] LSM: Use lsm_context in inode_notifysecctx hooks
Date:   Fri, 31 May 2019 16:10:02 -0700
Message-Id: <20190531231020.628-41-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux and Smack to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 5 ++---
 security/security.c        | 6 +++++-
 security/selinux/hooks.c   | 5 +++--
 security/smack/smack_lsm.c | 5 +++--
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 20e59e0b775f..eda0a1bcdf07 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1377,8 +1377,7 @@
  *	file's attributes to the client.
  *	Must be called with inode->i_mutex locked.
  *	@inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
+ *	@cp contains the string which we wish to set in the inode.
  *
  * @inode_setsecctx:
  *	Change the security context of an inode.  Updates the
@@ -1668,7 +1667,7 @@ union security_list_options {
 	void (*release_secctx)(char *secdata, u32 seclen);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
-	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
+	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, struct lsm_context *cp);
 
diff --git a/security/security.c b/security/security.c
index 0c23ffdd92c9..4f443dd481bd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2013,7 +2013,11 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
+	struct lsm_context lc;
+
+	lc.context = ctx;
+	lc.len = ctxlen;
+	return call_int_hook(inode_notifysecctx, 0, inode, &lc);
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e881f42d3ff8..633d62b97e90 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6339,10 +6339,11 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
 /*
  *	called with inode->i_mutex locked
  */
-static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static int selinux_inode_notifysecctx(struct inode *inode,
+				      struct lsm_context *cp)
 {
 	int rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
-					   ctx, ctxlen, 0);
+					   cp->context, cp->len, 0);
 	/* Do not return error when suppressing label (SBLABEL_MNT not set). */
 	return rc == -EOPNOTSUPP ? 0 : rc;
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 46eead699e1d..3d24503029e5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4474,9 +4474,10 @@ static void smack_release_secctx(char *secdata, u32 seclen)
 {
 }
 
-static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static int smack_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 {
-	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, ctx, ctxlen, 0);
+	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, cp->context,
+				       cp->len, 0);
 }
 
 static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
-- 
2.19.1

