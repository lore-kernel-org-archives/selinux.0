Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307627FD4D;
	Tue, 20 May 2025 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742490; cv=none; b=NI3txDUhkXRvg7gDrtqloWFCH4WhfMoIWXB4Tji6ReUPxEzdGz7dGqaPO61ROu//6E9QcKgeCAKUobEihQRuDyPDGOYfyGaM9hnP4sTeTibd/IPSMvrEP4brxV/BnxK3m3ZVUtSwkAfMgn4taPKwKK13KNnYaNlvJgAduM5TFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742490; c=relaxed/simple;
	bh=66lBvW/grNdo+sSRCeUpYDQXPQZ/wu3MSRzXzyMLNDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWKynZxlh4Zhq+cAYAw2dRz4/x5iNI6OCR2bUkZyRiCtsRkDRL+8h59wuJ/NGy/RfvFvpFIRwSZcDx+/rni1p8LRlfQtMGISeZ4LKN1hPL0Ex+FUYLkFwP4/p6gftN3UmO4pKBHgDOFIVQad1MssHJWLlv+Is06HYNy7T8q1zc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xzr+u0yJ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xzr+u0yJ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7caeeef95d4so568594085a.2;
        Tue, 20 May 2025 05:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742488; x=1748347288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VogML8hOq330//lO8RXoKqre2/SgUtPJLnT+iXo4obU=;
        b=Xzr+u0yJQ//FFSqEXClcpBeGFq0ZeaQZ1CeDmN65S/b7/80hzi2eXnEVa2+I5ymeXA
         Ddixg9vR57YgB5UcoTFCQiATdz/Au5CiEurt7kOLtYhi/tmF5WDbTdksX+B+o4HO5Yfg
         e8Rn3gihTN8s7Bj75oN+OtumtDd4AF+NqvbH51IMRk9dDVQBbykD0FRYmKra/2KPsJOL
         OzEFmMA+ZRUNQC2x/me3aBRV127VemtwawXzKdidh0dNVcawq95BWo7VBgjI6of03GkC
         gUMtiKEMockYw0rUULrvUKRSNLgMBdtllhGLvTbAxSXfenBa/n9YqS7hTzkvyV9vUy+y
         8Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742488; x=1748347288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VogML8hOq330//lO8RXoKqre2/SgUtPJLnT+iXo4obU=;
        b=LXjhYlZS7cLHQWa0ojOPlZ9cSS8RI+ZdQJ8Gfhu1jR406DizKBuu8DBhanyjCTOnvP
         vZePg+OQ5EauAsUZcF+385VBTlv7Mx+IQXKTgz6Ugyx4B9FyaPLSwDPnmGCXtOo3FwoN
         8Z3iO+8hc5k2WMYQ7Zk8acKLj6xDa8f33j3Sstulfv+CUPXcD3G6DttsopLQS9H6r9L+
         2Sk7ZEaRPkHn+lRYP4N9gnswdGJ1Eyqm3D5xlEkYa4eZO/BuaWaGUTXo0a9lUo46E6bD
         DcgBRLmNkhh60ephkxRDJ+0wCteDm+r/1OV/p5owgUWTpdlGbw5rhUuZs/o6Z9cnNC5U
         l+vg==
X-Forwarded-Encrypted: i=1; AJvYcCVLW09P54f+fDEJf/7wbaBiX5Cp/N1RkGuJlOmkNlW7xJJzKvVajfO8pgsFVcXPuWIg2SY27tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXvMRGiMYPOUS45ez4zMIHh4d1R/4LI/aDhWTGFDjLWXfHpH6
	jfux38+taCvJ59bxvHlznD0MYwxkDoVM9+5Spw1Ba8v2o3K2M7qvdL2j1mfmYA==
X-Gm-Gg: ASbGncumK3bKisF5UcBkNwlu3G5Dbsb95KLydf84hkRjJ7xYxmsOQBXvN5ImyHFrNZL
	RMHM23O1mQseAK05OGGRys7NNXOR818+ZpS4uvAzccBgY9vZ3pmZVUAjDeUaZXC1pOWhnpCu1zq
	+BW7NQLyKlwLx2/X58XIDvspT4ITvJXnf1gACQDn13Dxk6Db7KT3bhdQ/R4bR4CrT6yt5f1kOX4
	LYwp7hOSbliBnkRDD6V9ureHzIjboth+CKM187D9p4vwaUKMMLPFS+a6LMlb0NZFeX7GcHFSGj3
	7eS10rxe7tdWE1/Cx/BoAwn3qZWu+ULR2V93u5FtbKxEcIzRZZ7IIEMwZmOmWxS9ML8zfSpj3Wu
	s1tZIwyUv3U7B5Smeg/Fa2IjH7wNap8WkB6c5I6abE+A1uZn2fFx6ng==
X-Google-Smtp-Source: AGHT+IHitpL+LtUxjED740esO/ztz7nxQAqxjSWdPFSFy4pa5AhBX3ekd15cKhRYV/L6PBOc2+F/dQ==
X-Received: by 2002:a05:620a:40f:b0:7cd:4b5b:a214 with SMTP id af79cd13be357-7cd4b5bab08mr1955695485a.15.1747742487659;
        Tue, 20 May 2025 05:01:27 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:26 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 22/42] selinux: introduce cred_has_extended_perms()
Date: Tue, 20 May 2025 07:59:20 -0400
Message-ID: <20250520120000.25501-24-stephen.smalley.work@gmail.com>
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

Introduce cred_has_extended_perms() to check extended permissions
against the current SELinux namespace and all ancestor namespaces.
Update the caller of avc_has_extended_perms() to use this function
instead.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 26 ++++++++++++++++++++++++++
 security/selinux/hooks.c       |  7 +++----
 security/selinux/include/avc.h |  4 ++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 577743a01c5a..cf0161404bf5 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1291,6 +1291,32 @@ int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
 	return 0;
 }
 
+int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
+			    u32 requested, u8 driver, u8 base_perm, u8 xperm,
+			    struct common_audit_data *ad)
+{
+	struct task_security_struct *tsec;
+	struct selinux_state *state;
+	u32 ssid;
+	int rc;
+
+	do {
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
+
+		rc = avc_has_extended_perms(state, ssid, tsid, tclass,
+					    requested, driver, base_perm,
+					    xperm, ad);
+		if (rc)
+			return rc;
+
+		cred = tsec->parent_cred;
+	} while (cred);
+
+	return 0;
+}
+
 u32 avc_policy_seqno(struct selinux_state *state)
 {
 	return state->avc->avc_cache.latest_notif;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6142b39e0772..7c7366a9b6a9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3883,10 +3883,9 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		return 0;
 
 	isec = inode_security(inode);
-	rc = avc_has_extended_perms(cred_selinux_state(cred),
-				    ssid, isec->sid, isec->sclass,
-				    requested, driver, AVC_EXT_IOCTL, xperm,
-				    &ad);
+	rc = cred_has_extended_perms(cred, isec->sid, isec->sclass,
+				     requested, driver, AVC_EXT_IOCTL,
+				     xperm, &ad);
 out:
 	return rc;
 }
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index ce2d1b71e0a2..d00c9ecf5d91 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -150,6 +150,10 @@ int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
 		       u16 tclass, u32 requested,
 		       struct common_audit_data *auditdata);
 
+int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
+			    u32 requested, u8 driver, u8 base_perm, u8 xperm,
+			    struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.49.0

