Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29B280CF1
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212088; cv=none; b=AheBb7riHTrlmvUNDDOdhmXbYFt8p9cGZJSjmYMRC8nw9G9YoM6/SQU4NOp4W9h96wr4tfFlHuV06eQ3iL6jpmeH+3uNvx7Q1/Lx9VyR/kvnQuCKZz9nkrDh2gP3kWKHt8gLjO8d1xMhYeQ8NH0mGDnEQ2O3g72TkcRgLS1s1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212088; c=relaxed/simple;
	bh=8PW1HHQ/gAI0CJ3u8ssClkrgUUPMlnx9Tq+e2wxOLWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhOa5RW9C7VoQ06p2uu5NAe2U4fCizGT8WnOvkVtPV0qJ37REFbgkyGpMLssNqrgVViZVKEdD7U13gUpZByCmUuCX09YENzlgff1+Qo9ukjLOM/uKcatz8qVtfy0qelyF/nQESkeic/MMnpgko4jPmWYr4tFS+HCzM8qugUg6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bNvldAaf; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bNvldAaf"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e870325db1so138204285a.0
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212086; x=1755816886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jurTiI6w4d8RMzfoG5sAo/X5GYpN+c9bnuWfwXBVv00=;
        b=bNvldAafsHSPLcyg7l0lg1upjEDLCDU36FMNR1RDRpTPmo6A9l6yOekq9QRHZ6Kef5
         rVKMA1iMn2FZqZtGxVNK2nGRydwKiup91lUVuRffFDedlydhVEBl4j3VwztoZBnmii5y
         y5rkd3Pe9hwwHiWv/rZ+WkdUtYZ/CEhrmtVJIiR6BO4+0oqktH/vzpuY9Dbsl7OfQabL
         qJNWP6RABWIvZrRfwAqiukgatzHs3iQGWR6Es5ph22ERqBuL+FogRpBDeSdiJZBXSvgR
         ZxCpyjqGCLDN5XLy5Y89JzRayP/SejzME84L+6eW2kSdIiTP5ccFIjkKFcOX0MNKDiDr
         Jhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212086; x=1755816886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jurTiI6w4d8RMzfoG5sAo/X5GYpN+c9bnuWfwXBVv00=;
        b=cm1+S+vmBiZlcaxgzd5faEgaE/tH5z9GCWa37KDJ2frp+z8bV4POg09CjJffENX3iA
         u+2tqHq1of5EjTp2xA7ypzURAhSNkigDFMkGZHIcfi0gqdnvxhygmEWFJPOs9LofAeez
         jypqLe8It92Hk8TDuv3Jp9OclknpgwxiF68bF8Il7yguTQzZdspxvCPlSJRfY9K8uBFg
         SzTzOf4R320ks1GMrUvjiEhcqeCrSqcxbHNXenTHmCZtB+aGLOVAgyuW71d2DZBgnS+d
         PwZUyJ8tbvtUy33fHe7Yn92J8wYc42nzNyquO2LkNbas8MU4qHYtk3huFZVy1Mw3xp10
         uZXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT9ks4iAFsbrm5+/4eXiykXtM6dTn2XfpwkP6kJ0fUbGSp4cS8CQhS7K/wXWh19Gfo7CRDjmp5@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+KIDVszMxyHqRq2qgSaMdTaMDF3XOQA529pADo4onBU6HmyI
	hyJuLnvGvQ+zLbO4vGqra6j2pIUTiFwUWb9GKKk7XbeoPt7efTgi4D9Xjph2VFoKKg==
X-Gm-Gg: ASbGncvP6HwVo9YuXsVtoxRfBcmTsCT6U37NEgwqL9vogUriMGJNYLjaIgdo2/ssplG
	UCv/3eWyOPg9uzOLKTBoVap/ztINW2OAk1KZh1jN1NNplLyPdyiEiHA7cJt0VRyjVRgh8R8NJjc
	RFX+NBUTHY18Nag3V6BwmcTiuEBXtmNggCWQF2eOZWAwraEbVmKv6/z19v3wYc2ctT+g5+RFvOH
	mAYLN+4OeKWxlNOVB66AIYIlhcDg2q530vUCgIsnu8qxvBWKBWJ0gmgTWP+33E3iZwn9wCipnzq
	5R3hAOxFluXgDg5GW0BVWAdogmV8L/bcwVHCs13wdwXeydd5SrOl3GkOcNfwZmo0IAD+LptyLLk
	TcoCODq/EBOEXySYySS8r/R7woOrMfIVanfB/MbarqYw/HYHhtKS1Vq/B7eHa7jm3iOY=
