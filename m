Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B224C077;
	Tue, 10 Jun 2025 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576205; cv=none; b=pCp1d+OtPkbb9nnPfz31PX3XJsMNvEozud/awib+WKgE/TXHsCH5iLE5piVMge6ZS86CwNtWaVghO6O78py320BHaRRbfCJQwLa1v7d4NIl1q6+xIwceuD+Zu4JE+WcZxKtPofTpTMAUyFBEMzpw0PA6Odi6DFDCHAayHfGaYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576205; c=relaxed/simple;
	bh=ECuWKFBYO0gBmWbmxs4eVAfk6VotSZewDoh5f+QYd4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJDq2FvoT2c9/xp9swmQkvvee0vFiuDMOt3vDLMrq2dKDn4zNrp9sOEmLen61ufGra2Lh5Xr8/yAp1KXk8Xdj8z0RR49fCsOzP90kS2Oj/uw9p3fwPZwnLq+H+iVVjgC6nS2TPvgUl4RLOgdc6IRsqoVlpVossQgPBsfwsgvIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDWDfp4k; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDWDfp4k"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d38d1eae03so245018385a.2;
        Tue, 10 Jun 2025 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576202; x=1750181002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnQlrqjRhKAuVgKDJpf2a3GY6lLdVC9Mjbni+CHohT4=;
        b=YDWDfp4kp01q93oUSfjDU7vOycZ2aFXy4efNl6MBhfWzX4i9FjYqs4ykgFqBH/UpcX
         VdtI2ks9PvNkJPieyeWLxLdL6dg+e6EKCQ7AOoKi+PUq26+yWjIRNZpovdHOPdITNxbr
         4vFxoIsmdLMFcboxzW7tVL6ayiaaxGYcHtgaUlNUDmZgZmWu/0PYE3zYDse777lRuG/M
         3x3yIjkhedJf8mFpe8MZLlsLlVboRZTNpVjWGsP5a/tp+lGRD++VYQFaKOk+RU+TRqEZ
         2HFRYdW2Lf+5OFxdaW2oRzDVf6qmKAA+xAo4kQxQwc1wzJo/0juCdAN452onU3r9g0Me
         6GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576202; x=1750181002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnQlrqjRhKAuVgKDJpf2a3GY6lLdVC9Mjbni+CHohT4=;
        b=YKlbpG5bcgDCcCi8QYHhNFAqZhtl74PVrLd9y/RdlIh7zNPaTq17HbNo2y1ySDSRWy
         jC3FolPbzL4v5xqAdHVKUwNF2jbmgAqRPPgjhsvCLwRBmpGe9C+pORmqPa7gF29gu9WK
         xgbjw7RWOltFIAPOKe0pohD7UCZRqV8wPkwS8zU2ECux5fOR/BGo/2pUNvHOAXUqVQU6
         Wy0sn+xkPvW4DrR5iIyHfeNpjWWTzu86exC3mgNBc8oHXM1sqLFHUyXYqvQVqsSnbORi
         4w31/cwfv670F3GCAiJdvWGsgqVHlZvtk3ZJLjBR0mDRiYvAkPAVaFH9ZNZTF6SaLGle
         BmZw==
X-Forwarded-Encrypted: i=1; AJvYcCUbtU6Q2/ZDpFBgfbcvnn09N37GezgVdG2hZr0pDkPl3bDDnvaAGXsbtwEuh6OIaCNCcXDc3kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDkZGaAUzotNmTPjEUQJvuqG8VscQntPwd1cP0j3QgMfJ4VreK
	yATE5RxmAKGXEAPcAOzdAiYyJFzON/fJ+g+oVQEV61zMXhj+yrrHDg2h4Dnk4w==
X-Gm-Gg: ASbGnct9MyHgaS1iZXd7eMvNSD7CFbH/Apj0AiasHuHkj8Sv5LSIOo+7lWvHT0L8Mam
	fjyM+cfAbDaSX8rkC/UvnrXqYiBcI6UG9uh/maIm2RMFm4vH2QS8aI9gEhejGHHa90HzT+8K96n
	vy/jT29oZwrcB+bCg8rjjvwwg10SE6K63m4jrOGUbh93Wh8ZAc5XNI7pEOmY++YT3kqrIhdsFbU
	6Z8BZtDrD1mcZCjadouT2MtojBegNz0spudWCx8n+gCqfGWwWpoi5o+7B6MjmFj84MGKp/QQgZH
	qKERU5p4+hSix6wnWbs2lLK2jf+Qlv39UFDUCypDLspbKCKTGg/mykn3Z+NJU6QOFcw3CcOXO/p
	W6t8v37mLajGgCQGnNOdxpSLequZJtavbjV+vwYl3s8kDnqf9onuZop+sYfcYeU84+g==
X-Google-Smtp-Source: AGHT+IE5Dkolx5A2r5IuSoVFjeKkoih99wvH3TFjUuauDyVsnxnvD/SZ8dyOx48QCHkUItPdAxjSCw==
X-Received: by 2002:a05:620a:2995:b0:7d3:9288:5c1a with SMTP id af79cd13be357-7d3a894b73bmr28704185a.46.1749576202373;
        Tue, 10 Jun 2025 10:23:22 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:22 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 26/42] selinux: introduce cred_ssid_has_perm() and cred_other_has_perm()
Date: Tue, 10 Jun 2025 13:21:57 -0400
Message-ID: <20250610172226.1470741-27-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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
index c0a04774fd27..4c2f7491803b 100644
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
@@ -3412,12 +3405,9 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
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
@@ -4428,9 +4418,7 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(cred_selinux_state(cred),
-			    cred_sid(cred), cred_sid(tcred),
-			    SECCLASS_PROCESS, av, NULL);
+	return cred_other_has_perm(cred, tcred, SECCLASS_PROCESS, av, NULL);
 }
 
 static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
@@ -6362,9 +6350,8 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
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
@@ -7319,8 +7306,8 @@ static int selinux_perf_event_write(struct perf_event *event)
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

