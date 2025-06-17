Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5C2EBDEC;
	Tue, 17 Jun 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169196; cv=none; b=Bw6U2yYbAkCRyHiBPhiJiS7iFon/k+GgEpDoWlndVSojGGGAiaK0DELeCXBS6vWMprb0yhnsunwelACv1rb80VfT2UqOmZ2Cr8NZyxJ0gbMynTwV6XqTj12H/TMKb39rI3OmoPuoeyft4ipk8C1OFGJdEG/5h13/4hnB3hHTMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169196; c=relaxed/simple;
	bh=+8m20FWlJC5316G5yUObJ6M9MVzM2+P9vWtBVF9iwO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTZ+m9cduSY0qXJi1+CMMLYgoCggnXYijYOfMEhz8zGMMr++EZsZhS3WUv1ozwyoMHnw/Me4V5gKL5fHpFuS5WyXGWelD1Vr3K5lkQx4XzRdxpnCTNLWvT2bnun5YuEOaA+SsAYMIDlzClUi20AQk0D1n8oXt+dfx4ooHARsUM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6r6WRkZ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6r6WRkZ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d3939ecb7dso598345085a.3;
        Tue, 17 Jun 2025 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169193; x=1750773993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXFOdvv5iQh4GFiP2vja495lKceb+dUdJnc00qvhjeo=;
        b=F6r6WRkZlEgYHpGY+A0i5I4zetGl39oSMfvHSbkRO4VV7Q1zFVgm9YDkOlQlp5x5ng
         CRKqzBXEQIFuM3bdvwzNZ6LHGSZJL1q4LsfpYxulFAcDhL1ExsfWQJ5QX2ei3RCtOhNV
         Cs4UN2qgqMPKnnL2p0WL6gWuaqUeVTKOqAQg6vgn9bFacSeWX0OtVHWo0ToZeHW69bBb
         Y9MK8Ta/BrObtEJaeyWFlYiF3Iy321obvdbI3Ibfi8KA7PSh8WORjzdXRTfHJHLuKHZZ
         UBFuVUaNfELm9CqGhyH8SgBA8sJh+AQprQgbNQTWBytGTiuWZ5tpogQIM7E81Kk+NkBc
         xHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169193; x=1750773993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXFOdvv5iQh4GFiP2vja495lKceb+dUdJnc00qvhjeo=;
        b=CHYZlrhJjvSAOmqB2ldV70TIQVOJvQB8EgZWLl2R4a6HiRTif1c2l2wUKUCo+2/x3n
         XW0WORvKtA2/GrcOzyAqYnnPLIxvxMAw/7lbiuW9pMuX4BDU/OZeNcpNbcTU0+2hTgvY
         O8kx7kC9luoWagBne28/7BG+ny4vxr3Kmc13sbD4okrQgJXEm4LNuBXDePtnLiZUTwbA
         5oULLnDw+x+a9j5duQ99cGr/VtXl0J8jzU/sfoYKmF72w34t3VAruiXD+t3acOXgu+LR
         a5ktsXKkwmImgged//GS8Dd9iM5RREXQvK6pVRYWnvUT1YikuMmdkCOW5zAn5dZ/rCdz
         xapw==
X-Forwarded-Encrypted: i=1; AJvYcCUPK9BWzN9+51OVLHiEZbY2vlnDRW0Eyf76SgzbQAaUQC1zWxMqkFnzdUdIb41jM4EI8qBjsSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6lrLfdj0AWPvFNFiQrHdvIqR91vdn76YmRvOhHzkoQZokQ4E
	P5nITG9kv5XCwgzeRk5G232g3Ik0w/QAEEnEy7AUs3dVs0CnAavXpySrN1Wrgg==
X-Gm-Gg: ASbGnctAyqKe2Ei3+PvLpn8B1pijNEpGoDyQXKOCIsFOzt3X1yjPv9YmiGHH/v4QWxL
	cv/pXDVHayua2sTaMN8DTlSYLloaq9MvYvJMGjFCvxxlC3qlO4To9hGzR+h9CMZpYghzr86b9uV
	WnzfjONsvGe6j1hXfCmAQlbKbJddupns8bjdpOMHMxWwv3oJFxXyuQHgiAIqiczse+W7zUQuOo+
	84kKXWHUB/xie/JlXxbRnojXhI46rNN+ITnJ0emCGEZ0vlwbsXldrvw21Z6tJhmACTCGZ0KtpU5
	1wAj9eBXKp1Khb0CVBrDKl1zlVVZv4fbUbDOxiYMA4qUxmB8YcZEp13Hw6g0qPFa4wSHvogbL7g
	a8fsDiRI+8Hne4X7xt7Pyr7qgJJKExoHWWFl91PVpfws8j8SeMwxBPdBjX2TyH66ylkrrr66lnt
	xy
X-Google-Smtp-Source: AGHT+IEI6foH+oJoFDH/rEFPBWNfU2nn8oQK38tIX2R/1pBR1lP/UP0Mu2/HbkbLWZFlOhQn1gXWMg==
X-Received: by 2002:a05:620a:248e:b0:7c9:3085:f848 with SMTP id af79cd13be357-7d3c6c20410mr2163968885a.13.1750169192821;
        Tue, 17 Jun 2025 07:06:32 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 23/42] selinux: introduce cred_has_extended_perms()
Date: Tue, 17 Jun 2025 10:05:10 -0400
Message-ID: <20250617140531.2036-24-stephen.smalley.work@gmail.com>
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
index 7a0ead09b35c..6f5a51268c93 100644
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

