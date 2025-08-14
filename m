Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106930100C;
	Thu, 14 Aug 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178052; cv=none; b=nlzPatJShjNp/R5FcHyqSUsUUqfQCTsqDaWdyP+aHcXQi/8GuQx3oD1NIQAOkPrMh0qIN2Q1EVWn0SWW/FMLe8hT5SOifW+tfCvPLjT6FjA7Xa6WRFIRixn6c2kOWDmnXycf3DJWLl+5Yz/srrSV1+rTlbAN701C3DpWtjP/toU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178052; c=relaxed/simple;
	bh=f8Ee/OGpWajuPZu0QIfQwrMsIqKfWpRTv9/WJvgvy3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BX25YSr7S1Xrj8csCBdquyzYT0o3LhzskaMd6nol+ijAqDJ/QMFG+GUl7aUTOyiHB33Ufb+f6uqEGCshLvWjPdH0cRWmSMADMdGCR5rrlldyrDeVv6AWH+pujmLobXU6hEgeuGVMc/CLXBEA8lEQ6Bwjjtu+jAD12djMjXEhlRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR2zthvi; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR2zthvi"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109ac4223so8349471cf.1;
        Thu, 14 Aug 2025 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178049; x=1755782849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tm/LdadVTtRF5c1P8zrRa7/OFBjel4Z4JD95QkQ9ObI=;
        b=IR2zthviwnC7SNlN7JAJeJYAS6E30hcIyJlfu6ghcyUPkZLo7QOyHBsCvr5OaiRacZ
         Hz52soesg5WPPb3ItvKfCnVEKovZvuGYzXRkDWsZXP8v6qC4glWyp6gZzsnapuV8rYcj
         B6M554bTKLa6Q8TxMS6PRNB5Ro8YEcy+neO8M7dR3IBjZmuXFf1itiUJ/y1ls/Lo8+O7
         hAhOXlxzNYfrc58BN/i8917OhBHigEfeDpGNYLnJ+qC7zwnYJlxm5elSdm6kBn9Jm0eV
         qKrUTrTCaD4LQDc6Jso8PfVyc0C5CRAwTYwRciwaSWK2TATCSqW4u1VxtaFrl1NvNhCB
         GhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178049; x=1755782849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm/LdadVTtRF5c1P8zrRa7/OFBjel4Z4JD95QkQ9ObI=;
        b=HXNgHEuFb+pCurE4vtQa39D6e5SOS3QrYYGHy+qlv9RUf7iYWvHzMo+Ch6QmZ4VIuY
         shQE3HId+DV7zN4mZXywUlIGHWkFcjLXjkj/2b6vNXjkH/wBjLBBfkQsDH/jruvpbi49
         mqQVN2IbRaIBgbVjpVp3w/Flmfnj+LcAkG8ygeLdy2Jqyz6gmdB8DKkiEQULDUCJFUEi
         rODMPPbQ+1vaEZ5mL8IJwiSl8isXd5g54MzdHDNPzYpSDE2XyiY2kHb/oxgaE2VAlKtw
         Nux8BUoabTZKlDasPAB+TWTlnSH5KlYdugVRhsRvLUZgJK+97jzHw/UtGEfz9mCTPIlX
         IgWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAANPmmiSKEiBpplCBHj6Zf2/JeiaqNfolN6kop4zUYDiolRI91kOc2m3hweS5UHbGE3x0KUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4UOgMnlexPYpetWAqF4FqPf6n38IRhmm8wBMv4aLAjurjDn23
	KAqCXMRKPAgBWK4h/ANoSaiGw0izYtQjFZVVe4PtkynJiq1Lo+OrAEq6NQ+hFg==
X-Gm-Gg: ASbGnctqW9LVsgvrg3srhC85MzKNeKvX7zakqoN9rYDkgxW6/FvSzOXE/KmG3mO7jQv
	s2lzYZnJcEQ3ZZavjUETgkF7sRoCoTlzEd/ZgjJQtKcqjMW/Cpo2wfIG2q1Ys/t5Qrdqf1CplMa
	G8Z4YWH2sgI6lRd1/Iz44VINFqkjMtksOZkk1CJ8jl9CFEWETYUzSyrsvV6FHG6Seeu/rQDGtK3
	Y6soAiG3BnoF2rKBOCT8CLhhis8xdROW+xjdUpJE5ecLaLbB/shLmZfJD+RUUOxZlR+tlA+7iyp
	/8qzeTKILJZG+iDeYgpDuIJ0NB5q6S/Z/4WuQr1V3ZOjdJnBGFtqgUXT0UaEEp7AmyzIeNYGyiz
	bh7PxVq0PGwwnQyeFB1l1ZTZDd91N2gC/EfoIpjXNlNCM/7bS6WgbqLiLZO8xgXIXJ6cr/krZX8
	ws0qxAbJXZwNw1vdoD2kF+mVOcDg==
X-Google-Smtp-Source: AGHT+IHv7tYSrTHJbaC6FuvWxo8EGoLOD2us6ovie82a6zopUbp5D4sRUaYCZ538K4byeBs+fSTkxw==
X-Received: by 2002:ac8:5cd1:0:b0:4b0:da5c:ceea with SMTP id d75a77b69052e-4b10aa79928mr51855211cf.3.1755178049178;
        Thu, 14 Aug 2025 06:27:29 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 26/42] selinux: introduce cred_ssid_has_perm() and cred_other_has_perm()
Date: Thu, 14 Aug 2025 09:26:17 -0400
Message-ID: <20250814132637.1659-27-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index 5a17c24a8466..f529d7f90c80 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1416,6 +1416,68 @@ int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
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
index d759c48a8557..8dea622f9361 100644
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
@@ -4452,9 +4442,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(cred_selinux_state(cred),
-			    cred_sid(cred), cred_sid(tcred),
-			    SECCLASS_PROCESS, av, NULL);
+	return cred_other_has_perm(cred, tcred, SECCLASS_PROCESS, av, NULL);
 }
 
 static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
@@ -6386,9 +6374,8 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
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
@@ -7343,8 +7330,8 @@ static int selinux_perf_event_write(struct perf_event *event)
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
2.50.1

