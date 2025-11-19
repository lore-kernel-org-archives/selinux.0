Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D971F8722
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517833; cv=none; b=XZAGdiruu9FT6yYrhmXcoR850aJDHLUxg2WHBR7uMbQiqIXrHjgiTqwbagUaao4qPxNf6NME8Ctotl4SI431CBvIlYrB1mxtSEByGBCla/7xi9bBXny28bH3ldNNFjMO9sk9eFZUsyo5Xs883t2YO9A2jEADa/WxQl5l/v0mOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517833; c=relaxed/simple;
	bh=CAFDFwa/BWmeH+XfuoEGsyTQg3yqUQ3CCvxI2GLzyFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUE2tVKjxNE56ZQEj2djOg8mVkE5bh+bwARITkRsAGNq3SnuTKl8TtTPKm6D5ic47bc9UpwGC66nIgthI4R4Ymn1d/bLHegC1986oIOpuGgbJwscSipFJP/SfDk0ScuU3TZzY9XS6PgmI1/IUmKpbQDWFjOUxWWXWOAc/eknVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=e5LS/PP4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="e5LS/PP4"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee257e56aaso4598361cf.0
        for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 18:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763517829; x=1764122629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHB64kJcwXTxTFxMaX7ufdi/UJLQmu12/C7tYpe9688=;
        b=e5LS/PP4CiG+3pf1nSJ2ApvkUnR1TbLDn+MPqPgp07EGi/jatDp82WLrJecmSnw8rx
         eMJCGqNf6W6+JDw1uE/jykLT63pR0vxD1avTh2IYL1LngxFhaqh45ejlIjaholxGYsY5
         Yzc/G9a9smTtl5SdBZ8yaVZBAiB/PnUJZDK7Vjv82Z9CMt3drEAA5nrkphq0PNAjm/ln
         vKnAzG7hB1nA7pw3b4hS+Ii506UHoKz6tK8K7NTUZROJMUhU4JmSTQ8mfnLvL2AamwSN
         Gy1k6e9aNSWoBT0FE7PEDXQwV3jNWbPJIE2UK9x3YDjHaRjGM+OxxeEIfNAMDH1yDRvC
         hESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763517829; x=1764122629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHB64kJcwXTxTFxMaX7ufdi/UJLQmu12/C7tYpe9688=;
        b=rzW5IcV7QPdfa8doWvdknakucVMOhQtXFEWSCsln5cWaGUz5jS5fwEDd2W7kw9qmmZ
         RgM0IY37g19HX4/bLFYyEl0kfkJj+50TM/VUt2VrMYWeuitgo9/s99/kbMo7rze9brBR
         wlgx73mE7HoUHxCXi2U+oC0D8lEQK+Zj+Be6h8Ct6NbR5K7m3SOb+xRVXPut/lhbtPLL
         HJJR/YDxM8Cm8pXZutARNR/AthWhH5uqcb25mYgFH5095ckw82nO5UhAZLwSOfqvje0h
         NCcV/staewKU+kGx2eYPlwvxN22InzHqteE1bBTy0CQjbyZFPCc+S9zeaTKQc7TEqUHc
         Kdlg==
X-Gm-Message-State: AOJu0YyTy/1MdURQrOZ4fmIKdFkM2z6emuNfUMZHq1WON5yuywPZ+tvI
	7ey0szyY4YHFhQCNhJ3bZPZm7Aeokdcrlqlk+0azYrslJpTk5UTB02ESjBW7zFga8bNdG0LqLbA
	fo68=
X-Gm-Gg: ASbGncuwrdZG4zb3WpnkZn4KviRg4cNOVbKbR7spQtD3HFDCI0isVnqnOh5muICBGs4
	4nrv15zCDFV3vSeiXcAxWxsDUYe+zrSB3nrbPpOKYGLB0fcZGs/T+49MepNTDN0JV0sHrOG+Ihv
	2fOstF2z3oVeQctVsQqe/aQ0t9eo5BGEmhMppDk6n9BoNZClHrDqbBlLFssB94oIYo/39oO3U/K
	EWeKEMldVIWxkkxPJXULKWK61g/cPJT4KC4LYhyLTl03ufRU/1aTVgDll6CwQ0/Ga02A7EidxNb
	AVR8FbjU6BcbCHbIUihw4Ya60RnAwrtCLwc3yk0BRQ/AZiIyvchT4t3zc+X3wkWfh04TXUnWodX
	PvMH6JkVO5kwWuwoBJFgf5k6FlJAoxHCLIuVOfFHJ537qD4kH3BZY+65zrL3tgsHKA/NosUVHDA
	HRqk2ejctKOma8nNFR2UyXNtgf/LpWd+mA+crQUslLUPzbknq3L4XzMnDsqNPN+fLYfTZIQ1ZYl
	vTQhQ==
