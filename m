Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0801EC282DE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C269C2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gM/mtTIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfDITTT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:19 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:46074
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbfDITTQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837555; bh=W6Zq0mDGK6AXoBDD4bxoIumDend/XN6awxL+92CHmPI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gM/mtTIuOeFpLzbJmm+WZpkZ06F82uBq+NTLPgSzQwuBxNrR/c1omKJwpDVk/75n2HDCEhuk8vkqQLhYS8YvSxm42BGG+k17uBH9EfiIxxOtp8rZr2uNI0ctMcUUz4aJRqRf5syLEx41E7HwHXDnLmwyALabaK4K0Mg6FvTYWMKr8bmtR+88PmQNY4LE3AIQAF8JgVOaR2NcEv1W6O2Xej0rDxjTpi/kT1bVthiO8hrbXny3uoQiidCAxsBgH615T3uDQ4iwyGvXkz14xmqyu9yqoxJ5DrkQ6dRUkDfnDlXYpOo+GGXDn37I+5VLvTIEcVio8lifYmaBU3hki2vHSg==
X-YMail-OSG: exD7ILkVM1m8H7F2wZ4k9rDRYy71SuSk5GeV3jDwMMtfF7ef13qiMK1xA3Sh7ZA
 z39xC3Ekr6NR8QvqYjzRBGMST5gA.DqgNR_8fD28V7P9G6m5gSWJ6z3qbeGqIU2MFx3btvyO4YkG
 kRd3Kv8mJDJ.r4KVi6hy2aedliuHilpIKskNmeSXRyLVML.phua.MepmgWLcH_2rj.LRNas6gr7Z
 cWw.vLLDRmRg8clCCJRnZL9CPWQ0yK5H1F_0eowtJ7dRfDGJEeZFSe0axRQUrwXFPGd2WmrQbz.W
 egXcPtZ_i6fTWWgtnV0hXVeDxJT1p1GM7hF6aO21nYt_yYUsbrhtDC0AlMSMOas_sGUgzH03JbNr
 W30MmeRA6xB4a74Wt0FBC_4Rn.JOFErmumJ7Bqm6Nb1H20RRJ1O4ThULQlgHHQt6QxxUJLeu1jHN
 jEQF14JyP1CsDO3XkIzR.3LdCejvhQJ7YQ0hujaTK6J_r2f.8Ftwl19YYLZ04sXNXjx0TA2cxGfI
 Mtvjz1rCh247msHph13TUJRCY2qewr4dm9ow7UbvM.2_VTz9MTLYogDcohMj8RKS0Z4gsa1hphu6
 UaPsBlEXO1iUhzlBZLnV2Xe8zKYlKNoXgZb4W4TjH4ALRvN1v2kPqGnpB6UkpGzpWgYXrLTPu7Nl
 t.si5YUWQ1hmWLw.NOn.gsxZ0qTPmGvgpzJCqBbsV1.f8INYf5yrLZmGFpgQMflWd84AEraylUBK
 lvjZkWMcDtuH71rL7y1y7P_L.VHafVGB8WqnUeNO1ocJdL2IQ5jFPXVWwQQ_AJFNaetYVMwDh45m
 gXaL.g8atrHpY.LX2EJV_vcRC3h2Xt_sR2E1dgyqWcQOJBSzGuQoJWAy3hrGakm26YDcT5AbjQ9u
 pLzNzxeh2QUk4uogbpVjC5VJIPAD7UD_Zm0ELWQDPF0TAz1JZplZKeg6U10xGeoBe.Rj3F77sbyJ
 fPKRRtTCINO.ycCZ_UxhOJnnkN5Sy4WYRQVWkHO9SZXiHGfELhhYqAK8r4n84URg2yKJUn8cpiFG
 tkRgC2EZn12H2mn4TUf8EzYl6cHOcMwE0rlt3kLGJhBt7iiNsHv7dPrz8YzPyBfqA__NgLGLUc0f
 X0awwizhQCvSYX2U1C_SwPSoBuTdNLsDZ.ODBsKBzj4DcsGe4dmPpIQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 70e478474b1bad4641d6b335096eeb36;
          Tue, 09 Apr 2019 19:19:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 27/59] NET: Store LSM access information in the socket blob for UDS
Date:   Tue,  9 Apr 2019 12:18:16 -0700
Message-Id: <20190409191848.1380-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

