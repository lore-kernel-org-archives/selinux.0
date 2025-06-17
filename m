Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC32ED85E;
	Tue, 17 Jun 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169214; cv=none; b=d1xouD5klbMgPr2Uu3n11XW/KO7uu8whM9v/cLg7hC92/Nk/Fut7Fh8UMNa0srPK3i9nsS6+br5A7a4FAo9EDBoUP0+8KF784UrP/C3nlHtRyy/dBjePdJ5U/u9Mveh4yRj5eA9ERVHiDQlrvyrWPiXzjfJ1kSvhNkrG6Ttoorg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169214; c=relaxed/simple;
	bh=KhaCBGqpARqzlzDZHTPa3x793WlnldDyfFk1Phv7wvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN4wRVObPXs9RXos08U0kT1uXdh2y29KUhESh5bpDXTGC+tb3Ut+DfkuO5pKff5+VDnaVkcm6a4cSBBBrp1kSuvbabVIlEydbqOgwhq7tTiPejdSCUinqYmZ7tyvUMiGFMnYH6JRK3pw4bT/TqL5hnIEcqwN4LTYh5Cv5MxgCBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8OxRJ1j; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8OxRJ1j"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5f720c717so722462585a.0;
        Tue, 17 Jun 2025 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169211; x=1750774011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUF+ZzBa8xmUPxcmx+4WJ481EYs2a0dPc3SXPpWWv+w=;
        b=e8OxRJ1jzpn5Kpkr9qVQMM3ogb8XK5iWwU/cWnFqSqi2rKK0PE5YRzApNng864wQjA
         jsq1qZ1iQ2JrS8cyBRY6Ycc6AnDE5h0B5zknOqXeEmq6sDp8um+GNoKWuRV632LWivgE
         op4EzYoAuxj4foQlteUHlpIuN5XXkOnIBHHIhZrluqnzQVBLZcy/lbgVbBnNc06tfsw4
         qhNAoWcAqoa4w/7E8nWOUbCDm/FX907VtQMb1/LU02UZjqoWKYM77c4AW73PAAU3hodk
         p6hvFMSIwFgdjvMV3PiM9pcJhlEN7g5RXKvjKvSShz+Kltyzpb+zRBLBVaQ9YJ6beGYB
         t61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169211; x=1750774011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUF+ZzBa8xmUPxcmx+4WJ481EYs2a0dPc3SXPpWWv+w=;
        b=SHC8pFR14DLZ3nquNCFzYZiqmrtoV/S+jMuJBtepADGFDSyLHRsqLk+sTH/O6+r004
         cHRpt5Pai72xg49X/StdvCMd3Hh2pHOhjI/0SeNkCF0MMzjOuWUGgTRmvGdNnPlGg/gQ
         OnunLj8BZRUWcI88kMzBRdUzYIk65zHV78Oq6TqgGtiAob92nX7OLlfoZXfZFD4iTARP
         QFU85xX4k1nbV4Js5JxtI4eStK/n8Ic64EUzbG/KtMerDqp7pyvruFFtCrDq6u0Cl+C4
         Hwkq6kDOSh3nfUP9Q/mhBwWzbwt7XkATvJ2tRgm0xHxz4mX1unIhIj/h1vt5hlVW+ScC
         9Ltw==
X-Forwarded-Encrypted: i=1; AJvYcCXzNLRV2emOjlS+RLg7nuLoLncS62UGpr8Pgxo5efctmSxQvjsIvvB/3Mc8834p0h4eWbhXYxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzK4MMqMuqDfEi/5WRsF+5ejjlXbvDuh1+0FLutk82Hl1tjC2R
	hmRFwbTJt5eTHR0+Z5WXIjGSoa/4xJO5XbzDbf+awcEF5HwSJk60Y8Cloffluw==
X-Gm-Gg: ASbGncuBQIFpfGYOzZQMmAPpPYTjQc0PyFFzoUBXbxiW2cXwMF8AVElThJV4pMsR1YY
	YxDGVU678VN5E5CjYYjF4uZSbSsCQmLaAoS6HQCX1I+B6HB2vkMqwdrLWTg/0iKRCs/PQVusuDJ
	mNdLD6omKf2n7HrHO3tLV8A0knRIhyFDtFDp1KiNZBQghy3d66ix1vwnRr9VFpwtDcBrQVM6gyL
	87PfxGGiMn6P9MZ7U1wCVPPX+YKQwnAc6Et8PC6kjkomJiPVmPQX6HX5yIHueWEtA8zewLjTvtW
	ZHgdLNkg/88KIRyvise3z/tY49s20YygbNCtXq4968HYUlRFWK7wnYmv21k2pOEkgEqwnBfyaN/
	29zK/P1vpFEnqwzKjm3YUF4X+3CJQnbb0j9Ia6qZaE5b0HHnCZI9xw3oyZZvjWVpRbA==
X-Google-Smtp-Source: AGHT+IG5Ntyfyt9HXGk/9EaJSvxL6C+sNwec8BrxyzLepC2YS6IHE1YGOA9uQWFtLRmg7LjvDDWlGA==
X-Received: by 2002:a05:620a:400c:b0:7d0:9a99:1bb1 with SMTP id af79cd13be357-7d3c686b7d4mr2023036785a.25.1750169211422;
        Tue, 17 Jun 2025 07:06:51 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 39/42] selinux: make open_perms namespace-aware
Date: Tue, 17 Jun 2025 10:05:26 -0400
Message-ID: <20250617140531.2036-40-stephen.smalley.work@gmail.com>
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
index 2045da8b2b85..155409ad7e23 100644
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
@@ -3327,7 +3311,13 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -3341,13 +3331,41 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -4175,11 +4193,17 @@ static int selinux_file_receive(struct file *file)
 
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
@@ -4197,7 +4221,38 @@ static int selinux_file_open(struct file *file)
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
index 5cd49ca2e2b2..64e5ef56304f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -230,10 +230,9 @@ static inline bool selinux_policycap_netpeer(void)
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

