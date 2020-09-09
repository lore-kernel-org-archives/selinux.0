Return-Path: <SRS0=iCYl=CS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FA8C43461
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 18:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE0421941
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 18:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iz93G6N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIISX5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:23:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48182 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIISX4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 14:23:56 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1C84B20942B5;
        Wed,  9 Sep 2020 11:23:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C84B20942B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599675835;
        bh=ri1KVpspb9Sp0M6AdXZmdcYHMA1BrIV3XuR3iRcZk/A=;
        h=From:To:Cc:Subject:Date:From;
        b=iz93G6N7Cht6RhlMbAx8bjLpTkUF7ivOXrIXvskkwGT0ICb7jB1J6hJqat3TynEuq
         XeHLImCn+lxowvYT2tMCRa0i9m15XvEscXdsFqXNHMFznwhCGpRyHkkgu6tSTGZUvD
         6gKc+vvEmsA3xhRJpUBUPzYhGKSdPxxMS6bOPVtI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     stephen.smalley.work@gmail.com, paul@paul-moore.com
Cc:     sashal@kernel.org, jmorris@namei.org, nramas@linux.microsoft.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH] selinux: Add helper functions to get and set checkreqprot
Date:   Wed,  9 Sep 2020 11:23:51 -0700
Message-Id: <20200909182351.10740-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

checkreqprot data member in selinux_state struct is accessed directly by
SELinux functions to get and set. This could cause unexpected read or
write access to this data member due to compiler optimizations and\or
compiler's reordering of access to this field.

Add helper functions to get and set checkreqprot data member in
selinux_state struct. These helper functions use READ_ONCE and
WRITE_ONCE macros to ensure explicit read or write of memory for
this data member.

This patch is based on commit 66ccd2560aff 
("selinux: simplify away security_policydb_len()") in "next" branch
in https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            |  6 +++---
 security/selinux/include/security.h | 10 ++++++++++
 security/selinux/selinuxfs.c        |  5 +++--
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6210e98219a5..520c7b78bcd8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3718,7 +3718,7 @@ static int selinux_mmap_file(struct file *file, unsigned long reqprot,
 			return rc;
 	}
 
-	if (selinux_state.checkreqprot)
+	if (selinux_checkreqprot(&selinux_state))
 		prot = reqprot;
 
 	return file_map_prot_check(file, prot,
@@ -3732,7 +3732,7 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 	const struct cred *cred = current_cred();
 	u32 sid = cred_sid(cred);
 
-	if (selinux_state.checkreqprot)
+	if (selinux_checkreqprot(&selinux_state))
 		prot = reqprot;
 
 	if (default_noexec &&
@@ -7234,7 +7234,7 @@ static __init int selinux_init(void)
 
 	memset(&selinux_state, 0, sizeof(selinux_state));
 	enforcing_set(&selinux_state, selinux_enforcing_boot);
-	selinux_state.checkreqprot = selinux_checkreqprot_boot;
+	selinux_checkreqprot_set(&selinux_state, selinux_checkreqprot_boot);
 	selinux_avc_init(&selinux_state.avc);
 	mutex_init(&selinux_state.status_lock);
 	mutex_init(&selinux_state.policy_mutex);
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index cbdd3c7aff8b..b19d919f01e7 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -209,6 +209,16 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 	return state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS];
 }
 
+static inline bool selinux_checkreqprot(const struct selinux_state *state)
+{
+	return READ_ONCE(state->checkreqprot);
+}
+static inline void selinux_checkreqprot_set(struct selinux_state *state,
+					    bool value)
+{
+	WRITE_ONCE(state->checkreqprot, value);
+}
+
 int security_mls_enabled(struct selinux_state *state);
 int security_load_policy(struct selinux_state *state,
 			void *data, size_t len,
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 45e9efa9bf5b..ba636d3ea89d 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -717,7 +717,8 @@ static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
-	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", fsi->state->checkreqprot);
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
+			   selinux_checkreqprot(fsi->state));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
@@ -759,7 +760,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 			     comm, current->pid);
 	}
 
-	fsi->state->checkreqprot = new_value ? 1 : 0;
+	selinux_checkreqprot_set(fsi->state, (new_value ? 1 : 0));
 	length = count;
 out:
 	kfree(page);
-- 
2.28.0

