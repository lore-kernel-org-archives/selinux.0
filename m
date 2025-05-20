Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792F280019;
	Tue, 20 May 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742505; cv=none; b=aMn2PhnxEr1oIJeSbdq3G8uFuccoJ6fN1hLkRsWkv+5h6nxDrlgjBleS8a3lCrAZoq0Sg1PwWMRJnfHlKaLO6Lw97AGuDlDYSfRSrwqQpbJ/HrPnGwSx78Qp9YC+T2f+pSUMkWYTywLsdj1EfUtYdVcj9x5qx53JunLAMFCZqrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742505; c=relaxed/simple;
	bh=4cWwNwYX509FXWtw57tbtI5ppx7c5l2/AQOQbHmLN2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+j6xT45CE1ZWj3d4vyAd0+86K9VUEL2CrcTXGlhLhhEY0rXXidWDzecOtkQL79c5CM2lpLE07FPQrrqan+Fl7yOm3RzSSZobVgNXkujNzNjZJC20AicrhDFywjPbOE4QcYoCrv4wDNX+9YbXJ3x1ubTddcM+czPBUFKDPMwrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKEFzmrI; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKEFzmrI"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6060200710bso3097492eaf.3;
        Tue, 20 May 2025 05:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742502; x=1748347302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3E2BZbwVLRyBjMY4aF4EXSVftTL+KAQDO29tYCugh+k=;
        b=CKEFzmrI4Bpv19xPgNeIjq3B5fWIaGhscSQhxGh83JiqEqKfxrr0/W77YBU6nIFn7L
         CRtF13pqbhWJ1g6YJYXTD34cqbvjxMPuhLdSJDs5v8b76ysH2kx+dRPm0Lordn+3e2AN
         GxwLerPMPRQP5KOpCeOKhMeDnYEVlrl/L3sHO8/aEceqyH1u+EedgmZSJ8HRvtGC4qFM
         Wg7jAaOLaDkSDacAR6Mb//1sWUTker8r8fM6rUDNkDM31NHhSsNyimqAq2P0t228a9Gj
         rWQwl8jdhFWv65jbRQWLdGu0RADe29/8/PowD+NJWs/Yg842DJ9v763ojO3Rknls+VSr
         XrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742502; x=1748347302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3E2BZbwVLRyBjMY4aF4EXSVftTL+KAQDO29tYCugh+k=;
        b=dEqM+0FqsiC2Jb2w1UJ1g1UYboIf3TC5XQRU6TLS86kLqGlNVy8pU0KMrBIe7WlZtM
         6wH6jp8/c0zeiOGg8J84nay+x0YyRPA00DeUCG95X0FW4ufjLGD5jHFgDG+yi0rZJwZ5
         sWRtaVVOPJFHQqAccd/oqY5rKqjO4OILR0zasxc5eeoCnvMBqMaBNssoo4rYx1FDFqlm
         Vj7RBLcEVY5h6PDnrdaMlZFMOMMytNdqCKsMmWcDHHx59Yt7pd3WLJJKh/KFumoE277Z
         eJ0Bdw2ohdGzgAVz2fn6hkEbJAFY6WAW23Ug1RlPymBwfYvComukOcGER1LvkslOMGWQ
         X4ag==
X-Forwarded-Encrypted: i=1; AJvYcCVwIdZDDIHWRxq9iMEcozwXM6DELbUq/HYyDgFaJu3r+jkNpNJsacg+k//QQThnCbaz0ye2p0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+6C5bsaMFp3BeG1MtQRt1R6eU/itQfJUxOYIPhj+E90zDWG7
	t3HYiXHWfOOq29ZNNKd+ZgBsv5l/7yy4edYqUvXQbkbeIeYi/Ba/+oxcqsHQ5g==
X-Gm-Gg: ASbGncsdOczRr/bEp5zZ40uclKSPpoPLNkzqkLxi5o6YZfqxU8HeRYxQQKgvwW2+u7A
	VMhVwhtNxDIr4vpQ7hSN199wF4VXxYz/0GWPuEZWcOG/O+aNJQt+1LsgIEK8dR2GOujLY17JE9X
	rM2roZ66cQqWmoqIklJnJryyFCKJ6FUbeVmql62OstrCoz7ETdi7Ouzo5NjyXdwBkTSOLa28yn1
	p4xfUfjczAqWVKezc0Dlx+HgkfqJ4kwTDHLlXR525O0/QMOPS8QxT1x3HwIt1H96rb7i4tg+kUv
	TdiJrLBAa/DqFrcUzqcEvSMF3QZmvWfKthzcCi2FOGxusud+9e8fjdW6bJsZMOwmHsCyAsWnwrX
	YtOZGvha5yoVabEjrUZmZcnwxYrLkctXAu4+/y+4eEueBTPGQR9PF7Q==
X-Google-Smtp-Source: AGHT+IHI7bdH0BELlDGmxWMGPsFSV4YikFc+FHFb8NJ99xbGkkZCeZW0ugA8c0pPuyXmj+6DUSt1yQ==
X-Received: by 2002:a05:6870:b314:b0:2c1:7289:d62a with SMTP id 586e51a60fabf-2e3c1f62599mr9979508fac.36.1747742491814;
        Tue, 20 May 2025 05:01:31 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 25/42] selinux: introduce cred_ssid_has_perm() and cred_other_has_perm()
Date: Tue, 20 May 2025 07:59:23 -0400
Message-ID: <20250520120000.25501-27-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index 600a5f1e2b2d..dc0f95c3547e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -470,9 +470,8 @@ static int may_context_mount_inode_relabel(u32 sid,
 	if (rc)
 		return rc;
 
-	return avc_has_perm(cred_selinux_state(cred),
-			    sid, sbsec->sid, SECCLASS_FILESYSTEM,
-			    FILESYSTEM__ASSOCIATE, NULL);
+	return cred_ssid_has_perm(cred, sid, sbsec->sid, SECCLASS_FILESYSTEM,
+				  FILESYSTEM__ASSOCIATE, NULL);
 }
 
 static int selinux_is_genfs_special_handling(struct super_block *sb)
@@ -1852,10 +1851,9 @@ static int may_create(struct inode *dir,
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
@@ -2044,9 +2042,8 @@ static inline u32 open_file_to_av(struct file *file)
 
 static int selinux_binder_set_context_mgr(const struct cred *mgr)
 {
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), cred_sid(mgr), SECCLASS_BINDER,
-			    BINDER__SET_CONTEXT_MGR, NULL);
+	return cred_other_has_perm(current_cred(), mgr, SECCLASS_BINDER,
+				   BINDER__SET_CONTEXT_MGR, NULL);
 }
 
 static int selinux_binder_transaction(const struct cred *from,
@@ -2054,28 +2051,25 @@ static int selinux_binder_transaction(const struct cred *from,
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
@@ -2143,9 +2137,8 @@ static int selinux_capset(struct cred *new, const struct cred *old,
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
@@ -3406,12 +3399,9 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
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
@@ -4422,9 +4412,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(cred_selinux_state(cred),
-			    cred_sid(cred), cred_sid(tcred),
-			    SECCLASS_PROCESS, av, NULL);
+	return cred_other_has_perm(cred, tcred, SECCLASS_PROCESS, av, NULL);
 }
 
 static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
@@ -6392,9 +6380,8 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
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
@@ -7349,8 +7336,8 @@ static int selinux_perf_event_write(struct perf_event *event)
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
index 106c511db114..1631f6cdbefd 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -166,6 +166,13 @@ int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass, u32 requested,
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

