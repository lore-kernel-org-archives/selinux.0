Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1472527F16F;
	Tue, 20 May 2025 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742515; cv=none; b=EBWFU6kD55vqmhYa7QoMWlwVvcQyTuGAVx/Ow3Iah4iVS5ciMYwAAmDl2ZIpFVT29QMbB8kcArTWRPYnmiSRl4EFpLblAN3JKmAHTAhE2C+pD+utfx/g1dzm3uNdoyv7pzLNkxV0f4DbSMtBmyN7MfRoWrcgaRTiRW0DKRk1A5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742515; c=relaxed/simple;
	bh=ME+KxiV/z+KhAukJj4lUR5THSx5Y/rLA5u2i8WAWWA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJUdhYWjQ0nQwHqQIugNczm9Q6+breGN92Q7R//ZWDnaAhn0ED8dSPNs3Hby1ho/Hm8PlzzhpeebLdbaY1rtlRXz2UuYNcxenPxQWXR6oOFcnPEd1SZ10udQq9Cr/KbDeYg/q9saVY517NZwYtBgkeV4kUiuvO6ypIMvIFUNLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQu5PV0i; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQu5PV0i"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c53b9d66fdso779028285a.3;
        Tue, 20 May 2025 05:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742513; x=1748347313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ol2NFYEGgrpt6n2yhWZLB6mdINX7GFFt0cBDBJDc64E=;
        b=MQu5PV0i4L6uC9smxJUwoyu/8IMs57IE69FxsODJqFlqDwoBW5xPd8pSFSbzuvxphm
         zkz97ZC59eZBBbFbNrkJlYcZXbJt1byg+RiDzbfxpHAZ262qnf6AK7YW1yo8odQNLmO+
         /hePeLbV6GLHjLe3GH4sE2pszHeAr4yTZG8pat3ncFvnM9mebFDJiZwsg87Sj1wP//F5
         NMUYgS5D0o0FKK6rw+G3xmXymSrqFecNOu5VHyfxBbLe+KUjeNYhGDITcKmn3PCvABSO
         GlZE2ptPs+LSN5AJgWOqKQ/PUqFaSuKlXDeT9k67SB6Z8GApWUgOG4aTRpgB2yX2TF/c
         VJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742513; x=1748347313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol2NFYEGgrpt6n2yhWZLB6mdINX7GFFt0cBDBJDc64E=;
        b=qGzCLn7/ukMeXDMcDX7s+5d8bgCJ5MbBlkSULI+JAVn6yBY41wJf0VA0R0TwxEOjbS
         lGn1U7PWOlCYe6cyveGXeLKu1kMopBp2Z3n4ZxKWQ4IQVKWihaMETc64iFBAVSg0/DNb
         L2kp2t0hU0c7dGaUVNUZtRiBdoXdFQmAStMuykfu0SMXANtsSbQ3+q0MGVaAJfWdJuvs
         0duRQXsTBb/yGwsGJxPIuVieyyf5HwO9HaIEVkqkHf9O6uRHyOI/cKdnItjtrd//Htyv
         s+KUbj8ZS06DvQcQuzqBDmmFdkF8rhTMYq52jA9+m+6O8PXuTQlebyixZAycWU/Guhcu
         GIbA==
X-Forwarded-Encrypted: i=1; AJvYcCWFBlg7hcwtE4GBC9KMRd2mvsKUMzY+/lcJe7b9pJULw6JWojb6TGLrUnEjkYD6pTWDQWo2r4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyknj/b0kF94AP6EbRHauHNh3mwVPb3pdQJmZG1FqbwsuQVxKUX
	YLbVXFTjTrlZcibkUB48tA4z+VshcPPP1KOlD5CFMUrBrw3e4XOdJgN7H70Xog==
X-Gm-Gg: ASbGncv2AdWySkBPKC41DUg7+PLcDMm5yAKkKmx6h8k/Sgnb+o+XH/bAqv6ithn/vt2
	XvOa+QUjzIScZHLNaHsE5HczVQWEQJkAkgtTDP4CC35w3QzDy76kvhDMuiafkq/MKWAHC2slVTm
	9koZFhwrHK4ohb/uifha99N/Su3sgOScDUhb83tuS0f1DRfXEaWB+cG8lmJECIjnnfQfOLhaXUW
	aKbaLxLFJ9+UAI4I0A4STUnPuPusI56bK0xlz6RWFEduXwA1eUUmkP8qaqs5V3QbrW8k7Xt/rTa
	MVaFZI5A8fCqO1Db0gFFGPqlbl1zBLRcoy9Y/FTGeDWD9i8MGj/mf9P3L95Qwc31Dfk4F9Jyzt1
	0pgCmP8CdOGWVgTzMBoQhYtOU5CV115coj6fzWZRYZSWgr5dQy9ltuIn7x+M2QEup
X-Google-Smtp-Source: AGHT+IFdqvljPW2and5iYFbxCjd4m2d8NX0OmTVlHDJb2Hl2N62VkdvuNcMNxnjt6+4iErRF4SWSvw==
X-Received: by 2002:a05:620a:17a6:b0:7c5:46d0:a77f with SMTP id af79cd13be357-7cd47f13116mr2070687685a.16.1747742512560;
        Tue, 20 May 2025 05:01:52 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:51 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 38/42] selinux: make open_perms namespace-aware
Date: Tue, 20 May 2025 07:59:36 -0400
Message-ID: <20250520120000.25501-40-stephen.smalley.work@gmail.com>
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
index 9bcd84ea7c95..850533412896 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2022,22 +2022,6 @@ static inline u32 file_to_av(const struct file *file)
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
@@ -3321,7 +3305,13 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -3335,13 +3325,41 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -4169,11 +4187,17 @@ static int selinux_file_receive(struct file *file)
 
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
@@ -4191,7 +4215,38 @@ static int selinux_file_open(struct file *file)
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
index e1c1b2da9256..a9ef6d97b88d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -229,10 +229,9 @@ static inline bool selinux_policycap_netpeer(void)
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
2.49.0

