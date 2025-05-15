Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61029A9D2
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314647; cv=none; b=UYvYdHunldct9PxV54wWVvVWgLwezhrt32AZEIcM5uQcr39H/1HoSFAIAkHUX01HxzYvHn2MVbL/VOraTqAQUyk804hevpQo6IkKXmOpDu3oNQ5cWM7HF28tCkM171kkxLxqrJnhEmh5Zn5UDs9x8iXRXOpFtTKVhY2kz+ILcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314647; c=relaxed/simple;
	bh=xrUma9m4+jwyePX30Kmgai+MHfGoT6286ft4M9EJhCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4XLRF3hWdwuQThEM//avVVVdSqrZmcgNy/H+OToA8FgV/0x0SAc2HWJRl7qDTTz9XhaY9JpTLuiwJ02adTQoN/I+ELvquVfcPkXbGjVb0sHlYozpYUUNZbIqFB7OmqYYyd5vuZMREaHdUc8JvUEf53E6TTkXyseQD18bNdQsiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR1cUs2W; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR1cUs2W"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4766631a6a4so9934991cf.2
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314644; x=1747919444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9QKbGKuiTmfRJLTbrQ/bCSHNLuCSFC/IKnEaYbwVzc=;
        b=YR1cUs2W9sAABEkCp67gxwKqFsqvEWOzjSgfk1k1R2emr6P8QoaRdg4ffJTJp9tp6E
         soVBwK/R4auaWgmHbJxCZOeJng5eNX9ANrYnzUBLjSZ6X3KitBtgRzTn/SdxDPbKKZmB
         ClYB58Cu1MN0OCEPr7Opowd0YX+5cggwB7v1BYo4VpXPZyFJJmoRmpo9dvopOBBYGfQH
         6jesxfv5QSBdR0HuLKuN2s8/myvIlo/TzlslmMMFqyDf8hByAzsOpBvO+ejH5BtlhL9Q
         lN2YWgoxjkTEYHhqCyO4/UBecWhiW1+TdjPMWegbAex/9DtS6B1jdwwHFXb6367fH0VV
         e6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314644; x=1747919444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9QKbGKuiTmfRJLTbrQ/bCSHNLuCSFC/IKnEaYbwVzc=;
        b=e1SJZcvw5U9ZbHLMLPkli2UgV0iyKs7IKg49Gt0jAJIC014sz3OL1dQ+NAHO0Qz5AM
         wCHos9LiWJohR9tZP0jRDNxlZ30iV8yDeU/QpifrdXQnoWi/xSJmE3OklN95mBVuOeWw
         WdnbWr7HisQ93sTZfxys8VDSFG6YcYk0l7zYbzDVo532p03eadWrRPNdv/TE/SdArx5/
         vvqZQZmhUJcCnCgn+0ty2OgZfIFcqP5RPke1jPrkHaFY37QvkTohjxonPcRB0jocujPA
         EfORugQMJC5zBPZHchjpk/+0YeZS2zAz3N8zTCiqiyjD0g/wRlPv+kCsuMSO/QbpSxkG
         +jqw==
X-Gm-Message-State: AOJu0YyqNSjEnkSblvewyMPgL+wT9gTsTWNDDKkfOyUgFty2mo/mee0F
	XfQ4qSQ/XjTCm7lgC0RwknMZstK9/HCoUNvTZGWhJ0aP2ZuK8O9BY8+CPQ==
X-Gm-Gg: ASbGncvCa5PI8zPSsIhVLsnvrmHqkfNRExOP9HXsJ1FYCUYpUKQzdCQU2dPMAiO1uNe
	M2tP3Nomf06/3xMYBjxG8htXaw6LaT3R7IKbZRAiikL+upALSNks5asyef6AapqkhTO39+PzI8L
	h5G9rIbHi5qSaIkCnmRDUITFXc8OJX6RssRzpNYpcn7xZSxJjx10tH8NlBzV+CGD2UPWXIqHEoo
	TRg8y+LbpdvvPSLhr4Gc/qeiobi1aYfrZ5a9bkY7UKN8fCI4hlgMMxGDrN5t4bbtqbHu57s4AW3
	C27k654EEdQRVzNsCs8hbXuUoN58NtAYRg4Bl6spg/tpiohGvrUjcHkqpjr3IKkXlslnplEA0eB
	VbPXLtmeTj4t1tfccJpnwwvIjWzD7gmGIPmJ7cgYOjsCAkVbGcXWZpw==
X-Google-Smtp-Source: AGHT+IH/m0nGurVu2yZ8lDn2csk37YP8QkwL54ZvawjyOR3ysFB6PqAIFnR0QYNXhQWV23hOi34qZw==
X-Received: by 2002:a05:622a:2512:b0:476:8288:9558 with SMTP id d75a77b69052e-49495d27368mr121563461cf.46.1747314644297;
        Thu, 15 May 2025 06:10:44 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:43 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 34/49] selinux: make open_perms namespace-aware
Date: Thu, 15 May 2025 09:09:32 -0400
Message-ID: <20250515130947.52806-35-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
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
index a5f2e089d33d..df4f74c6cec0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2019,22 +2019,6 @@ static inline u32 file_to_av(const struct file *file)
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
@@ -3318,7 +3302,13 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -3332,13 +3322,41 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -4166,11 +4184,17 @@ static int selinux_file_receive(struct file *file)
 
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
@@ -4188,7 +4212,38 @@ static int selinux_file_open(struct file *file)
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
index adcd0b04e3a7..d193866f729d 100644
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

