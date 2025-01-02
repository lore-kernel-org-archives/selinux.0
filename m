Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20112153803
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836349; cv=none; b=bQRxS9tqiT+yLO0H7DVaPvrxjGtNBTWzPWIp8NIzMTSjsw7Z3wcVLDqJtFz9YMNtgp8IjBkHJ1rU/zRq7oh6bCOGyVkNuXM2/UtaPXU0N1tFgbdnA5ykSbnqkQQqelffGk5IKKbhgjUJCKwJ+fIU4ddX1TF+KlfJ3NtnklvoBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836349; c=relaxed/simple;
	bh=1O5sylxr8M8hFOuWv2BC10pwyG/sr4+MdROL6mbF80Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T1CEQzymxZ5dS2+GT3hrQBfaLPGnG2SZB5fhNO5qW7wIALNpg/iD7V/kKoR2KgGiaazVqYRQoX1NJT3GTAzww2jA984Y5nqvhe+XgNuwQBa7A3fERWGJu0pex0Ak43010QTWJJ5a2q3QmB/5gdkH9wHeudmGqEU8NfI8NZeYKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDBwQjns; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDBwQjns"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46769b34cbfso171275831cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836344; x=1736441144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NhDILDRD0nqc3fBBu1FK6YnCMmG0lhNRfdYsK64T4I=;
        b=UDBwQjnsRMHxdZZlnYeDH83KouYdZByheS1sm6hoDz8k3h2Mz0aWmTZwHfolmbN6nq
         9X/V5TmI6ccFftkCKOEVM8oi40ZPTuijQmEEae0R6ZkC5XfvM6BWCEWRkl0D6szi2sdG
         gSQeUSAIVT9u0TnQX62zgR+ypwCcj7Y/wiYqTQY2KAxB9HOylm/3APVD6U/szi5VxIs6
         CzGF8hWlGfaTX/dspDANiGY6eMNalHao2Ab47AXqZF8q0EbPHJjbf+Uh5fmWg75R8Ffc
         PRgaxO2wSVtF2AspJf9ap5tnsDWENr7T9XG2RmAH4hYtP+nJx0AvnLDwjINyrpK3OAVZ
         y1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836344; x=1736441144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NhDILDRD0nqc3fBBu1FK6YnCMmG0lhNRfdYsK64T4I=;
        b=FqxWtSg9fi7gYYjXEH0w67c1NI+8bbYPCyFsmSoyITgg9+E9cv2hkd8sMA0vrfJN3f
         fK1zZ0VFRa9aAEPVK+bsaLakOaIR4qP4YAh7YEnwZJmk2AwX74fJYMIvVP+fhuQCVGB9
         LoWHUwuFpzJwFsdoHjjEBlP1CeacWTmVHbC5no3UOIAmoDta1pjtxSMv/Rp+AgyP1aIw
         XKkjc27Ux7H4UHYOlr2DV+YWtMTdkLYW7191X4M2BKpZFo3YHoH8PgmUQWsGlIvSwDRl
         j9C2+Vp9ZRBpuHn3zZO5MLS2XDC1WbkC7ycF30uFtjgqJ2HQkk3yuWCsS0qpWVpOuDLm
         uGIQ==
X-Gm-Message-State: AOJu0YwYZd4UpcJN6kGjOMNMOERQmoVrr50Ux+c0nJNPGMLESrFSH+j8
	RoOGyGc5lxyhBcGDxH6v+0EIvD6kqiizY6CS5wVQbmMrpEgRQx5cK5tJNQ==
X-Gm-Gg: ASbGnctc1c+DnuLRAnoTuyO0OeW0VJTqz7i1BgXtkEuHUZ+i2RNqIw6YrlDoZI8t1Ts
	ZQ2GnCPp2RDImRYL89czwSObxJE+tDfHQKxj5PX/3y1JPb2QNgOOONmwhy5MUYHpu+rj/gXvFe+
	SSH2nK53E3yI6HV2eEiMfFh+uh4J+OCHKGKFko99jlGFxvFWJevCwMtzB1+KqZ9fAWeFoOTY7Yz
	jGvPwTpfSpu8WM3xM/hQLFwjHQxXZ7oBLXFXJ8le6r/yB+Mec/jYv2xknVkx2ZsqF07iXJv6HfE
	B9GpYb1w4ixIhAWB5lSPhpdOLijVtCU6lfblkZPks5PEi8sEeZZ+8ckrHDQVr+W3W/s1nQ==
X-Google-Smtp-Source: AGHT+IE/DW16TfP1JcF5JFgKtRVFNKsz5jrBi49uZHPx18F3PcPZ/h+SohChpH6M8P9I/POI95d3XA==
X-Received: by 2002:a05:622a:118c:b0:467:6226:bfc1 with SMTP id d75a77b69052e-46a4a8f4d78mr766140441cf.29.1735836343900;
        Thu, 02 Jan 2025 08:45:43 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:43 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 14/44] selinux: introduce cred_has_extended_perms()
Date: Thu,  2 Jan 2025 11:44:39 -0500
Message-Id: <20250102164509.25606-15-stephen.smalley.work@gmail.com>
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

Introduce cred_has_extended_perms() to check extended permissions
against the current SELinux namespace and all ancestor namespaces.
Update the caller of avc_has_extended_perms() to use this function
instead.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 25 +++++++++++++++++++++++++
 security/selinux/hooks.c       |  5 ++---
 security/selinux/include/avc.h |  4 ++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index bdd97f8bb571..93a7eaa42cdd 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1277,6 +1277,31 @@ int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
 	return 0;
 }
 
+int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
+			    u32 requested, u8 driver, u8 xperm,
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
+					    requested, driver, xperm, ad);
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
index c7aca5610402..7608774ac283 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3768,9 +3768,8 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		return 0;
 
 	isec = inode_security(inode);
-	rc = avc_has_extended_perms(cred_selinux_state(cred),
-				    ssid, isec->sid, isec->sclass,
-				    requested, driver, xperm, &ad);
+	rc = cred_has_extended_perms(cred, isec->sid, isec->sclass,
+				     requested, driver, xperm, &ad);
 out:
 	return rc;
 }
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 0a12ebe43632..199d83d354fb 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -148,6 +148,10 @@ int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
 		       u16 tclass, u32 requested,
 		       struct common_audit_data *auditdata);
 
+int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
+			    u32 requested, u8 driver, u8 xperm,
+			    struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.47.1

