Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD1B1547E8
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836350; cv=none; b=avT7ekLoLn9xXpbR/cYxsfggeriUhdcDmgt85i+V+W+zYPXPQFy8D2EJGR5uQuIhbBgqPMxfMlKNAFsgfeVunoXpMzbUJevaKrI8/SnldcOoaH3FICZRSstgVvfpTvzMyMNKx9DqwCkI0MBe8qVEv+rGA0i2CYZ/ZFIpIb99KOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836350; c=relaxed/simple;
	bh=9+MPeFTotEObXZYYezhBENmtY3zuLnrf4bV/zxX7umo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OHzpD5WvZTXq62DIbVMsLPZ37BzlkP4738un5A65fYUX9d4BhkA4mjdwCmpmLqj1L89qY+QEd0csMCdlWtZvMdcgDBGEzrbhj3FX9Tw60iOTzkhvC3v4T/y9oXLwGjURlsV6LVVvA2knY2rBdBiBbua0s9+/MoWhlWvUvCgalEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cU32ppMo; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU32ppMo"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6e9db19c8so853149685a.3
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836346; x=1736441146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrtXLv0R25qnhdj/3TGD1NzpKanoO+elzjn/Sd6sYlU=;
        b=cU32ppMos0ownAyaOWC15ZalL/oBDq+ThXfGsf7g8ZSos/stkmYYvJsDItTxdyigmj
         pzqp+kq9Ygp/KP/nfuYwMWM/LOeocovv2u2Dvk1ZLunbVw1DWrD7awHFLgnMEL6s5MLD
         J6x3j9Ekb3SLzLW0i63JgGfA/3u5t1J5X6fxpISvobQ1xFr4uYVypqcNdJeb4bJMiJf/
         R1PNOhnSJO/+6nY/1oiioZ7mE12wVrrWj6EIEGdGb5ecGdSS6cxNpBZfqol3z3iBK0RY
         0TlbEorcmENmXECCr/X/3oZwLjBw6sG6TGNldnrPXpQkmSU75FNOX32fbD+GkcnfOEX4
         77rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836346; x=1736441146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrtXLv0R25qnhdj/3TGD1NzpKanoO+elzjn/Sd6sYlU=;
        b=G0RC26Fu0qRNANXT7mjEbyVwXWJeb0eE9RsbD0+ktOWsJbpnc5fnYvmLgc1J9i6pQD
         j/J5Ii/nYR6D7RHL0O0IE+8UsqPMft+GKC+Ndfr5VgCziZMofo+5WYdYtdU9ENRfaUfi
         o0gXze3w1E+PVqpn2SAzeucoPErFEDrayxav0jMzhnY3AynfOVdk7EUuABqBflWbjso+
         v2mo1M9gDNiBTFQs2t6RiVi1FUGiOsZdSogQ/VfxGfABeccn9n09OOUgE/sTebpED7yu
         POLCZwQkz0Fla+qWQb7BL4+o/wP59CdsfOhNwQiq/F4RP0BpgSB4WFXuWInHGVt9VnYC
         o9xQ==
X-Gm-Message-State: AOJu0YwoxUw9OJqtbYEmFvVJ/qo2eROM06FQrJXWkW99RtKdDTStLLQr
	cwMAwsPwN7deDTcZzhKtQ5azbrXv7VqRfgzbVz2rlSMkmg6az4MLp0YdZw==
X-Gm-Gg: ASbGnctMZiEUBqYYfIAeydEtBJtaV4/xJRWJgNd28OpfBEA3DYHG/j7XPAJD3TRjvJ+
	/1OyMftMOioyLT5vbFOdRMRJmSr1ep0zoYdZpst9YChJeiozIefOzkNMids9+IRt9mRp2MCo3eo
	qm2ssf/FdB+gvXt5qIp/8XbM0h7jSSeMrEMbZjMVmQvWWC3t5mw1gLLPr+xrcfge9huWrq8u9Fa
	2iBPneTiKKLh+xcSSHjwmPjFEiSKHU0uH5ScfjpkpvqPEGAzCbDpT0eGV+hrepg7HTwh3VjVmY2
	6o4pYK4b/Ogi3kbNyMupZDn/DH5T33QdlOpSmA07y9rmEAAbouYbjwhKCpipK+FQYQxErQ==
