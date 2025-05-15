Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FF298CA9
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314648; cv=none; b=ULtNl3cRtr0zRi8x769SoH65ows17aeKrme+BZaubeaB75YEt+H5IGACju37uQGdLhi0J/TQ9JYt8tFfiDzdjgczVfo6I7E5oS1fs/FCEv5nQeUCD89FWUWkO13190MUln8+j1WGkbt9blvfMFi2KeglrQrS4eaA15FShpnj9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314648; c=relaxed/simple;
	bh=WmaCCCJWSMFayBCEOf9nb+/jtCq7d8OYRwDbN+IEK6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoADqwGHCkdotvbKOwzoHPIfZ8Wf2ymPdEOzY8f8cvYvDB/9qcTjOmbUZArbTqAkc6G9yfAYZAq6NpqXfyjEFKMdNxKfY/krSvmlEvm1YAJsK26Zzm6Zxh6BSVqzH75hrTjGiDlD4fdni+3huteHdz9SmtytZg87Ek81+6FWTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRaodO4L; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRaodO4L"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so6320606d6.2
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314645; x=1747919445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYk3G+ZPE9cMhDuinovuYwDdR7KyeZiqHmtDo/bcL94=;
        b=GRaodO4LgNMEBh6jtb4v4WyEwidW9rkOVW0y20/xvvIzVlhBxRIjRwUlX4pJfL5FpG
         n9Li+MRnoGlnkz3OtK1mJcpF8OyihoWqTfvPnJQWqPsDiCCNI1ru1zkNJTw1BiMcXDeO
         qc5/3j/vQbGN8jczJeVf4VpNVhj5XxdeiH66hBalDcM94cvdfWdjQTQ6Kk0fGEZM0qzj
         NIlBHj0Po3ibWOwad0DgD2IgVniFbv7QaDpXUC/LkWXyqktUJE8Arik3T5eiD69LacKe
         gHCzIH8uTEjfzKdV+QkVhYdjOwuGe2tQABS6fNRMelLHizOMVZD56Dp9HCXlIB4bR+oe
         mgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314645; x=1747919445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYk3G+ZPE9cMhDuinovuYwDdR7KyeZiqHmtDo/bcL94=;
        b=aw89fnrYW0o+HAEvX5jEtJKj/5ld2dpHhj4xrHWVkuUkKArzv26er1TckRpMOqHUiI
         fTMo4t+yWHczcFKuW6QYrLCxYCRVbbR0qmIdQqKzu52VhnJWPc6TGLubAhx4y/dFmWBE
         xYmUtDxMe1ZaZynw3TRSBGiJhfY8nJ9La29svBwVMDuZp8qBKRLYnCqW0Ecfq12WkQ8v
         4pMpPGpBiEkJ9yZLgjWV7kiOajNLIHXc1StcUqbo7bG7udenKrOqZI+OJIAfEilShCj3
         IR0QiXLFE63JbK9DRskXEXGFsAqfdqIWrgjh92oQqZnxMJc0aybNiRai9S0AeynZJjy9
         cC9A==
X-Gm-Message-State: AOJu0YzLTGltVTwvUvzDBeMvw59ugrE2mVsxt9F0vKghxlZWmXPDXQpl
	YAynpA1D539WXVjE4KdVeX2L2WjCx5wu3mWG6ReTOTVA3bYssyckiEflIQ==
X-Gm-Gg: ASbGncu/EeLe7qT/67QROoc2SWpBJyU6mjSuKxwFfXgijAUQmDR1d4VGv9q9K//TM/C
	GXe2fRqJVfcsyFZ6JW7/eEB20MUvQ1F6cRH8h5SDCPSC0uhvZVD69gumnNhU20PbMJYruiqeZ79
	+dBVkX8lj3Xd75PPQzke5ajAqXL8zNJavsafsLTssa6NwstKsh3Yv+NjcSUfVFmFUCdBryrOj+Z
	ppWt1IoRjcr4UQZSSsn0ucXNbe/gKyqAfLMqtnN5ajD1vIBZL9pM9OTTtnr9rCkf3qZf8ksgB93
	Ic13PxHk+tKChe37NZDRlXqdHEjh8M18Lls9zl4S0f/84+miWKhkbmodG9s4R+tXEOZ+5aWJdPy
	yQc2Z0Tmg/FjbgIDRQd2F0HlkKPNbO/SC00AwhfOGPOqRYKUQrSyds1Vq922m3rrM
X-Google-Smtp-Source: AGHT+IFxNzLks4qxeo1sN5YKbvq77diKCZFK9pd6qZzc9EvNsUHy0EHNX0EvZYcjBo6DmKBjTaYO8g==
X-Received: by 2002:a05:622a:1244:b0:476:87dd:16f9 with SMTP id d75a77b69052e-49495c70b7fmr147984601cf.18.1747314645103;
        Thu, 15 May 2025 06:10:45 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:44 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 35/49] selinux: split cred_ssid_has_perm() into two cases
Date: Thu, 15 May 2025 09:09:33 -0400
Message-ID: <20250515130947.52806-36-stephen.smalley.work@gmail.com>
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

