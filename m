Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1D248F48
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140276; cv=none; b=n/fueF3u35blU2DvSCkNvc6l6Pv9ecJhyn7/ggva/v9v+yXGFGaDZ29FGzDHII4bcCmdIURm8l+Bh+K4l/CUc0ECynE3p54DhlT2dfJ3qx3PjqQC+GMrPkc0hEdp+t471Dy9uCp7q/McpaQH7qRRD7e6xeBjWCSX3YmO+4Xit/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140276; c=relaxed/simple;
	bh=vPdc3SOpTci4+4mp2v/bZ1LnI+BPfWUsg+wEZDAEBxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M38QBSrqzvpoa9eX+3EVcjZAExX/yILLcbU22u2Gw7SsZs6nQ/5VxQpt6D4etHbVWzdU3X+xmkP6TLMIlMU/8Byjnd1YOIGFKAA5bY+EzWFDWLSry/mdrwxhl9tnzy1IQXeQExmW9BCTr7IU9IDlPJguhw4At5oYN1d7YbWEnq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZKouTipS; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZKouTipS"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab92d06ddeso71897951cf.3
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140273; x=1753745073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DARCErLbFdrtL4b0TUanJSyLAvm37+avSUaQyZYMHDc=;
        b=ZKouTipSFcq3qWO/DQaYQRRQqC+47ptmDCkadKHqX9aAa2AiJPInkM/j7NnguPQYvO
         Jf0hfJ9M0imCDXzb0XnEQ7FUs/6DqjWMNTVaiM2hxpgZcR8Q3twlNd3zzXSr1DTYOS3U
         JqCLg1BdtSqmATKXOkRlzVEhOpF8HrENQtI7U/LNuGXkZZwG99xeFaRS3FRB9ICfwJ29
         /5AIK4la94EeB3tN+o1RO1jyu85fgGqLl1R9dwWZ8cy/ujaSzQenvdFD7jRvUhXHCQ7G
         6y9o9MIhZMEugh1l4CbwfCfRrZDuAg6fHDlCU/5/A+mDCLK5FR17iRjFDiUirsQm6RtJ
         IdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140273; x=1753745073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DARCErLbFdrtL4b0TUanJSyLAvm37+avSUaQyZYMHDc=;
        b=m+ravHCHPzYRNvGdsLgO1qjxiRDCPagH2hUm5EUweicyfsheGJOg9q6ppa5CIUiNlI
         pXZS+gAntbAPQjuTxOG4BIwVXOzYy8F/WKqYVKGrSzD3FLBDVYZiw/AVq0z6UoMTQ8Qd
         m+iNZm/y8C9rq4F/uAQDU7U+privZDxN6LFeUQb478/SSsalQAmqNmaUWSOPsT1Ftyel
         glsjD8qk94VJzkjlewxThwjRcjfJ8DuxDt2o7EIO0CXiMZC2YEtCTCSKFzRuCkqhAvx2
         R70ZGB3V7CzNyvFI7ZECpnLDm80/1oFy8blpp/N0T9NrJe0N24XWfp4nSsqW6Hl9ZMuh
         h/qA==
X-Forwarded-Encrypted: i=1; AJvYcCXUP8BdxR9rQLzFbs7ZBTKhUX8bhvxiKUvKufQ0e3YBeUN51v+iPacCSdacMLvpYeTgmHQAuCU2@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9IwgwfWIvO++oPP0iI2bTtr93WCFuPK34GdQuPZS01noEori
	bo+v6qiVhggSch0SI/gbKef0GhukFlmK01n+f/ywRh8pftt0X2Co2RIOOoCYwrny0A==
