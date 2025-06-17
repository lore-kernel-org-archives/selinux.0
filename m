Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B82F3622;
	Tue, 17 Jun 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169216; cv=none; b=c4nlM4q47HHCdXS33F0EEQe3opcVhkxGJpMh+MzooxJloY4uomSpBpL5NFg04laJvz1zCwJl3SEWPbmnjtVbIn2r64v66RebraOZnFeJsGO2EmOcxTg7Si8OiIHDsEhCC6gvbbKWfSVQT6kac0JWgEwTM6Gxd/t1EiO9uHHffhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169216; c=relaxed/simple;
	bh=o+5Go2LMeJu+XzEV/cVRdeeXXZkL1EKT7vnY2gInxFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB/ebZZCQ35fo7niKBZjojB3BqLKgDM21I2b0mHe6Vo0J842Mql6D8Q0xdy07j95ku0REIoU59xLaLxFt9vpW6iSdEflRUZKM5CQht4i89bh2EVu1fgP9/2Q1GITMOVyFs2NzDjMVAVMeXis2jgo8yN2CpX/cArptWPWfK8OMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AanFKT/r; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AanFKT/r"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d3939ecb7dso598427885a.3;
        Tue, 17 Jun 2025 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169213; x=1750774013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeiluqlflaTrKlx/Y/5U2G3bLyg7cFiddbDsoLtR4oc=;
        b=AanFKT/rpcnWKndUJ5888Rqs1j3Niq8Hq/zasOqPQsnKA0+mVsTGEzSnTssDGc1IAD
         jOgQ7VOxM8JWHAX9mkyBApntwzx+mNs+mxdMdX5c4IAWACV1aZnf8sec1guwxoIy38sS
         wjaeeN7URSnlxuFbF+10/OjDHjsxd1mjU9Q15mQ6UWVjagaGzjeTPbtU/fYCa8u15QKh
         SNlHMQIFrnnTc+YO+3PVRUcuJuPmU2VypaS1smg0Q4GGey5PbohsIiDdcx+9XvTyZEsM
         MYuVNBinzvLcUlsx8Lao7nPaJJ+b4OkTRSLm/n9THXcRRME8ppz1FnRn+Vyv9P3KH4RC
         qJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169213; x=1750774013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeiluqlflaTrKlx/Y/5U2G3bLyg7cFiddbDsoLtR4oc=;
        b=o5y4X+X/S2TJq5IdpYbRQK+2mMeWS59D+ewyKjLtFARs7mKwjEIdkugtwbbKIq0zf+
         RWLFI9mfd2PtbTQqkwCkwpC13YgrY2jJXdeCnunUj63zJkPpChRah0wIw7sjzEqWacRf
         U40ZYUtEbhKiv4rmtGUTNBewJLxAgJtyhKoqvNQyIFIVcooVzKSANHYw3YEfmhDhqEaI
         ivlwiPtD1tTKx09N4hJuQrN8owIvl1hDup3/8cafODyJt0EyqxVVP2jr4w54ZQG43buK
         p46510KT5ipGlkTIOwGTHcGTIyTw2soHjgjqjQuc787PyS9Rgpc6Oyuk3ap/NWbUBrFt
         cyLw==
X-Forwarded-Encrypted: i=1; AJvYcCUz3Bp2p+e6WeLVbazjooF8u+ALT2UV+2hBiXCMhb82hV15QiJoCauqwlwlhb7zK1F5Kzr+CNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcR48bwOGIjzznbtqzkTCC+YSIcfI1YHAuc0BqtNmp4otJjXpi
	Iv+6UhfTsR2lyq0ZWEHI6dE4hKTH+Mi8stW9cHeo0rf64RPbe471llhpfi33CQ==
X-Gm-Gg: ASbGncubTma9x0EFLu7Jz/gVPXK8qO/UuTKw41i0RhjF37HV0CRbgYDtcDRaY9+LfvK
	QJiwrp8dYXnmBv9DWbmv/omtieKj05vLjiuKTHcAjRPZdH0hjFYEPzvxqfy9zK+gWTXjSHH0zGH
	By/OMV7BPLw2CEfsWu++6C5qiSfuNW/foOvXJFUHlVrgiOcaxaGmB0a6oO6KcT2EEOfjPW82OGu
	HSbp+KPDqaESKy6o9+aEJNEi1Q7i39cDvKwvOH9vXwr5lJreuhAmsrY+kcTyAntrKVwHkRCGRCU
	jYqd+wQ6U+mOO4fJFThIwzHd3IK+GL18BVREuh+ROizc1jA8GgU1Ug4+dPiMKTzWHk5gYXgbL2F
	IJ3ME8QdF6n0Vl1lxNRD+s5Z/R8vlotDwA8XiQU9juodcTmDl0k9hfAMzHxuyXwUUhw==
X-Google-Smtp-Source: AGHT+IEM9s6yflF1byJxvF0JzMmOkUb4Y9ok3lpLtwE2DxOJJIU1lbOc47QFp9VOHepJdLvJhA4L8Q==
X-Received: by 2002:a05:620a:248e:b0:7c9:3085:f848 with SMTP id af79cd13be357-7d3c6c20410mr2164217685a.13.1750169212928;
        Tue, 17 Jun 2025 07:06:52 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:51 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 40/42] selinux: split cred_ssid_has_perm() into two cases
Date: Tue, 17 Jun 2025 10:05:27 -0400
Message-ID: <20250617140531.2036-41-stephen.smalley.work@gmail.com>
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
index 155409ad7e23..5f27d2932e4b 100644
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
@@ -3482,9 +3482,9 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
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
index ffb8946dfeda..8ce75a5ffaa1 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -165,6 +165,9 @@ int cred_tsid_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
 int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 			       u32 requested, struct av_decision *avd);
 
+int cred_obj_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
+		      u32 requested, struct common_audit_data *ad);
+
 int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
 		       u32 requested, struct common_audit_data *ad);
 
-- 
2.49.0

