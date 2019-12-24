Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0C4C3F68F
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DE92071A
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lyyiC69N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfLYADB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:03:01 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:36908
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbfLYADB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232176; bh=5cY8aQYfCfcg+S3MGGafLkGfGCoP1mwsBtNOpQieffU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lyyiC69NzNrI4eWSYbxICZA4QlrVNFIri7JAp0Y84ixbTX9op78f1TCmVdBI3Khmgx6firO/PWyDV3ILXCfA0vbUm28MBOu1jU2CeWCA+wR4yVdixxAY5AJaL5lMxXSewVPn6IAsd+kGlPDEE5m+cT+uYhLj9h8gBxuIiq/b6ZyyIKZR58y5gsPTPAH/CzNKXLw3go0LHPsU2M6MlbkcgmvUjycSKz7KH4keHs7TYTqJemBbh/myUkgJg8qU6qmasSCuIDxaFIwY43qu3jNGKFM4Opq3XeqKz9hxWIoTswuywLSVYOb+2pNECGFcNTF/kG1mOZ9ODcveyFWKKo7RFA==
X-YMail-OSG: PqoG6dAVM1kSTXbOYPtaMb48QEtoniU7IMa.qHs.bTc8VRiWmxKI_Rcfma.odym
 YfhNIlnrLhq1mIlE9h.6uyBylD9q55U37yvdVWWeQhcFtGVpV2rRJatPFRU00Pjsnsp.a5sRHlkW
 pW8uso21LAcdlF8ZupzJX2hmTzUMcHrRuF6g14Q..wej0.V7_ELLMzq9rUbbZvIgC4g8r1.dk26z
 HsFaSdv6cw32aQlGo8qpuD88boK0FSiTj0.d.hx4h1wBrgxzzmvhpQqlKicI7s5FPhpQbk_9wl1F
 UJvAALp9hRv75IBcgt1kTy9YcuzmbdOpydS1VC4gjkUyCp1GFS_yB4NiNOB0dBjEQfLArIHQLbK_
 03x.M_AApljaNQmkmPv3B2pG41SoY4jUR5VnG1sgwgbmsGSn2HNLHqc1h8AqLNK_GrFo7NxiTYSb
 y7WhAUbDJj_Cy6FU0I6mteOTQ3bYBDb2tenvKec7DfOMA5_DV6b9hrD_519uzcMSFCxlgRl0wRZ7
 2nDLAVtvHk8lZJ._eQ18padcrIX7xRk8I45hvYwXcv_doTsC4LGhxvRgVTjPI.Cs3zouYGpzJGcN
 Y5V2yOQOII6JQZNYrUsXiiHrOV4MLihlbOCfi65RkVzkNNAHne3_AaiuiVQSzbxo5nRkI4sniau6
 riNd0mAzL9oM6YVeHxBXuuLkgC0CZUq9ZwUaiWD8Hydsv_I9EAGIPlFZeLap6Ik2Bs.RJ6WcWw4D
 jcA0KV1Vwo4MLtnqnT7x.be1JLZlds_DU0fuJvTrCoR5qR2aZ4Ettpr0n_OFAT3QqUtiWjQOqquL
 13kfU3aL7YqO6L.px2O1cM_ghYrsvp5BxBkYpszRMR0n5dLAQn8imJIbl9KHj7XE.MlXWfXUcowj
 8iPHiOW_GRnwfeE_Z0aUE0.MnsltiIvFGyYplTq26x61_o2oPJpPRtSgmjkzinaiZYRwEa5m3ZyJ
 lsatMViP9RqcB9FC3yzNrYxiCsY.doaR.jmRELYfdaQJKJbbpE4TB7Zjp7fztn9D6dvWPY__2i72
 qbaiH5_Ez600dcvp1GUBMPW38G2g7xAf24QWqo47__3S9RQ8NxRQ7YhST.lSMMaJ7a74Y2.Eh6Q5
 J9ZTMT8NKpvkFTJddCU8b7JhweoYqRymzA2h.FdJi0uQ1e0PqRP6yAVPkOe._Xe8dDh97WyGzSgU
 DbJch4EXOaQxL7CShTzRVjMp8N4KIaDj0aEHRiDF0tnTLDspAXcnHKrRft45JnORlaLEUFhuD9Gy
 LF5nuU72wE2w0mEXYICFdqcG9Ov6J8U6DZiXFVRLa9o8UFJfByPOjb7cyqqR.L69Xw8H5drenat4
 m.D3qp_RAyhU5EX59tMWQlyfToV_5GgvuTnyAL9iyUmTInUjy.DQHqw4lOObpgLwkZtnZ6m.PKt5
 dIrMSDyOI6a.Vg9PJshBM.7KMFBQe2rztv785M2bK3uo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:02:56 +0000
