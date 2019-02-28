Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40097C43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5F620851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qsg0rstv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfB1WUk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:40 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:43712
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729976AbfB1WUH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392406; bh=ATJToVBjnuDBIC7U6KtklpNvDxWpsaxtFTNEcUSwbgU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qsg0rstvFZf4l5V8P7aoXr0OzKbRefXTT7AJxuHhswaTcBxosIeqGB6KD7cj1iqxDTr3Yh65IX5kf0/o68no+7OB6SzXI0beDh769bCTIpUQP+J6E3ABgOyP0fSS0mrIRAHI2zKCdFDr/ovMYi9dGGmW4w0nDDVUSFBcLJCqPzLah5LrkqNwztBrbpS7psvb04C+tQ5/xng1vgJFJ1My7UvRmD0sisWby3OPBP4QPS1Xatd/KCFswFRUPHZOMvHCQ6CI50WbFEkQOzcj2U0UlcRncMV4ZVrywzx1oFqCuHJuQxrxhBWjttG3u2sPOLU6AQzjlRnXb32WJouh2UoqQw==
X-YMail-OSG: IzJelawVM1mkjcIIccWL1dEtfwi6vTTXkzyezLVL4_yBtpnxGtTa9VHWt.xjlex
 wdx1p8MDJOBDfMVZsIwk04HpUsCm5klyzaGQKkdMfPNApxrQLD_DB1TjLAkc6DQ7rRx5392mgLXt
 42C4lOfvB.Ewb4rUnWcMAkCGsLCYzGxPJQxtKNRcyRENisGXX_ZT.PX6FO9EJ_ZKqFzFo70WcPhN
 RBOX_SStO8wQ_1n5tZMuvHKVFS0FJaIAqh.4kaEuQmx3zx51bi2UuwdFhxhloq5cpFM8Hub9u_Uo
 HRkG9jOIwSmO3c_IAGjC815520KpGKgk0LI_9yyCIugo2DJi97IV6CMJZIXkLjjQ3FIQno2zz4Pi
 EZEUU6f5U10ZWW5m22b8oHZk3FfkvWw6x4yIJrAUVOe8lGMeSgryhE2xDxgMPGe6BfRj73b5EbBR
 5KHVj_hIaRhcWeHhtwijlrr38ZJT9aaauejzriLnV78SUrTraY1hfkg.Mup5_wf4jpopxSsXWln1
 Ikbm7mWLsPdUndIlb3vRbN_J6.54xp5vHqmUczDCEtqLT2T.06iw.2APcfjvOO4KlCU2dZHwlK4o
 TTD9mK.WmiNgrNs14vxTwZwA4xqwg5gjBTuzWTCV0tjkVg7GE9Cd16a8jwZ8MyZ1iuCO1q33oXO5
 hYJm6zr1L9gMoRown33xijO_QvZW7bWrxaan3NnP1T0tdqA4m1s.Es9LbGEAD42ueXio9aK9CfZ7
 2i_M6MbbLZQhd_9l_3GmfEI0doBwaEcoO7GbGF6wnsJJqeKS9bk9pTnQGvaqoRz6ZMn.GuLS4lYO
 yHb8g8Wn7R3kF7A_syHzJI2uAcHfln99HDCVs8q3iYpdpRSHoHp7qQtTnLR2ZT7zWOMGlr0s.oFJ
 uTbYffp95ZcNfy6nADsuLuJvGf6RWCX7ZaBCEaC772DpP4EKbc1NJrMxcjDWk5DSjXwBGaa_eShi
 lDHiRvPIyQXbxUN6XGtpteEXeEu.eyAWQHSDdyg73SMKzyXXa_86ktrbELxAf515ekxDyxSjk52n
 b.FT0bA6gMGikQdLZYfvy0pbmn4PmAlbZV2HrdL8BlkLroAt5Wmmv4lpK.h656uMU_vRr7hTZx9o
 DZO94Yb3AYD9x73O2oGHZGIXq9hZ6bDkdar17XBwRGI_7osFR
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e8fded081226753664bb344863181a7a;
          Thu, 28 Feb 2019 22:20:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 33/97] NET: Store LSM access information in the socket blob for UDS