X-Google-Smtp-Source: AGHT+IFYIw13VDoXtlQk63b/5KG4IPxT+1NrV+wDMbuEV1zJs1peu+h91o1BYDRnx7WORcv1ndyKlw==
X-Received: by 2002:a05:622a:1a26:b0:4ed:7fe3:7be7 with SMTP id d75a77b69052e-4ee3fe6d6demr12492271cf.24.1763517828921;
        Tue, 18 Nov 2025 18:03:48 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee15455a4fsm74451791cf.28.2025.11.18.18.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:03:47 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/3] selinux: rename the cred_security_struct variables to "crsec"
Date: Tue, 18 Nov 2025 21:03:37 -0500
Message-ID: <20251119020334.521449-6-paul@paul-moore.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251119020334.521449-4-paul@paul-moore.com>
References: <20251119020334.521449-4-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16874; i=paul@paul-moore.com; h=from:subject; bh=CAFDFwa/BWmeH+XfuoEGsyTQg3yqUQ3CCvxI2GLzyFg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpHSV95fRmyHTUwPG8GK0fujyKwezccm+bfhrZI 6DlNkAbU8CJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaR0lfQAKCRDqIPLalzeJ c7G/D/9uVfxQrkrhYuxpGsq0Tkoq31Sr5STv7HkXeeA16ohp2tYftS1402uw12eVavtOqq4K9OK 2PXg49/R6J73eMflmMOkuDKvNTXS5btE/YwuzJgSSBmXtFIEULcqdRYexW0XHUXj5R5BOhwjZX/ XvozH2yk96ttTTAWsjCpMP44HTX7nrW8IIxy7RwFaYpeNMm3NWXdZqqUDxqMzOwN16WkzAfno4f UhNBLBSG+2UOfbJk2uMSB0jreanUmLWt4WnPLa+C9Y/Wxg6rs59Sj94xP8X5pNHspyXXOeHR2G0 J1IeAwzzPeUR3lDFayQVQhIeZPax9Q12Zyy2h90vk6o4kACT+GJ3bMG+yBJ5X2+BgMtBl1v5+PN 96MuQUD83f6quAcp5W3rRG+iV/DP2FY45m39nbzASeYjduojR4ibaySWFz8UxhGGkVwpgfZjvad XXZkzEAAOjuxteHZcM5vf5d/LnFUf8VZQNvLO2sfZReqsIA2SJcO9aaNOM5IHMGnHtrtrlLFeKj XS8/zuMLffAW9cPQtcOMO9QPNhs8SA9uRpk8wmOT64KAn+nwio0/zMREzFr4qNlXFMECAv6ZGmL xdebeEbfIYqKqpZZJ/xKE1ter8wzFJeP8i4JD8adrkcb3GJg1+USviIGUT1QCD61UdowLhAzNu3 8ioBB77fc9Ka2hg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Along with the renaming from task_security_struct to cred_security_struct,
rename the local variables to "crsec" from "tsec".  This both fits with
existing conventions and helps distinguish between task and cred related
variables.