X-Google-Smtp-Source: AGHT+IFVSuOd6/yd/4VnoneZHdxUpDJqciw8kuRxeDLQG1QqrpvB7iz+NwxkjMISspcPr2l36tkkWA==
X-Received: by 2002:a05:620a:4623:b0:7b6:daf1:7f13 with SMTP id af79cd13be357-7b9ba716936mr7182484785a.9.1735836345989;
        Thu, 02 Jan 2025 08:45:45 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:45 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 17/44] selinux: introduce cred_ssid_has_perm() and cred_other_has_perm()
Date: Thu,  2 Jan 2025 11:44:42 -0500
Message-Id: <20250102164509.25606-18-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce cred_ssid_has_perm() for checking permissions between
a fixed (source SID, target SID) pair against the current SELinux
namespace and all ancestors. This helper is appropriate for
checks between two object SIDs, but should NOT be used
when dealing with task/cred objects.

Introduce cred_other_has_perm() for checking permissions between
two creds against the current SELinux namespace and all
ancestors.

Convert permission checks of these two forms in the hook functions
to use these new namespace-aware helpers.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 62 ++++++++++++++++++++++++++++++++++
 security/selinux/hooks.c       | 61 +++++++++++++--------------------
 security/selinux/include/avc.h |  7 ++++
 3 files changed, 93 insertions(+), 37 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 19641d5daba8..acf62dad064f 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1402,6 +1402,68 @@ int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 	return 0;
 }
 
+int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
+		       u32 requested, struct common_audit_data *ad)
+{
+	struct task_security_struct *tsec;
+	struct selinux_state *state;
+	int rc;
+
+	do {
+		tsec = selinux_cred(cred);
+		state = tsec->state;
+		rc = avc_has_perm(state, ssid, tsid, tclass, requested, ad);
+		if (rc)
+			return rc;
+
+		cred = tsec->parent_cred;
+	} while (cred);
+
+	return 0;
+}
+
+static u32 cred_sid_for_state(const struct cred *cred,
+			      const struct selinux_state *state)
+{
+	const struct task_security_struct *tsec;
+	u32 sid;
+
+	tsec = selinux_cred(cred);
+	while (tsec->state != state && tsec->parent_cred)
+		tsec = selinux_cred(tsec->parent_cred);
+	if (tsec->state == state)
+		sid = tsec->sid;
+	else
+		sid = SECINITSID_UNLABELED;
+	return sid;
+}
+
+int cred_other_has_perm(const struct cred *cred, const struct cred *other,
+			u16 tclass, u32 requested,
+			struct common_audit_data *ad)
+{
+	struct task_security_struct *tsec;
+	struct selinux_state *state;
+	u32 ssid;
+	u32 tsid;
+	int rc;
+
+	do {
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
+		tsid = cred_sid_for_state(other, state);
+
+		rc = avc_has_perm(state, ssid, tsid, tclass, requested, ad);
+		if (rc)
+			return rc;
+
+		cred = tsec->parent_cred;
+	} while (cred);
+
+	return 0;
+}
+
 u32 avc_policy_seqno(struct selinux_state *state)
 {
 	return state->avc->avc_cache.latest_notif;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b38d0f78f33d..028e94c6e396 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -475,9 +475,8 @@ static int may_context_mount_inode_relabel(u32 sid,
 	if (rc)
 		return rc;
 
-	return avc_has_perm(cred_selinux_state(cred),
-			    sid, sbsec->sid, SECCLASS_FILESYSTEM,
-			    FILESYSTEM__ASSOCIATE, NULL);
+	return cred_ssid_has_perm(cred, sid, sbsec->sid, SECCLASS_FILESYSTEM,
+				  FILESYSTEM__ASSOCIATE, NULL);
 }
 
 static int selinux_is_genfs_special_handling(struct super_block *sb)
@@ -1848,10 +1847,9 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	return avc_has_perm(current_selinux_state,
-			    newsid, sbsec->sid,
-			    SECCLASS_FILESYSTEM,
-			    FILESYSTEM__ASSOCIATE, &ad);
+	return cred_ssid_has_perm(cred, newsid, sbsec->sid,
+				  SECCLASS_FILESYSTEM, FILESYSTEM__ASSOCIATE,
+				  &ad);
 }
 
 #define MAY_LINK	0
@@ -2040,9 +2038,8 @@ static inline u32 open_file_to_av(struct file *file)
 
 static int selinux_binder_set_context_mgr(const struct cred *mgr)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), cred_sid(mgr), SECCLASS_BINDER,