Received: by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4d8acb07bbe0004dd2134ff17c6a0ed8;
          Wed, 25 Dec 2019 00:02:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v13 21/25] Audit: Add subj_LSM fields when necessary
Date:   Tue, 24 Dec 2019 15:59:35 -0800
Message-Id: <20191224235939.7483-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add record entries to identify subject data for all of the
security modules when there is more than one.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: netdev@vger.kernel.org
cc: linux-audit@redhat.com
---
 drivers/android/binder.c                |  2 +-
 include/linux/audit.h                   |  1 +
 include/linux/security.h                |  9 ++++-
 include/net/scm.h                       |  3 +-
 kernel/audit.c                          | 40 ++++++++++++++++++-
 kernel/audit_fsnotify.c                 |  1 +
 kernel/auditfilter.c                    |  1 +
 kernel/auditsc.c                        | 10 +++--
 net/ipv4/ip_sockglue.c                  |  2 +-
 net/netfilter/nf_conntrack_netlink.c    |  4 +-
 net/netfilter/nf_conntrack_standalone.c |  2 +-
 net/netfilter/nfnetlink_queue.c         |  2 +-
 net/netlabel/netlabel_unlabeled.c       | 11 ++++--
 net/netlabel/netlabel_user.c            |  2 +-
 net/xfrm/xfrm_policy.c                  |  2 +
 net/xfrm/xfrm_state.c                   |  2 +
 security/integrity/ima/ima_api.c        |  1 +
 security/integrity/integrity_audit.c    |  1 +
 security/security.c                     | 51 +++++++++++++++++++++++--
 19 files changed, 124 insertions(+), 23 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 463372198099..57e14b80588f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3107,7 +3107,7 @@ static void binder_transaction(struct binder_proc *proc,
 		size_t added_size;
 
 		security_task_getsecid(proc->tsk, &blob);
-		ret = security_secid_to_secctx(&blob, &lsmctx);
+		ret = security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_DISPLAY);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
 			return_error_param = ret;
diff --git a/include/linux/audit.h b/include/linux/audit.h
index f9ceae57ca8d..2ce0e8da3922 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -161,6 +161,7 @@ extern void		    audit_log_path_denied(int type,
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_task_context(struct audit_buffer *ab);
+extern void audit_log_task_lsms(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
 extern int		    audit_update_lsm_rules(void);
diff --git a/include/linux/security.h b/include/linux/security.h
index 49d2a778020e..d7af2bbbc878 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -176,6 +176,8 @@ struct lsmblob {
 #define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
 #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
 #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
+#define LSMBLOB_DISPLAY		-4	/* Use the "display" slot */
+#define LSMBLOB_FIRST		-5	/* Use the default "display" slot */
 
 /**
  * lsmblob_init - initialize an lsmblob structure.
@@ -217,6 +219,8 @@ static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
 	return !memcmp(bloba, blobb, sizeof(*bloba));
 }
 
+const char *security_lsm_slot_name(int slot);
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -526,7 +530,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			     int display);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob);
 void security_release_secctx(struct lsmcontext *cp);
@@ -1330,7 +1335,7 @@ static inline int security_ismaclabel(const char *name)
 }
 
 static inline int security_secid_to_secctx(struct lsmblob *blob,
-					   struct lsmcontext *cp)
+					   struct lsmcontext *cp, int display)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/scm.h b/include/net/scm.h
index 4a6ad8caf423..8b5a4737e1b8 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -96,7 +96,8 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(&scm->lsmblob, &context);
+		err = security_secid_to_secctx(&scm->lsmblob, &context,
+					       LSMBLOB_DISPLAY);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY,
diff --git a/kernel/audit.c b/kernel/audit.c
index 224c7b4a1bc0..d40f64a47c4b 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -392,6 +392,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
 	if (rc)
 		allow_changes = 0; /* Something weird, deny request */
 	audit_log_format(ab, " res=%d", allow_changes);
+	audit_log_task_lsms(ab);
 	audit_log_end(ab);
 	return rc;
 }
@@ -1097,6 +1098,7 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
 	audit_log_format(ab, " feature=%s old=%u new=%u old_lock=%u new_lock=%u res=%d",
 			 audit_feature_names[which], !!old_feature, !!new_feature,
 			 !!old_lock, !!new_lock, res);
+	audit_log_task_lsms(ab);
 	audit_log_end(ab);
 }
 
@@ -1347,6 +1349,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 					size--;
 				audit_log_n_untrustedstring(ab, data, size);
 			}
