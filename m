Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8D2EA74D;
	Fri, 20 Jun 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441543; cv=none; b=E4vkkF38Qy2QlX4vI5bXvbNNffTiFVhDCA16wg4gRA8LmIKF/41LTfh4KNazGvfeXqvWwiNoRIl22YwOkf7j7lRfbVPPMHCqNtZAzELGxwNWpE98CmncHtDpGiqWWJFzMC7TLsFl+DXs64ozWRmsug1NcNDHw/ab1yyG7IVl0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441543; c=relaxed/simple;
	bh=GznpIjv7wsQtyxOk8sxR0tr8Qx685igry9lWaXpUvE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go8vq9smjhLF3vtlv2vmi5XRvmz2OiTGV5fruUF7C+Q7BSYjTCShDUDbin7Vekq1Ea2P+UJtpeioMP0aCpKTBQKnq48VKRls1UwREZvDcJuXgZLdo4v+7i/9rRCT2kHvYkO69gDWvT/8afzbv373f1g7MyrNG+eEE9mHMyRcgyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTmXIipd; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTmXIipd"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fafb6899c2so22694016d6.0;
        Fri, 20 Jun 2025 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441541; x=1751046341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/kebG9gB0NVNaH7yErjC8Oq3Qy2Za1AxJ6MCns5FvY=;
        b=kTmXIipdTvxwxykIZka3/jFCVcJ7G1+xfL7kcWjt/3ieZeZboCyTJibX6j6l8dqvKS
         d7Lz41/smw5C1Wni9Eu/sQOwZDhzwXGSibLlCFDMHI1SG7CgbhH1xLxBuo5ts82KLkN8
         yNnjTj+VrGMSmhKUo3zjF1n5CaJZo0qy3rBz1tv7DGJXuvqO1qxx5Zf5V/dumFgAF1ht
         fVwo2qUcbOHuPMw9d2w0h4iNKr1r+/VO7nr3HwSmyNIfIZvkmfUI8CXogN8XjG0G0Oi6
         a7vJmsgbjjENt/N/hTCJD/g3DyLJA3oiVPE1GXQRZKY8AE8yN3AjpZCFH6Nmbufv2288
         gQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441541; x=1751046341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/kebG9gB0NVNaH7yErjC8Oq3Qy2Za1AxJ6MCns5FvY=;
        b=RPiZJAZCXYA4sC2quYpU0RSg0qrJuRAoLJbWOmAdb2oGrhItWrzY65qMG79odhMkj5
         z5JoaBSatdgE9QhlX8BqkSMDfOJytm55NAg9OfgCcYCq+rH1IJ9V+67P5NtMlPSeVcpd
         OPvjAkkyE8gTD1jg/ntzuxUERfqfYt0lXRUWujBlUyAy1Yxz0XcFio0Y7NssoZJ4I6Dk
         Wr/MT42LNTdi08eZc3fAIKPB0Ehg51Re3kGyVpy/y0txkq1vfWjiW/ruPR/0qtIJMWdZ
         77alyy38kl2hjbY1y9B27ni21NcSUAM2jTFndSTMIWJro/wksswyS+TpQcEHhLOx+2bt
         gzfA==
X-Forwarded-Encrypted: i=1; AJvYcCUNBijnzgQeOsdWdpUodvZ7Nwqfgr0aX2A+Zhh/3r5cw4KokUqKVeK6ZT4PJRrWiTiyv9la3EM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Q+DglixraavJ24JEvhypVUmWGWzT+C3A+o8IdMbthkbqklh+
	jb9i3J36xRuawmcZOdxzne0L+GUuefUPUknHJWzr9RUTG91Jcx5hgZvcqCgJdQ==
X-Gm-Gg: ASbGncvJ5/UitfJuuxleC7uW2yoNhhBDBN/5rPs3ib2ztTcYOr0zhtK3L7DVomnVOMj
	43VT3FZiF+VUyvtpRSvqdo9q0Q8Trg8gZwAHfgXvzWgpTlHW8QWHufm7PKd3D23CbSEqalVjQzX
	td5mrwZCF3WQHIxj07Wi5h4V22V9HR8gjCgUj+5W8XwFXN5nFHy+foQnt8tkd/xzeSH7b0uXunl
	jFdv5GEHwbsQQu2FyAVMMwX4eQDI4q1XoK3h044pjHxwL33sQt+jBNvhdxscz8U+KFk+HvMz9Qx
	7OrrKQyOOWgLHuOeV8bkv0uGwuMXnCqJFGZfXM43wJ2nvHC3IrbIBviTvqnJBy31YRlPqdc2wiE
	q0Is/4pp/lXn+HLul9K0NhjjgJuRPzy1Z0w08xLQp7NozgVMEhnsRlzbZXVmvy6DSdQ==
X-Google-Smtp-Source: AGHT+IEFlMwy40K1b/wBG2PxtWjJrUPqz4L+gYpRMOtYSrb4+fEYjt5Goz1L98iCccvL2qjQerNoTw==
X-Received: by 2002:a05:6214:d6f:b0:6fa:fdf5:a604 with SMTP id 6a1803df08f44-6fd0c9496a5mr51477506d6.12.1750441540837;
        Fri, 20 Jun 2025 10:45:40 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 26/42] selinux: introduce cred_ssid_has_perm() and cred_other_has_perm()
Date: Fri, 20 Jun 2025 13:44:38 -0400
Message-ID: <20250620174502.1838-27-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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
index 1d1a6fdafa7d..9385dcd84eee 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1417,6 +1417,68 @@ int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
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
index cab185c149aa..9e4683bf34da 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -469,9 +469,8 @@ static int may_context_mount_inode_relabel(u32 sid,
 	if (rc)
 		return rc;
 
-	return avc_has_perm(cred_selinux_state(cred),
-			    sid, sbsec->sid, SECCLASS_FILESYSTEM,
-			    FILESYSTEM__ASSOCIATE, NULL);
+	return cred_ssid_has_perm(cred, sid, sbsec->sid, SECCLASS_FILESYSTEM,
+				  FILESYSTEM__ASSOCIATE, NULL);
 }
 
 static int selinux_is_genfs_special_handling(struct super_block *sb)
@@ -1858,10 +1857,9 @@ static int may_create(struct inode *dir,
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
@@ -2050,9 +2048,8 @@ static inline u32 open_file_to_av(struct file *file)
 
 static int selinux_binder_set_context_mgr(const struct cred *mgr)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), cred_sid(mgr), SECCLASS_BINDER,
-			    BINDER__SET_CONTEXT_MGR, NULL);
+	return cred_other_has_perm(current_cred(), mgr, SECCLASS_BINDER,
+				   BINDER__SET_CONTEXT_MGR, NULL);
 }
 
 static int selinux_binder_transaction(const struct cred *from,
@@ -2060,28 +2057,25 @@ static int selinux_binder_transaction(const struct cred *from,
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
@@ -2149,9 +2143,8 @@ static int selinux_capset(struct cred *new, const struct cred *old,
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
@@ -3424,12 +3417,9 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
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
@@ -4440,9 +4430,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(cred_selinux_state(cred),
-			    cred_sid(cred), cred_sid(tcred),
-			    SECCLASS_PROCESS, av, NULL);
+	return cred_other_has_perm(cred, tcred, SECCLASS_PROCESS, av, NULL);
 }
 
 static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
@@ -6374,9 +6362,8 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
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
@@ -7331,8 +7318,8 @@ static int selinux_perf_event_write(struct perf_event *event)
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
index 95178feac52c..3198ed11aa80 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -170,6 +170,13 @@ int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass, u32 requested,
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
2.49.0