X-Google-Smtp-Source: AGHT+IG4Xi51RHAVP1u1Lqa2sD35Ij2ze6XXDW2EEztOyogKNa7hhQEBxH40EoxkPDqqb0pxlKx9PQ==
X-Received: by 2002:a05:620a:7011:b0:7e8:38ba:fa5a with SMTP id af79cd13be357-7e87bdd17c0mr115692985a.39.1755212086135;
        Thu, 14 Aug 2025 15:54:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b4dd0c1sm42053385a.62.2025.08.14.15.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:44 -0700 (PDT)
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
Subject: [PATCH v3 23/34] lsm: introduce an initcall mechanism into the LSM framework
Date: Thu, 14 Aug 2025 18:50:32 -0400
Message-ID: <20250814225159.275901-59-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5261; i=paul@paul-moore.com; h=from:subject; bh=8PW1HHQ/gAI0CJ3u8ssClkrgUUPMlnx9Tq+e2wxOLWs=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjXFqJkpd8Uki+YngdjrH0zJlk/r2EGuzwIv R87uUn9R9aJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o1wAKCRDqIPLalzeJ c2QzD/9eg4eMFeHHaOtcVwQ5sZxy/3tkjluU9thLrB2T4y1nsA3owZXWycN58BFCB/hNahIVXpf sn0ERS14zjA0eRkbW6tfDOYmeY2ygkqjReGQb6JE6I+XbHJ6l1FvxpiRr33/sV/vtKE0AVZ4p/D J1BUSpP0o2W0/41ejXuK1lm0Z2TuElYODHuUg6kBU2qvbTyNZ61R3XxwcuznL5xnhjdpLF/76nt fK9fDh1wXB7bCEH+O7Ym3XXe/vcBdUSMW6TAVQQKmUAHs1kBrk7ce6fN2Qqsgk68YqMDJuOwsIJ o1WdHtgdfauvRCGLgm6K2byY6PzbupfWb9rAdpbNYu3+QjJtT37xTvbYGGW57BWHPLM/TH2EJaL uUB24MvHQpsoRkWuXtOKylo4MKBb6DkJDuBmpf0T/2NeoFcwvVwvt3TX3H/oXShGsFgEjPFawcN rTuUMjN85/QKyjMUmAISEjulqQHA8r6TBVkFD7FqzJmmHXNmASlax0deFdxomZ97OLg2Yy3sN9G aixc9E6WnWuykiqaniqNquq1HFL0+WPYJquPkWsJDdpFLeNEu/iprXBbQG9cM8xjjskNeRQVNFo N+AVj/fHRHUejpQhaoPMfZFB4+DG2e88a/m/Kga4AQize5p5zbvezsHV4JsiI000GZsWWwu8+9L D2+l2ZcGj4DV1Bg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Currently the individual LSMs register their own initcalls, and while
this should be harmless, it can be wasteful in the case where a LSM
is disabled at boot as the initcall will still be executed.  This
patch introduces support for managing the initcalls in the LSM
framework, and future patches will convert the existing LSMs over to
this new mechanism.

Only initcall types which are used by the current in-tree LSMs are
supported, additional initcall types can easily be added in the future
if needed.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 33 ++++++++++++---
 security/lsm_init.c       | 89 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 86e457aa8809..b92008641242 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -151,13 +151,36 @@ enum lsm_order {
 	LSM_ORDER_LAST = 1,	/* This is only for integrity. */
 };
 
