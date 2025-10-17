Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F482550BA
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734152; cv=none; b=ojpjQG4Og0E/VYDt73VBPv3cLs43YNwNMLgSa9QIAq/hGwoJ82SduN864cFJL89n5mMZ+f0PJzZxajYmWaKqiO28tn19XELi06rR8yrfErY4hS9xmYfti0dK+8nJxL6wXYHIhtbs9D3JtanY2Iz4bICgeZfXykc7I93YPbe7fxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734152; c=relaxed/simple;
	bh=7HdH7ZU4mhEK0U8+ylzT/vmDjjDcGTN+ZMB4CxSvS/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HilxBluB9gOjusCpW/DUs5Bq1ix2UXZNYr94k1uekK5QbxA/TB7Y0AX17EKRFo+GFC7kqeENaQlyJ8adGYH1iYeA1ImrBbeQhvV9nQqPFbAmYg3FACtGDVIcHbS6mN0j0F4cbhNjYgA/BQ8J3OQZLcVGKwagW0uVNHClmXw9+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AZqIqOn+; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AZqIqOn+"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87c1877b428so40640976d6.1
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734150; x=1761338950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp5rpHSRP6no5p+XDNQQFNPVu5IiBO5VBXCfZ/brWkk=;
        b=AZqIqOn+2e0Uma6fxMW2+50pXJV0BLBgusb83BCEBFqzEz2JqaFThAZV/lTzplQEsL
         /owOJPiosjDXsBYZMAsKhuDNUaYhAouBEHlLnsPCCt5Lgr0d/2Pb233C3fAXWebDjOqU
         OwqTUpVM0ATl38w+qKx3p5HtHu+ZwuKowqjp1Jhbcc2LIZGMnUQbxqdK1uTdh72P1dbi
         GTwTri3uQalq+riDNQq6ApsRb5vVW/kkWMgmp+1ujnE+5LdH6aUItApwe15/Mjxxblri
         XUWGZei31dSieourhy8QC/0KU7aSXW5n1w9TYubXw1JBODK+d1cf3d1EV8e4DoI3gWk/
         8Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734150; x=1761338950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hp5rpHSRP6no5p+XDNQQFNPVu5IiBO5VBXCfZ/brWkk=;
        b=mHhGLn8ftwMhZmyKhnMCrsQ3I/5Dzsf7p6KsWLIO+HaiU1OA4x/XuBNyjqNJBU1fnD
         3VxMb6W29GKTXVRNV6UXr+s1ZhYsyoEUUw7rolFkR6u8xTbQrBAkuP3cERN7Bjt72fyY
         1H9fn39Fe6/+Dr4wFNsr4b8fNgylkMp1viC9fkY2z9p7mGI6j+2E3CIGtK/41hVA921m
         N+CS6sosIHwxq/YzzLTA0cEJ2KZXICzxiM7KtWlzzNwq8AFL4vqRplc/UCaCijXzpRd+
         V2HG9HlOAjsRq7dcFPMvRyBfOjlviV8/057jXiPITouGmW6Rx1qtjY9TCTAOpWzt1Yqr
         Ym4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsoopJOxkuepIWl5I7qzgXAHMMAn3Ig46Y9pDsSS/mQhh1DQ7hzCmxuTl/IfV7WLC+ndPhF5zw@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3ggBvVUho/ldaaB+mEbWwcr5BvI2A9g5PhYCnJvOXzIh+pcM
	3RdspbE6hHe3Ob1uxAM7DRJXbapdLPVm7wxAU1fFh8M66fNTi3Ma0KOI89sfyf2AtQ==
X-Gm-Gg: ASbGncupWjIaDStebp8BW7N2S2tX5UaMF2PpMZW53Y+qkMboSuwxhEU2ofeGRPzVvgb
	fC2i4MJeKGjdGdZlLJOcofQjmY8T51v9kea59yJKPhWFc6x1cVwWKlG/KDFy0IZdpYqpN0rp46V
	+N98kAbvQSA27pySLCZVaqvT27GNVgej/jqTFGwBZHFf1n424NWYiU1s5NWrS5NFmT8DiTKLr1b
	NaqC2Gf0cNPBr3tipdN3oOpEFmjLosLwd6vwEzko541BXkmIjndoz4uAPZP3D4cZu7cEO24bYL2
	9+pkZ5Qfr1CXU9QAXI4ulDwBX8CfiLr2SYVER5+5jYGW6V3aDAuEhQJF43If/aPozxJzVv1WvDm
	Rr5Qlp9KBSnCnjJjJGXETHPkkun0scaoZnaYs8z417QXIskGfA8LgG4dnQL8sjINT4yKiitnxUD
	hwDX1yjVPdd88tLJpq9ZuApgEFZXmRFvBOty+b4CFWFRmUqQ==
X-Google-Smtp-Source: AGHT+IHYC/8x/2/N9yviHhrF7hTN7TOdWicO4p3mneTGpNZoFTAx8Bjh5tx+d+sXhE+LJnHb6VZWEA==
X-Received: by 2002:a05:6214:1c4b:b0:87c:17e4:e11c with SMTP id 6a1803df08f44-87c206111c1mr85827496d6.34.1760734149995;
        Fri, 17 Oct 2025 13:49:09 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf52209cesm5136216d6.23.2025.10.17.13.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:49:08 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 10/11] lsm: consolidate all of the LSM framework initcalls
