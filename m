Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253A2494F5;
	Tue, 10 Jun 2025 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576202; cv=none; b=Z+tlVd6sup4pCd5GMbH7XVeYcxtGT4GW+Kum+90xKJ2vC5pZTptCjFlPINv+E5aIuYz8LD4UrJX9wCMWqbvvVRxdV+0dJm82S2MtIBrvBnWjJt+hklsyeojxBjI75ffmgDVxiGFQoWt+iWhFvZ64AtFYGsZZJLy9agF2UocmZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576202; c=relaxed/simple;
	bh=xNjJ9JsgIkuw8gjqEhnH/Bfc9OA3w+9ckkVYb6VXcx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isdQt8a4l4LSxoUc1an5bZCDA0sAwx2T6y+IhuhGK8PFDClcHOBKqKIy9CnJD+FHzVZF1Sg8xicMqLOAYRXCKnxO33rp2NtLaOZxfsF4tiRksilKdN+8wSR3aXET9P5KEUzoEuLuAImF3oGfPWfrAcZsbc6WOmi0RY3nS7XNeZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYCdC/LC; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYCdC/LC"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d38b84984dso468736685a.0;
        Tue, 10 Jun 2025 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576200; x=1750181000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHAvEFcolNSu2akNefUPIxn2R9XpVL8kIy1VNrE1QVo=;
        b=mYCdC/LCFoReAPDcvc/AqIpPIbxOL3ytnvWutsxroDx1D7Ky6TCng1+8VdIpRxQ1x/
         7tY6o3R3Q/WUmuEa7LpvHS7yr6P4+3RNJTlDZuoYpIWbn1JtFSjmKRy1OFtz0IdWSPE2
         Na3WgqftwAwkh0XHYZCUYO+VERA33ptrkuCEt7djcBkOODsJSBO2orEIh839K0pNLnCX
         9n0d0ZHi6AmwLNnGg0feu19SoDhjxCKHelMwWtYSG73A5vRD+wXgv/uaFZfPDUTMzmzT
         8fHp8USaGTDQ2seyl8c0lGGruIpXY9wNIuAShfwg+LEDLVZDyL7JkVN2anF3KKP5ZkXQ
         ywEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576200; x=1750181000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHAvEFcolNSu2akNefUPIxn2R9XpVL8kIy1VNrE1QVo=;
        b=D6G+HwnuJpZ/jrXK3YV2TI+V01OZzFX0QrHmfvt0VWmN+YInWZLp18aopZ2cBh1QSi
         0me7ED5MuJrvnUEtt23oOWELt55DFIFtQe/XpoSowQsWrhBDUD92rhlZnYWG6wu5uer3
         elHaY9C2qXERyo4Yzv3HaXKhU/Ox4GQ6DEXAJilqKvBH/iTd+H3AO8b+aXuUtYT3UMsh
         gLQaihTU9USbAV1SeXq/BHYlIL6iaEOtp00nDUgiLMfs8y6uIvb+27zmDQcoI5BMCdVj
         +EQSSb67RPg+oR3aYTb2kKIvI0vHfXQ57HvRxTsIvqeflpmI4U7Y9umJuZHha5vw6/wB
         /sYA==
X-Forwarded-Encrypted: i=1; AJvYcCX0djYC12dWcpa7Wu5wM0+FvJBgHHnWmfqYT2jAzo2PRrO8sZg583XoKzrdceB4TM3lF0yGuU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1xND9EnOch2d4o15beB6y+CrunvppGA6DM85488P6KIZdi2Y
	pWvpzhu1HOehzX0ze8GQU1pNtZXa4HbRVY2ZawjQjVlKjiIugn8IuuX8o1Dr1A==
X-Gm-Gg: ASbGnctf259LiuJnWq22bndCs062piPGi9DYa73kuXjbFs6iLZqMUnZZ3BLDWtsX015
	RrKrERChL4tC3rokWhph/+CzI5pBkuYmr/cTYLuupRgFAATcgDwluP+sHFtmKFIrThbijlyM7ss
	7Bo/y3XpxVJA2RivSkeTOHAD0pRzkNbIXmb9jyzm/8bj1RTVMVZUcY1V2KekYKOptGJ61fJI9Da
	V7+1S5uprS4vAArTdssKOjEhyJfWDJoskSkjxdjOT9n1Q0w4DaBvS3jyhuZuF5inE0szBvWdO9o
	oz4Aa2+pjCcdXOn2BiYX8NqZTQTvY5Au6SgR3AqQO8ltwglxvY0C2E/ikQQ+L8Vqyx090cenDK8
	BgAynOXDdb+gjS0/hXzSz4yO0seUmxPtGU6/vKUUkHNgouoNaufNk/yDCx/hieIwfXw==
X-Google-Smtp-Source: AGHT+IEzc/F3ZMCG3tHO3+VzM3vv7gwCPTLj7B0+6aMfM5pDANrMJzaLWGpIgj8r/Prb6SZfOxOVwg==
X-Received: by 2002:a05:620a:44c9:b0:7cd:4409:e58a with SMTP id af79cd13be357-7d3a881a5cdmr28212885a.17.1749576199994;
        Tue, 10 Jun 2025 10:23:19 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 23/42] selinux: introduce cred_has_extended_perms()
Date: Tue, 10 Jun 2025 13:21:54 -0400
Message-ID: <20250610172226.1470741-24-stephen.smalley.work@gmail.com>
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
index 93df1d969547..2112da2f5d4d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3889,10 +3889,9 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
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

