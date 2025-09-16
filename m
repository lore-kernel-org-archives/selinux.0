Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3242F83CD
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060864; cv=none; b=W1iz4TshuRHixOhI4RyoXHQOoWWVvkrHF0eAvJOJNhN4vnIs/hfQpC6f+H8gyguERkMFh2dE0qIn6raQ283nsrbQkgvVYGTDrjsSI1bG/RbgU/80U85pm19xJAhUN1c7BtMQt8OJETHVolpBzUyWMnc+dHx/q5QFLJR3Bv276+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060864; c=relaxed/simple;
	bh=Q7ZOEABy3jJJ2JP19xb/Kao4mYXENOAI2IfARTBHnfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpvXPxpUErFRhoeNBZY2zxlrE+K0JyCh7xlt0uQQhyojC2QEHx1tR2g4VLjLJELnTDbqZrH5FwCROz5DpOIVMjfFMZ/M1BN6z7We2YjnHabSst7ACb93LpmhwD5QelBPBllMcYrgawTwBcFnMUG0IFmobLawZdHZZA5Bx+/YLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HJco/9yW; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HJco/9yW"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78ea15d3489so881006d6.3
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060862; x=1758665662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f49nponootI31KA2Yo+vdW3eScDBQdhhKkpsXkVPSDE=;
        b=HJco/9yWSBz3JaWgRh20GsS5mF39/oBDYtd55F2AgMr2ZjhTtDFt4jCqa372AV6R7m
         4AaB8FOGSjgv7EeqHh25yOXSNOA5+NtIMQpneGpxYfR7qwtVX/S9Kp936o9xU8aM5kjH
         bvBgO0Eec5ucMbNI4K44SIiIFJik87OquOGy+rV9kYBAVSt8ibA51E/1i5k4MymNyOqQ
         ii+u6gWLqKHNiRb1sT6XYHONC2KfF0GngnHlXB+28WFON+bacl5z9zKJOs3Cau/Qca4v
         cQ1xwNWzRcRdnlrm8Zf1gOFeJIGe7crkAgJ6QL1JuW+GY9qSo0lsijXCO8UlousI+EYz
         D0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060862; x=1758665662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f49nponootI31KA2Yo+vdW3eScDBQdhhKkpsXkVPSDE=;
        b=EDOLWGFugojler+oE9dilM4hWy6k3ksKlVEtwXMe7AQRfX5aeZSzUVZ0u3FgL5lpf2
         PQ/v0PoupVLWLNC+UfvNdWCRZW5ysRIbnqaC9HkxDx2wN/KHKxocGukv/sgLZBpQ2Wde
         Z4JP2bJvkdWlresWgQ7J2tlx1Pfbxt/HhBRf1vxgAwcjrqRrocxZyrXP5h48yr7jTQEQ
         E3txMSDvd33kuWBtoBdnuwJLxdDz6BIIAej3Qp5MWRXq3F+Y0TBm3FAoO9KDeAF52j3+
         L0k8jEpGNlS2DGvN0XVX4/M+c2ouSi4PSLq/kGZFD11TAhVivkXhpg5pUmtsY2opk0KQ
         5HPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFSgThLtpmjcruPX/zUHSBKDPw4TgxUTgFzVSHV8J00WODlxccrPvixs/rG81wf2PBa7NAYEP4@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZpiZ2CoB4/AIzTpk7x9tKrrVyDslgrEv9wJqqafLIOfLBRJG
	+E/LvQahtH1zJUL3ZsJw3EUUpVGsVURpkqTjgpULb6ABaoZp0wihVaiGlMOKfpdofQ==
X-Gm-Gg: ASbGncuHcx8b8EKy1ZPM0fOA5mWFVGm3cJ+GAroptrKziAJaqXrdmZV+0Lh0tdalWo0
	9hvLzXsaaoS/oLBVFBK2UgFra7JjAGs6z+KtaZLxAV+4vIHH2rUOMsxwh7FMnguKPfZxU/BDX1G
	9GI8TCEkTJUgIG9Hr/DcsVfNmeknH+7aFJGonxz6f5UAaLn8fHTttRvAcH7Hr5D2pibu7MBklxl
	WlyL9/RE0SIc5K51c0rI4BDiBd5jiYWCv1dCXTcsLE19RVyUU5LbPVPf0Q+1mTib4V4S5Zxv5j6
	G9oF62BK2261mRWoteHhKeSBOvDQXKXWwov5Jvef2A8oxps5Pr8JvSyWZJfrL3qWbTjEz+4wiuE
	P6KwcieJ3t8w+bqls8UhdxZyEICBR9tPiGNPiJWr5DLbA9PN9Oi3YvNKnzROO3GzBvNKw