Date: Fri, 17 Oct 2025 16:48:24 -0400
Message-ID: <20251017204815.505363-21-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3185; i=paul@paul-moore.com; h=from:subject; bh=7HdH7ZU4mhEK0U8+ylzT/vmDjjDcGTN+ZMB4CxSvS/o=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qusjE7MOxIhnsbTYVijT9Y8nVsu7NAg3AOUt 66BJHGhFVmJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrrAAKCRDqIPLalzeJ c3BpD/94CWPRxv1D7ts/MElgcjWn0kyyRr52fQbl8v8/FqG55zmiebclkUOuUAQIGfxgzSLQNRj /bbBef+C0OHHbfDgYHyvRNNh4sVeNKdWOKh4xb2bZAu2IJVI70JlKN7UzlV7FGJTNJwECDsIKpU ZD/+3f/VlWYqPe6f5kigGelO5E0EXy7B9kRufBocTsqxodpXgiUvfzXD5mhvNe/XhAH96UiBKyk sb0tP2POZAfrG3vKO37kixMpPavgEOyF61LLS0QCvgf2GWHXZTS4L4uxAG/Of3gB2/EUq1+h7ES xLcUoz7kOMiRdsBAc2NZjSgS063F33wZdjnETpSP5p7BUhYNM0h4dEct8sAInNscXnvY+qtpz0S tgJezyj+cedyMezz94pTZXrkLUVlLikLFtl0xGHcgQyZ2EbiFFZ0hML4M9jgO1BW53gP4UMwML+ Qnvks/77r4RwGXF+ZNjO6ONFFUp7OPrEg5wC7Urg92kxbq2XGsvDPzGlaap6hTn6hT60blILlwA +C71xrHgC9LM1zfq5RHjyJYZkRCeQbJBgioU0s7DBATNrJM13nzx5UgEUueuIqNFhncPkKPOH61 SsvfPoygtTIzNTDOxFjq7M5J6a0ZnoNOmfJHLwTWPEf4yFLke9L0ZqdiF5yJM/YlftKOLoeFvvo V5lGgi0+NapZxeQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM framework itself registers a small number of initcalls, this
patch converts these initcalls into the new initcall mechanism.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/inode.c    |  3 +--
 security/lsm.h      | 20 ++++++++++++++++++++
 security/lsm_init.c | 14 ++++++++++++--
 security/min_addr.c |  5 +++--
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 6620c3e42af2..ab8d6a2acadb 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -368,7 +368,7 @@ static const struct file_operations lsm_ops = {
 };
 #endif
 
-static int __init securityfs_init(void)
+int __init securityfs_init(void)
 {
 	int retval;
 
@@ -387,4 +387,3 @@ static int __init securityfs_init(void)
 #endif
 	return 0;
 }
-core_initcall(securityfs_init);
diff --git a/security/lsm.h b/security/lsm.h
index 8dc267977ae0..81aadbc61685 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -35,4 +35,24 @@ extern struct kmem_cache *lsm_inode_cache;
 int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
 int lsm_task_alloc(struct task_struct *task);
 
+/* LSM framework initializers */
+
+#ifdef CONFIG_MMU
+int min_addr_init(void);
+#else
+static inline int min_addr_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_MMU */
+
+#ifdef CONFIG_SECURITYFS
+int securityfs_init(void);
+#else
+static inline int securityfs_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITYFS */
+
 #endif /* _LSM_H_ */
diff --git a/security/lsm_init.c b/security/lsm_init.c
index aacdac406ba5..0f668bca98f9 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -488,7 +488,12 @@ int __init security_init(void)
  */
 static int __init security_initcall_pure(void)
 {
-	return lsm_initcall(pure);
+	int rc_adr, rc_lsm;
+
+	rc_adr = min_addr_init();
+	rc_lsm = lsm_initcall(pure);
+
+	return (rc_adr ? rc_adr : rc_lsm);
 }
 pure_initcall(security_initcall_pure);
 
@@ -506,7 +511,12 @@ early_initcall(security_initcall_early);
  */
 static int __init security_initcall_core(void)
 {
-	return lsm_initcall(core);
+	int rc_sfs, rc_lsm;
+
+	rc_sfs = securityfs_init();
+	rc_lsm = lsm_initcall(core);
+
+	return (rc_sfs ? rc_sfs : rc_lsm);
 }
 core_initcall(security_initcall_core);
 
diff --git a/security/min_addr.c b/security/min_addr.c
index c55bb84b8632..0fde5ec9abc8 100644
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -5,6 +5,8 @@
 #include <linux/sysctl.h>
 #include <linux/minmax.h>
 
+#include "lsm.h"
+
 /* amount of vm to protect from userspace access by both DAC and the LSM*/
 unsigned long mmap_min_addr;
 /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
@@ -52,11 +54,10 @@ static const struct ctl_table min_addr_sysctl_table[] = {
 	},
 };
 
-static int __init init_mmap_min_addr(void)
+int __init min_addr_init(void)
 {
 	register_sysctl_init("vm", min_addr_sysctl_table);
 	update_mmap_min_addr();
 
 	return 0;
 }
-pure_initcall(init_mmap_min_addr);
-- 
2.51.1.dirty

