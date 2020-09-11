Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE02C433E2
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 16:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7632B221EB
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 16:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HYnzghPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgIKQkU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:40:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33600 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgIKQkP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 12:40:15 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 63EB620716FC;
        Fri, 11 Sep 2020 09:40:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63EB620716FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599842413;
        bh=hqzz6WRWa3nR2dbbRpbP6OFEqZ01hWmyRaOJIi4qc1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=HYnzghPitYXNHwE3/BmPpFenaB47krtlhPjWScR3y/2WLZaokJ7epnKoZA+S9oR7f
         nr/Lrxqa6YkxYu1V+VOJiAxnsZ+NZWoj/vIEvu8MoPdtPSdWDqbrJIeFpUGg3o1p78
         BEBO7uNbA8ko/dPtb0mc8Pc9ryHSIc2byagO+96M=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     stephen.smalley.work@gmail.com, paul@paul-moore.com
Cc:     sashal@kernel.org, jmorris@namei.org, nramas@linux.microsoft.com,
        selinux@vger.kernel.org
Subject: [PATCH v3] selinux: Add helper functions to get and set checkreqprot
Date:   Fri, 11 Sep 2020 09:40:09 -0700
Message-Id: <20200911164009.21926-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

checkreqprot data member in selinux_state struct is accessed directly by
SELinux functions to get and set. This could cause unexpected read or
write access to this data member due to compiler optimizations and/or
compiler's reordering of access to this field.

Add helper functions to get and set checkreqprot data member in
selinux_state struct. These helper functions use READ_ONCE and
WRITE_ONCE macros to ensure atomic read or write of memory for
this data member.

Rename enforcing_enabled() to enforcing_get() to be consistent
with the corresponding set function name.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Suggested-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/avc.c              |  2 +-
 security/selinux/hooks.c            |  8 ++++----
 security/selinux/include/security.h | 14 ++++++++++++--
 security/selinux/selinuxfs.c        | 11 ++++++-----
 security/selinux/ss/services.c      |  6 +++---
 security/selinux/status.c           |  2 +-
 6 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 3c05827608b6..9d0cd7054b08 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1020,7 +1020,7 @@ static noinline int avc_denied(struct selinux_state *state,
 	if (flags & AVC_STRICT)
 		return -EACCES;
 
-	if (enforcing_enabled(state) &&
+	if (enforcing_get(state) &&
 	    !(avd->flags & AVD_FLAGS_PERMISSIVE))
 		return -EACCES;
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6210e98219a5..2bbfbb722e95 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3718,7 +3718,7 @@ static int selinux_mmap_file(struct file *file, unsigned long reqprot,
 			return rc;
 	}
 
-	if (selinux_state.checkreqprot)
+	if (checkreqprot_get(&selinux_state))
 		prot = reqprot;
 
 	return file_map_prot_check(file, prot,
@@ -3732,7 +3732,7 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 	const struct cred *cred = current_cred();
 	u32 sid = cred_sid(cred);
 
-	if (selinux_state.checkreqprot)
+	if (checkreqprot_get(&selinux_state))
 		prot = reqprot;
 
 	if (default_noexec &&
@@ -5882,7 +5882,7 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 				sk->sk_protocol, nlh->nlmsg_type,
 				secclass_map[sclass - 1].name,
 				task_pid_nr(current), current->comm);
-			if (enforcing_enabled(&selinux_state) &&
+			if (enforcing_get(&selinux_state) &&
 			    !security_get_allow_unknown(&selinux_state))
 				return rc;
 			rc = 0;
@@ -7234,7 +7234,7 @@ static __init int selinux_init(void)
 
 	memset(&selinux_state, 0, sizeof(selinux_state));
 	enforcing_set(&selinux_state, selinux_enforcing_boot);
-	selinux_state.checkreqprot = selinux_checkreqprot_boot;
+	checkreqprot_set(&selinux_state, selinux_checkreqprot_boot);
 	selinux_avc_init(&selinux_state.avc);
 	mutex_init(&selinux_state.status_lock);
 	mutex_init(&selinux_state.policy_mutex);
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 0ce2ef684ed0..845079045e62 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -123,7 +123,7 @@ static inline void selinux_mark_initialized(struct selinux_state *state)
 }
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
-static inline bool enforcing_enabled(struct selinux_state *state)
+static inline bool enforcing_get(struct selinux_state *state)
 {
 	return READ_ONCE(state->enforcing);
 }
@@ -133,7 +133,7 @@ static inline void enforcing_set(struct selinux_state *state, bool value)
 	WRITE_ONCE(state->enforcing, value);
 }
 #else
-static inline bool enforcing_enabled(struct selinux_state *state)
+static inline bool enforcing_get(struct selinux_state *state)
 {
 	return true;
 }
@@ -143,6 +143,16 @@ static inline void enforcing_set(struct selinux_state *state, bool value)
 }
 #endif
 
+static inline bool checkreqprot_get(const struct selinux_state *state)
+{
+	return READ_ONCE(state->checkreqprot);
+}
+
+static inline void checkreqprot_set(struct selinux_state *state, bool value)
+{
+	WRITE_ONCE(state->checkreqprot, value);
+}
+
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static inline bool selinux_disabled(struct selinux_state *state)
 {
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 45e9efa9bf5b..ad1bc4f57313 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -129,7 +129,7 @@ static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
 	ssize_t length;
 
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
-			   enforcing_enabled(fsi->state));
+			   enforcing_get(fsi->state));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
@@ -161,7 +161,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 
 	new_value = !!new_value;
 
