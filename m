Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843921487D1
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836364; cv=none; b=Qdt3ohv3VeM7PuUbSgshUd9FLKFbL4Zub+5JY17OzoA2RcEcGE5gNa06aiFKS3JzPtVuA+Eg2iTAqCbiAkRPJPvSydxmrT7UObJN+GbVcxXFPAwwPgfWsYcO8k21eKhaFIMTRU83SHU1JOcBOlxfhsxOGPocsmyEpId8LVT9qmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836364; c=relaxed/simple;
	bh=jJYRPJO8GkRCzfd5ETPVYCTf3CrT+rBA4AiojXX8088=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GexXG7DBrSyj/aaQvTakcTsBPtXGOLzyAu5Tb7GM6pt0fDiOutTq0rnOKYXg1zL3bu2abcF8GPxWeiZYh07J3oOZTnUIhqxnPSgG4ZPciS7TspTigiAT15FHyXbhaWjDhDC3DmeyBmmzjHgdhvTDwe6Y8X1zdfsN3nCX0jwWjoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZ9S6Uvp; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ9S6Uvp"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467a37a2a53so137998841cf.2
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836359; x=1736441159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEmcYjCd/swmAgsX5yvNjuuYpxBOvM3SqdH7e4dnSC8=;
        b=lZ9S6UvpSp9t3rqJN2dZuq4yT7HvHiWyuYYYM7psoRqwVi4eEYG6v/0JVr/7ZMK2zb
         +pamZbPmEjHCres2JARwrrE7AUzqTA9Y0VtiNQPrt3jxp2I/bRzYIj3OBQL5nb4NPYTA
         VKs+32BgiZvTGpg1QZ7Cy5rGVzaoealwv0YuFJD+5f0phbIo0Q/1ZJsrnN5Gu9iovL1b
         j0rOv494ybb2hPIn7HrpFskjkLexy4EF9nPnMnFwADtGG6RfwgaxYyzaaE+1TepGIR0w
         ok32FE0jc2HGQjz3/eSIju1fhMzP8mU/5uIjzYbzyQZUb/2lH+YFDxXNCXzRB/3CEiY7
         mjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836359; x=1736441159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEmcYjCd/swmAgsX5yvNjuuYpxBOvM3SqdH7e4dnSC8=;
        b=UWlzjmW1j0CX9ZKEM2N059IlbFZgqcSJZ6hsiiDm6linUxGUIEheI0ErJ/ZVDpm7Y7
         LrgDZgR3AJGbg0WkATGy56K/Woyzu5udB4Afcm5g41pK23EnlkCayHvoORjl3C+Yp2la
         IDrKu9RhAd8dkkq+vJK5SShZpfYUTPUqhMw1BXl52C589bbD7Kk46KXI9m24ktaCdx4z
         JJD4LnN4pRGQmD9TfqRSM9thT2+bjF+4ehjrC2o85M43fiMROGEI9CHSo/dsh6kHySfq
         FtAV9gxVhW5mFxmUuZVi93JWknCFJiR6s4caLlMGM8G4PoW2622w4BtH4V6VbpZcZ/FR
         IvhQ==
X-Gm-Message-State: AOJu0YzJQQCMPfOOTTLdz1PQQDX1XhJZ5JqWZ/aBjzClb0nJ8QRWqAXj
	IaOVJdexKnGPPvmlmY4Vewt0hyP1fQJgW9J1ziNGlr21T8CIZkLtR/OkKA==
X-Gm-Gg: ASbGncuTWjkNv/7yxUpIW8tRMus2aPU/Qs0uJc7ou8zBskVssjLfeodhxJLh2t20ESg
	g7eP35ydDXcIMo47pTCyyUX0/fww0ttNGtp+LyNe9erLn4oJbG+iG3aAebaM7B/jO75bREDF+Zu
	45zw7fPUFBECZzQPGIfztgrVre1eQ6xDKMMTLroeWcCnXTSJ7s0BDKJ8UAYiTX3HbdLicqwAF/T
	4wotWYOpj9pLKhnZb5WzHehvLIDdx0CJNtsmlXuTnQXilaWcXmeUn7QPvXg6/rZ4rUz9/FFCuWf
	Tpo/QhWXkcdJyHZz+XOmdXK0rybTiv/M/E5ZpzJEQUPAy19X4FnoKd1zF49sy/GuGPdTug==
X-Google-Smtp-Source: AGHT+IEUekRhIGNniJq2Ylfs+3fS8sY1n6ubgAxeeNOKAHFDZyJaqvrkotFcUysQngmDu/R5phvBqg==
X-Received: by 2002:a05:622a:20b:b0:467:7513:3d8 with SMTP id d75a77b69052e-46a4a8d0261mr702318461cf.21.1735836358999;
        Thu, 02 Jan 2025 08:45:58 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:58 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 35/44] selinux: split cred_ssid_has_perm() into two cases
Date: Thu,  2 Jan 2025 11:45:00 -0500
Message-Id: <20250102164509.25606-36-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
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
index a533385d0149..57935359b3d7 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1568,7 +1568,7 @@ int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 }
 
 /**
- * cred_ssid_has_perm - Check and audit permissions on a (ssid, tsid) pair
+ * cred_obj_has_perm - Check and audit permissions on a (ssid, tsid) pair
  * @cred: subject credentials
  * @ssid: source security identifier
  * @tsid: target security identifier
@@ -1585,8 +1585,9 @@ int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
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
@@ -1605,6 +1606,58 @@ int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
 	return 0;
 }
 
+/**
+ * cred_ssid_has_perm - Check and audit permissions on a (ssid, tsid) pair
+ * @cred: subject credentials
+ * @ssid: source security identifier
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @auditdata: auxiliary audit data
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
index 80590b99399a..68538c74dc99 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -461,8 +461,8 @@ static int may_context_mount_inode_relabel(u32 sid,
 	if (rc)
 		return rc;
 
-	return cred_ssid_has_perm(cred, sid, sbsec->sid, SECCLASS_FILESYSTEM,
-				  FILESYSTEM__ASSOCIATE, NULL);
+	return cred_obj_has_perm(cred, sid, sbsec->sid, SECCLASS_FILESYSTEM,
+				 FILESYSTEM__ASSOCIATE, NULL);
 }
 
 static int selinux_is_genfs_special_handling(struct super_block *sb)
@@ -1833,9 +1833,9 @@ static int may_create(struct inode *dir,
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
@@ -3353,9 +3353,9 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
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
index 95fed265071d..5e02c1323848 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -164,6 +164,9 @@ int cred_tsid_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
 int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 			       u32 requested, struct av_decision *avd);
 
+int cred_obj_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
+		      u32 requested, struct common_audit_data *ad);
+
 int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
 		       u32 requested, struct common_audit_data *ad);
 
-- 
2.47.1