Date:   Thu, 28 Feb 2019 14:18:29 -0800
Message-Id: <20190228221933.2551-34-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

UNIX domain socket connections don't have sufficient
space in the socket buffer (skb) secmark for more than
one Linux security module (LSM) to pass data. Expanding
the secmark has been ruled out as an option. Store the
necessary data in the socket security blob pointed to
by the skb socket.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 20 +++++++++++++++++++-
 net/unix/af_unix.c       | 14 ++++++++------
 security/security.c      | 17 ++++++++++++++++-
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index ae79b24f076d..6659ffa8cacc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -68,6 +68,7 @@ struct ctl_table;
 struct audit_krule;
 struct user_namespace;
 struct timezone;
+struct sk_buff;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
@@ -97,6 +98,22 @@ static inline bool lsm_export_any(struct lsm_export *l)
 		((l->flags & LSM_EXPORT_APPARMOR) && l->apparmor));
 }
 
+static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
+{
+	if (l->flags != m->flags || l->flags == LSM_EXPORT_NONE)
+		return false;
+	if (l->flags & LSM_EXPORT_SELINUX &&
+	    (l->selinux != m->selinux || l->selinux == 0))
+		return false;
+	if (l->flags & LSM_EXPORT_SMACK &&
+	    (l->smack != m->smack || l->smack == 0))
+		return false;
+	if (l->flags & LSM_EXPORT_APPARMOR &&
+	    (l->apparmor != m->apparmor || l->apparmor == 0))
+		return false;
+	return true;
+}
+
 /**
  * lsm_export_secid - pull the useful secid out of a lsm_export
  * @data: the containing data structure
@@ -140,6 +157,8 @@ static inline void lsm_export_to_all(struct lsm_export *data, u32 secid)
 		      LSM_EXPORT_APPARMOR;
 }
 
+extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -171,7 +190,6 @@ extern int cap_task_setnice(struct task_struct *p, int nice);
 extern int cap_vm_enough_memory(struct mm_struct *mm, long pages);
 
 struct msghdr;
-struct sk_buff;
 struct sock;
 struct sockaddr;
 struct socket;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e2327428aecb..df183ff69d61 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -141,21 +141,23 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
 #ifdef CONFIG_SECURITY_NETWORK
 static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	lsm_export_secid(&scm->le, &(UNIXCB(skb).secid));
+	struct lsm_export *ble = lsm_export_skb(skb);
+
+	*ble = scm->le;
 }
 
 static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	lsm_export_to_all(&scm->le, UNIXCB(skb).secid);
+	struct lsm_export *ble = lsm_export_skb(skb);
+
+	scm->le = *ble;
 }
 
 static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	u32 best_secid;
-
-	lsm_export_secid(&scm->le, &best_secid);
-	return (best_secid == UNIXCB(skb).secid);
+	return lsm_export_equal(&scm->le, lsm_export_skb(skb));
 }
+
 #else
 static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 { }
diff --git a/security/security.c b/security/security.c
index e52b500adb27..2f9411b93f70 100644
--- a/security/security.c
+++ b/security/security.c
@@ -46,7 +46,22 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+
+/* Socket blobs include infrastructure managed data */
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
+	.lbs_sock = sizeof(struct lsm_export),
+};
+
+/**
+ * lsm_export_skb - pointer to the lsm_export associated with the skb
+ * @skb: the socket buffer
+ *
+ * Returns a pointer to the LSM managed data.
+ */
+struct lsm_export *lsm_export_skb(struct sk_buff *skb)
+{
+	return skb->sk->sk_security;
+}
 
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
-- 
2.17.0

