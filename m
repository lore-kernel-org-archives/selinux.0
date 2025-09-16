Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E793294FB
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060863; cv=none; b=AHqMT4GraVhd9i1MkHpFxRR5hIYaW3p0F006PKyeFz/britnFb1LO98qt21jWMv8bFCfNxS1nZDxN4vZcAC9uf/cOnbu7+gV4vS09nRhc1ZNj8I0B6CjcKAc1+RbVoK3uUDOAblvM0Qbm/2O89swhnuXEm0+E+M/2XLV5oel68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060863; c=relaxed/simple;
	bh=wjQWGBW3KDYDssIaJvKKBP8pYlvYCWVkR29Oj7NozlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXwsSTxBMz1FHrRm3yK8go6Htv+8eoZPW07lLeTZaOKK4IrUYPye48me0UrZQjborRTh5SM9RCIT2Zasf43xmQX61enkzyHKDRB6MAFZ5ylSjSJuXPF0gKBmkLHLP0L8LgYydi06NedYAi8vqxtBxgFSn5JxJy+7FOtBTsrAKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VJ/PZVKw; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VJ/PZVKw"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b38d4de61aso56930251cf.0
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060860; x=1758665660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQQs6+s7fNi4hcDyU6yjAzUQgN3m6Uk9Ih1WTGtofKM=;
        b=VJ/PZVKwmaV9fqhZWAd/OzJ7mp1KBFdUvdqwFhMJiK5omPlpEEBZQpocx8e8sILh+X
         16yEFbQjXUZckrB0WlGjTBSvjezqRjN3xKG4mkGrwN8VT9jm5y0lSWw9N37XfHfa5ujE
         /yD8EMyD2L/LZXmydeqR9DXsfsDoMRuIrIo72n9uK4+2i9WJQyds8U7lHw7s2ZgKV47t
         NZOtIACjbgad0QaVUYKnNswhZSjQz+OpziJF7JO/zCEjIc35CEIcxbiTUMgXkI1r59km
         yRvuKQSna0JWsuIoLSO+6MWPGFOyimVstmOzYX6HazPfwE+J/OKfyxKXDO/f4Q70U0PA
         oShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060860; x=1758665660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQQs6+s7fNi4hcDyU6yjAzUQgN3m6Uk9Ih1WTGtofKM=;
        b=wieyXG5NIBZ8nMNXWCSSrrMLi/2X0Sh3g4vjDRbP9vmyghSb0q+hl26tvh19fB+4Xv
         R7JfRa0xqLxmA6zgiIkTEdPbRftcfkIpHopThbdrlhhUIviXoE3+9w1dNVbfURToYJil
         C2TfJRMwTIfgl1QT6vqSCNsoJWzEDwujYsmYoZZ84F4tFzJgZzKH1Io4CxKAW72L7OSf
         /OGZBcw1/q9bjUK6vOipQpzF5XcohKNRk8RuA+ODJnOxuV5+oRghOkNU+fXcwoSoe7VY
         JghpYY4kg44vVPXWoZYA1+JnLcDb1O4CBJI54GzSmDqyOCc3ptjQdULVyIICOvlxVS7Q
         ZhMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX63rq6q+23Z4JfghWMrdcgsi9qsN9Fbms0FpoyblE2klrp/nrSwfElKEojzXr4DTZUY+3BQVN@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXfW+0g3KNrqyfIkMcY9rpuUIa4+qH63C18Q0hQP/g6LMVJz9
	GClltrmguXhng7PjYgdM2s9sWzwMpieM8FtDSz7LXaotz3Ao1ao/2cD+MREpecmywQ==
X-Gm-Gg: ASbGnct7bcJKw2wtoZ0/ZN3KcTHR5ZDBXraRjsqb68cQ7lxN3XHny3X0aWpGBV1Hmc7
	yXyNJDImg4ZPebhgcZeg1dw1sgQEaILAlFK8RKwASkOiq7zorXRSD68/fBOoQl9dtn6BPcj6dz7
	xPhQ0tUDvVl8IiJBtMz+1Jb3sNBkaDzSPNhOAbtKxjZhbK7anEED6VVRWjtw4c+/raF1gXlpKkb
	u5wJNZexcOmwk3Lc8ga1KNhK0uyFYFxHbxiBEfz+wjpN6vLYcYwoJt2nNjikLR0hy7XbhgRvRax
	7REqwOEjL5Kbf5wRrXL9MIB9341i8Tndv16JoOPXjP8pnBE0BxuiUmiliXUu53DD0FLmeAcXRTQ
	WDxVORtwObPcmAw7krWvRZ13jtrZXn7e3nVkY3D6cbe2ulkWcVftMNeyFOVe9MhqybqS9Yilpwe
	F9ju0=
X-Google-Smtp-Source: AGHT+IHMRo/QZYWnjXFNxQqo7cjhGChO4vGaYAiG6VsPzajxuoMRQwLczoMSXjWLqT6CyMUzsp28Mg==
X-Received: by 2002:a05:622a:1389:b0:4b5:e63f:d5d8 with SMTP id d75a77b69052e-4ba6b275c08mr622181cf.59.1758060860598;
        Tue, 16 Sep 2025 15:14:20 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-77f44157463sm50608916d6.2.2025.09.16.15.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:18 -0700 (PDT)
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
Subject: [PATCH v4 23/34] lsm: introduce an initcall mechanism into the LSM framework
Date: Tue, 16 Sep 2025 18:03:50 -0400
Message-ID: <20250916220355.252592-59-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5320; i=paul@paul-moore.com; h=from:subject; bh=wjQWGBW3KDYDssIaJvKKBP8pYlvYCWVkR29Oj7NozlY=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8Un9tT3wVCSqlbaCp91l7GiMaXz3OmjXW9C 8VvKL62J32JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfFAAKCRDqIPLalzeJ cwE7D/9cXO1IeJWcRKFUy9MgBPwRw8MTTBKecF+qA+crLGtmZIZatOpP0mCja5H+Dav0QCV6zXP WSkNAw57MsJSFQV3dMCtyx6A6CKHMNKfBpsJyPt/5psHh4xzsuu1XFXdrliRLQxguxMF9mVB+QS dTlBZKzhpP9kMDpSdINV06duggHI66yC5nIYIxjLulWqbcklEm2bb07+Ff5fO2pIMymkgkfYF3n bUt+Sh4TCGQP4Z9wv0xPAgMarrt/lUnOOBsHXFy7z9xHadIOqWSxLaNQl5Y7pfSnnPZp3xF+Rpp JDebA7ew/3MopjWc4JaRGlbtnZZEJbMbs3rmefNzGWuKGbMUJNfk6D1/rE91MDgE2+ahVsHzsUR CTthLMpbyh9bKESfWFKxfqxejGYgUwn5lX4yDXdiP0ki/FxrN2idhazU98cDuw49VGV7ByJfJyp +nJDJCC38aCT6Y5Mi4u9SCajl8kcGQqq144cb0KfpPvu/Qo4yLFaLa4HR+mkwNr9Fajt/RyL5L0 HX+IKX6+5UyZRGpjnQcCUoXUm7cYBmSMvXCHQkVTl0alLD3biIxiMhtwqPjCVbcPjJ9+C7ZtT6n RTJ1c0TcYpwNh8zS+/xUJUdBFo1MuCYUb3iMFGdjxoRnw6E3qJ0rj5U9C8rPcCoU5HLD0utxGdG wtIU55vl8364Qug==
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
Reviewed-by: John Johansen <john.johhansen@canonical.com>
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
2.51.0

