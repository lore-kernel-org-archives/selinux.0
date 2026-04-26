Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C3314D2D
	for <selinux@vger.kernel.org>; Sun, 26 Apr 2026 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777245832; cv=none; b=rw03dtEfVmC4F52aQaLHME2u/S8ix2DnXTGaAUCPO7kOw/ih5VfqkcFDc8RfH0x5STOiODERzNA5xzdv1Lq4FlIoECb8xp1M74beoR1vXmof6shNBIFzM9LwdkB+83yytFlFRzHuSNNWCZNY8VCpIY8L7ru5H2jMIKkBXoPfwdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777245832; c=relaxed/simple;
	bh=3PfpSsq9PVqlOFmWLAB5WPbcbb7zy7cmiuYW1YK3Yac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sE0ZW+MsVjRl3XjkD4MbahUME6SlhpPqzx0hViEnaRj9lTrkDHF6mxd021017TK+GBkacnFeMveORqmgdSyEtsgqBcW1T5A2RbftUG+dDiLyZTUaF9lssRf/caq+EyKJfVNsll2wMNpRSIey4QvB0/eLZSqQHD4lC82FXdH7xcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R83f3coU; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R83f3coU"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8f0a87e23daso501829685a.1
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2026 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777245830; x=1777850630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SMcVPLr/wbi2Q8Kaqf49orEV0Xtu1ZF/I9pLdpkPlEs=;
        b=R83f3coU1bE3WufNsrV+dbv02EBiCFDAJuGnn9wQEDCs7kjA+Yhud5f0dWS9S52VlR
         Ydyoo41RB51h1BOttZd0CaG+Ip62cX26fmzspW3tVo/kJ4ZOE9UqEodJfKxsSwqpwWIy
         Vn7yFD1JIONuHVCCd3dJX/WoJCKOuIKSQrqkOosuRZMVFINgENxHk0cIaxIFndf4EfwF
         GpnobeWEZOydLUDEdN0FLcmq+jsxTSIcPs4s2v8MJjTpuKL689Zaejse0rrO+ZjSb/mp
         ddTjJqBW4tgiTuthSsrqF4NVFnI4fO248ZN8IOu9/VHRXYn5aMfwiUYMrFJ9dbRbEcTJ
         eSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777245830; x=1777850630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMcVPLr/wbi2Q8Kaqf49orEV0Xtu1ZF/I9pLdpkPlEs=;
        b=gsfPk/IrHweud5EF/6/GDGrhCRbyC9MkTzPAmkdCWcHCtXTyY1SZ8H1cazuSQr7dwX
         9WeEXYL7Qr6vgVICYaShJIGx7UiklRRKDLQ15l1orgprsiBZQvb6Vvm+xKizcMP59hbQ
         TqpstH64Lw9MJL3a+pgcp9GFuHIDZZa9rUFJoSAS5opk0Qu7AMNMvxkkXdgMufLWHkq3
         VS5AdorGIKi9V3Kd3u3d0ByXBZRJpnXZOJncO9Jk6cFBgHwUUsrUq6S2tJ3xAYB6ChXg
         rjsiK8zmWU5EDt5An/aw0kEq6JXJaefxZOEdSRjPFxdjX+NHv9OTIpSnchY6XsXlieQV
         hhCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cE7PxfppLkvovDjmWUXq5/0Gi4+9KKbjmaPOvzzLG7mX/J1XaJ0Krf8a4Z2WC0TtkqXoGX6Rk@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJ5ysp5Nrl1uanyYGAtMvj2F4yOaLS0UXk9We7FHlNAit4MW3
	9QgKxVgCsANq/DPMRsZBmmkT+fHno6a/GGwkW2EcjpiWjYJYHjKFpVCp
X-Gm-Gg: AeBDies8IGf/nbL/Re1vXHRpTCnyj9U7/uW2M2dMvkS599bRwyezczG/hsWSaATp3us
	Jx7cbLGPzEE+Ay6PzsHt5BfwvwjrNTXSfK3R2IZB/Bp9S2yJXs0bGbD8AcS1EY/Sv3nsyZvqDrL
	CU8OOxPPwFwZaFjhUCpqU6easQzW8OIF2oq3LvjIiPtq7ZW3vXNGQssrA1o8XXLyEwcc5SMoG9F
	cffGT61CG+BvWvVfBTxIE/9YKSm0e0gO/PwCoy9WBzYEN6PI5upQkh57AIwdPofjMKaJCfKIbRx
	J6jGhQqh0cm/ZvQisMSf1rv8pbsvwg9ONG/VGOyRYpGJgfRxeh9wukk5lRWwXY5ubwK6sRIrxJP
	4ZDlle2GxAb3CrzMhPKcOTUC3dJpmSBFSIjlF3uUpaNub8d8ANQeB8/fZ/KM6yPO7gQM1QdEi32
	qydsEUyS7GtMXsWX9y/OIt8nmYQMz0ZxYRPUEOmxZL2VczygxwRvn2pbk+dJG83P3sw37KY+Tc2
	ApM3G9qOMQb2onNv0xv6VVt6vcrnaTKiug1ThT5kvqaWO3JcDjn
X-Received: by 2002:a05:620a:46a9:b0:8db:de3:92a1 with SMTP id af79cd13be357-8e79208594dmr5861913385a.48.1777245830182;
        Sun, 26 Apr 2026 16:23:50 -0700 (PDT)
Received: from battery.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d93c2fffsm2383899085a.36.2026.04.26.16.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 16:23:49 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: don't reserve xattr slot when we won't fill it
Date: Sun, 26 Apr 2026 19:23:49 -0400
Message-ID: <20260426232349.844289-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move lsm_get_xattr_slot() below the SBLABEL_MNT check so we don't leave
a NULL-named slot in the array when returning -EOPNOTSUPP; filesystem
initxattrs() callbacks stop iterating at the first NULL ->name, silently
dropping xattrs installed by later LSMs.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 97801966bf32..4ff118a9395f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2966,7 +2966,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 {
 	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
-	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	struct xattr *xattr;
 	u32 newsid, clen;
 	u16 newsclass;
 	int rc;
@@ -2992,6 +2992,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
+	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
 						   &context, &clen);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0

