Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A52E2675;
	Tue, 17 Jun 2025 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169201; cv=none; b=ojAzouzpLFcTFy3OI+cf/p1Ba+e76ErJthaNHMntIrQJX+bo91viY1mJ+vXbz9uJD76LfV3HZHJqpyA8hOwc86W5VmnFMQu/NKNwCXaQoDmKe70rFyxsmR+urnibmXeGp5T5iQP/QAn8H/Yrj5Z/rvNn9PKiiQYKGv6AL4BKsmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169201; c=relaxed/simple;
	bh=nuFBuO+Sl0eFXEdDbtfJLdNSfchbo+YrqTNdfuJK0Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPtT+nmSrSPaxYoIVe+wRwTBn8rSbbRI9VgHbMhPHl1hmb5TAytfbxGDbP7Zvt4+/mUf6gvTZbuZQHWMzCeu7zrR87ki6A9i2q/TfIacGnK5/eAXBjKaP5ia0CxyY8W/iUqSxJNNB+L6tyg+/dyJBdYPJtI5PyM3bla5HgpBwRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moRko3PM; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moRko3PM"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d09a032914so505724285a.3;
        Tue, 17 Jun 2025 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169198; x=1750773998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kk+cC8ET0q6gsRBpQxXTp7Rs2UpGrGUkd7ZHiRDjs4=;
        b=moRko3PMDnXACC9i7ngfmdI95lnRDF0fKVNAg9yggdDXZe5hec1xkh9rrjZygpOEF6
         BbpQVEJ6n1kP8OzD65bapW/VnAJNz7EkgC+uFnfp6zSOJOhYX/EqE5xdFnY2VGFegJWO
         6YM4coqceTwdrW58iNII9DLoS9JB0LdwEIXrRCgzMQYWXjfPoX80Vep4OLRG6X5TQ7uG
         NVKikKo7o0F5LOyjQPUyWpOEFo5yFcZzfCk3U6lfEctwoj93etB2R/XhTnQGPUIVCS1r
         6/ZR88yfNO5TJX1uCZSlnhrNTCBz/Uq5eQo49OM8CPt3c3lRWtd004ke8upRQ7yFx52m
         66sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169198; x=1750773998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kk+cC8ET0q6gsRBpQxXTp7Rs2UpGrGUkd7ZHiRDjs4=;
        b=vKkHnQEpGf4gx1Hb5p4rAZwg5ymcRVO6Is6lI1/pKZN4lZowE+LqJJVx43b4/Y0siB
         1LYiakyL/4ZjiQZUsn5jOFgW+oEpL/PPsFDIUzZKH+0h6xQc4mS1mfCMuNIUwYanMJk9
         4Z+Tty0fC1DKKan5n1LqZr2YX/U+n527wYPYZP+tVu9F7Zu6dQMKUu/Xd5nWFZbmcPYf
         WiVCtHB9dbf2/82N7T+EYbwq1H/JmVB67qVl6Lu9CTSJQUuLI48Auu3f/LtdsFqIILmK
         weaay2Zia2j5GgGPtVHKYG/n24wI23cWwJuVksBfobwUWPjH6/wKs3UnklHCgnCcLtUQ
         dRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6ebWGzim7wWPiJ+IfePeCOwLuj1gnZ4L/xsNRw4DMw1tD1Vh/EBOdIHp27J7wGVAbWLvxJqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5sgqnV0+7PjkTn0mKH6MZg+pApIAoS8N+6xK0e5tRzAzYsdQz
	oKlaship2ID5vZCV+ddeBIMHozEmMGbQnRWMvPJLtEYgIGcHa1QE9Se5BApZqA==
X-Gm-Gg: ASbGncsfbTAitO25VXYhtL4Zj7XC4cd/klXnXiKB4JWxR3xLwwTm8n3kzTP4hTy5uZS
	3KYo82BXn6X8YCKkNCwrMl6HKU3RtI1yxm4h+9FGrdIMl0fsqt/1OxgBmPKLf6MAW3yE7+e/XkY
	/LSdlUS8HhfqlPxKDbiySusdmh1Bj/zptctlokpBzbTafhIDFgctZibOHbmCV1iFWf1EIMqomvK
	hlsPWrX26OD7jVNlh8QkQqN4S7w5MOTYVYDPuYVI5bBuODaoI98Lj/VkVTWmwn7berPNyRUfmk2
	ZppOdOznGOw2joigMs1PEwH4b0LMgrPoQJUzJX6g+3HSEEjZsA5t33zRMoVAsdt+p08qrpNK2rg
	BDjkl4yl9b4R4fPHEw8mBlx+3ijOSPW/O2QUlmmO5HeVS3MCsrGn76C7hemGfk6fyxA==
X-Google-Smtp-Source: AGHT+IEDMccnjB/Mbm5bgcutuGz6YIz22F5u6HqegxiEmi5Y25mKMraYYLt+9XeR6Q2AdxymNsqCTA==
X-Received: by 2002:a05:620a:1a1e:b0:7d3:a6e3:769 with SMTP id af79cd13be357-7d3c6cfefe2mr2369824785a.54.1750169196803;
        Tue, 17 Jun 2025 07:06:36 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 26/42] selinux: introduce cred_ssid_has_perm() and cred_other_has_perm()
Date: Tue, 17 Jun 2025 10:05:13 -0400
Message-ID: <20250617140531.2036-27-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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
index 553dfc9d69ae..426c8efd612c 100644
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