X-Google-Smtp-Source: AGHT+IFBjBQFDuBmD2zDm7TZmOYfn3grpHuemV/xzDj6uRYVQVkAzf+tS3nnFdOvHixskRvBDTPQLA==
X-Received: by 2002:ad4:5ba8:0:b0:786:8f81:43e with SMTP id 6a1803df08f44-7868f810840mr73130766d6.33.1758060862371;
        Tue, 16 Sep 2025 15:14:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-778d99113d1sm59678156d6.68.2025.09.16.15.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:21 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v4 24/34] loadpin: move initcalls to the LSM framework
Date: Tue, 16 Sep 2025 18:03:51 -0400
Message-ID: <20250916220355.252592-60-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=paul@paul-moore.com; h=from:subject; bh=Q7ZOEABy3jJJ2JP19xb/Kao4mYXENOAI2IfARTBHnfk=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8XU60aTMDAMqFMWd8cnCUNeXZi+xCbcmY9Z mppqptDzHeJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfFwAKCRDqIPLalzeJ cxeED/49StXxU3L1Jv4DL9L1r859r5yYY4dHLlGw7K39Ymx+kD0IA1s13Q0HA5YqSB59dWn895E kF8xRnX5836nOj0ad6xlihtTPMY5wiPo1SaNeQNFEole651/lCaqNyaI3qB8nrsDleUQ4T/+8iJ 8eat6vThH9sepGGTREMOu2yFvwVYNXWweA/fz4kx25Jfa4RXKH7D0IK1QTEikS7v6gLf3nY/ib3 5YMfMwmqduRJnnSeoJyPIWJO/dLZdUZxOki8ZlZl+sMBDEpudKJ6ve7ymnnBQfyt85HG/UXZIZp iULJRyvp+0jl2aOr1uTD7Dbszp/slvPFw/+9O3YjbAFF+Ux95X7YsOSv/DRKBfONZU0VbjuxTVj Je/Omf1OFkIPX0UW79q4BtWZvOdy6vUA9Jm2LHNEWj0jz5MGfnxgTCR0v+trq/kmx3ltAOO85+Z D+/Hy7htdRhfIU+acTW/lfBYgL/Mt1HR6EYXZzCssgE/lSm3d3hcu6nrrKZYa/s1H/cmeQUnSse ZhezVgB++J3w1KP0FlTu1GO3uJqk7ni9ad6h2C9tntdM3AGFxdPJQ2SbVapTIV1BlOo10KMyKYO SX3jEROqfgDpcSyK+I8zMulHsZMN4Ji/AG//cGYzu2g8S9Zx75EkiyEPMGZqUJZRo224kdwTJ1U 4PHrdiC+1aSqfXw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Acked-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/loadpin/loadpin.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b9ddf05c5c16..273ffbd6defe 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -270,11 +270,6 @@ static int __init loadpin_init(void)
 	return 0;
 }
 
-DEFINE_LSM(loadpin) = {
-	.id = &loadpin_lsmid,
-	.init = loadpin_init,
-};
-
 #ifdef CONFIG_SECURITY_LOADPIN_VERITY
 
 enum loadpin_securityfs_interface_index {
@@ -434,10 +429,16 @@ static int __init init_loadpin_securityfs(void)
 	return 0;
 }
 
-fs_initcall(init_loadpin_securityfs);
-
 #endif /* CONFIG_SECURITY_LOADPIN_VERITY */
 
+DEFINE_LSM(loadpin) = {
+	.id = &loadpin_lsmid,
+	.init = loadpin_init,
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+	.initcall_fs = init_loadpin_securityfs,
+#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
+};
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
-- 
2.51.0

