Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8A2EE5F0;
	Fri, 20 Jun 2025 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441542; cv=none; b=it9ZqyTpr/YtmYB/p8Ffj3Yj1ZrV6/3n0VCboJk6777Y+acGwfDLrlIlm5mtTck+xLBxrSNv1iAHprZZ8tli3jBhr78OoZWTMBu21wb7yEXYA4csplYdmQ333WG5424u/fXZL3bghAZTsS0aBw1Sem+W17ZXqyo5AqaHt1vdBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441542; c=relaxed/simple;
	bh=DbwsjSDOA2ARzx65a06pW+AZ6Df70Xs7U7tq2yHsWRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYD2VR2I1cLtuFqcN1fywTUBBcjKMUMvbm0QczrtajoC7mxa9cJVnJbJjUIXrmAoULVo0Qs3ST9uKoOKN/DlDyqGOnsWiY/XHeLlHm0WGGPlhwXzUryNex+bHt5BN8IYByqmuicidKI22Gl1xb019zF4KzMU70inzF79quvuaQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWQzwUHr; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWQzwUHr"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso22559336d6.2;
        Fri, 20 Jun 2025 10:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441538; x=1751046338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAfI5nd8j9dMsnFSAAZVUQ7ttkTigUKgU1EXgGOdYLE=;
        b=KWQzwUHrqQxcyvKBoYldkPAahF4yYZECH9RHivM5C7Df3S5vzVtj+bU5ev455pd3wL
         GReYS5UesYyyl71wxL3YFHDiBCGfo/h2TFvp8vyj1td4NzUs7F51mXiqmsorE3SNpN9j
         r+sj2485qm+RKSh1YrDaVPRnIb9b0gecGYWK0XI97BYdyuo045nurrKetPw0jqgExXdS
         Lw7+0JMDEMwC+01nmafz6FA0fvHuXsbUSRroWmgsjitI1nT46FG93UZZv1yNhMCFu+TO
         nUPrv59Nl7rz2aAc6TEx1vxZf7GjrvG7yKRlC4DkyQry2g4f2J5H+CEQGUiAdLj0IfYa
         q9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441538; x=1751046338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAfI5nd8j9dMsnFSAAZVUQ7ttkTigUKgU1EXgGOdYLE=;
        b=XZD6y4jPH+Dgvx6xwJWRzUDhTD66GAaDC4sj0XWZULiJjJqSMyy4mUQuCRFzmr/HWk
         nzMBYo4ntdbP6RdrozAVqLPds1tk+w/vjLsM0KnnAUB1BVbLVHpdPqylRO83tYiyF/Us
         Z0pUdEn7ztlVYC6T6sFVqIAas9dm0WTwZG3++oNWsdMc8ZyB5BaiKAErShY2mJOpZ74O
         h0rjoL0QLRhHYr21YiE0m0sUvRYqy0O/e/TUiaobvTXxECDdoer10D0Ua4G11Kl+bIv2
         7tQsQkK5GqX+Bg0Lao5W0iW6mMu+pojgVTrqmEEnKTrPf3p9fLzgNeQMEftKT60i1qId
         2wPw==
X-Forwarded-Encrypted: i=1; AJvYcCViEQRDkuKuNyR642uaIkDrIvvkzXu7VkD+SCS9PO9k4QLaW7c8uV3OnEpMBSxKhVYKi9hS+8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1997SuF9iuWYGgr2Y2XGTGoIHB2YTJGqn5RkjtR/ZOXPdEruW
	jQVzIpU3gstpCfTbEl+DZ8iGWUzzks/RC5Nnw20UE3AsvyfeTpFZiwa9s8fSYA==
X-Gm-Gg: ASbGncu02+PBe9dIzI4bV31dGCziD8d0WnBeXZcve0jTfRSUnODcH/EioJ3gcnIon5W
	q5wuOjx73SQnsUkUwdZVlEOiR4DoSwfw3qP327aSj7IpsDETPsu0pWtzfHAMNrGSPpxkQ1GGLOp
	UHP3IsHrr7DFs1ZcBdUppbdku/ozr42oKfXcPEFvylJxw4ioKBQfrjAXEBnhRq70Sxj5NG8s52e
	fbuU2pI9YSdtMRASLhmVwcZWaz0PyWnkcOTPHkMN+k8JdoJblgRqqmSndgyz1YpmJIR4u3nQSJH
	8SeVQL2nziw1LW4xaq9GYOmg80vHa2u9ZJBupd05aWNtLOY8crAePokU31DnTrXz5FDiQU3JcQ1
	+cfqGwWtRoihh6mMu8b0/zLQTy9jfRrSyOy8Eo2u2Z6SLbwN8W185TKUkJaWUePFhWg==
X-Google-Smtp-Source: AGHT+IGRZQ5wM0vo7GIoYCkhcywMk4PMgAE7Vhtoebge7bqTOW3Slsdx+xKwEBO+dtevL2PvIF6giw==
X-Received: by 2002:a05:6214:2f09:b0:6fb:6777:e370 with SMTP id 6a1803df08f44-6fd0a5afc62mr67507676d6.45.1750441538525;
        Fri, 20 Jun 2025 10:45:38 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 23/42] selinux: introduce cred_has_extended_perms()
Date: Fri, 20 Jun 2025 13:44:35 -0400
Message-ID: <20250620174502.1838-24-stephen.smalley.work@gmail.com>
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
index a068752368b4..6ad3d1ed07f0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3901,10 +3901,9 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
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
2.49.0