+			audit_log_task_lsms(ab);
 			audit_log_end(ab);
 		}
 		break;
@@ -1361,6 +1364,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 					 msg_type == AUDIT_ADD_RULE ?
 						"add_rule" : "remove_rule",
 					 audit_enabled);
+			audit_log_task_lsms(ab);
 			audit_log_end(ab);
 			return -EPERM;
 		}
@@ -1374,6 +1378,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		audit_log_common_recv_msg(audit_context(), &ab,
 					  AUDIT_CONFIG_CHANGE);
 		audit_log_format(ab, " op=trim res=1");
+		audit_log_task_lsms(ab);
 		audit_log_end(ab);
 		break;
 	case AUDIT_MAKE_EQUIV: {
@@ -1409,6 +1414,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		audit_log_format(ab, " new=");
 		audit_log_untrustedstring(ab, new);
 		audit_log_format(ab, " res=%d", !err);
+		audit_log_task_lsms(ab);
 		audit_log_end(ab);
 		kfree(old);
 		kfree(new);
@@ -1418,7 +1424,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		len = 0;
 		if (lsmblob_is_set(&audit_sig_lsm)) {
 			err = security_secid_to_secctx(&audit_sig_lsm,
-						       &context);
+						       &context, LSMBLOB_FIRST);
 			if (err)
 				return err;
 		}
@@ -1477,6 +1483,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				 " old-log_passwd=%d new-log_passwd=%d res=%d",
 				 old.enabled, s.enabled, old.log_passwd,
 				 s.log_passwd, !err);
+		audit_log_task_lsms(ab);
 		audit_log_end(ab);
 		break;
 	}
@@ -2055,6 +2062,33 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 		audit_log_format(ab, "(null)");
 }
 
+void audit_log_task_lsms(struct audit_buffer *ab)
+{
+	int i;
+	const char *lsm;
+	struct lsmblob blob;
+	struct lsmcontext context;
+
+	/*
+	 * Don't do anything unless there is more than one LSM
+	 * with a security context to report.
+	 */
+	if (security_lsm_slot_name(1) == NULL)
+		return;
+
+	security_task_getsecid(current, &blob);
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+		lsm = security_lsm_slot_name(i);
+		if (lsm == NULL)
+			break;
+		if (security_secid_to_secctx(&blob, &context, i))
+			continue;
+		audit_log_format(ab, " subj_%s=%s", lsm, context.context);
+		security_release_secctx(&context);
+	}
+}
+
 int audit_log_task_context(struct audit_buffer *ab)
 {
 	int error;
@@ -2065,7 +2099,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context);
+	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
@@ -2173,6 +2207,7 @@ void audit_log_path_denied(int type, const char *operation)
 	audit_log_format(ab, "op=%s", operation);
 	audit_log_task_info(ab);
 	audit_log_format(ab, " res=0");
+	audit_log_task_lsms(ab);
 	audit_log_end(ab);
 }
 
@@ -2223,6 +2258,7 @@ static void audit_log_set_loginuid(kuid_t koldloginuid, kuid_t kloginuid,
 			 oldloginuid, loginuid, tty ? tty_name(tty) : "(none)",
 			 oldsessionid, sessionid, !rc);
 	audit_put_tty(tty);
+	audit_log_task_lsms(ab);
 	audit_log_end(ab);
 }
 
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index f0d243318452..7f8c4b1a2884 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -126,6 +126,7 @@ static void audit_mark_log_rule_change(struct audit_fsnotify_mark *audit_mark, c
 	audit_log_untrustedstring(ab, audit_mark->path);
 	audit_log_key(ab, rule->filterkey);
 	audit_log_format(ab, " list=%d res=1", rule->listnr);
+	audit_log_task_lsms(ab);
 	audit_log_end(ab);
 }
 
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 19cfbe716f9d..bf28bb599b6d 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1103,6 +1103,7 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
 	audit_log_format(ab, " op=%s", action);
 	audit_log_key(ab, rule->filterkey);
 	audit_log_format(ab, " list=%d res=%d", rule->listnr, res);
