Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58525B1D5;
	Tue, 10 Jun 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576216; cv=none; b=lNzoW2vToG7zcFIJxoPg9w1NYSqGbrx617FAhrzWyVRldKK9swm608HsSo+bgPCthQEMMYbjl9JqsZcl/Q5HmB43tXxMPAHuCWWyfchg3JwQyxygVGYYNskPDH6+QOhimnvzhJ72c4br4mTfQ4l6JS7YW2JseL2axHXp/LV2Mlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576216; c=relaxed/simple;
	bh=U4eivmSCHabqk4GZ61VKu86FdmU5bzu5xl0J6g5Q/c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aa41HXRsi0I/eA0OuPfXSoQQ3usZasNRfvW+BLVwQDzXc18Mh8lPj64ZH7WwzuXpt+O69v3TjqIlpAVAok9K/HPpBqkiGf2LT06ZvgDalKINYAeSOaxtHfeuXV6Gf1z+yXrcsE7kWYdEaqVe9QHXSTmLo77N6i1te5L1iSqYmVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdCWZ87x; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdCWZ87x"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d21f21baf7so527930085a.0;
        Tue, 10 Jun 2025 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576213; x=1750181013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KW+3ykHiuB10D5XPwEN3nTBDr0ls873OV8GIYEkdTNA=;
        b=NdCWZ87xO+AjSD4qavKgiHnRmqGGNMaggJBOxFRD2nEr8jBS7kUexdECkhbZQ1Kcp+
         ngHKMA/vpSdscnBWVHe7r1BFFiEULfSUBsFMtSB4PP2DjQv1HpqC6Aa4f0j0Y8MNNdMm
         +e7nFIv+dFgUK0cb9WgRLSS8NzZa4ggRw2YPaNQCKxnPtYvnrR2XzQy2xemzhhnxQsob
         v/aQHHrlBfCoy0vY/ixYaEBKoFw0Bk0kgVnORlE41fCdhUv9eH2UuS61kAAdZj+bqcFa
         P8w3p1RDrKA8diCiDKkYW8xJ20afH5BgaYu2YVQGztkK6rrXlPN6pzFeqBm83ymPHXPN
         Mn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576213; x=1750181013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW+3ykHiuB10D5XPwEN3nTBDr0ls873OV8GIYEkdTNA=;
        b=Am/Gm4KF12nDNms3fsGKOEuHrKcmmuryhrBK5sz2xCxoY8TwM9jelM+Hv+z9HqVjup
         ob2ZNsqKyCYhDdWlmewBruYwdCBQ4OP4rbTCWMDCLkoW/M4+GqiQZJqnjpTQNxxmz6e/
         3FB5uH8UR91gRKHL7iQ3PSbyyhMbdOQGkDQQGAPOTcWHoE1fahuhU9/6tFz380ZK6g2o
         8LlVTpSOa6TlMLroo3RUJ4MI5VZtrps+xe5VHD6y/hXHgGjCm9w8I8E6OdLsZORwLtzB
         Rd3exvn4hVfu4ftmx/DFcT6vuoCaVc1Hm6WLTRf3OoraWyQ+x4RBe33zKnnoQalY2NEg
         m5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW662u8KaGam/FEgsnYiYBiuiSrKb358WQf3SmbtfzCo9FsYBP+lkLa9VrEZj1axlb3c+S7zQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRLkplE+vsukhSGfWdiTlBZFllpFlygpJCX7txBGLpQ3duqNJ
	d3M7HIVvzU1zD44a0nWXYf9KZK/3ED2+vp52IV9RKI8nA4OX83Cpv34oHUP7KA==
X-Gm-Gg: ASbGncscQgnX1q0QPStFBw/DeG6FHDJmRYb3hTo1ANpL9RWj9spCCiHUQ9hvPDCzbyj
	SMKJi4wgG7/BRwN0TWtP/cJRpDREkZuMnkJ3MmZebhSqDI1nIau381bWiRTNgiazym7iKFQTnxs
	nQaZV/lE6C8pHcFmnv2VqRH8bbHB54PzS0qzPICeehATjecLGdnCTFT0Pt6PqKnBXfgWWd/M5hX
	9kwwEtgDfgYeGrBulJ/aLVplh64LSHOQlsVauqTE91gOWo4coD7ueu8u8/ErdFR3/TSaD7H9qz0
	iZbxpYlsCUyIpybRB66O18Lfu1mTOd/gU/6f+qB4BEhxAk/j73slc2i3HAcBirms3BDwgFyGgSi
	zAUJ8SJLJpwAKdSV/wwRnmYJq2w0JJ3rD90hnNVbUTjMtzbh1IXgnqa3gPxpH5FhYYQ==
X-Google-Smtp-Source: AGHT+IFiCMUtyuI6MYzyVL4AX4+xBf4MUAPGHUncxsB7pE1i1ebvEUOMI8qHSMHoXaRy3IDQdDu5yQ==
X-Received: by 2002:a05:620a:2956:b0:7d0:a0e5:87cd with SMTP id af79cd13be357-7d3a8805f47mr31885185a.4.1749576212785;
        Tue, 10 Jun 2025 10:23:32 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 40/42] selinux: split cred_ssid_has_perm() into two cases
Date: Tue, 10 Jun 2025 13:22:11 -0400
Message-ID: <20250610172226.1470741-41-stephen.smalley.work@gmail.com>
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
index 35cd0c9c9d41..9a76266e8305 100644
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
index c30df3404754..c5ab227e0ffe 100644
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

