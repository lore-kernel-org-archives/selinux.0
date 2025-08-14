Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9D309DC2;
	Thu, 14 Aug 2025 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178064; cv=none; b=JjWZ0x4Ru414sAoHaxPcTBjriMxyRjHHouik7VRAbFNQXKYw6+CkXwNyp3HyGT7i0rIbUdwButsCvZNZ4Y75aYMT50l9WMdEHEBbswYKDNo1CU9Pp0wC5ja6GKEqZG+gKLN7HNQOLZJ8pNZ7NxluCEwyOI2Dqs/fxveSXETm4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178064; c=relaxed/simple;
	bh=ZRM87kMs1bkaEU+nblnk3mLM9o27gumu7ieuqeKQDuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TC9Gef0I3RDt4VyrEL4ZI/67+upoRQxF6C+wKy1FbAk0UXBF5Ks6D3Wc0q0l0KwV4olKEkDjBeBRNRmFPFH/zZuxJT3bn7EHBbriSzx5R823J8W7/SfO/y34hrem+mWE7hEBqiWsveBmLm3u6p1epqE5nJhvuBO8HBdqVIxD/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaPoL1nl; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaPoL1nl"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70a9282139fso8197086d6.1;
        Thu, 14 Aug 2025 06:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178061; x=1755782861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7MlOEomLy5FiDaEcqCPVFI7905wq/H8JvMH3jzaIYE=;
        b=HaPoL1nlzZIRul+Gdi4mjZBXI4hY2ceMO+0L4Xr/AXUn6UosIntRvRzmd0VX4VIyAE
         scpleX98Z1R36pBRsL2yqQOW4qvu7DFngNGKEBd0NuFqztbtWDxgq4Eg286vmW5D/dQ5
         4RfNXijAxSfHGAXEmDC+dbBcBGcPpNY0aBN9Lgui1HRdbO40axD8gWGjtzriBBg53y74
         Jduwym+/XHapX6UGDHTleNReigUhHovHgZ6scPRsIzNawNoUxqv2kriTEU2SPfB5JKz1
         eJkN3zyBKfXWSUhz44kdoYzKSPXRYT2AFSTc5ox5Yj4bF2TzRpppn05R7nSgYKPqAQDN
         87hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178061; x=1755782861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7MlOEomLy5FiDaEcqCPVFI7905wq/H8JvMH3jzaIYE=;
        b=DjZxp0Nyk4GjmeON3NnpV3RPZPxpF5ygvaNLtt8WvwMAJorw0iOTUBSroucpd0mpcR
         yTQcwUI8v4rfBGmiggHUCQM72bfNuULbdb8ngZid/dddiHukI2kKnTKs4P5DbWcJThny
         fB1C/4s+xQ7scuOJK9IF23Jm2D3upDomhwJjhB6RVtO2dhvViF1iRIHKuREOSerO/wze
         CKyzOXGpJUcIlHUBXVoidOeyrXIeqtWzMTQbWCkJKFV6ZdUTbLtbkblIuMKG4zU/DiG9
         6RWCNwDICGn30hGy7DdZ7/HRPx5BFd24khRTGtXhyzaaO6zcBcH6f1mMKyU6FqH3gT31
         V09Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTkzVBBx7t94l/2/nPB+5Tdp7U+jZb7JJmUkOBwPFjGaY9X/+4lTW5v5vq6N69r7zq8oNBxak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZ9gKrutOUxaEU9vg2cyXJZrwfH5IMm8QtPg1oM5QnijnZeRB
	iubUFjhmYztSrfiWs/FBL8SdWf7/zBF6EjVSlITi6l83WQIOZZ1VZvOCRIBzJA==
X-Gm-Gg: ASbGnctLoiwl8EussptooQ3qmtz5Mq4gzsz6gMEGCgIRmxCEhJC0634bVEODQWoCZIm
	xOJos4BMbwlSqNl1jFWz8115xZFDbfTbnhrIqLTZbT/5QmPE5j+fuEdbfyDZb3Sh7OyoSksm3UD
	GmBhPzzYa7Et/f1kc0xZ9zbXt/frBI21qV8giiAmlo7sbE/ylYZSUIJICOARGd8Qp7tGMRysEk1
	K0pRUQH5T7BlRJ6Y1X1ddDI5B7XPWAMohMWL6Z13yvevwRx+uk6DbO9ypvMYcLUin82LY7b8eHU
	+2bW62TDvC2R0j3+Bao2Ztpie7LAznc4nJADv6QwL5irBmYoKkrIjnq39ZKGTqrawE5NaF+sIzV
	lijMN1PC2Z19TTz028U25+vrheIxbXU5xIKDwqiRS/ECQ3KRbZM1u3Wo8+G24Va31csdVtyx9gu
	iMcbHTruT6BFmljytvEM97ba06Cg==
X-Google-Smtp-Source: AGHT+IG5GKD8e+dHkAzsmWsyHtbrAcMBPJ6c1eNSy/d+Rx2uVRZK/uniS65+Pjfofer/2WVHNKPDUA==
X-Received: by 2002:a05:6214:f03:b0:700:bc43:27a3 with SMTP id 6a1803df08f44-70af5f0f2e7mr48978556d6.36.1755178061481;
        Thu, 14 Aug 2025 06:27:41 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:41 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 40/42] selinux: split cred_ssid_has_perm() into two cases
Date: Thu, 14 Aug 2025 09:26:31 -0400
Message-ID: <20250814132637.1659-41-stephen.smalley.work@gmail.com>
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
index 1095b7720eb8..fe77af02360b 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1594,7 +1594,7 @@ int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 }
 
 /**
- * cred_ssid_has_perm - Check and audit permissions on a (ssid, tsid) pair
+ * cred_obj_has_perm - Check and audit permissions on a (ssid, tsid) pair
  * @cred: subject credentials
  * @ssid: source security identifier
  * @tsid: target security identifier
@@ -1611,8 +1611,9 @@ int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
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
@@ -1631,6 +1632,58 @@ int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
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
index d83b764ab86b..b22dbb4a1a05 100644
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
2.50.1

