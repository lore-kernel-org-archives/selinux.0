Return-Path: <SRS0=R+7g=WL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E08C3A59C
	for <selinux@archiver.kernel.org>; Thu, 15 Aug 2019 17:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC092063F
	for <selinux@archiver.kernel.org>; Thu, 15 Aug 2019 17:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="lyrQHJHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfHORlc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:41:32 -0400
Received: from UHIL19PA35.eemsg.mail.mil ([214.24.21.194]:21629 "EHLO
        UHIL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfHORlc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Aug 2019 13:41:32 -0400
X-EEMSG-check-017: 13654325|UHIL19PA35_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,389,1559520000"; 
   d="scan'208";a="13654325"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Aug 2019 17:41:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1565890888; x=1597426888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6sFrC1IrvTeInvzzw6Njv3hSPqI7O96uD+5Z5QRocIo=;
  b=lyrQHJHfMxRAeX9Q1FDsSRH5HUKFqY2dHLzRxO4YK9PjWbITyrHzUsQH
   drdUz/VIDXGj0fQc3BVS9stNO1jx6nKeDCFi6ZI9CC8c4Zz2fVlZDA8RV
   Xy6OyqmccG8vrUNhab7UpVcCdB0fDbspoefOSsgBeRUYMSK1AiLhIorrW
   /dUMevzuinyYbYyd1kX60nZixRrArapbfaLJDiqb4bPlmCbf6Tv2gCYgT
   31ZWMGLjy1ywrccGEejcIhdW+22CDrkaiVChzkZ/Ink/9ZSwxtcNUxX22
   MNeR9szVGE99Dfe9DBu5h8TXcnGtlApegPj/7XzCuXf1Xlr9oSc/x/GkP
   A==;
X-IronPort-AV: E=Sophos;i="5.64,389,1559520000"; 
   d="scan'208";a="26845171"
IronPort-PHdr: =?us-ascii?q?9a23=3A9qRiJR2Iie2dMuq+smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesUKP/xwZ3uMQTl6Ol3ixeRBMOHsqgC0rGP+Pm5AiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagf79+Ngi6oAvMusUZnIduN6g8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaOTE56mXXgdFugqxdrhyquhhzz5fUbYyRMfZzeL7Wc9EHSm?=
 =?us-ascii?q?pbRstfVzJPDJ6yYYUMCOQOMulWopLhq1YNtxayGROhCP/zxjJOm3T43bc60+?=
 =?us-ascii?q?MkEQzewAEvBcgOsHPSrN7oNakSVuG1w7TWwjXHcvhb3i3y55THchAmoPGDQK?=
 =?us-ascii?q?x/fNHNyUgvCwzFjlKQpZbjPzOOzOsBqWeb7+1+Ve+2jWMstgJ/oiC3y8sxhY?=
 =?us-ascii?q?TEiZgZx1DZ+Slj3oo4KsO0RFRmbdOiDZBerTuVN5FsTcMnW2xovSE6xaAYtp?=
 =?us-ascii?q?OjZygKzYgnxwbYa/yab4iE+hLjW/iVITd/nH9lZKiwhwyz8Ui90e3wTNW00V?=
 =?us-ascii?q?ZWoSpFldnArHYN2ADI6sebUPd9+0ah2TKX2wDS7OFLP1w0mLLGJ5MuzbM8jJ?=
 =?us-ascii?q?oevVnZEiPol0j6krWaelg89uit8evnY7HmppGGN49zjwHzKr4hldCwAeQ/Mw?=
 =?us-ascii?q?gBQnaU9P+g1Lzj4UL5QLJKgucwkqnCqp/WP8sbpqmnAwNNyIYs9w6/Dyu60N?=
 =?us-ascii?q?QfhXQHN0xKeBaGj4jvJlHPL+v1Demwg1uyijdn3fPGMaP7ApXLMHfDlK3tfb?=
 =?us-ascii?q?Fn605T0AAz18xQ54pICrEdJ/L+QkvxtN3eDh8kPA242v3nB8th2YMDQ2KPA7?=
 =?us-ascii?q?OZMaPLvV+N4eIgPvSMZIsLtzvmNfgl6ODhjWUjlV8eY6apx50XZ268Hvh8JE?=
 =?us-ascii?q?WZe3XsiM8bEWgWpgo+UPDqiFqaXD5XZnayWb885z4iBI28EIfMW4GtgKCa0S?=
 =?us-ascii?q?ehAJJZe2BGBUqQEXvya4qEXPIMYjqIIsB9ijwESaShS4g52BG0uw/10KFqLv?=
 =?us-ascii?q?DK9SIFtZLszsR16/fPmhE18Dx+F96d3H2VT2FogmMIQCc707xlrkxm1FiC0b?=
 =?us-ascii?q?N1g+dEGtxT/fxJTwk6NZrCwOxgEtz9RhjOcs2VR1ahR9WsGSsxQc4pw98Sf0?=
 =?us-ascii?q?Z9HM2vjhPd0CW0GL8ai7uLBJs38q/Hw3fxJ9x9y3HD1KkgklkmR9FDNWq8hq?=
 =?us-ascii?q?5w7wLTHZLGk12Fl6a2cqQRxDXN+3mZzWqBok5VSw5wXr/BXXAbZkrWq8716V?=
 =?us-ascii?q?/FT7+rEb4nKBdOydaeKqtWbd3klVdGRPLkONTEeWKxmnywCA2OxryWaYrlZW?=
 =?us-ascii?q?Qd0D/aCEgenAAZ5WyGOhQmBie9v2LeCyRjFUr1bEPx9elzs2u7QVUpzwGOdk?=
 =?us-ascii?q?Fh0r21+hkPhfOCUf8cwrUEuCJy4wlzSU60wtb+E9Odo09ke6JGbJU251IU+3?=
 =?us-ascii?q?jesllUN4anKehNgV8SfgA/60rl2BJ2BohojdkhrHRsyhF7b62fzgUSJHujwZ?=
 =?us-ascii?q?nsN+iPeSHJ9xe1ZvuThwDT?=
X-IPAS-Result: =?us-ascii?q?A2CaAgDYl1Vd/wHyM5BlHgEGBwaBVQcLAYFtKoE+ATIqk?=
 =?us-ascii?q?3gBAQEBAQEGgjSIbI8ngXsJAQEBAQEBAQEBGxkBAgEBhD+DFiM2Bw4CBAEBA?=
 =?us-ascii?q?QQBAQEDAQYDAQFshTOCOimDFQsBRoFRgmM/gXcUqyUziHSBSYE0hxBmg3MXe?=
 =?us-ascii?q?IEHgRGCXXOKJwSrTQmCH5QnDBuYPQGiA4VXCCmBWCsIAhgIIQ+DJ4JOF44+I?=
 =?us-ascii?q?wMwgQYBAYtRJYIrAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Aug 2019 17:41:26 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7FHfMZg005699;
        Thu, 15 Aug 2019 13:41:22 -0400
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     jmorris@namei.org, serge@hallyn.com, sds@tycho.nsa.gov,
        keescook@chromium.org, casey@schaufler-ca.com, rgb@redhat.com,
        linux-audit@redhat.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Aaron Goidel <acgoide@tycho.nsa.gov>
Subject: [RFC PATCH] audit, security: allow LSMs to selectively enable audit collection
Date:   Thu, 15 Aug 2019 13:41:11 -0400
Message-Id: <20190815174111.6309-1-acgoide@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Presently, there is no way for LSMs to enable collection of supplemental
audit records such as path and inode information when a permission denial
occurs. Provide a LSM hook to allow LSMs to selectively enable collection
on a per-task basis, even if the audit configuration would otherwise
disable auditing of a task and/or contains no audit filter rules. If the
hook returns a non-zero result, collect all available audit information. If
the hook generates its own audit record, then supplemental audit
information will be emitted at syscall exit.

In SELinux, we implement this hook by returning the result of a permission
check on the process. If the new process2:audit_enable permission is
allowed by the policy, then audit collection will be enabled for that
process. Otherwise, SELinux will defer to the audit configuration.

Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
---
 include/linux/lsm_hooks.h           |  7 +++++++
 include/linux/security.h            |  7 ++++++-
 kernel/auditsc.c                    | 10 +++++++---
 security/security.c                 |  5 +++++
 security/selinux/hooks.c            | 11 +++++++++++
 security/selinux/include/classmap.h |  2 +-
 6 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ead98af9c602..7d70a6759621 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1380,6 +1380,11 @@
  *	audit_rule_init.
  *	@lsmrule contains the allocated rule
  *
+ * @audit_enable:
+ *	Allow the security module to selectively enable audit collection
+ *	on permission denials based on whether or not @tsk has the
+ *	process2:audit_enable permission.
+ *
  * @inode_invalidate_secctx:
  *	Notify the security module that it must revalidate the security context
  *	of an inode.
@@ -1800,6 +1805,7 @@ union security_list_options {
 	int (*audit_rule_known)(struct audit_krule *krule);
 	int (*audit_rule_match)(u32 secid, u32 field, u32 op, void *lsmrule);
 	void (*audit_rule_free)(void *lsmrule);
+	int (*audit_enable)(struct task_struct *tsk);
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_BPF_SYSCALL
@@ -2043,6 +2049,7 @@ struct security_hook_heads {
 	struct hlist_head audit_rule_known;
 	struct hlist_head audit_rule_match;
 	struct hlist_head audit_rule_free;
+	struct hlist_head audit_enable;
 #endif /* CONFIG_AUDIT */
 #ifdef CONFIG_BPF_SYSCALL
 	struct hlist_head bpf;
diff --git a/include/linux/security.h b/include/linux/security.h
index 7d9c1da1f659..7be66db8de4e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1719,7 +1719,7 @@ int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
-
+int security_audit_enable(struct task_struct *tsk);
 #else
 
 static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
@@ -1742,6 +1742,11 @@ static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
 static inline void security_audit_rule_free(void *lsmrule)
 { }
 
+static inline int security_audit_enable(struct task_struct *tsk)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_AUDIT */
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 95ae27edd417..7e052b71bc42 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -906,8 +906,12 @@ int audit_alloc(struct task_struct *tsk)
 
 	state = audit_filter_task(tsk, &key);
 	if (state == AUDIT_DISABLED) {
-		clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
-		return 0;
+		if (security_audit_enable(tsk)) {
+			state = AUDIT_BUILD_CONTEXT;
+		} else {
+			clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+			return 0;
+		}
 	}
 
 	if (!(context = audit_alloc_context(state))) {
@@ -1623,7 +1627,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	if (state == AUDIT_DISABLED)
 		return;
 
-	context->dummy = !audit_n_rules;
+	context->dummy = !audit_n_rules && !security_audit_enable(current);
 	if (!context->dummy && state == AUDIT_BUILD_CONTEXT) {
 		context->prio = 0;
 		if (auditd_test_task(current))
diff --git a/security/security.c b/security/security.c
index 30687e1366b7..04e160e5d4ab 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2333,6 +2333,11 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 {
 	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
 }
+
+int security_audit_enable(struct task_struct *tsk)
+{
+	return call_int_hook(audit_enable, 0, tsk);
+}
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_BPF_SYSCALL
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d55571c585ff..88764aa0ab43 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6628,6 +6628,16 @@ static void selinux_ib_free_security(void *ib_sec)
 }
 #endif
 
+#ifdef CONFIG_AUDIT
+static int selinux_audit_enable(struct task_struct *tsk)
+{
+	u32 sid = current_sid();
+
+	return !avc_has_perm(&selinux_state, sid, sid, SECCLASS_PROCESS2,
+			PROCESS2__AUDIT_ENABLE, NULL);
+}
+#endif
+
 #ifdef CONFIG_BPF_SYSCALL
 static int selinux_bpf(int cmd, union bpf_attr *attr,
 				     unsigned int size)
@@ -6999,6 +7009,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(audit_rule_known, selinux_audit_rule_known),
 	LSM_HOOK_INIT(audit_rule_match, selinux_audit_rule_match),
 	LSM_HOOK_INIT(audit_rule_free, selinux_audit_rule_free),
+	LSM_HOOK_INIT(audit_enable, selinux_audit_enable),
 #endif
 
 #ifdef CONFIG_BPF_SYSCALL
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 32e9b03be3dd..d7d856cbd486 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -52,7 +52,7 @@ struct security_class_mapping secclass_map[] = {
 	    "execmem", "execstack", "execheap", "setkeycreate",
 	    "setsockcreate", "getrlimit", NULL } },
 	{ "process2",
-	  { "nnp_transition", "nosuid_transition", NULL } },
+	  { "nnp_transition", "nosuid_transition", "audit_enable", NULL } },
 	{ "system",
 	  { "ipc_info", "syslog_read", "syslog_mod",
 	    "syslog_console", "module_request", "module_load", NULL } },
-- 
2.21.0