-	old_value = enforcing_enabled(state);
+	old_value = enforcing_get(state);
 	if (new_value != old_value) {
 		length = avc_has_perm(&selinux_state,
 				      current_sid(), SECINITSID_SECURITY,
@@ -307,7 +307,7 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 		goto out;
 
 	if (new_value) {
-		enforcing = enforcing_enabled(fsi->state);
+		enforcing = enforcing_get(fsi->state);
 		length = selinux_disable(fsi->state);
 		if (length)
 			goto out;
@@ -717,7 +717,8 @@ static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
-	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", fsi->state->checkreqprot);
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
+			   checkreqprot_get(fsi->state));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
@@ -759,7 +760,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 			     comm, current->pid);
 	}
 
-	fsi->state->checkreqprot = new_value ? 1 : 0;
+	checkreqprot_set(fsi->state, (new_value ? 1 : 0));
 	length = count;
 out:
 	kfree(page);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 9704c8a32303..62792e026096 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -737,7 +737,7 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
 	kfree(n);
 	kfree(t);
 
-	if (!enforcing_enabled(state))
+	if (!enforcing_get(state))
 		return 0;
 	return -EPERM;
 }
@@ -1657,7 +1657,7 @@ static int compute_sid_handle_invalid_context(
 	kfree(s);
 	kfree(t);
 	kfree(n);
-	if (!enforcing_enabled(state))
+	if (!enforcing_get(state))
 		return 0;
 	return -EACCES;
 }
@@ -1964,7 +1964,7 @@ static inline int convert_context_handle_invalid_context(
 	char *s;
 	u32 len;
 
-	if (enforcing_enabled(state))
+	if (enforcing_get(state))
 		return -EINVAL;
 
 	if (!context_struct_to_string(policydb, context, &s, &len)) {
diff --git a/security/selinux/status.c b/security/selinux/status.c
index 4bc8f809934c..88990d381374 100644
--- a/security/selinux/status.c
+++ b/security/selinux/status.c
@@ -53,7 +53,7 @@ struct page *selinux_kernel_status_page(struct selinux_state *state)
 
 			status->version = SELINUX_KERNEL_STATUS_VERSION;
 			status->sequence = 0;
-			status->enforcing = enforcing_enabled(state);
+			status->enforcing = enforcing_get(state);
 			/*
 			 * NOTE: the next policyload event shall set
 			 * a positive value on the status->policyload,
-- 
2.28.0