+/**
+ * struct lsm_info - Define an individual LSM for the LSM framework.
+ * @id: LSM name/ID info
+ * @order: ordering with respect to other LSMs, optional
+ * @flags: descriptive flags, optional
+ * @blobs: LSM blob sharing, optional
+ * @enabled: controlled by CONFIG_LSM, optional
+ * @init: LSM specific initialization routine
+ * @initcall_pure: LSM callback for initcall_pure() setup, optional
+ * @initcall_early: LSM callback for early_initcall setup, optional
+ * @initcall_core: LSM callback for core_initcall() setup, optional
+ * @initcall_subsys: LSM callback for subsys_initcall() setup, optional
+ * @initcall_fs: LSM callback for fs_initcall setup, optional
+ * @nitcall_device: LSM callback for device_initcall() setup, optional
+ * @initcall_late: LSM callback for late_initcall() setup, optional
+ */
 struct lsm_info {
 	const struct lsm_id *id;
-	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
-	unsigned long flags;	/* Optional: flags describing LSM */
-	int *enabled;		/* Optional: controlled by CONFIG_LSM */
-	int (*init)(void);	/* Required. */
-	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
+	enum lsm_order order;
+	unsigned long flags;
+	struct lsm_blob_sizes *blobs;
+	int *enabled;
+	int (*init)(void);
+	int (*initcall_pure)(void);
+	int (*initcall_early)(void);
+	int (*initcall_core)(void);
+	int (*initcall_subsys)(void);
+	int (*initcall_fs)(void);
+	int (*initcall_device)(void);
+	int (*initcall_late)(void);
 };
 
 #define DEFINE_LSM(lsm)							\
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 363aac92a8da..697482a22a02 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -39,6 +39,27 @@ static __initdata struct lsm_info *lsm_exclusive;
 	for ((iter) = __start_early_lsm_info;				\
 	     (iter) < __end_early_lsm_info; (iter)++)
 
+#define lsm_initcall(level)						\
+	({								\
+		int _r, _rc = 0;					\
+		struct lsm_info **_lp, *_l;				\
+		lsm_order_for_each(_lp) {				\
+			_l = *_lp;					\
+			if (!_l->initcall_##level)			\
+				continue;				\
+			lsm_pr_dbg("running %s %s initcall",		\
+				   _l->id->name, #level);		\
+			_r = _l->initcall_##level();			\
+			if (_r) {					\
+				pr_warn("failed LSM %s %s initcall with errno %d\n", \
+					_l->id->name, #level, _r);	\
+				if (!_rc)				\
+					_rc = _r;			\
+			}						\
+		}							\
+		_rc;							\
+	})
+
 /**
  * lsm_choose_security - Legacy "major" LSM selection
  * @str: kernel command line parameter
@@ -461,3 +482,71 @@ int __init security_init(void)
 
 	return 0;
 }
+
+/**
+ * security_initcall_pure - Run the LSM pure initcalls
+ */
+static int __init security_initcall_pure(void)
+{
+	return lsm_initcall(pure);
+}
+pure_initcall(security_initcall_pure);
+
+/**
+ * security_initcall_early - Run the LSM early initcalls
+ */
+static int __init security_initcall_early(void)
+{
+	return lsm_initcall(early);
+}
+early_initcall(security_initcall_early);
+
+/**
+ * security_initcall_core - Run the LSM core initcalls
+ */
+static int __init security_initcall_core(void)
+{
+	return lsm_initcall(core);
+}
+core_initcall(security_initcall_core);
+
+/**
+ * security_initcall_subsys - Run the LSM subsys initcalls
+ */
+static int __init security_initcall_subsys(void)
+{
+	return lsm_initcall(subsys);
+}
+subsys_initcall(security_initcall_subsys);
+
+/**
+ * security_initcall_fs - Run the LSM fs initcalls
+ */
+static int __init security_initcall_fs(void)
+{
+	return lsm_initcall(fs);
+}
+fs_initcall(security_initcall_fs);
+
+/**
+ * security_initcall_device - Run the LSM device initcalls
+ */
+static int __init security_initcall_device(void)
+{
+	return lsm_initcall(device);
+}
+device_initcall(security_initcall_device);
+
+/**
+ * security_initcall_late - Run the LSM late initcalls
+ */
+static int __init security_initcall_late(void)
+{
+	int rc;
+
+	rc = lsm_initcall(late);
+	lsm_pr_dbg("all enabled LSMs fully activated\n");
+
+	return rc;
+}
+late_initcall(security_initcall_late);
-- 
2.50.1

