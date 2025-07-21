Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A7247280
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140267; cv=none; b=mU8zJM7QycGiJoIC4SCBkcDMaeWmfa34JDRl6Bjbe4KkZN9W0wvBUoZdY/U+sclGwU4pEriw2C6EYqSqV7PYMFSnZ9ovkkJpYx6fs45LUUOeqE8JcQrzm9UNcHHj/26i8HuiS4ibWceyOgBCn9j19eMGdYXcV9OrxtpaOm/bgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140267; c=relaxed/simple;
	bh=zR3egF/wPLe71tgajtyZ/9i1yj89Ms7CuDLgofTfsFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3NeUuv+a3R22JM8Pa+S0fUmFWpjsPkdOwUXILb0elv0qVaflN9JrbHp9EI9Zo4z4G4Dlb6KrfeDeY/44xWsH0+/PPm+EWr74r9XfKQPhRXkhoIXgSJpvqE4GGDpX+wIvuDd+jkLep7xoEVJh0MbuLLXe0pr++x1CIzLuwHuzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d1zBZQCV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d1zBZQCV"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e182e4171bso523241585a.3
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140264; x=1753745064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaM9i8Waobr6uozwWOT1nYE623nUf/uJpp5WdsK28tw=;
        b=d1zBZQCVX+/fBtSBIvHBXQJIuRGiCzi7XwzNe7Wp+6zZsexNmqZBNmls1RiRGW4HEq
         gMJv/5j/n4mSTJ+L2GcfmUHTZh0NcvWR+X4Iyh08s2aXGYdv8FxHgCRmMk9RdC/Zg3HN
         H8Bzujs9TSc6SlbmYkC/kat4Gfd11BInTp1KIS43z3rv0W3uyKUicTbnEZT513oqA4LC
         x2hhRZdSQO9YiAqbIwHMSakbQm/dfxiJ2G+2P+YCIDZLU2hcvnn/R5ck6+n5ewMwuwM7
         u4YfkLL6fHVQh0v1rDGyMvpC6fcyfpdOLf7bYckkJ/KUpZBjg+7c73W5FJ4X5khQDMuc
         sjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140264; x=1753745064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaM9i8Waobr6uozwWOT1nYE623nUf/uJpp5WdsK28tw=;
        b=pvVBaUT/Knxtv8rfq8blJt7Un/Daox1eoA+adLQFOfTFW0mpwUNjyY8lWcRo8ErhL0
         fpdk5Nx0+KjSZ9z2xCLCbYl8avPITfjsI9jU0RwDmhmU5ibVFsZN/6FCCM4IbnTXkSHx
         XvGzGksl9rRXFfKV/rJNTo+v+Pof85a1zjrD+JK5EhOecKYjCAqTrdMsCgdjB3RBnbQu
         vqlY03eNPiNpVwMZN6ezvnLXm0ezQ99IpT3fgUi+d8iC+izMN0XMJvrn0G91HVpVhmBL
         xq4Ei+QKxF6cg+qnXPhOkn690Ubrm4Dsjye6k0NQ0kwd1TEM/W6UYUIDFEGg89ccB+r0
         9WWA==
X-Forwarded-Encrypted: i=1; AJvYcCW3Sx3TeScg4s9jPZ266aKdXOj72aXS+vhA3tr2pwHK8u4ev9jj4ncdhjdRBDjm67+eeP9kEYnb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qWkntMwci0Kyb9E4RSpj1rUVQa/oU2sIaD5JK6nAYoljpUFs
	30bFlMkaU3onLvtTnpLqDDIMv7eYijl+a+7XUu9OunQKZGMWD1jgagV0WsOQUJir+Q==
