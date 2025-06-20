Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C12F2719;
	Fri, 20 Jun 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441553; cv=none; b=Vu9aybftuimmsKRiD2Bwc6wGGXinaR8wG3y8Ao8rKzxcLhIYgXKJIY4bAkRU/15F1OoAi/5HEX2XAz8afpHs2dHwoninVyiKE5zeUNjR3Hcb8h5I3KcGfrMATKt8eMZNYqYavWQT0TVo52KerNeRUwGeltq2svOPD8PmrKmWO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441553; c=relaxed/simple;
	bh=wL83GwKhkHnnoyftycHd5+yDTZhwCw9Ya11H80ulRaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJ53cpFhzb64CSHorjMZVWS24c05y0t2eKh12G2OVUJ3iFkGYuZoVIOieX2lXvBKQYRHMd+cDY3CN/v5xsMQe5VHySOzd19LNPWYfFGQ6b2KikRpzJ8RQhY4yEe2soLNFJjjDqTzmOX9ht6SwPFD/KqkFcfWaA1JC5C+2fDz5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED0xuG2y; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED0xuG2y"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d38d1eae03so178170485a.2;
        Fri, 20 Jun 2025 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441550; x=1751046350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1qpXssFoBqxrAhxlWo/EoS/v4c2bfRdIrs8ZQcPDi8=;
        b=ED0xuG2yhUUcEpVVy2VxsFwx/Kgg/oc2HiVgAV+jKdq0kgyk/6e8Qvvt4dfb2Ba7qt
         LfFkfInz2Wt83fJKM+PAmECykskwNHVl6XCYwAks6xiGD20Bs1b8U8tG204xor05qJQm
         1jPseajjiyVC5BzJtiQhh7RlgZ6UqTYJfY05Rvg/ZtO2SXqyhMEMO7L9+pKpdmypc53e
         qvpJedXqBvKfm37auDSZ2FR0x6OmMV+FuX9adBjxt+GlrIuYv6jO/CMOkI9tX8oSZgC6
         DdYyxcpBV6WRdNBzr0rLzYrOxRemUQtKLNEwXZ7mHiuvMPWF2cWoDPc18x264GkFe/F8
         UWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441550; x=1751046350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1qpXssFoBqxrAhxlWo/EoS/v4c2bfRdIrs8ZQcPDi8=;
        b=Un1grZq64Yvp6SvuzOW0zbJfydRMFaHnF/WD9JVDVyR78zTqxw+7leFxFPkuKLLcUn
         a8x6BNNRxWyM7lpsTXUJqBpASEBb54RDOU3B2aYtAuULHpC+8Ev27J5kZRKbhvjK1Mxt
         ytXXB8EyvzvCxE99EAt8KRSPTkyTnonB25eP5Qbwn7yg1/fLH4Cp1Re+rj0etwHkmArA
         KYEXlYQ1C7Gz1DvbGq28MAZGu/2nyvz+COLcAvUyagirZuVmHosZp9/dk0wjoWKxK8x2
         dZbJLaHGzaAqxKNIidfJ8orxRImXcsB3hXJT10a6FMs8tGHE1BAzHC9KEqU3f9kkYT6T
         mzbw==
X-Forwarded-Encrypted: i=1; AJvYcCXU+DLC0W7X5RjaTICDDFWG60Ba/hn5aU3AlD1rW2/sFG4LgONKaIDBfR8raC1MLgRrgxrvnp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22k4hHqlZox+U5ufjsSAvuJWnmfxQaTe1Vji7YzM9L7hfhkDR
	yNXswVtk2ND3LEAojQdVAyRXoDG+lzjYEAgyIlMzd5UIQZGJa5j81Kknge69fA==
X-Gm-Gg: ASbGnctecswclsgPgWrbNT8SDjcb3RjD1cMYY9HEAIA4it6T68rV7HOCvUn7ghjoZQ6
	c1Xzb09XUdJWmTAlvX4WobNcgJMnCKeCcdekrxUosSLa6k+szSFR8K8u8NMZNYiQTbnHZB4hs80
	CPbhFSAbFNJIhZe5AoYdL6EvzLYpHeLDuQD3jWc96728jDMvp2Om/QXAAUYii8wN9+dNIUlQF4X
	JZipJlY0u6YevycLGxyJXB1rTQnIb3W2RLmV0nTTQCCt5BeHDrI7z7dKs9ezG2K2EaCFV/r+3Lu
	YVYJT7pZ6TvO5Gdcf8qsJSeFsMGIkXYBqAdxIe1+eEr93QLsSNGOEko6uoWC/avpkQQWvbIRNZP
	dTBWly8espA0wvE6y6lGyqHZKkTsMg5MLBtqG5O/81lTo5IHmB5TcW1o9dUVHZn43Q8CAnyYYMF
	E8
X-Google-Smtp-Source: AGHT+IE//WlFoycTHBvywbmlPuFWyTOrFGtP35E8y7ef/VK9bJ6xB7ifoPVUNr47mEhfxIhAqYoTZA==
X-Received: by 2002:a05:620a:8812:b0:7d3:b0b8:887b with SMTP id af79cd13be357-7d3f9920e1emr498997085a.34.1750441550386;
        Fri, 20 Jun 2025 10:45:50 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:49 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 40/42] selinux: split cred_ssid_has_perm() into two cases
Date: Fri, 20 Jun 2025 13:44:52 -0400
Message-ID: <20250620174502.1838-41-stephen.smalley.work@gmail.com>
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
index 5b690194b86a..ac2fc68d9460 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1595,7 +1595,7 @@ int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 }
 
 /**
- * cred_ssid_has_perm - Check and audit permissions on a (ssid, tsid) pair
+ * cred_obj_has_perm - Check and audit permissions on a (ssid, tsid) pair
  * @cred: subject credentials
  * @ssid: source security identifier
  * @tsid: target security identifier
@@ -1612,8 +1612,9 @@ int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
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
@@ -1632,6 +1633,58 @@ int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
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
index 678dbe85f040..92d756cfd0bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -469,8 +469,8 @@ static int may_context_mount_inode_relabel(u32 sid,
 	if (rc)
 		return rc;
 
-	return cred_ssid_has_perm(cred, sid, sbsec->sid, SECCLASS_FILESYSTEM,
-				  FILESYSTEM__ASSOCIATE, NULL);
+	return cred_obj_has_perm(cred, sid, sbsec->sid, SECCLASS_FILESYSTEM,
+				 FILESYSTEM__ASSOCIATE, NULL);
 }
 
 static int selinux_is_genfs_special_handling(struct super_block *sb)
@@ -1857,9 +1857,9 @@ static int may_create(struct inode *dir,
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
@@ -3494,9 +3494,9 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
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
index cf437d0479f5..ce3df5a674f5 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -169,6 +169,9 @@ int cred_tsid_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
 int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 			       u32 requested, struct av_decision *avd);
 
+int cred_obj_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
+		      u32 requested, struct common_audit_data *ad);
+
 int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
 		       u32 requested, struct common_audit_data *ad);
 
-- 
2.49.0

