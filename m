Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9449C282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0692147C
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fiGPTzdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfDIUAb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:31 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:43648
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbfDIUAa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840028; bh=W6Zq0mDGK6AXoBDD4bxoIumDend/XN6awxL+92CHmPI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fiGPTzdOP+W1DKNtR0BgFdal1M9FyPaKSYMT5x21b11WxyXCuGweL4L4vZNIVYajTXMuzsGjbZmyqkhPezanWUf++KgF1f/i7fYh9KatpzQfSOFxh3SVI2fcv0maxXE8Sk9K8fEu0uzPWA6d7UU2/Uz5UQ0bnIW2sKVjUMKG2FljAVx5uog7SYpy75XZxCHM4KqfLs9AAU/64y6TOjx/OSxzZgJI4X/pvzPwBu7Esp9u9w0GeB/4ozuFDXr0gc/OWjeUzc8lcFs+J5Fz01C8TdJSdbtAO8JWoFj6wm33Q7XlllRkV4pJTdbz5g4lWnwRfKMhVB29LIMHWdhjvePQTQ==
X-YMail-OSG: wIhAszUVM1mTmTyznddPMAMYFKlB0UPV44Qwen59tT5jXMCcZtYAxwdpd1nYpaE
 PdLwmrBW21QuGeE0z5XS9n7StdTuMGjahKPdCG2v98U.8KqmZlHc24S7K5G848NqxC69a2yhoWak
 ofiLz88xoCvU1gMAN.F3D2s8kJbSYpAx9q0zZHeW2INdYSiM3o0EZpTBvOINTvlNVnLUPBwv_nmW
 GtmIuvcmACsfr2puH49Uk1y7V6tfjrBSuac2FdhISgHjgjXYyKtwyYkLfw04_hQr1kDSHN0RO_NR
 gJ0Qjb.mFdmrQyWEJZPTq9kjCmcEVyuF_pK4IPmM_wwCwzGffhZ1KYrGUody9phB.4ooZzxFJD4r
 Ei5F1D7wm9nEh3r9y9bapDsqGgjtBfelHKmNc6OvgZGdhi.whDRBChs6cqRja_wS00ChlAy_04Ua
 pyDKqj9g25ALI7slIgqYBGA7baA4ulF15QngFPxYeGyS1Na9UUzRFv60y_HDYxrc6G4iso9nSJWP
 _hft8vFGaSV6EbvVxQcIXuYXWO_OtZoygfdD5ffoUZ0wW6Up2slqefaL2XR5_RMvqEcxeRrR4IDL
 4dOS0BUvPwQ4baLHrYc3My8cutT3_LSuY0CCMGsp2KkC84xs2PYzH3.R02PBGDr2OSHfpND1brhP
 7o0L5wj7Na4pul2ItRVTTXr_IQpeLmo1kqyzDTgwl3Sw_wK9Xom6aB2Cld4vzl1TS3zHuC._64j6
 QHhmj_gNxBLzT6_PVpjhWbhhYLGuRUJGRYTs7fb5TZE_DFJY62x265ndDm2Gkf1vqZoNJzOutljm
 O1U_jI.5Qg3.u9Ym1WWm8C97Bl8lO0ckzf.SibIkSPT_C44gUM6RQ4aTjt9AM7Tjx5wA9A4HnauR
 hBb4OliCuj1TLOJCRnjW10LUEu3ENlROBXTfRa7Ph9SM9k2zkS9qaHiHgeSHzg89RREUuMd2kbxw
 q0uU2SfGUA0BbQKtzU4TQPN9AKAuftoHi1QKPdsG8t8G0G88YrYd53oPD7wnBvTLjh_1tXPotR4a
 Y54oX1kiAigTXdztYnUylKIWgnpp2ZndRRpylIBcszrsCnky0xcHGNaNZ2QBuNXEpiajAxWPE3tZ
 _B5qa8QzzL0OkEzNygYuP1w9u8OqO087Qamc6hJ5iOuNwQMp_fUUJJg_q91U-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 102fe805e930c993b64b67f47c5c2e96;
          Tue, 09 Apr 2019 20:00:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 27/59] NET: Store LSM access information in the socket blob for UDS
Date:   Tue,  9 Apr 2019 12:58:52 -0700
Message-Id: <20190409195924.1509-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

