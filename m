Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED315575D
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836363; cv=none; b=iOxNvJl+yM+wVogsjCR0LmuVoaGfjQGrlkyIpcDmr/3nXQeRYXTqMf+92lWWO5uczHg7irnNb7V/lF4YuoOj2dgClonFEJBpk9YhlPVhHfZEb7WT2AWiv1/cafkHOhNaC5fj0VwT/ehHrhLfg/4zxiAwoLQX6h6pSMnBxhrM72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836363; c=relaxed/simple;
	bh=06KcZWQYrh91+bR0JzH5PuxSxa1e7uqw2+5FixvLwe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uamVnMu/PnW70O/dgpUkNTBI4xaguygW9U+gpzIsK5MeUM1lF0rslOja6Y+19TOTfDxvjk1ZrFLTnWJ7+fIix9jZB11iOAlNTZRQpZjSbhPDHqktiOLYSdqJAAkTszNA1ld19c3f7lBwwRP+SdsYHuDMdJZ1zjuhjos40SXxDfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yrh7aVuv; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrh7aVuv"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46792996074so112827221cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836358; x=1736441158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdawipmAM+1BxbnzS0FSenj1HYBbHP7fiM226zN9Mh0=;
        b=Yrh7aVuvbcqLBjixWrZCjvr/apfqq8G7m7X6aqFE9jm5pz3peaKp2zDwC7gq5xfO/7
         ThqJ4JDr9Et8//hZf/XuIykek+AQATaVgeikRmh9rfSizJ8F/8A6E3+AgU81/qIuJATd
         er2RlSXPkzdyn1hSzl93RAIP0B2xAJ1dd5zS3nkLuV3kUm7mhUuqpeLMI0ATNlguOcWq
         b5ifvMFu9/Xzp2d976llCfnwmf4oJLNNK0Hk9x0ahtuo4P90zTv7tCarktorcohHoEsX
         ofBBpzu8twTl7faezkNKjFuh2kBOhjHOpmqpNjyxAWhoTw2rEsKh4vJ+LGDWg4nCYCvJ
         U8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836358; x=1736441158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdawipmAM+1BxbnzS0FSenj1HYBbHP7fiM226zN9Mh0=;
        b=X/9kxf7vTr0jedLuTgmB75hg8vvOH2zgAbg33I10UPAV426y5Wi1jl/b24cdpMfu+P
         XTDVPnXyowuMVdGxe5mcqEcgSa/l4Hky9YxzvLUr8mwUljCYQxjcugAb5SfC3qzNYtcP
         kQwChdVrj9SJ9yxTS4R4ZwGHnzYrjIO+1nZyExQW06t2CjFRy36GJezuiiSopLpy0bc9
         DkSwp1ISOgDLVtjhT9G1gf5pUvVd/CXmhJrAs1FjwDGOKEijuv9cdnr6eUaX3fYOTYa2
         +hkN0NlSmBbR5Rw8FQuGlg5FKe7BjQzXh4EopzLMxY7sJVkRp1Aomkj/Gx+pNDo8QXCt
         7tsw==
X-Gm-Message-State: AOJu0Yzszk01ea89/D/9dnENLclAdUJxJQFlJypYI5rXMaIq826JdCFd
	sAk4C/lztQqNHYK4h/ZEZ2tu1kf87rsFZ5ikwrJ8HJfo0fDnzg5tlIw9Cw==
X-Gm-Gg: ASbGncvNNxIn4naINhbyNnI59Rx0SGqCQBoj1oZkoEdcJIlN65VUZkGUK5MGI4CIbrV
	9TTCVreeLc5bzhYWWGpbYNOjLS57YjLIQaGnAt3gqPifJ8KqU64GSF8BCf2WAHrYbH3EH7/vfO+
	wafAIcvsIdhjWYtU+77Lo7U/L6xBr/P4bKjo4mt+9bDSA1Epq/NMlqD+naM814rN+2Sl+cMH2Fw
	+o84pN56HFJIBVJJl+Iyf2sO7XwKNMerE3M9TfAuIPNwuaH7Zq7AEQHDmSrMMo6Pve7ZJOpcfaa
	4eK+vEQY8fHjTBNbCrtf7d5dN4lqI96eAexQhvN+eYBJvF5xW7wMwZykUa83CgHWReqZFg==
X-Google-Smtp-Source: AGHT+IGhglLdz2oxtb8aKOFBU6YiVr18tZwdrKfn14jHkEl7Oq8Ye2etPQEm9Kl5SnxTTAFLKob/fQ==
X-Received: by 2002:a05:622a:1a29:b0:467:5da6:8096 with SMTP id d75a77b69052e-46a4a977800mr833245641cf.44.1735836358458;
        Thu, 02 Jan 2025 08:45:58 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:58 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 34/44] selinux: make open_perms namespace-aware
Date: Thu,  2 Jan 2025 11:44:59 -0500
Message-Id: <20250102164509.25606-35-stephen.smalley.work@gmail.com>
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

Adjust the handling of the open_perms policy capability to
be namespace-aware. This ensures that file open permission
is checked against each namespace in accordance with the
namespace policy. Otherwise, a child SELinux namespace
could escape checking of file open permission in the
parent namespace by disabling it in its own policy.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 111 +++++++++++++++++++++-------
 security/selinux/include/security.h |   5 +-
 2 files changed, 85 insertions(+), 31 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5ede1bf55f9a..80590b99399a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2004,22 +2004,6 @@ static inline u32 file_to_av(const struct file *file)
 	return av;
 }
 