X-Gm-Gg: ASbGncuoZjF/LAT23qBc777WGLO2l0FXtwKzrD+Mo9hYEuy7gtENWXHGKpL8tUk37B3
	QhMBemtUV5XJEkVpR4PEaDSSqaeD7exllF1i0CntEs6iNasn6WBVpaHEdhp8oQDRoLHOeieylkK
	MryyCud5roszPOrwySzhyt6bbocq5YgdMOG2hwzT5t2zqw5DIrJBRcVWvLESzzGQicca6tzO3aU
	Q9vqTssIzxy1H4FUHv49zOwzMSMAoWzuFDfGzuVzD4GAtaGMPln5wGf6UDsV9RoPHeOgcfB8Bwe
	aHhaFFLCounohMpK8qeJB/VjJNJOGwRNvqI+Ghd47yETr6GCeg93iYoC1hPIpfvysqGDQe0z/St
	slsKv/nObrYC1yaCoZv5H4+r5y2NFIPjVF+mHHUFCoreE99Ho7AXlF28xj40wdz3Y1Ds=
X-Google-Smtp-Source: AGHT+IEtcaO6y+Np/BJMERrrGq0CaDYXK2MGsxEht3zTpDKq9mNJWoW7Kmb2NsiBiQv903P02Ol91g==
X-Received: by 2002:ac8:7fd4:0:b0:4ab:3b66:55c8 with SMTP id d75a77b69052e-4ab93dbece1mr334223951cf.43.1753140273490;
        Mon, 21 Jul 2025 16:24:33 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb4b456acsm47608071cf.63.2025.07.21.16.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:33 -0700 (PDT)
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
Subject: [RFC PATCH v2 31/34] ima,evm: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:34 -0400
Message-ID: <20250721232142.77224-67-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5630; i=paul@paul-moore.com; h=from:subject; bh=vPdc3SOpTci4+4mp2v/bZ1LnI+BPfWUsg+wEZDAEBxQ=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsv1mvfsXawxeSk4vTJh8jsaJUF27gUJxAzVX 6xMupStek6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L9QAKCRDqIPLalzeJ c+ITD/4lmUFqS0HRQqG4JszNs4di9O/RUBo9iQwDZfPj7esS4ygaSqB7UA5lFEPykfWsDXfz2Q0 iIeItWqYrAtgTdjoIpYMM32tNpPyhXugv8/V3Tao/LwndaOa/DUts4jSvQYuSjKdKIcFrV4ujRv HhksD3eDwMN2UmNuZeqo4w4r0nTomVzDNcWLT48WDLtZx7B6b5ThajRGgjlpS5TfKgE93wzJf9z Bbh6hDdPvNqPlym9JMGUcpTX1AzphXj4tXsjmplwnleshyM97q7eIruXZax9PmnGAve3xE/sGHl 9mOwkKW8b2w7J7FZVFVJc6Bx5hBsh6XoxWTgFj/Brk+xPwDN6iDkDr9owFWbFzLf/3KyXgxqUNa 4gQCeAZYyvNbJzhADptxWCSHe3hGdRMSoZqXr00pbPePqhCqNWZwsoyT5sYdF2KETDIFrb1lJxc 9728tk9Og5wXsLqINorcIab3NU53xKWh2zUB7H863rUoMKOuPfKDr4he5Ydz+5ovl39DmD4r/G4 T6Ep3U3Xp5Vn5SDHPLVgGM2HAmciYDQRFQO9Ui/kHB/M74YQQfzZuhrM9lb2i0AblM1C1Y5dltg ulhqZmKMfgSMERZh4n+XVikIfRly4Z/wY1Y/hBEbb/FMLqk2AT9eh1prBADwj5pjZ3mJve/POok A2Y38LMV3Tj5JZw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

This patch converts IMA and EVM to use the LSM frameworks's initcall
mechanism.  There was a minor challenge in this conversion that wasn't
seen when converting the other LSMs brought about by the resource
sharing between the two related, yes independent IMA and EVM LSMs.
This was resolved by registering the same initcalls for each LSM and
including code in each registered initcall to ensure it only executes
once during each boot.

It is worth mentioning that this patch does not touch any of the
"platform certs" code that lives in the security/integrity/platform_certs
directory as the IMA/EVM maintainers have assured me that this code is
unrelated to IMA/EVM, despite the location, and will be moved to a more
relevant subsystem in the future.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/integrity/Makefile       |  2 +-
 security/integrity/evm/evm_main.c |  6 ++---
 security/integrity/iint.c         |  4 +--
 security/integrity/ima/ima_main.c |  6 ++---
 security/integrity/initcalls.c    | 41 +++++++++++++++++++++++++++++++
 security/integrity/initcalls.h    | 13 ++++++++++
 6 files changed, 63 insertions(+), 9 deletions(-)
 create mode 100644 security/integrity/initcalls.c
 create mode 100644 security/integrity/initcalls.h

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 92b63039c654..6ea330ea88b1 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_INTEGRITY) += integrity.o
 