+	audit_log_task_lsms(ab);
 	audit_log_end(ab);
 }
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 7d66bb7497ef..7c381b1e9993 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -973,7 +973,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsmblob_is_set(blob)) {
-		if (security_secid_to_secctx(blob, &lsmctx)) {
+		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1218,7 +1218,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 			struct lsmblob blob;
 
 			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt)) {
+			if (security_secid_to_secctx(&blob, &lsmcxt,
+						     LSMBLOB_FIRST)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
 			} else {
@@ -1370,7 +1371,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 		struct lsmcontext lsmctx;
 
 		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &lsmctx)) {
+		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
 			audit_log_format(ab, " osid=%u", n->osid);
 			if (call_panic)
 				*call_panic = 2;
@@ -1479,6 +1480,7 @@ static void audit_log_exit(void)
 
 	audit_log_task_info(ab);
 	audit_log_key(ab, context->filterkey);
+	audit_log_task_lsms(ab);
 	audit_log_end(ab);
 
 	for (aux = context->aux; aux; aux = aux->next) {
@@ -2602,6 +2604,7 @@ void audit_core_dumps(long signr)
 		return;
 	audit_log_task(ab);
 	audit_log_format(ab, " sig=%ld res=1", signr);
+	audit_log_task_lsms(ab);
 	audit_log_end(ab);
 }
 
@@ -2628,6 +2631,7 @@ void audit_seccomp(unsigned long syscall, long signr, int code)
 	audit_log_format(ab, " sig=%ld arch=%x syscall=%ld compat=%d ip=0x%lx code=0x%x",
 			 signr, syscall_get_arch(current), syscall,
 			 in_compat_syscall(), KSTK_EIP(current), code);
+	audit_log_task_lsms(ab);
 	audit_log_end(ab);
 }
 
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 27af7a6b8780..10b418029cdd 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -138,7 +138,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 	if (err)
 		return;
 
-	err = security_secid_to_secctx(&lb, &context);
+	err = security_secid_to_secctx(&lb, &context, LSMBLOB_DISPLAY);
 	if (err)
 		return;
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 255bcb886a2f..b2f522b39a1a 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -334,7 +334,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	struct lsmcontext context;
 
 	lsmblob_init(&blob, ct->secmark);
-	ret = security_secid_to_secctx(&blob, &context);
+	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
 	if (ret)
 		return 0;
 
@@ -649,7 +649,7 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 	struct lsmcontext context;
 
 	lsmblob_init(&blob, ct->secmark);
-	ret = security_secid_to_secctx(&blob, &context);
+	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
 	if (ret)
 		return 0;
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 8969754d7fe9..0ff2b8300c28 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -177,7 +177,7 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	struct lsmcontext context;
 
 	lsmblob_init(&blob, ct->secmark);
-	ret = security_secid_to_secctx(&blob, &context);
+	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
 	if (ret)
 		return;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index a1296453d8f2..b6f71be884e8 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -314,7 +314,7 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *context)
 	if (skb->secmark) {
 		/* Any LSM might be looking for the secmark */
 		lsmblob_init(&blob, skb->secmark);
-		security_secid_to_secctx(&blob, context);
+		security_secid_to_secctx(&blob, context, LSMBLOB_DISPLAY);
 	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 3b0f07b59436..60a7665de0e3 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -436,7 +436,8 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(lsmblob, &context) == 0) {
+		if (security_secid_to_secctx(lsmblob, &context,
+					     LSMBLOB_FIRST) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -491,7 +492,8 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 		if (dev != NULL)
 			dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
+		    security_secid_to_secctx(&entry->lsmblob, &context,
+					     LSMBLOB_FIRST) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -551,7 +553,8 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 		if (dev != NULL)
 			dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
+		    security_secid_to_secctx(&entry->lsmblob, &context,
+					     LSMBLOB_FIRST) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -1122,7 +1125,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		lsmb = (struct lsmblob *)&addr6->lsmblob;
 	}
 
-	ret_val = security_secid_to_secctx(lsmb, &context);
+	ret_val = security_secid_to_secctx(lsmb, &context, LSMBLOB_FIRST);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 951ba0639d20..1941877fd16f 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -100,7 +100,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 
 	lsmblob_init(&blob, audit_info->secid);
 	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(&blob, &context) == 0) {
+	    security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST) == 0) {
 		audit_log_format(audit_buf, " subj=%s", context.context);
 		security_release_secctx(&context);
 	}
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index f2d1e573ea55..bd2b36a83e66 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4206,6 +4206,7 @@ void xfrm_audit_policy_add(struct xfrm_policy *xp, int result, bool task_valid)
 	xfrm_audit_helper_usrinfo(task_valid, audit_buf);
 	audit_log_format(audit_buf, " res=%u", result);
 	xfrm_audit_common_policyinfo(xp, audit_buf);
