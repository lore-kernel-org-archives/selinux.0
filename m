Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB2C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8896D2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LnF0/pwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfDIVlm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:42 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:36650
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727073AbfDIVll (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846093; bh=W6Zq0mDGK6AXoBDD4bxoIumDend/XN6awxL+92CHmPI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LnF0/pwEHjgCtzikMnh5MX8EhxGi8c8M1DXloZFbbWY27baN74AzHIrwpj6lfE5tETJBAuapmT7n3Lj210XE5gr1mv7xboiXVKdvzamJWYqCeO1d1LKt5yAWM9UmdFpyrIZXUOdVn84ADSHBXptQJ4dYh7Rd4prBRma/OCx5Bl2gc0K+j+1LwRr2zrVyJhfo+cMeHh7C2Zuh51llV8QM1kW3tIVGseOk3tTrGctA5Z79VtUToQwU5s1WBqujfYVtR4GxywMTQXr2wI3pC8Z711L8UyKOyG5iT/CrxpyDeywZuLs3x5J52mMn8RCcyjMiRkURsExyJMvGnThR2aHAtQ==
X-YMail-OSG: zh2CAE8VM1m1QUpYWqnFOU_xkH9A909VR61LxSkzPwMZAsdk8nwRgZLK_ZZke7L
 IXeUxjJAsr6dEtFnCFH71O3Kwq0Sgw3VRLBehXyqRtHS7kFOXH6IY2g_RtbUcB8UQp1014fLOgCZ
 IaUDJqM0q1rBRx0Qke94PnZaiAPavkmK3n6cgXmmYeE3p9k_rDwWYMlnSJKWKupgEROCP39PBUBg
 QTVxPHI6dhBIOd_kz04Z_nLwuZdN2LuMGmDhMwCUg2JiXwmmBHRhgNPh4csjnhPpo1nqBrKqnkSX
 VNwQXdo1TOQAbR7RwHX9uZ6IvMTMv6qx19.rWQjf48.Xn66HHgbsAuO4wDF7xrB7OKHdF.OCOcfT
 b2iu4PREZN.BIsGCVdV6toeTzhjsbX9cqSLbbFFjHm1gnfCca5w0tvXHv2x0pct4rFYd220JHeuZ
 nCKkTiD3CctBi5I2a2cA9fLNJgOMcSawOBkgpqrRmZwhJLLgXBzzlG8NnuvetWFlJke8XzOs.8Qx
 RKhKR93GWB.2R6kby55xCREm1hNDj30k_BRgWmDFseSDLj6wMnToVG5EYM_ejGEQxUOGKMnwpYtY
 .5l2JCj2K58hBPpE53TPwV1dxebntyHgC7zGueq9uq0VpQU2xTeVbp1Nua4bSPv2MxrFREXx21hM
 vXqgIEZKgB9SeRDKAN88btMFC08wjl2sA4jRwzvwpP2j1ivHQD6NayGvAtPONqZvRT2Fbve8ugjp
 ZXwHlJzsstjS6j2ygQYoFRyv36Vn6iwulL9nRP_MWNQy.QCyKn9bOlylB9mBrN8lmHviyxwIL.8Y
 O7Pp5fCemiYHy9DmoxsVo5qelVdegqvMvXzJhSqX2iN5.JimY.2YNY4c2zHFVbi1suTvq7iP36Lj
 f30dH9cZ8zuGl65QbKgn.n3CZgkRIDktHjAbOs.bjgK10.Zp5voYPyOnKKtAZrY7M2j11h8UjumP
 qw3uxgdLcWBL3RCv2x9NnopcbunjPM97zj8yuoijcTNwpfhVHuBKiClonCfIsDN6ndLLTNZp66LI
 mhm14._eeVyXs5mdMMIb_JdWdFSIwoWYguK8qXvpEkxfZruZJC9ZBq01ZhWq6vIK7lPqyzZ1sSuw
 9cgjq27ek5kNi_LR0OP6ukzTi6iL17u4cvM1k7ANyHXxH8pwFlezePBqP_DsQhw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp407.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0f9fc43d6127678694d9e39aed29be56;
          Tue, 09 Apr 2019 21:40:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 27/59] NET: Store LSM access information in the socket blob for UDS
Date:   Tue,  9 Apr 2019 14:39:14 -0700
Message-Id: <20190409213946.1667-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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
index e76d7a9dbe50..c413dcc1905a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -71,6 +71,7 @@ struct ctl_table;
 struct audit_krule;
 struct user_namespace;
 struct timezone;
+struct sk_buff;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
@@ -100,6 +101,22 @@ static inline bool lsm_export_any(struct lsm_export *l)
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
@@ -143,6 +160,8 @@ static inline void lsm_export_to_all(struct lsm_export *data, u32 secid)
 		      LSM_EXPORT_APPARMOR;
 }
 
+extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -174,7 +193,6 @@ extern int cap_task_setnice(struct task_struct *p, int nice);
 extern int cap_vm_enough_memory(struct mm_struct *mm, long pages);
 
 struct msghdr;
-struct sk_buff;
 struct sock;
 struct sockaddr;
 struct socket;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4d4107927ba2..afe9c9f1adeb 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -143,21 +143,23 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
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
index 69983ad68233..015c38c882ba 100644
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
2.19.1