-integrity-y := iint.o
+integrity-y := iint.o initcalls.o
 integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index db8e324ed4e6..823573bcaa27 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -25,6 +25,7 @@
 #include <crypto/hash.h>
 #include <crypto/hash_info.h>
 #include <crypto/utils.h>
+#include "../initcalls.h"
 #include "evm.h"
 
 int evm_initialized;
@@ -1112,7 +1113,7 @@ void __init evm_load_x509(void)
 }
 #endif
 
-static int __init init_evm(void)
+int __init init_evm(void)
 {
 	int error;
 	struct list_head *pos, *q;
@@ -1179,6 +1180,5 @@ DEFINE_LSM(evm) = {
 	.init = init_evm_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &evm_blob_sizes,
+	.initcall_late = integrity_late_init,
 };
-
-late_initcall(init_evm);
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 068ac6c2ae1e..a4b88d67ff43 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -11,6 +11,7 @@
  */
 #include <linux/security.h>
 #include "integrity.h"
+#include "initcalls.h"
 
 struct dentry *integrity_dir;
 
@@ -42,7 +43,7 @@ void __init integrity_load_keys(void)
 		evm_load_x509();
 }
 
-static int __init integrity_fs_init(void)
+int __init integrity_fs_init(void)
 {
 	integrity_dir = securityfs_create_dir("integrity", NULL);
 	if (IS_ERR(integrity_dir)) {
@@ -58,4 +59,3 @@ static int __init integrity_fs_init(void)
 	return 0;
 }
 
-late_initcall(integrity_fs_init)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ded971bdeaae..ea9c0ed12e06 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/iversion.h>
 #include <linux/evm.h>
+#include "../initcalls.h"
 
 #include "ima.h"
 
@@ -1182,7 +1183,7 @@ static int ima_kernel_module_request(char *kmod_name)
 
 #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
 
-static int __init init_ima(void)
+int __init init_ima(void)
 {
 	int error;
 
@@ -1257,6 +1258,5 @@ DEFINE_LSM(ima) = {
 	.init = init_ima_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &ima_blob_sizes,
+	.initcall_late = integrity_late_init,
 };
-
-late_initcall(init_ima);	/* Start IMA after the TPM is available */
diff --git a/security/integrity/initcalls.c b/security/integrity/initcalls.c
new file mode 100644
index 000000000000..92ec9f0aa2a7
--- /dev/null
+++ b/security/integrity/initcalls.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Platform certificate / keyring initcalls
+ *
+ */
+
+#include <linux/init.h>
+
+#include "initcalls.h"
+
+/**
+ * integrity_late_init - late_initcalls for IMA/EVM
+ *
+ * This helper function wraps all of the late_initcalls for both IMA and EVM.
+ * It can be called multiple times, e.g. once from IMA and once from EVM,
+ * without problem as it maintains an internal static state variable which
+ * ensures that any setup/initialization is only done once.
+ */
+int __init integrity_late_init(void)
+{
+	int rc = 0, rc_tmp;
+	static bool setup = false;
+
+	if (setup)
+		return 0;
+	setup = true;
+
+	rc_tmp = integrity_fs_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = init_ima();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = init_evm();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	return rc;
+}
diff --git a/security/integrity/initcalls.h b/security/integrity/initcalls.h
new file mode 100644
index 000000000000..5511c62f8166
--- /dev/null
+++ b/security/integrity/initcalls.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef PLATFORM_CERTS_INITCALLS_H
+#define PLATFORM_CERTS_INITCALLS_H
+
+int integrity_fs_init(void);
+
+int init_ima(void);
+int init_evm(void);
+
+int integrity_late_init(void);
+
+#endif
-- 
2.50.1

