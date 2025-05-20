Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E74289366;
	Tue, 20 May 2025 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742517; cv=none; b=Xu337plROAxp95hAufrArxNAjspLVWLp4x4pHRRn3Hd5SHgA1EacwhcvTmYNjDO3Z6vnswy3fZEVuwKMf3uayq1kvVBqYUtke4Gncuu+w5ikqho9hdvhMozStPP7QXl3GnRbPnsdDENdZxXNBb6chbaiZUdFrGzJcf7s91uCQOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742517; c=relaxed/simple;
	bh=KzxLbSzHohR1f0LYXmyQSwhLVya9/DWh8JWgbU0Cs/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSBZyMR2VzIhPObVQbG8Huv7oWAb/m8UwjgMUKg3SHM9tRcVDp99ZnCDudKDpOXq5EOgHfhlFWTfSqXq3Mnlwa5ypvxvyHcheuuhIxt1RGSUhuncG1ZBbSeK5VoHo+kopAjW2ECocoKgbcVgy9vrKH45g54B4qfVSPd9jdaW2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf84I1mz; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf84I1mz"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5f720c717so781617685a.0;
        Tue, 20 May 2025 05:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742514; x=1748347314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROuyiFA96AMF/YhIXHwKbC7UIid76V6BEwqUHst3fgA=;
        b=Vf84I1mzkEoXig+W6Eh7ywKypUs/jWIzAURNsWVHGEejkloiYywHdfxJNqil8E+Su4
         FzhuDEa1rVYp4Tv2X1qrT53B7BAYZ7hvnt0YQiWnb6gRtHUBX4y4oftbkkrsOs2IuIss
         jCiFZ3KTNuBFabEBw927g56tRzFJucmQ8iugxnmm96eIYO76BBDYu2On6nD9IRN+0TaJ
         m3GWLRhh7k7ZkLZ29ZmJwD0NzFbSIUiO8EZJXW545zsgV0nVXLRgRzwystgXpYCMQYO0
         tHVnwIMBscuj9WNUNdhePr7CBvfMMS+Sf6QgNkj/vtrgUaZajXc5kA0WYWul2eX1LfHr
         E0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742514; x=1748347314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROuyiFA96AMF/YhIXHwKbC7UIid76V6BEwqUHst3fgA=;
        b=iqD4WHfks3qOx+n8QueHBfRcX/FDDHTu4qBRiYf0bR6IIfpBKFnX1kkfKzfShcLdiS
         ZjbR93gzNDw04H/Vr8/SOLkKQL4/FECx9pL3BeEWAqEQ3Ot0501UNIGIbLX1vpw9FgPe
         Ccchx/GGPeL1ckA+c0T6yRdH3UF2XkRJ5Cuc+OrC0v6hUqMai+LRbBaUilYrs3g2pwxT
         /hzoSWD/H0vLj7IKeh2Zm/UEuumSLZ/5DrHK7RNPxpRr6b/lvEwN7wp3ju+D5n/GxiWE
         pIERzu11xEn0V2qarPaLGYTo2nVfzeDbPyl+A4LwRITV38Uqg6YzsWk4/IhHYFfHNMUw
         Q2EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF4AuyEiXTRTaFnIPmtGhN9ShgARXYCoWOjV6esN08SYWmPU6cJTmZscPdckzLzEcTQCdsxs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7JA8FtYeTQLDhzsSxLP+X6JI4jwuxxGOvNFeVytTkBNPsy2Xk
	uF1r/I373mqTk7xC28YJpCOw52kCsks6l9CBVTab9g9Uy5jMV6hDQM62LSgYsg==
X-Gm-Gg: ASbGncttZYjqACW3H4di366Zbt6UzZHqjoLJAqZWlhOfUQSE/FTzopU08wGbSvj4I5T
	iwu9XA/WdKjJBUVw+oqmVXi1s6yov5c4M8jgvm4KZ7Yz6EQRE+gaAL/AKmRj11UlujMbJgNc0CY
	WdkVQ/cnKxl5gxG6Mw7cKwBuOJKO9t7EhQwJd3j+yg6mdjAJ8yrNCf31955bmOEaGiuZUZIVr7/
	q1uiug5DPbup1f8Fsj9iO5z1NW03EzWvoRoj4KC/uQ0SGqS7AaKamv2K69RJx/5+DooFOFnR6rA
	wf4bdNtZ1UXHgCVCGmB/yI7AgLscRUXvhBdmdx6Fsvpnswu55YuISOuFPxT3eT1XbBXZHzXLfem
	civcjLqtoBkgA6V7q4tdvhuQN9HZxugofhQk9CgoiylDVjcLy1NKHaA==
X-Google-Smtp-Source: AGHT+IFY3IuGngb2GENIn4Qqjx6I7KOr9Q/xRqbpf5vWD0cPoEH5IuFgdIhhr5/WvhAh8cVXRoFVXg==
X-Received: by 2002:a05:620a:1985:b0:7c9:38ce:becd with SMTP id af79cd13be357-7cd46b6cac2mr2571560085a.22.1747742513995;
        Tue, 20 May 2025 05:01:53 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:53 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 39/42] selinux: split cred_ssid_has_perm() into two cases
Date: Tue, 20 May 2025 07:59:37 -0400
Message-ID: <20250520120000.25501-41-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index 850533412896..deba2b4d81c9 100644
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
@@ -1851,9 +1851,9 @@ static int may_create(struct inode *dir,
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
@@ -3476,9 +3476,9 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
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