-			    BINDER__SET_CONTEXT_MGR, NULL);
+	return cred_other_has_perm(current_cred(), mgr, SECCLASS_BINDER,
+				   BINDER__SET_CONTEXT_MGR, NULL);
 }
 
 static int selinux_binder_transaction(const struct cred *from,
@@ -2050,28 +2047,25 @@ static int selinux_binder_transaction(const struct cred *from,
 {
 	u32 mysid = current_sid();
 	u32 fromsid = cred_sid(from);
-	u32 tosid = cred_sid(to);
 	int rc;
 
 	if (mysid != fromsid) {
-		rc = avc_has_perm(cred_selinux_state(from),
-				  mysid, fromsid, SECCLASS_BINDER,
-				  BINDER__IMPERSONATE, NULL);
+		rc = cred_other_has_perm(current_cred(), from,
+					 SECCLASS_BINDER,
+					 BINDER__IMPERSONATE, NULL);
 		if (rc)
 			return rc;
 	}
 
-	return avc_has_perm(cred_selinux_state(from), fromsid, tosid,
-			    SECCLASS_BINDER, BINDER__CALL, NULL);
+	return cred_other_has_perm(from, to, SECCLASS_BINDER, BINDER__CALL,
+				   NULL);
 }
 
 static int selinux_binder_transfer_binder(const struct cred *from,
 					  const struct cred *to)
 {
-	return avc_has_perm(current_selinux_state,
-			    cred_sid(from), cred_sid(to),
-			    SECCLASS_BINDER, BINDER__TRANSFER,
-			    NULL);
+	return cred_other_has_perm(from, to, SECCLASS_BINDER,
+				   BINDER__TRANSFER, NULL);
 }
 
 static int selinux_binder_transfer_file(const struct cred *from,
@@ -2139,9 +2133,8 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 			  const kernel_cap_t *inheritable,
 			  const kernel_cap_t *permitted)
 {
-	return avc_has_perm(cred_selinux_state(old),
-			    cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
-			    PROCESS__SETCAP, NULL);
+	return cred_other_has_perm(old, new, SECCLASS_PROCESS,
+				   PROCESS__SETCAP, NULL);
 }
 
 /*
@@ -3297,12 +3290,9 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	if (rc)
 		return rc;
 
-	return avc_has_perm(current_selinux_state,
-			    newsid,
-			    sbsec->sid,
-			    SECCLASS_FILESYSTEM,
-			    FILESYSTEM__ASSOCIATE,
-			    &ad);
+	return cred_ssid_has_perm(cred, newsid, sbsec->sid,
+				  SECCLASS_FILESYSTEM,
+				  FILESYSTEM__ASSOCIATE, &ad);
 }
 
 static int selinux_inode_set_acl(struct mnt_idmap *idmap,
@@ -4265,9 +4255,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(cred_selinux_state(cred),
-			    cred_sid(cred), cred_sid(tcred),
-			    SECCLASS_PROCESS, av, NULL);
+	return cred_other_has_perm(cred, tcred, SECCLASS_PROCESS, av, NULL);
 }
 
 static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
@@ -6226,9 +6214,8 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
 				   &ad);
 	if (!rc)
 		/* Can the message be put in the queue? */
-		rc = avc_has_perm(current_selinux_state,
-				  msec->sid, isec->sid, SECCLASS_MSGQ,
-				  MSGQ__ENQUEUE, &ad);
+		rc = cred_ssid_has_perm(cred, msec->sid, isec->sid,
+					SECCLASS_MSGQ, MSGQ__ENQUEUE, &ad);
 
 	return rc;
 }
@@ -7163,8 +7150,8 @@ static int selinux_perf_event_write(struct perf_event *event)
  */
 static int selinux_uring_override_creds(const struct cred *new)
 {
-	return avc_has_perm(current_selinux_state, current_sid(), cred_sid(new),
-			    SECCLASS_IO_URING, IO_URING__OVERRIDE_CREDS, NULL);
+	return cred_other_has_perm(current_cred(), new, SECCLASS_IO_URING,
+				   IO_URING__OVERRIDE_CREDS, NULL);
 }
 
 /**
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 31fbf844f9d4..ec40b856da91 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -164,6 +164,13 @@ int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass, u32 requested,
 int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 			  u32 requested, struct av_decision *avd);
 
+int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
+		       u32 requested, struct common_audit_data *ad);
+
+int cred_other_has_perm(const struct cred *cred, const struct cred *other,
+			u16 tclass, u32 requested,
+			struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.47.1