No functional changes.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 154 +++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0ac4b05eb56c..49f5720a144c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -210,12 +210,12 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
  */
 static void cred_init_security(void)
 {
-	struct cred_security_struct *tsec;
+	struct cred_security_struct *crsec;
 
 	/* NOTE: the lsm framework zeros out the buffer on allocation */
 
-	tsec = selinux_cred(unrcu_pointer(current->real_cred));
-	tsec->osid = tsec->sid = SECINITSID_KERNEL;
+	crsec = selinux_cred(unrcu_pointer(current->real_cred));
+	crsec->osid = crsec->sid = SECINITSID_KERNEL;
 }
 
 /*
@@ -223,10 +223,10 @@ static void cred_init_security(void)
  */
 static inline u32 cred_sid(const struct cred *cred)
 {
-	const struct cred_security_struct *tsec;
+	const struct cred_security_struct *crsec;
 
-	tsec = selinux_cred(cred);
-	return tsec->sid;
+	crsec = selinux_cred(cred);
+	return crsec->sid;
 }
 
 static void __ad_net_init(struct common_audit_data *ad,
@@ -437,15 +437,15 @@ static int may_context_mount_sb_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct cred_security_struct *tsec = selinux_cred(cred);
+	const struct cred_security_struct *crsec = selinux_cred(cred);
 	int rc;
 
-	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(crsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(crsec->sid, sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELTO, NULL);
 	return rc;
 }
@@ -454,9 +454,9 @@ static int may_context_mount_inode_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct cred_security_struct *tsec = selinux_cred(cred);
+	const struct cred_security_struct *crsec = selinux_cred(cred);
 	int rc;
-	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(crsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
@@ -1788,7 +1788,7 @@ static int file_has_perm(const struct cred *cred,
  * Determine the label for an inode that might be unioned.
  */
 static int
-selinux_determine_inode_label(const struct cred_security_struct *tsec,
+selinux_determine_inode_label(const struct cred_security_struct *crsec,
 				 struct inode *dir,
 				 const struct qstr *name, u16 tclass,
 				 u32 *_new_isid)
@@ -1800,11 +1800,11 @@ selinux_determine_inode_label(const struct cred_security_struct *tsec,
 	    (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)) {
 		*_new_isid = sbsec->mntpoint_sid;
 	} else if ((sbsec->flags & SBLABEL_MNT) &&
-		   tsec->create_sid) {
-		*_new_isid = tsec->create_sid;
+		   crsec->create_sid) {
+		*_new_isid = crsec->create_sid;
 	} else {
 		const struct inode_security_struct *dsec = inode_security(dir);
-		return security_transition_sid(tsec->sid,
+		return security_transition_sid(crsec->sid,
 					       dsec->sid, tclass,
 					       name, _new_isid);
 	}
@@ -1817,7 +1817,7 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
@@ -1827,7 +1827,7 @@ static int may_create(struct inode *dir,
 	dsec = inode_security(dir);
 	sbsec = selinux_superblock(dir->i_sb);
 
-	sid = tsec->sid;
+	sid = crsec->sid;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
@@ -1838,7 +1838,7 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = selinux_determine_inode_label(tsec, dir, &dentry->d_name, tclass,
+	rc = selinux_determine_inode_label(crsec, dir, &dentry->d_name, tclass,
 					   &newsid);
 	if (rc)
 		return rc;
@@ -2529,12 +2529,12 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
  */
 static void selinux_bprm_committed_creds(const struct linux_binprm *bprm)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	u32 osid, sid;
 	int rc;
 
-	osid = tsec->osid;
-	sid = tsec->sid;
+	osid = crsec->osid;
+	sid = crsec->sid;
 
 	if (sid == osid)
 		return;
@@ -2911,7 +2911,7 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 {
 	u32 newsid;
 	int rc;
-	struct cred_security_struct *tsec;
+	struct cred_security_struct *crsec;
 
 	rc = selinux_determine_inode_label(selinux_cred(old),
 					   d_inode(dentry->d_parent), name,
@@ -2920,8 +2920,8 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 	if (rc)
 		return rc;
 
-	tsec = selinux_cred(new);
-	tsec->create_sid = newsid;
+	crsec = selinux_cred(new);
+	crsec->create_sid = newsid;
 	return 0;
 }
 
@@ -2929,7 +2929,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr,
 				       struct xattr *xattrs, int *xattr_count)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
 	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	u32 newsid, clen;
@@ -2939,9 +2939,9 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	sbsec = selinux_superblock(dir->i_sb);
 
-	newsid = tsec->create_sid;
+	newsid = crsec->create_sid;
 	newsclass = inode_mode_to_security_class(inode->i_mode);
-	rc = selinux_determine_inode_label(tsec, dir, qstr, newsclass, &newsid);
+	rc = selinux_determine_inode_label(crsec, dir, qstr, newsclass, &newsid);
 	if (rc)
 		return rc;
 
@@ -3660,7 +3660,7 @@ static void selinux_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 {
 	struct lsm_prop prop;
-	struct cred_security_struct *tsec;
+	struct cred_security_struct *crsec;
 	struct cred *new_creds = *new;
 
 	if (new_creds == NULL) {
@@ -3669,10 +3669,10 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 			return -ENOMEM;
 	}
 
-	tsec = selinux_cred(new_creds);
+	crsec = selinux_cred(new_creds);
 	/* Get label from overlay inode and set it in create_sid */
 	selinux_inode_getlsmprop(d_inode(src), &prop);
-	tsec->create_sid = prop.selinux.secid;
+	crsec->create_sid = prop.selinux.secid;
 	*new = new_creds;
 	return 0;
 }
@@ -3698,7 +3698,7 @@ static int selinux_inode_copy_up_xattr(struct dentry *dentry, const char *name)
 static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 					struct kernfs_node *kn)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	u32 parent_sid, newsid, clen;
 	int rc;
 	char *context;
@@ -3726,8 +3726,8 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 	if (rc)
 		return rc;
 
-	if (tsec->create_sid) {
-		newsid = tsec->create_sid;
+	if (crsec->create_sid) {
+		newsid = crsec->create_sid;
 	} else {
 		u16 secclass = inode_mode_to_security_class(kn->mode);
 		const char *kn_name;
@@ -3738,7 +3738,7 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 		q.name = kn_name;
 		q.hash_len = hashlen_string(kn_dir, kn_name);
 
-		rc = security_transition_sid(tsec->sid,
+		rc = security_transition_sid(crsec->sid,
 					     parent_sid, secclass, &q,
 					     &newsid);
 		if (rc)
@@ -4166,9 +4166,9 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 				gfp_t gfp)
 {
 	const struct cred_security_struct *old_tsec = selinux_cred(old);
-	struct cred_security_struct *tsec = selinux_cred(new);
+	struct cred_security_struct *crsec = selinux_cred(new);
 
-	*tsec = *old_tsec;
+	*crsec = *old_tsec;
 	return 0;
 }
 
@@ -4178,9 +4178,9 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 {
 	const struct cred_security_struct *old_tsec = selinux_cred(old);
-	struct cred_security_struct *tsec = selinux_cred(new);
+	struct cred_security_struct *crsec = selinux_cred(new);
 
-	*tsec = *old_tsec;
+	*crsec = *old_tsec;
 }
 
 static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
@@ -4199,7 +4199,7 @@ static void selinux_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop)
  */
 static int selinux_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct cred_security_struct *tsec = selinux_cred(new);
+	struct cred_security_struct *crsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -4208,10 +4208,10 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
 			   NULL);
 	if (ret == 0) {
-		tsec->sid = secid;
-		tsec->create_sid = 0;
-		tsec->keycreate_sid = 0;
-		tsec->sockcreate_sid = 0;
+		crsec->sid = secid;
+		crsec->create_sid = 0;
+		crsec->keycreate_sid = 0;
+		crsec->sockcreate_sid = 0;
 	}
 	return ret;
 }
@@ -4223,7 +4223,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
 	struct inode_security_struct *isec = inode_security(inode);
-	struct cred_security_struct *tsec = selinux_cred(new);
+	struct cred_security_struct *crsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -4233,7 +4233,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 			   NULL);
 
 	if (ret == 0)
-		tsec->create_sid = isec->sid;
+		crsec->create_sid = isec->sid;
 	return ret;
 }
 
@@ -4748,15 +4748,15 @@ static int selinux_conn_sid(u32 sk_sid, u32 skb_sid, u32 *conn_sid)
 
 /* socket security operations */
 
-static int socket_sockcreate_sid(const struct cred_security_struct *tsec,
+static int socket_sockcreate_sid(const struct cred_security_struct *crsec,
 				 u16 secclass, u32 *socksid)
 {
-	if (tsec->sockcreate_sid > SECSID_NULL) {
-		*socksid = tsec->sockcreate_sid;
+	if (crsec->sockcreate_sid > SECSID_NULL) {
+		*socksid = crsec->sockcreate_sid;
 		return 0;
 	}
 
-	return security_transition_sid(tsec->sid, tsec->sid,
+	return security_transition_sid(crsec->sid, crsec->sid,
 				       secclass, NULL, socksid);
 }
 
@@ -4801,7 +4801,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	u32 newsid;
 	u16 secclass;
 	int rc;
@@ -4810,17 +4810,17 @@ static int selinux_socket_create(int family, int type,
 		return 0;
 
 	secclass = socket_type_to_security_class(family, type, protocol);
-	rc = socket_sockcreate_sid(tsec, secclass, &newsid);
+	rc = socket_sockcreate_sid(crsec, secclass, &newsid);
 	if (rc)
 		return rc;
 
-	return avc_has_perm(tsec->sid, newsid, secclass, SOCKET__CREATE, NULL);
+	return avc_has_perm(crsec->sid, newsid, secclass, SOCKET__CREATE, NULL);
 }
 
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct cred_security_struct *tsec = selinux_cred(current_cred());
+	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct inode_security_struct *isec = inode_security_novalidate(SOCK_INODE(sock));
 	struct sk_security_struct *sksec;
 	u16 sclass = socket_type_to_security_class(family, type, protocol);
@@ -4828,7 +4828,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	int err = 0;
 
 	if (!kern) {
-		err = socket_sockcreate_sid(tsec, sclass, &sid);
+		err = socket_sockcreate_sid(crsec, sclass, &sid);
 		if (err)
 			return err;
 	}
@@ -6530,37 +6530,37 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 			       char **value)
 {
-	const struct cred_security_struct *tsec;
+	const struct cred_security_struct *crsec;
 	int error;
 	u32 sid;
 	u32 len;
 
 	rcu_read_lock();
-	tsec = selinux_cred(__task_cred(p));
+	crsec = selinux_cred(__task_cred(p));
 	if (p != current) {
-		error = avc_has_perm(current_sid(), tsec->sid,
+		error = avc_has_perm(current_sid(), crsec->sid,
 				     SECCLASS_PROCESS, PROCESS__GETATTR, NULL);
 		if (error)
 			goto err_unlock;
 	}
 	switch (attr) {
 	case LSM_ATTR_CURRENT:
-		sid = tsec->sid;
+		sid = crsec->sid;
 		break;
 	case LSM_ATTR_PREV:
-		sid = tsec->osid;
+		sid = crsec->osid;
 		break;
 	case LSM_ATTR_EXEC:
-		sid = tsec->exec_sid;
+		sid = crsec->exec_sid;
 		break;
 	case LSM_ATTR_FSCREATE:
-		sid = tsec->create_sid;
+		sid = crsec->create_sid;
 		break;
 	case LSM_ATTR_KEYCREATE:
-		sid = tsec->keycreate_sid;
+		sid = crsec->keycreate_sid;
 		break;
 	case LSM_ATTR_SOCKCREATE:
-		sid = tsec->sockcreate_sid;
+		sid = crsec->sockcreate_sid;
 		break;
 	default:
 		error = -EOPNOTSUPP;
@@ -6585,7 +6585,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 
 static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 {
-	struct cred_security_struct *tsec;
+	struct cred_security_struct *crsec;
 	struct cred *new;
 	u32 mysid = current_sid(), sid = 0, ptsid;
 	int error;
@@ -6671,11 +6671,11 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 	   operation.  See selinux_bprm_creds_for_exec for the execve
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
-	tsec = selinux_cred(new);
+	crsec = selinux_cred(new);
 	if (attr == LSM_ATTR_EXEC) {
-		tsec->exec_sid = sid;
+		crsec->exec_sid = sid;
 	} else if (attr == LSM_ATTR_FSCREATE) {
-		tsec->create_sid = sid;
+		crsec->create_sid = sid;
 	} else if (attr == LSM_ATTR_KEYCREATE) {
 		if (sid) {
 			error = avc_has_perm(mysid, sid,
@@ -6683,22 +6683,22 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 			if (error)
 				goto abort_change;
 		}
-		tsec->keycreate_sid = sid;
+		crsec->keycreate_sid = sid;
 	} else if (attr == LSM_ATTR_SOCKCREATE) {
-		tsec->sockcreate_sid = sid;
+		crsec->sockcreate_sid = sid;
 	} else if (attr == LSM_ATTR_CURRENT) {
 		error = -EINVAL;
 		if (sid == 0)
 			goto abort_change;
 
 		if (!current_is_single_threaded()) {
-			error = security_bounded_transition(tsec->sid, sid);
+			error = security_bounded_transition(crsec->sid, sid);
 			if (error)
 				goto abort_change;
 		}
 
 		/* Check permissions for the transition. */
-		error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
+		error = avc_has_perm(crsec->sid, sid, SECCLASS_PROCESS,
 				     PROCESS__DYNTRANSITION, NULL);
 		if (error)
 			goto abort_change;
@@ -6713,7 +6713,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
 				goto abort_change;
 		}
 
-		tsec->sid = sid;
+		crsec->sid = sid;
 	} else {
 		error = -EINVAL;
 		goto abort_change;
@@ -6880,14 +6880,14 @@ static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 static int selinux_key_alloc(struct key *k, const struct cred *cred,
 			     unsigned long flags)
 {
-	const struct cred_security_struct *tsec;
+	const struct cred_security_struct *crsec;
 	struct key_security_struct *ksec = selinux_key(k);
 
-	tsec = selinux_cred(cred);
-	if (tsec->keycreate_sid)
-		ksec->sid = tsec->keycreate_sid;
+	crsec = selinux_cred(cred);
+	if (crsec->keycreate_sid)
+		ksec->sid = crsec->keycreate_sid;
 	else
-		ksec->sid = tsec->sid;
+		ksec->sid = crsec->sid;
 
 	return 0;
 }
-- 
2.52.0