X-Gm-Gg: ASbGncv4VuXahqXYfgAPgx7tE3EGd+tQIJBccDlkAzjc/IrwR5OBRDbjsVzmAM5f6LN
	dZkk1S8K/+gxeBuGSdUVkmNLDNurNa6nXMGOEoaoCmaAJLTtxSFCdwpu+kgYZNSedimOhy+Ks3k
	VSS7HYnbcQwmPIRuvamRFgPsxSHfkpj3A6bq0xZ6wa2BEJzNxP7nc7wINQ8dt6QNOBSjvZBwL/o
	4wPU1uFq4OX72zEAgIOfNnjFI1lfKMRKqkRd4/ZIKPg6tHFEQlHBBUvtoUT3oYSmII3U5fKpFGG
	Swfbm/s8oOS+yqhGB/vTjWkx+vmWr+lKtJE/SRC91+E2axit+In4j6f2dEA1Ma00pMfvBqJ8lvj
	a8aOaMwBb2skIkxzdj7w/uKfx4SALwruChGXwxfs44HnorPE4n0iG+FlMD3klzCgiRKk=
X-Google-Smtp-Source: AGHT+IE5CkEgaMFLQADYioy/FjYAWCGI90DfdnnG1RT1q5xF2jyQQTcIcco+1HqNfOfopCX7dJzv3w==
X-Received: by 2002:a05:620a:2a02:b0:7e0:8503:f948 with SMTP id af79cd13be357-7e3435ea5e3mr3622462985a.36.1753140264385;
        Mon, 21 Jul 2025 16:24:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356c75cf5sm479800685a.84.2025.07.21.16.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:24 -0700 (PDT)
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
Subject: [RFC PATCH v2 23/34] lsm: introduce an initcall mechanism into the LSM framework
Date: Mon, 21 Jul 2025 19:21:26 -0400
Message-ID: <20250721232142.77224-59-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5221; i=paul@paul-moore.com; h=from:subject; bh=zR3egF/wPLe71tgajtyZ/9i1yj89Ms7CuDLgofTfsFI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvaP23wBIfnmG6m43d6X1PegXqwWiBrkAIXx ZJa2acrqu2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L2gAKCRDqIPLalzeJ c0pBD/9IqRWYyKWRvRaKvwgh63nvD4GC2BtHUOlrFBHJZBEAsZ6bZl2O/lkSu+GOam0mqiXcBuR UpEfnauITcFQudVGTpkEwMNDZ9Lg4bELmJWIAtiuyVxlXxg8sOn1z/8k7Tc20bJeX5OM8sohDC1 gGIczP0vCS0cI82rJGme4KmEuCxOdzEgMAYS0p86MnD4Jzv80kVa95s3idIxg1Ev2rZMs1Kk997 BOmCZOZp+5xUt7KWxSgz0RzMqhLGVW6EF98ZwOaDjg/p77dBN21oaTpOEf+LXYAA3b01P4L9p6U gAZXSI+ptNI/mAPOo5bVxp4m1D4Ne4aVWFDNyXfn4UKil3gby3p2BBsJO2010mC+IqpPx4Hx65m LmxD+RIntxV5e95UNuTg53z7YArnPehUCNf6FM+GJSogsuemrZi74ASqNDRmwZfAt7LYC3PLS2X PWpQlQqOx5r+04TtwEB4M0Mo/GJ13UPqz8hCWTSKVwfNyEbt+RaNY4OKHIgfhjihd5z/l9KYGHe k15HgTDyjNjJdAq6yuqqtOet2WI0XDNtW5xtJxm0jB6F1Cy77FRNU/i5NsZe5wg5G3pXlFhkA+W JKoTCVVmmACFNjfkmvK0ZOdKcKnzmgrJ6QcdUnCUsiIcqEIQFeG/MI0Vsbh2yA9fYp/zVZSMR2Q HAVu+bYRfEWK13g==
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
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 33 ++++++++++++---
 security/lsm_init.c       | 89 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a7ecb0791a0f..0d2c2a017ffc 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -148,13 +148,36 @@ enum lsm_order {
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
index ada9b5448409..ab739f9c2244 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -39,6 +39,27 @@ static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
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
@@ -455,3 +476,71 @@ int __init security_init(void)
 
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

