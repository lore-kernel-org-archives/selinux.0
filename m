Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6AAC10F06
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8314206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fYIFN3Ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfB1Wom (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:42 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:44014 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731103AbfB1Wol (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393879; bh=0s2KBJq36nVFH7MLd6nTz4cocnrI67Rp9WTiPIZnBPU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fYIFN3TyY2IAcPkqAvhmLZk1TnCn+JH6jnn0Y091PwD2zBcGlhXok8+y6FaQhNds1km1vqTFW3Cvk5iYfvitWYbmwFeT7y/OGPA4ecg8wR+lnKyf2m4EbkdE1ZwDp36wCl6PVhnHBVo+Lk3udOhaIRNT/pAtrTpruG2KO0naJKNlVOcnkiNk+RXDH2NaTPLNIaPNi5RDDxsVWbCYiQUlW6R2V298eG2a2eYwVSMalnAxKseFuIWQU5WLRsXbjFYaO7bIxU2NL3g2MgHp69SYDUvyIjfjW7PCwzodrxJCdpVQwIRmeUB/OUrEXLOWxctRW54XcUjRP3YuQTFKYwFQOQ==
X-YMail-OSG: DQOAOnsVM1mOAQhI5wtssINR5Zwfh1UvUKF9cTDZ9MyKyl0n3z3EpcdcFHLPgoJ
 _efwyoUgkWE5u2kSCxixJZotm0bCvd2x2YTXmR08Qjx2hZ9cGJ837sf_UnLTRNKSbxaIHCg3AYmk
 YonShgey3Da0GPLjQaJgNvh8ayEcbwlSuHRHfWWeXbrEgnZKWwh61CuQuWn43TR3GuQfMAzOBeWt
 wL6iAbt8batOgvCVtlNShm8d.L4vyDCJ9hGjkZgP057KwVN3xb.mDpYGe.Pr1DgkFGY5NOL7kKxH
 uB3JWqLC.gaYr3Qo3tGBz_EZKMlc_PPaQshf07N0TEsmSdJPpREByy.pjcHPf6kvpwiI_5gJL1f6
 9ydxf4Byp2wAX59IY2G_bbq_rcvuK7Pi6dFEfNTpk.22hBwjWBxBXOwpvl_v.qO7aBtKkhQxiMrv
 4ZYPlziR.dAL.396kWd4jYqpjtkF5magptkxJcGHicYoYRYpyReQ2o_8yK2wZfGhuERhInu1yd83
 9O.EeZc5fiEIXgVDgchumYoitg5gm6FPTF78deNYdoRFQ6_Jlu2G9I1VtrQhns91YLBcXOMdZ2Md
 U0LmMtv2Spigt7h5F5HcGe0098b0TyLrQYTjj43NkEYEhL_ohsWpkfMwT2lh6iRGDqLIpnkF1MZu
 bi.si1wU3VsM8CWp9AjgTdXRVafyYRS.cszfIGGf32dS8UrfrCroD0MThaGtLerJwGXbmEiC3WY0
 IyYwa.BUaJSrnyu_Ff50JmejvtX3Xq2ikUgvZjgi7vPkZ5TPyknQDxZ0yIcke3z8qc6pFNamrWlN
 MohacVjw.ILe7uNKhrFzHBP5dqUwtmd5AZxzofRjDjXV5uMYXO.HdACJZEwta1o2YrDXP76G..Ju
 M2WNqCdDLdMRQaQwyRc2enbLTGS8fCtVpTXC8_XO9f0dbBhys_TFvLYcigWRJwZZ0RuBJVonA31p
 9aZ8VNqRqH.cDOCfXmSNTpOKKa7LeWV8i1Vwk9pKAKo56SF6NceT69q1Ttm8edwRJm0tyAY43vuL
 AXGQY6TtFPPJGXR1CuKbJrANCMFZ0J1gW17EjajBXTOExm8TXlkwOFnd_N_zxh87lbJglXKbzcsN
 frP5TlAAonyZpXYpM3AwnmmxJn0G7I6dm_IqxWoxAKnhmCUv8ZSqNmWQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41bc5dec9e4ecaa87e9a199cc17828e6;
          Thu, 28 Feb 2019 22:44:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 94/97] LSM: Hook for netlabel reconciliation
Date:   Thu, 28 Feb 2019 14:43:53 -0800
Message-Id: <20190228224356.2608-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add an LSM function security_reconcile_netlbl() which
uses the new LSM hook socket_netlbl_secattr() to decide
if the active security modules are in agreement regarding
the labeling of a network packet.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h           | 15 +++++++++
 include/linux/security.h            |  9 ++++++
 security/security.c                 | 50 +++++++++++++++++++++++++++++
 security/selinux/hooks.c            |  3 ++
 security/selinux/include/netlabel.h |  7 ++++
 security/selinux/netlabel.c         |  9 ++++++
 security/smack/smack_lsm.c          |  9 ++++++
 7 files changed, 102 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fec7f86897ea..2a53465f94da 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -29,6 +29,9 @@
 #include <linux/init.h>
 #include <linux/rculist.h>
 
+#ifdef CONFIG_NETLABEL
+struct netlbl_lsm_secattr;
+#endif
 /**
  * union security_list_options - Linux Security Module hook function list
  *
@@ -1416,6 +1419,10 @@
  * @bpf_prog_free_security:
  *	Clean up the security information stored inside bpf prog.
  *
+ * Security hooks for network labeling (Netlabel) operations.
+ *
+ * @socket_netlbl_secattr:
+ *	Report the netlabel attributes this module wants for this socket.
  */
 union security_list_options {
 	int (*binder_set_context_mgr)(struct task_struct *mgr);
@@ -1772,6 +1779,11 @@ union security_list_options {
 	int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
 	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
 #endif /* CONFIG_BPF_SYSCALL */
+#ifdef CONFIG_NETLABEL
+	void (*socket_netlbl_secattr)(struct sock *sk,
+				      struct netlbl_lsm_secattr **secattr,
+				      int *set);
+#endif
 };
 
 struct security_hook_heads {
@@ -2006,6 +2018,9 @@ struct security_hook_heads {
 	struct hlist_head bpf_prog_alloc_security;
 	struct hlist_head bpf_prog_free_security;
 #endif /* CONFIG_BPF_SYSCALL */
+#ifdef CONFIG_NETLABEL
+	struct hlist_head socket_netlbl_secattr;
+#endif
 } __randomize_layout;
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 7edceb91d77f..c9d7de811b53 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1878,5 +1878,14 @@ static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
 
+#ifdef CONFIG_NETLABEL
+extern int security_reconcile_netlbl(struct sock *sk);
+#else
+static inline int security_reconcile_netlbl(struct sock *sk)
+{
+	return 0;
+}
+#endif
+
 #endif /* ! __LINUX_SECURITY_H */
 
diff --git a/security/security.c b/security/security.c
index ab1050a2dce3..3c1d2f47b09f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -33,6 +33,9 @@
 #include <linux/msg.h>
 #include <net/flow.h>
 #include <net/sock.h>
+#ifdef CONFIG_NETLABEL
+#include <net/netlabel.h>
+#endif
 
 #define MAX_LSM_EVM_XATTR	2
 
@@ -2775,3 +2778,50 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
 	call_void_hook(bpf_prog_free_security, aux);
 }
 #endif /* CONFIG_BPF_SYSCALL */
+
+#ifdef CONFIG_NETLABEL
+int security_reconcile_netlbl(struct sock *sk)
+{
+	struct netlbl_lsm_secattr *prev = NULL;
+	struct netlbl_lsm_secattr *this = NULL;
+	int prev_set = 0;
+	int this_set = 0;
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_netlbl_secattr,
+				list) {
+		hp->hook.socket_netlbl_secattr(sk, &this, &this_set);
+		if (this_set == 0 || this == NULL)
+			continue;
+		if (prev != NULL) {
+			/*
+			 * Both unlabeled is easily acceptable.
+			 */
+			if (prev_set == NETLBL_NLTYPE_UNLABELED &&
+			    this_set == NETLBL_NLTYPE_UNLABELED)
+				continue;
+			/*
+			 * The nltype being different means that
+			 * the secattrs aren't comparible. Except
+			 * that ADDRSELECT means that couldn't know
+			 * when the socket was created.
+			 */
+			if (prev_set != this_set &&
+			    prev_set != NETLBL_NLTYPE_ADDRSELECT &&
+			    this_set != NETLBL_NLTYPE_ADDRSELECT)
+				return -EACCES;
+			/*
+			 * Count on the Netlabel system's judgement.
+			 */
+			if (!netlbl_secattr_equal(prev, this))
+				return -EACCES;
+		}
+		prev = this;
+		prev_set = this_set;
+	}
+	/*
+	 * No conflicts have been found.
+	 */
+	return 0;
+}
+#endif /* CONFIG_NETLABEL */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 22a190f291c0..84bfcf7ca08b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6769,6 +6769,9 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
 	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
 #endif
+#ifdef CONFIG_NETLABEL
+	LSM_HOOK_INIT(socket_netlbl_secattr, selinux_socket_netlbl_secattr),
+#endif
 };
 
 static __init int selinux_init(void)
diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 8671de09c363..b316c62e7bcc 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -69,6 +69,9 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 int selinux_netlbl_socket_connect(struct sock *sk, struct sockaddr *addr);
 int selinux_netlbl_socket_connect_locked(struct sock *sk,
 					 struct sockaddr *addr);
+void selinux_socket_netlbl_secattr(struct sock *sk,
+				   struct netlbl_lsm_secattr **secattr,
+				   int *set);
 
 #else
 static inline void selinux_netlbl_cache_invalidate(void)
@@ -165,6 +168,10 @@ static inline int selinux_netlbl_socket_connect_locked(struct sock *sk,
 {
 	return 0;
 }
+static inline void selinux_socket_netlbl_secattr(struct sock *sk,
+					struct netlbl_lsm_secattr **secattr)
+{
+}
 #endif /* CONFIG_NETLABEL */
 
 #endif
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index b6fd905e6e9e..56ae261d2805 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -642,3 +642,12 @@ int selinux_netlbl_socket_connect(struct sock *sk, struct sockaddr *addr)
 
 	return rc;
 }
+
+void selinux_socket_netlbl_secattr(struct sock *sk,
+				   struct netlbl_lsm_secattr **secattr,
+				   int *set)
+{
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	*secattr = sksec->nlbl_secattr;
+	*set = sksec->nlbl_set;
+}
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1b9c7e5e801a..885e1799df00 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4487,6 +4487,14 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	}
 	return 0;
 }
+void smack_socket_netlbl_secattr(struct sock *sk,
+				 struct netlbl_lsm_secattr **secattr,
+				 int *set)
+{
+	struct socket_smack *ssp = smack_sock(sk);
+	*secattr = &ssp->smk_out->smk_netlabel;
+	*set = ssp->smk_set;
+}
 
 struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct task_smack),
@@ -4638,6 +4646,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_copy_up, smack_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, smack_inode_copy_up_xattr),
 	LSM_HOOK_INIT(dentry_create_files_as, smack_dentry_create_files_as),
+	LSM_HOOK_INIT(socket_netlbl_secattr, smack_socket_netlbl_secattr),
 };
 
 
-- 
2.17.0