-/*
- * Convert a file to an access vector and include the correct
- * open permission.
- */
-static inline u32 open_file_to_av(struct file *file)
-{
-	u32 av = file_to_av(file);
-	struct inode *inode = file_inode(file);
-
-	if (selinux_policycap_openperm() &&
-	    inode->i_sb->s_magic != SOCKFS_MAGIC)
-		av |= FILE__OPEN;
-
-	return av;
-}
-
 /* Hook functions begin here. */
 
 static int selinux_binder_set_context_mgr(const struct cred *mgr)
@@ -3198,7 +3182,13 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const struct cred *cred = current_cred();
 	struct inode *inode = d_backing_inode(dentry);
 	unsigned int ia_valid = iattr->ia_valid;
-	__u32 av = FILE__WRITE;
+	struct inode_security_struct *isec;
+	struct task_security_struct *tsec;
+	struct selinux_state *state;
+	struct common_audit_data ad;
+	u32 ssid, tsid, av, requested;
+	u16 sclass;
+	int rc;
 
 	/* ATTR_FORCE is just used for ATTR_KILL_S[UG]ID. */
 	if (ia_valid & ATTR_FORCE) {
@@ -3212,13 +3202,41 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
 		return dentry_has_perm(cred, dentry, FILE__SETATTR);
 
-	if (selinux_policycap_openperm() &&
-	    inode->i_sb->s_magic != SOCKFS_MAGIC &&
-	    (ia_valid & ATTR_SIZE) &&
-	    !(ia_valid & ATTR_FILE))
-		av |= FILE__OPEN;
+	/*
+	 * The following is an inlined version of dentry_has_perm()->
+	 * inode_has_perm()->cred_tsid_has_perm() in order to specialize
+	 * the requested permissions based on the open_perms policycap
+	 * value in each namespace.
+	 */
+	ad.type = LSM_AUDIT_DATA_DENTRY;
+	ad.u.dentry = dentry;
+	__inode_security_revalidate(inode, dentry, true);
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+	isec = selinux_inode(inode);
+	tsid = isec->sid;
+	sclass = isec->sclass;
+	av = FILE__WRITE;
+
+	do {
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
+		requested = av;
+
+		if (selinux_policycap_openperm(state) &&
+			inode->i_sb->s_magic != SOCKFS_MAGIC &&
+			(ia_valid & ATTR_SIZE) &&
+			!(ia_valid & ATTR_FILE))
+			requested |= FILE__OPEN;
+
+		rc = avc_has_perm(state, ssid, tsid, sclass, requested, &ad);
+		if (rc)
+			return rc;
+		cred = tsec->parent_cred;
+	} while (cred);
 
-	return dentry_has_perm(cred, dentry, av);
+	return 0;
 }
 
 static int selinux_inode_getattr(const struct path *path)
@@ -4038,11 +4056,17 @@ static int selinux_file_receive(struct file *file)
 
 static int selinux_file_open(struct file *file)
 {
-	struct file_security_struct *fsec;
-	struct inode_security_struct *isec;
+	struct file_security_struct *fsec = selinux_file(file);
+	struct inode *inode = file_inode(file);
+	struct inode_security_struct *isec = inode_security(inode);
+	const struct cred *cred = file->f_cred;
+	struct task_security_struct *tsec;
+	struct selinux_state *state;
+	struct common_audit_data ad;
+	u32 ssid, tsid, av, requested;
+	u16 sclass;
+	int rc;
 
-	fsec = selinux_file(file);
-	isec = inode_security(file_inode(file));
 	/*
 	 * Save inode label and policy sequence number
 	 * at open-time so that selinux_file_permission
@@ -4060,7 +4084,38 @@ static int selinux_file_open(struct file *file)
 	 * new inode label or new policy.
 	 * This check is not redundant - do not remove.
 	 */
-	return file_path_has_perm(file->f_cred, file, open_file_to_av(file));
+	/*
+	 * The following is an inlined version of file_path_has_perm()->
+	 * inode_has_perm()->cred_tsid_has_perm() in order to specialize
+	 * the requested permissions based on the open_perms policycap
+	 * value in each namespace.
+	 */
+	ad.type = LSM_AUDIT_DATA_FILE;
+	ad.u.file = file;
+	cred = file->f_cred;
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+	tsid = isec->sid;
+	sclass = isec->sclass;
+	av = file_to_av(file);
+
+	do {
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
+		requested = av;
+
+		if (selinux_policycap_openperm(state) &&
+			inode->i_sb->s_magic != SOCKFS_MAGIC)
+			requested |= FILE__OPEN;
+
+		rc = avc_has_perm(state, ssid, tsid, sclass, requested, &ad);
+		if (rc)
+			return rc;
+		cred = tsec->parent_cred;
+	} while (cred);
+
+	return 0;
 }
 
 /* task security operations */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index adba67b074e4..4b2ebe31467b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -215,10 +215,9 @@ static inline bool selinux_policycap_netpeer(void)
 		current_selinux_state->policycap[POLICYDB_CAP_NETPEER]);
 }
 
-static inline bool selinux_policycap_openperm(void)
+static inline bool selinux_policycap_openperm(struct selinux_state *state)
 {
-	return READ_ONCE(
-		current_selinux_state->policycap[POLICYDB_CAP_OPENPERM]);
+	return READ_ONCE(state->policycap[POLICYDB_CAP_OPENPERM]);
 }
 
 static inline bool selinux_policycap_extsockclass(void)
-- 
2.47.1

