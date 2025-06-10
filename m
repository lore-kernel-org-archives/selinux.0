Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C252571DF;
	Tue, 10 Jun 2025 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576215; cv=none; b=F9f0qkESZWIRd6pBBxhgQoiVMuUvnnCCi1QEYS17vplI58Fu5AltRgzlU03DGL5n5sUEov5BNI7Lg2vi28VHt4VBl9kNPaK2CJ6orMXehCkUGVkpp7XC4KTl3/M+OJb3hqwBeo2BFCokGj3Mv+BD5mIXod/4PTQtWAcpPa0ZwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576215; c=relaxed/simple;
	bh=MJxQIIVu/gZHa3Nc0GMpgeesvjz6DWtWqdQ6OLJPKy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I694GKTgHFkYEmZX93EzfGEbUor1lcdwVkwCz6GPE0uSkt+/vzzv1/AtY/mmKhS06sVPqdSCCtmjGnQ6mlkr2+PCckPrSoMjbQXGADa1eKr2RXEjhAgi1wP+SPNvoEEpEl85D2Wg+3ttDaQuLtkmp5ph2LeWPGXgQ8a49eKo/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Purh+Np3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Purh+Np3"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d20451c016so309514885a.1;
        Tue, 10 Jun 2025 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576212; x=1750181012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpeuqiP1yr//RFvQHlmd7eQ6A2L5j7D+PAQ6t70GN+8=;
        b=Purh+Np3K8jaRM6MuhlnKr8ZrMqdQcnv7C6ktMrOskn6VqRUby9RTgpNlaArYrkd3I
         fKicnaYBnZRTWs6ekt7A1H4Gojn5AZxjbmnRjWrzcCP7Jb0qwtCcKUbLEjmff1XCif/O
         Aqqb4cnLCEsLEJwTcP9LIGVwtHEUAJnd17cFI8CCkATu11BRufxIv2eL1qdhSnNqHh4U
         HJ2kLgJXPDctvqakpOSJkv8TMjP5fFnuzCPV+fELifUvkBEeg/gHFoEI45MhF53o58mR
         0wfOs1CDyk20UtT77lrkYocDTo2Bt8PddOoeA0Idiw4YPDAkqdEGKexmzMZoElbZA9m2
         78Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576212; x=1750181012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpeuqiP1yr//RFvQHlmd7eQ6A2L5j7D+PAQ6t70GN+8=;
        b=BnIBKPHnkKmm31GGxrqpMLlY04uzHwOETjwQCaejWdO7DChOnsCJxXNZ/7m7P1rlWG
         Hu20RcGbWXLjJxzn35j8+Uw101dJ9EvZbMoyazlB0oSgOdEJUVPX5rlrqkgVw1gSSaXH
         zuGfsmdTxJS7ON3Uby4qn4zhsrtfvoo1NABIiYPWX0Zy7u/rCh6uycKC6BHa/JD8yL3C
         AIgJ6mro2E1QDnUDA3B43S6hL4qoXe2LH0XwDPFzcJk0/960ylR4MpjL9cmTFLbxy8EG
         88wMxxPsuWzx+q7FlXexJ5tkq2OHHjWQ3r+N83CHynKO6vQXuGOf7hVVQlWwQ1e5tpxv
         Q4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmnBBtbca82S8e6VquuiYXB/WldRJobedpGI4AWhLQvlCLFfzsUfH5zr7ObAThjCx9fUhlBuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8I96eXRrHosAYIsungDJH5r0M4x/SLBQl/D6B4u5jhD3qhYy
	4ECZbJoNwk9bE43O4qfHXcozYMmDPV7gfUPqd0a4dIH32U58B+CqOWPtVdY7Ig==
X-Gm-Gg: ASbGncuOvhSEwX5djPa3XAlLrZ9uuB5v5B061J9OwMOztyfrkx5cv0EfqgJguc5/JKE
	yNeHoaD7mGq8EpX13cjb2eRKUSh0xk3gLTfQ6kvxvUJ5Oo5IHmKLWaDFbyZ6nXwvNiQQvvRs4Vi
	JsEo8bho7Yuxppvtm7NI8SWjiUmSok8D+Qb69kUX6EuAZKO41Ixd6rrxXzbVZLdw3UnYuSKL6pS
	zlNtMyQA3dLB3aw7N4PfbVTXJXPmDIKfAsN8s5Q9EcKVJK0oSUTBupq195YyckXuDiyUdJBqf7R
	UjlVCGM4rUXxJEjk60owlHjTl/dqhsjY8bRkW1PLApa2pnvUQOq9L6q8kUZTpMNMdm898hpWjp0
	7s6vj+5olCGS0/1Q42eOBs8E/DsWo9tSjBOJzEWdlKULiyGvMpWjc1m9zuMuEnOx+Sg==
X-Google-Smtp-Source: AGHT+IGd/Je7Lpi3lF3yEpLNpEw91A0TLi3UkYHcjbY88D/kz07/XV5YSoe66kd81m2OfzHIZdHt7A==
X-Received: by 2002:a05:620a:4041:b0:7ce:f58e:7e9c with SMTP id af79cd13be357-7d3a88062c4mr36584585a.7.1749576211916;
        Tue, 10 Jun 2025 10:23:31 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 39/42] selinux: make open_perms namespace-aware
Date: Tue, 10 Jun 2025 13:22:10 -0400
Message-ID: <20250610172226.1470741-40-stephen.smalley.work@gmail.com>
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
index ad502bcc3e6c..c30df3404754 100644
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
index 00e3e22b274b..22de64287b4d 100644
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

