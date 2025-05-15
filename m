Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4487B299AA1
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314632; cv=none; b=PNe7XJs0pw9yi30tteBWqUd0bjz8DfoD2pFqrxmj/Nt3MoEgAOlKyiEvNmGEZYzRzvlbrc6t0q/DKMjEJpbKyV6ddeiJePHIlT9vXCW/Id6GbvfUClAiyCA4raY2VT1v2Aeh3xxtKMJL58ZAmtF8nYo4HPpZ9gXtvvyhMPElcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314632; c=relaxed/simple;
	bh=elB8K06T75SnqYyeAa81dEzbBm9bV12jPVYCQ2oM/Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEhOk15iwHEbgkB2dhjfbPkzV8i1Kckh76hZNpqGwY71gHDYFKtHlEKXmFH2kCGlz9x9ktBVhXmAgVqXJn4Kvx+0li2PCBbxodZeUXy3PpNY2syXZA7ZaHFe8vEwLBk5U8ECC6cAbFr3XURZyImi9W+apHzYYRuxQzwxtHjG2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPDTHjZJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPDTHjZJ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7caea4bc9e9so148061085a.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314630; x=1747919430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfTxig1gPYKF8EErLUBMY7wSSVKMlRAzRjXyzRvwV5s=;
        b=gPDTHjZJoP807AY2E0uKQS2RZ0uxCHHxFY+2kusoOubhp4N2XRP5q4FHGp2XSQje6H
         4Y+4K/OclCyp88XXS0utJZwEYUeWdmj58C5CKj4Zfpa/Fi4JdwSrYvIHukZxCNxkCWoD
         pnKRnM08HPhFfLoBDIWGh3hsi6R+QbbhL5GyW4kr37b6I6ZEfKuaskmEMaF6Yb+Eh3VO
         ixNycqa0BnwF2DwAh5b3O1hpyQXsYBLj5Bv9PDXjHirf8vTGVFpF6oZkOzx3TH12WuWj
         1NN35+kCxTCYqst+00Dl9yhuVnsI+L12aAMDHVDO4/acFXzGRVAwwcwfat1Nrxdq8yuH
         N+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314630; x=1747919430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfTxig1gPYKF8EErLUBMY7wSSVKMlRAzRjXyzRvwV5s=;
        b=wZN2kSM2ERR1lckw5N315WiVjxkPzZi36a01IUUSPBQH/JMYTBGDdtRL/1PR6fRxfW
         R2GiNFK5tPNUT/Qu9lBxvMGFqn90D/qwNzVETD7gPlAM51L8dtXCbpc3dJPM0qu3Tns3
         NxPqXJJhn1NeO0eIWJ76YWbj7vVOpIoMhUyxQbw23X/BTZMR8H/av2Xp06CO9oEr5syh
         vscmnZ0qtsGFQszZhCM6jFgWCmsyVZdN8RY1pFBvVS89JBZsPA93p/LguXHGUphAwqA3
         t7Y/+hUzR/YuOytoWHtG9OqsHtFqEHv774//5w+jDUfFEfQ0T2j6KOAt/ksBu4WMZURq
         Cpwg==
X-Gm-Message-State: AOJu0YxWQwE0wclqIrZ9rKDKChZgRSIGdXgUTCS7VHVnDdyKAV3pRrum
	UutGQdCH6HjgBGZtDP+xDZ9uadAHoc2ZMaBH+M8vsS0/fvjn4HP15ZYWhA==
X-Gm-Gg: ASbGnctlZBLEWi3PdqqTn+VNdXXrjOeW973stc6oUoUAH2akzPAgNZl+8WiXbCw01D8
	+iwQesLxyhTVxyWxoDduizGk/iocGG/ATD5L2GR4n4OC7PiLqpalyFw6lSqHeboTB631L1RrxXp
	P8CvbL05lnoQy6D3NnS5MLQfg0wDqpMKtv7Baz5YVQqxagrqUPws/96l3mzA0d5UTq0WeFcGoPq
	HfXdXWEyIHrb4RIaTHNR7T+G5yfvELphJ+ULV47TIH68CQRF1DGxhUUWln+dKBI5AvPRoVjHGnF
	3QVT4d6RGRc3rkDjOl+Nbcyn+h29YfmRghkRGTbOxhwfbXbSv7a3b5+QtN1reU9EZllDztNVXVt
	BRaVKi9KzCOTDJ0/AJA1ES1UUERBIz8rcGSAuRMfWcGe+QmXethcMMQ==
X-Google-Smtp-Source: AGHT+IGJVAqZ0ls6AjLw0YLpctGuoqYhIXDxewjbdM2F+cmDMTngBF7M1VSlUOOfqApmIEr7SgiUsQ==
X-Received: by 2002:a05:622a:5c07:b0:476:a713:f792 with SMTP id d75a77b69052e-494a33ced67mr56604071cf.49.1747314629823;
        Thu, 15 May 2025 06:10:29 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 14/49] selinux: introduce cred_has_extended_perms()
Date: Thu, 15 May 2025 09:09:12 -0400
Message-ID: <20250515130947.52806-15-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
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
index 2c9ee01eb408..eb3a824321fa 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3896,10 +3896,9 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
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