Split cred_ssid_has_perm() into two separate functions,
cred_obj_has_perm() to perform the namespace-aware checks
for inter-object checks like associate, and cred_ssid_has_perm()
to perform namespace-aware checks for socket and SysV IPC
checks where the SSID is in fact derived from the creating
task SID. Modify cred_ssid_has_perm() to only use the provided
ssid for the initial check in the current namespace, and to
instead use the task SID from the parent cred for each check
against the ancestor namespaces. This ensures that socket
and SysV IPC is correctly controlled in each namespace based
on the task's SID/context in that namespace.

We still need to determine whether peer labeling is correctly
handled across different namespaces, and if not, to adapt
appropriately.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 59 ++++++++++++++++++++++++++++++++--
 security/selinux/hooks.c       | 16 ++++-----
 security/selinux/include/avc.h |  3 ++
 3 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index cecbfea6b72a..24263b0b8e03 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1584,7 +1584,7 @@ int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 }
 
 /**
- * cred_ssid_has_perm - Check and audit permissions on a (ssid, tsid) pair
+ * cred_obj_has_perm - Check and audit permissions on a (ssid, tsid) pair
  * @cred: subject credentials
  * @ssid: source security identifier
  * @tsid: target security identifier
@@ -1601,8 +1601,9 @@ int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
  * DO NOT USE when checking permissions involving cred/task SIDs; this
  * helper is only for object-to-object checks.
  */
-int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
-		       u32 requested, struct common_audit_data *ad)
+int cred_obj_has_perm(const struct cred *cred, u32 ssid, u32 tsid,
+		      u16 tclass, u32 requested,
+		      struct common_audit_data *ad)
 {
 	struct task_security_struct *tsec;
 	struct selinux_state *state;
@@ -1621,6 +1622,58 @@ int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
 	return 0;
 }
 
+/**
+ * cred_ssid_has_perm - Check and audit permissions on a (ssid, tsid) pair
+ * @cred: subject credentials
+ * @ssid: source security identifier
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @ad: auxiliary audit data
+ *
+ * Check permissions between a source SID @ssid and a target SID @tsid for
+ * @cred's namespace and check between the parent cred's SID and %tsid
+ * for all ancestors to determine whether the @requested permissions are
+ * granted.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ * DO NOT USE when checking permissions involving cred/task SIDs; this
+ * helper is only for socket and IPC checks.
+ */
+int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
+		       u32 requested, struct common_audit_data *ad)
+{
+	struct task_security_struct *tsec;
+	struct selinux_state *state;
+	int rc;
+
+	/* Check using the provided ssid in the current namespace. */
+	tsec = selinux_cred(cred);
+	state = tsec->state;
+	rc = avc_has_perm(state, ssid, tsid, tclass, requested, ad);
+	if (rc)
+		return rc;
+
+	cred = tsec->parent_cred;
+	while (cred) {
+		/*
+		 * In all ancestor namespaces, use the task SID from
+		 * the corresponding credential as the subject SID.
+		 */
+		tsec = selinux_cred(cred);
+		state = tsec->state;
+		ssid = tsec->sid;
+		rc = avc_has_perm(state, ssid, tsid, tclass, requested, ad);
+		if (rc)
+			return rc;
+
+		cred = tsec->parent_cred;
+	}
+
+	return 0;
+}
+
 static u32 cred_sid_for_state(const struct cred *cred,
 			      const struct selinux_state *state)
 {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index df4f74c6cec0..b9d1600b6340 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -470,8 +470,8 @@ static int may_context_mount_inode_relabel(u32 sid,
 	if (rc)
 		return rc;
 
-	return cred_ssid_has_perm(cred, sid, sbsec->sid, SECCLASS_FILESYSTEM,
-				  FILESYSTEM__ASSOCIATE, NULL);
+	return cred_obj_has_perm(cred, sid, sbsec->sid, SECCLASS_FILESYSTEM,
+				 FILESYSTEM__ASSOCIATE, NULL);
 }
 
 static int selinux_is_genfs_special_handling(struct super_block *sb)
@@ -1848,9 +1848,9 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	return cred_ssid_has_perm(cred, newsid, sbsec->sid,
-				  SECCLASS_FILESYSTEM, FILESYSTEM__ASSOCIATE,
-				  &ad);
+	return cred_obj_has_perm(cred, newsid, sbsec->sid,
+				 SECCLASS_FILESYSTEM, FILESYSTEM__ASSOCIATE,
+				 &ad);
 }
 
 #define MAY_LINK	0
@@ -3473,9 +3473,9 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	if (rc)
 		return rc;
 
-	return cred_ssid_has_perm(cred, newsid, sbsec->sid,
-				  SECCLASS_FILESYSTEM,
-				  FILESYSTEM__ASSOCIATE, &ad);
+	return cred_obj_has_perm(cred, newsid, sbsec->sid,
+				 SECCLASS_FILESYSTEM,
+				 FILESYSTEM__ASSOCIATE, &ad);
 }
 
 static int selinux_inode_set_acl(struct mnt_idmap *idmap,
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 511847a6b11c..64982cc8d17b 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -166,6 +166,9 @@ int cred_tsid_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
 int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 			       u32 requested, struct av_decision *avd);
 
+int cred_obj_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
+		      u32 requested, struct common_audit_data *ad);
+
 int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
 		       u32 requested, struct common_audit_data *ad);
 
-- 
2.49.0

