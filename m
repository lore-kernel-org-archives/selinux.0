Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F137305E13;
	Thu, 14 Aug 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178049; cv=none; b=c5aMAS6iokqK1Ubsv8sutVx2vXTc+tNkKd1CrNyu7jUTubELnE1FQSOreVGnwPcovjre/pHFx09qt+yPlQ8ViAU9cwLOFG0kj9yHuga3svyGkP3JNY0qI0gop6QlJkpgzSNAW+amDiLCNMgdRz5j5R/RHSKEIEPNqT2oqAqZ6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178049; c=relaxed/simple;
	bh=qyN0FMK+CJNYMGrhe5dYm+t6i3eqIjtwwPVwtu3HlGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGkrnwpEtveDi/BNjBBmcAse5+1MXflJWdQUJ1E/K3Eb7Fvy9UfeH6v110sWyV7H2R/PBKcEbqXXbI5DqTB1d1f9ra1j+Uq0yAEv1aboQ0Kn1JySNRUfIFw5K1lFeSr+SSjeDnRDnHj8lwdXhr/NTEfGp6Fxc0rsbPpLOijhDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdAnf6E5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdAnf6E5"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109c58e29so16630451cf.3;
        Thu, 14 Aug 2025 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178046; x=1755782846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvJarRSEf4meM8euqeAnEbISu3FGsh2YODmT4/n/0Co=;
        b=UdAnf6E55TwK0LLd2VG+RT6S2ZXKWoJudMYkcutOrhswTGKfpanTDFykN1WzpKr49l
         o1tYHf5RyS0mUxxUINTiD2Nvikc+8pVUPbsyoEIH8AgbnULTp8jzjFMirw9N/4GQytaj
         5o3QVfcr6oLOHHCgyWriulgR3S0hQVj3EJvA4c8yx/R1pffHHEgysHd293A67Ns/RFxi
         vPTV5ZTT2c+u0xdf/7PiMp/7uInJABvyoZiOeHA2Mk4x7X31HhOmdMQ9zpFyaiddZQyE
         mPhXuGLbBzQxHnKWa9yyafxDnT8IV2QPQLUBbe3/zv/d0MJqRkb6C4eMRG21LXQXWvL4
         6tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178046; x=1755782846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvJarRSEf4meM8euqeAnEbISu3FGsh2YODmT4/n/0Co=;
        b=ApeDH3jpQHpWUipjg0FT2iaaOSZ+qPXSZhs+0wRxQWp94mdWLLuJwlqPWXEvb1eZ85
         I4X2gzbTd0EZhHf/QhZ52vDDj5SpOMWf1bKRlhnzXGperuz2GLFmXht0jgmXiJIlMHUM
         /DDQf+vZYpxdheFI2ctCD3nHLx86NeWueLdfy3miVp1kdbLM7gBAYTIt6aNKDs/kt8Qo
         Gksgm0PDMMIgPif79gMEX/s7PXyqcyDhKEUEGFNsR1BuqskrurU2jA5Odi7aQhKihRfs
         jioPUBzZ2JSvQ6J1vx0Nn5wwy+qDfR9IVO4DzScSXbPJMwzf4+cTGFqWz71MU5g3rmlY
         rWNw==
X-Forwarded-Encrypted: i=1; AJvYcCVhskF+n1xWtL2j3rvUX2BnPX+Vm/zmRDg6K66YwDaeGwNtgDfg0AQHDtLZaIEFHkNdxalZpbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpibhM0FbwVh//YAfB8MqCxKWmOuuZ8xYMniU+PHkKiXQzgc47
	KWqHIIpTDKCn5y7dW0CUtwveUFhk6DCZMvpeYhMBLL7T0S04Is3yzIY+urrzrA==
X-Gm-Gg: ASbGncsEUIGOLReya9NK3MRLeMUt3/PTdtKZ8PeqNf9VxEC3NtR380EfPauw8XTrOXh
	LyI3M9XiErIwziSP/oNp0l9VkQUorWroOsNBXS/kVPJaknn28RpKJVFTPKo29cs4pc6Hg+TJOW7
	3lq21MHyO+QeWW8R2O44uojQbz5yApvQsTyOV70adz8a2AVorc+gOAvu/r28zdT56NRHbHpbCwE
	5rKb6GEkGO73riAymPs8bYVN4JddGZ2DQJV1IGnEQBDOShRmLBDVWRk+ZMV9s6PTsyHWnMJqzHy
	8eb9kmXa/4SZdVe8BmakF7lXPJrg8K4ky1XF5nhWMWTZGfmQgrZLhdIdnnoyZAZ3e3Ogss2/gNK
	YTIgWyv7MYIrpwVXlfu7uXdd1LdlU+aSW9UMDShYOVdOyFM0lzbJcHtKwvpTcvSRqDqwVNkkrcD
	hEJHrHU1F7oDqqlp9Fn2mFLciJlw==
X-Google-Smtp-Source: AGHT+IE/xJzD+w0HDsoCWD39kh4W4es13xrEueHhXFFN5Y68Q/AZTclFqZbjNA7Ahmm4PGLWfwz4Zg==
X-Received: by 2002:a05:622a:2616:b0:4b0:da5c:d1f8 with SMTP id d75a77b69052e-4b10ab2f784mr42531001cf.57.1755178046474;
        Thu, 14 Aug 2025 06:27:26 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:26 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 23/42] selinux: introduce cred_has_extended_perms()
Date: Thu, 14 Aug 2025 09:26:14 -0400
Message-ID: <20250814132637.1659-24-stephen.smalley.work@gmail.com>
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
index 44caaead16aa..03760f7e7cac 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1290,6 +1290,32 @@ int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
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
index d21b3d03cced..f22acce323b8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3913,10 +3913,9 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
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
index 5d79bb7c610c..adbbecc681f2 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -154,6 +154,10 @@ int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
 		       u16 tclass, u32 requested,
 		       struct common_audit_data *auditdata);
 
+int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
+			    u32 requested, u8 driver, u8 base_perm, u8 xperm,
+			    struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.50.1

