Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA7309DCF;
	Thu, 14 Aug 2025 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178065; cv=none; b=bZrxoZU8STTo5ttmyD9PfLsHkg2FdM9KDujH9GIMM58MeOv0NcqJmOD2jk7PG8yIUNDAhSWTjYqZ0+EFvCX+ToBXiVlMkX9GEZA58lHvTLs26qqcOzRdECxjw4bwdIJk9I9kK2t+qQrOb0+9VavzVPuqqyBfI7uaZYHxWLZIfCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178065; c=relaxed/simple;
	bh=w4gDWISuhjenzvbjkH06dNfDEYtnMSYgJAg34mC6PYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebZA2bPR8QN9nnCZ1+7DT6h5EpQpUsYrzTJIbN5YmYe8vLZy857MKJkYJjf2LUDVHsUDIVEKMj/5441I3X+LnYqHVAHQ2TP/9MVeOQc1DPNmWZZln2+czvMWJsW7/9ucWKg82vsL9VZXSHU8aFuy1osBNUib9/1BIArbSUtr0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAW+6aPn; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAW+6aPn"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b113500aebso2632441cf.0;
        Thu, 14 Aug 2025 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178061; x=1755782861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V74wOrUlSzQfpl6ll0Z9FkeOADpjTRjuGvjVjDBC90g=;
        b=BAW+6aPnQ95CcMIgWm2ShVwOeT+vougm7veSUnVPjdAuLBKQHvAy22NSZu/j5+ZETA
         EKQlVDcCl8otKIzQAEhiltGPZ4MjCGkNkctU7bFyzZ/Stay+okNZ09ZZjXf4ISLFcAjf
         RNZEOakT2vZjo1qfVzPp/agDLJznKF6295RKq3dQwqnydvGKZTtUznZN6RjPHsrfYs3s
         JjieDn8a1RltD7eHIw0SqhlfaijXfXTAJX5hVRfoZ6NtRccLTiUoevgtdyGSegotqja/
         EHH3Moi9SUX4OZcBf6myBdIpwIcaSc3UXdrxzoZA6tRsAQY8mPl/eIWwfiJ/HXHEElMh
         U4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178061; x=1755782861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V74wOrUlSzQfpl6ll0Z9FkeOADpjTRjuGvjVjDBC90g=;
        b=UqzxJivslRmjIU9hIzrOVseVao+5WJUgkAkIEdv85r+C6lBYfmdKkT1KSlRfeuG4+M
         zuWYXTdlQsy+Y2cvcJ4I2DruVViTiB7gBLR9hyi9AlWZXdPtosK1kpWXsR9BmTxtSBVr
         y3e6AIHD2HNKInonq9h3LyitMdWnK9n+0JqYJuW7qFNKV54B7ku9GnjCFbYJ17OrVjbX
         t+Bi4i/GGytkgnokbI8JatM2vvbWE/dU6UaCewYckTweMggwmAXn4Hio9kPko+DdxuFC
         hOTk8WEAliZsxFNfRJKdxROi6Lq9/SM/rlKTLNMJa1tku4z1dokGhdM5s0CyJXu2cgwU
         vpkA==
X-Forwarded-Encrypted: i=1; AJvYcCWhAj/+p4tG2+1w4gMZl14laIUtrLv0zTNiL+ViUNPWwsFJ125kfenUfixA205PTHTE2R91j2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2FtEP2lM3vZwtwyvimuFOf3i2TpOT1LlW+BidSlm2Qt6biVeT
	c6Ues+ffP5z88ju60P27qf9z1UGXmn2julcUmUZE/AzLUt1ZQiloqRpYvjagoQ==
X-Gm-Gg: ASbGncsYtVleLkxyBm3E7RB+8bd5c5V9LskI5IUSLgsD7wdQoSX2BMXHKQsxb8wzez0
	0cYlPxrCbABd/RgIY7fVfSE8w7x1KfRC8vUVG8+HOcyWvKD+EJIqnAY7qA6sMCE9l/3gRHTZWSE
	pPdj78TquY+WWiioDUfNj1KH2eOVLOhRveNDAm6/N0kcRJuNVpBuIzYSJX0uPZIP46v2gFJN/fP
	fZUZfq9RUrJHcMqbID1sDpt9tkdIDQi8ocYSnW0txMA/MjFipABnXXQW1xyc1q3hcUYBgaIa+B3
	YTgz0eGEBpBNvwx3845qKuAaQ70WYtJkWsokMV8s8SVoMD2w8BN3hQQaa86wo9ZqHuJzaa1W8+Y
	lSN4MlIdi1V1yaSzczXrY2W/N8DUx9rMzVur7KvkuFUVfjmcq0C3X4dJymjJzHFdzgZdflzgunq
	yZf/zNsqTmrM953d2gU4Zqk6cCWQ==
X-Google-Smtp-Source: AGHT+IEB+rvhfUJztvwL/9ncIksRXdnLpGuaSR9Rfg/yx/pUY54BpBGGtYWG6VROdVtj5vtWVcebWA==
X-Received: by 2002:a05:622a:1f18:b0:4ab:4d30:564f with SMTP id d75a77b69052e-4b10ac25797mr42633961cf.47.1755178060737;
        Thu, 14 Aug 2025 06:27:40 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 39/42] selinux: make open_perms namespace-aware
Date: Thu, 14 Aug 2025 09:26:30 -0400
Message-ID: <20250814132637.1659-40-stephen.smalley.work@gmail.com>
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
index 15b0dd725f76..d83b764ab86b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2028,22 +2028,6 @@ static inline u32 file_to_av(const struct file *file)
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
@@ -3332,7 +3316,13 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const struct cred *cred = current_cred();
 	struct inode *inode = d_backing_inode(dentry);
 	unsigned int ia_valid = iattr->ia_valid;
-	u32 av = FILE__WRITE;
+	struct inode_security_struct *isec;
+	struct task_security_struct *tsec;
+	struct selinux_state *state;
+	struct common_audit_data ad;
+	u32 ssid, tsid, av, requested;
+	u16 sclass;
+	int rc;
 
 	/* ATTR_FORCE is just used for ATTR_KILL_S[UG]ID. */
 	if (ia_valid & ATTR_FORCE) {
@@ -3346,13 +3336,41 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -4199,11 +4217,17 @@ static int selinux_file_receive(struct file *file)
 
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
@@ -4221,7 +4245,38 @@ static int selinux_file_open(struct file *file)
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
index 145ab528d71e..057f2da62d8a 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -232,10 +232,9 @@ static inline bool selinux_policycap_netpeer(void)
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
2.50.1