+	audit_log_task_lsms(audit_buf);
 	audit_log_end(audit_buf);
 }
 EXPORT_SYMBOL_GPL(xfrm_audit_policy_add);
@@ -4221,6 +4222,7 @@ void xfrm_audit_policy_delete(struct xfrm_policy *xp, int result,
 	xfrm_audit_helper_usrinfo(task_valid, audit_buf);
 	audit_log_format(audit_buf, " res=%u", result);
 	xfrm_audit_common_policyinfo(xp, audit_buf);
+	audit_log_task_lsms(audit_buf);
 	audit_log_end(audit_buf);
 }
 EXPORT_SYMBOL_GPL(xfrm_audit_policy_delete);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f3423562d933..bfb8402cb28d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2642,6 +2642,7 @@ void xfrm_audit_state_add(struct xfrm_state *x, int result, bool task_valid)
 	xfrm_audit_helper_usrinfo(task_valid, audit_buf);
 	xfrm_audit_helper_sainfo(x, audit_buf);
 	audit_log_format(audit_buf, " res=%u", result);
+	audit_log_task_lsms(audit_buf);
 	audit_log_end(audit_buf);
 }
 EXPORT_SYMBOL_GPL(xfrm_audit_state_add);
@@ -2656,6 +2657,7 @@ void xfrm_audit_state_delete(struct xfrm_state *x, int result, bool task_valid)
 	xfrm_audit_helper_usrinfo(task_valid, audit_buf);
 	xfrm_audit_helper_sainfo(x, audit_buf);
 	audit_log_format(audit_buf, " res=%u", result);
+	audit_log_task_lsms(audit_buf);
 	audit_log_end(audit_buf);
 }
 EXPORT_SYMBOL_GPL(xfrm_audit_state_delete);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 1ab769fa7df6..252dc00700e8 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -363,6 +363,7 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
 	audit_log_format(ab, " hash=\"%s:%s\"", algo_name, hash);
 
 	audit_log_task_info(ab);
+	audit_log_task_lsms(ab);
 	audit_log_end(ab);
 
 	iint->flags |= IMA_AUDITED;
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 5109173839cc..bca89ae72e3d 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -54,5 +54,6 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 		audit_log_format(ab, " ino=%lu", inode->i_ino);
 	}
 	audit_log_format(ab, " res=%d", !result);
+	audit_log_task_lsms(ab);
 	audit_log_end(ab);
 }
diff --git a/security/security.c b/security/security.c
index 1dc3d2f71a63..6d05222aac9c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -449,7 +449,31 @@ static int lsm_append(const char *new, char **result)
  * Pointers to the LSM id structures for local use.
  */
 static int lsm_slot __lsm_ro_after_init;
-static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
+static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
+
+/**
+ * security_lsm_slot_name - Get the name of the security module in a slot
+ * @slot: index into the "display" slot list.
+ *
+ * Provide the name of the security module associated with
+ * a display slot.
+ *
+ * If @slot is LSMBLOB_INVALID return the value
+ * for slot 0 if it has been set, otherwise NULL.
+ *
+ * Returns a pointer to the name string or NULL.
+ */
+const char *security_lsm_slot_name(int slot)
+{
+	if (slot == LSMBLOB_INVALID)
+		slot = 0;
+	else if (slot >= LSMBLOB_ENTRIES || slot < 0)
+		return NULL;
+
+	if (lsm_slotlist[slot] == NULL)
+		return NULL;
+	return lsm_slotlist[slot]->lsm;
+}
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -2159,13 +2183,32 @@ int security_ismaclabel(const char *name)
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
-int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			     int display)
 {
 	struct security_hook_list *hp;
-	int display = lsm_task_display(current);
 
 	memset(cp, 0, sizeof(*cp));
 
+	/*
+	 * display either is the slot number use for formatting
+	 * or an instruction on which relative slot to use.
+	 */
+	if (display == LSMBLOB_DISPLAY)
+		display = lsm_task_display(current);
+	else if (display == LSMBLOB_FIRST)
+		display = LSMBLOB_INVALID;
+	else if (display < 0) {
+		WARN_ONCE(true,
+			"LSM: security_secid_to_secctx unknown display\n");
+		display = LSMBLOB_INVALID;
+	} else if (display >= lsm_slot) {
+		WARN_ONCE(true,
+			"LSM: security_secid_to_secctx invalid display\n");
+		display = LSMBLOB_INVALID;
+	}
+
+
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
@@ -2176,7 +2219,7 @@ int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
 					&cp->context, &cp->len);
 		}
 	}
-	return 0;
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-- 
2.20.1

