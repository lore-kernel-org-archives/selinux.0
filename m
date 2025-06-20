Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B52EAB92;
	Fri, 20 Jun 2025 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441552; cv=none; b=ouAv84Fl4l6Ae24CUq07pbfH02F+IcdRhl3gfLgJC6AzI5WQxXWl8BCo8nwGKkhjZrsN81+uEaM30MyBxE43KykzbD6rofmHdhWGyUnRa8rGpGBSug9j/7fjqwTMCr1vAuR2yVEwAVwmxYKZvnhTAirxSbILGMVtZO0QiEV48go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441552; c=relaxed/simple;
	bh=GN72RHjiWhpI/K/GAFBOpWdsK2SJqRjbHyl+65L9YD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKAkJGiuNJ1hPE6o3HoocUI4JbmA57LOBFPzVwgUlvEuSzh6g4SY9j/zjMeTWGcbsTukNVbh0HuLQNSWIaZIfi3lAwUJodwhKlJ/QpLvu9AmdaABVMVyGbaEQ2EPVZiylB1vAUYu9EKTb0SIkfP73ZAU5qg/c/+d/FcjCBqkxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFxnxaiE; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFxnxaiE"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so22566456d6.1;
        Fri, 20 Jun 2025 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441549; x=1751046349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTI7H51rsCgZmQTzQf0QWCTzxzyVK0YE4PhKftb5pu8=;
        b=UFxnxaiE3aliYnyjdX/vU4DDOIcYrDPNK+S0QwYmj7fqA0ueWIxvTT//pVG8/z14QR
         XvGWjtOGZb48bl0Men3cuqZR1ZhCNfBaw4Xtri7RbPyvrg4t6whfKbKvKYUSb9Oj87gS
         VyqiE49Xp0DjeaZ8QAlE3GIkFGuscfejjgT32/WmaWj+zPffjdK7hcxrbLWK0Ta5SRik
         Saa7lFwWWduLYPGidghfpx1skC2wQfXjQ+pk3UiyilbC8OBtY5Xg6l87Rqyxw7DuuU1I
         gJ/vkeYIxxJQOcoEjpe8/hzffZ1bohw5ysGSkqf80w/S1ufreVgqzy0qM6qWUHvy+HDg
         Bbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441549; x=1751046349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTI7H51rsCgZmQTzQf0QWCTzxzyVK0YE4PhKftb5pu8=;
        b=QatY/06tE8xOKlcLIn92lhgmU8klbTh8QC/oJF21K3MN+xolytdpdfsd3GYM2kj6v+
         8Y3WAqmxouGvzTUJAmeXhJUeo0eHazW8H+kDgXYrHI2Mz0kcpmTk0t9/0QWlt6qrAXPh
         hd4VGMu5McEeadaOL7L9SBLbqtfbRXsklQhzOxRY4Wb5pbzKgbRHPzg2kpZNlZdEvUdy
         G0BSM0KX+cXMuVld9CxI+H/UZqUGlx8N4szIDgMunt5RviQWd4Dcb1I6QCi0eQYeS+oj
         tfWjux5pcETEiDEBVuAyaSK+6Q60azEDHmJFQ2ctmivSoM5D+GL2J0XT33es6BjEla6W
         d5Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUcAR32JCgvnd1s6m6ubV6Qx/X/Vg/oaZulEfBoSsOVY5TQh8B88I4u1Bc1jsoH9tYikhJcPgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxj+5j1qglFWt/e65/HM9Ve7wK/i7ywcZZD99kZ85JZfaqK+v
	ihYNhbqLEnqBz/BRTi32YxYpnURigG99M0v7OKCAo0+rElh69MjZtvJEv0S/XQ==
X-Gm-Gg: ASbGncvIeCrVFCjMZKIWTULyypUj9GGgfupyMZ4mxDr8KAq6xi4gfNXBdZAxusu89d2
	RBxmM2Y49k1RQdgrNOdb+DMn2kfJ35McS1kWmnxgWK6iBVXonD/GuMGP3ELwIeZz3qzTXJdapOO
	drqkBTMgzB6OGYcPH3Mm7HhR4ODMOwLe+1cORorxrEj2FkiMRZ0ZFeTlIORYYN0fJyiQL/Zy2u+
	2DDZick+Oh00dqakJ5ZkDAazkMAbO4hFofnjtX4S37MAer0QXFiloS2R8x9NAIHkNqYHhqgZG9C
	+XLur101QdsF/hVDN+mpnkWvfzanu0usyey1XI2rp8S1KHVS8RlIsu1qBIFDhlyW6wbq2O8Fg0v
	1PFO7cvdcq2r2h9qRqFwvxfKthX/IcojSAUcV4+YJSrJ/Iry2gxbv7IGVKNcbwyiX1A==
X-Google-Smtp-Source: AGHT+IHIeijhGkzTop7QOYFNMOUKftPDUl9aJlMQomWh98iq8TUIb1ZFF6X7nyysiyoIOQFp4VVyhg==
X-Received: by 2002:a05:6214:2e8e:b0:6fd:c80:98f2 with SMTP id 6a1803df08f44-6fd0c809a62mr37080836d6.27.1750441549601;
        Fri, 20 Jun 2025 10:45:49 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:49 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 39/42] selinux: make open_perms namespace-aware
Date: Fri, 20 Jun 2025 13:44:51 -0400
Message-ID: <20250620174502.1838-40-stephen.smalley.work@gmail.com>
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
index 866a9fdf7522..678dbe85f040 100644
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
@@ -4187,11 +4205,17 @@ static int selinux_file_receive(struct file *file)
 
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
@@ -4209,7 +4233,38 @@ static int selinux_file_open(struct file *file)
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
index df3ea20f2026..b933e7aa51c3 100644
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
2.49.0

