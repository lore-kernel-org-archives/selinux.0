Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72274C433FF
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479DE217D9
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gVyeaIiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389630AbfHGWnT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:19 -0400
Received: from sonic317-27.consmr.mail.gq1.yahoo.com ([98.137.66.153]:46532
        "EHLO sonic317-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389632AbfHGWnT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217798; bh=rgt35VYK8xtWCyWCZH0+rRuwRdtZJYLmJIf0XfoyZVQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gVyeaIiN+aFvS7j0igFCpk4MA+lDBU/1BxSoFR475ZnwhJQ5Ke1vsREW9ELqA0F+MkocpQ1nW8ze/YlOVfgmE4pE3oZnx0nJ9HgNTgEOoAf2Y9er/DYnohvxCvxkMLsE4nlmycevdxlGbPx8lKc3Unq80JkZ6LXJpFzcnDhM0Tt+J/nhJjCzJ7pUf8wpWM9KS/s4Kcf0OBY4U03WMKQ2gGrFz8m608QNFGfAC2q0kkA/G+JfXcAPZrl2zmf/O3w/6pboLHqSYzJfCYeM79W5NMZbcaK2xR+b4qzdheNU6R1yYNpFbKCOmxcdVJhxvLq9780Sr8V1DqQSA+AhaC+isQ==
X-YMail-OSG: .k6Q0lwVM1n9bI21Q4Q1mWByexH2psMldO2kvAIsCnrBjh.peeYhc2bYF97.F9U
 fjNcmIXB39bZWkMK5ID7vTakY8PbMtBqgLHBmNso4SiRkRyqGYDHEZrPPHrGZlvoSC.VKeMP44ri
 X1ydJGR1z1QZ1ocgIz6lwnx6SNcPmTbclTgv6zP6igUlh1uPHeIuOE.SPF3iO_qV2Yc9fhHIe1eS
 U4w3j2_lj7h5gu5SHBz5sZ8sGBnV4Jw4ckiXxlGivZYQzbaWsKKLwh9XMLoIdJZxkkXXGCLG4uU1
 KMUnTjcbcjo.oKcBzenLYIAnlClkmYs8z7Xw0AaIR.8HvbAzAH.Cs.rcsxTVby3UXqxZqUP5Afxq
 7KaXJpGbAZLA0sIBH1s7bGLO..XMen7scz8iHKERmrj5urHPoG5DlrwLQeSSm7e2rSvkiVNCR0TB
 Z.8TM3LL2SUyGcmYVAR3xq08yBcG.qnz9VNZyUtlmt9AbK4ZYl0KqnSKpVGVCWKBYSkodHVPtKVB
 aUXlgFBDuCVgM1no2j2KTPvKsgBUY3Z4nlEycYj_cIBJwhY8DrUA1ULWCDmPaOwtEfc2YbsG16cH
 ALbUTEDSx.Hmqy_p7vQRWdkoDo8JJurfrguGznd61tGwURrky8_ed2AdlkDbnhLfN8it08leIi.c
 q.kvTK8ytslF2wvsy1j2t9ZZ.ySswtJH1kxK__CIRIxzxCGmrZ_.b2Tx5GZptexz2KTFhShIHxPF
 o5KvDJQ.xq0xEYN0DYuz2sqW4oZ16.Cv.fNaFu8SipdW.6MsIXvRMJS92Jk2b0yVcfkIB7K_zx.E
 1oBgnl1Ipr4wh0FW7T5FFh34djrOowdBt8UZi__1eKogA3S6DKUtIh0jQU1RP64SoSffAs3uWpAu
 3hAm8kPYwBsUnrCBN1RPhG.joj_vWY1botErCYiBQZweac.vq4dKQzaNaNzYWgKHAX1Xjb2LZ4HR
 udSiQAgQEuGEN44Bduwq7lb7gBdFDylOVMCSA4cI8q89iR2oVoN3pYICFSpxVhlU7NKrhgsH.j3u
 bWyxIPYkU1Vsoa9PzC6Zk.S6TscNs72Y1eS5.wWMdbOPfvuZmrJ.Mhv8LofDYg2fyYTqjiZplLk7
 Hgd8W0c4hjC0zFweNqu9s01la3bqAlFre3tj8tbXWZOozshxNSjY9kYUQJbX2bSr0Cy83mUsoaJA
 PZ3RxLFHxWXTu2ole7o7dqmr_u1qIcU9DHISqxq_q5B745mQE3483WenQE4Vlr21018cZC8lbZ6Y
 MOMqzzFhydyzsHOWyiIqP.Jt1r.AJ_Pcq0TG9LYxvDy_qhZro993pP7lK5Cutn5JDDIXzU5yWwOB
 VqyRM_jBL
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Wed, 7 Aug 2019 22:43:18 +0000
Received: by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b31e22a1723893410aaa66faa171513d;
          Wed, 07 Aug 2019 22:43:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 14/16] LSM: Hook for netlabel reconciliation
Date:   Wed,  7 Aug 2019 15:42:43 -0700
Message-Id: <20190807224245.10798-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 67797c67093b..4bf88fa5b55d 100644
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
@@ -1432,6 +1435,10 @@
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
@@ -1788,6 +1795,11 @@ union security_list_options {
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
@@ -2025,6 +2037,9 @@ struct security_hook_heads {
 	struct hlist_head bpf_prog_alloc_security;
 	struct hlist_head bpf_prog_free_security;
 #endif /* CONFIG_BPF_SYSCALL */
+#ifdef CONFIG_NETLABEL
+	struct hlist_head socket_netlbl_secattr;
+#endif
 } __randomize_layout;
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 0e699d4ed13a..c234d881c206 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1934,5 +1934,14 @@ static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
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
index e726fc7c6712..bfe40c11f5bf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -34,6 +34,9 @@
 #include <linux/binfmts.h>
 #include <net/flow.h>
 #include <net/sock.h>
+#ifdef CONFIG_NETLABEL
+#include <net/netlabel.h>
+#endif
 
 #define MAX_LSM_EVM_XATTR	2
 
@@ -3003,3 +3006,50 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
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
index 91ef2ae77abb..48468a4b478c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6887,6 +6887,9 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
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
index 56e780340114..0f50a646c8cd 100644
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
index 87c81cbc8c67..122c13604d28 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4572,6 +4572,14 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
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
@@ -4733,6 +4741,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_copy_up, smack_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, smack_inode_copy_up_xattr),
 	LSM_HOOK_INIT(dentry_create_files_as, smack_dentry_create_files_as),
+	LSM_HOOK_INIT(socket_netlbl_secattr, smack_socket_netlbl_secattr),
 };
 
 
-- 
2.20.1

