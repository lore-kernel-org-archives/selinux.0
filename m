Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51A2F5A3C
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561019; cv=none; b=o+GBQKhDAdtiLqldY2Xn34pUN0IOyhGkTFJPbBObat4aKNwibBwgfjuz/ABHsU/XAGlYcrQ6UDM2DTDakebcZ6hLqZRPfuvUE6oilXo/fb/KDWa8HOhy0n17f+elULnwb3KL8EWbmFEim/8TErdQnGg6lqUkYSoYOUMHmvWmxMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561019; c=relaxed/simple;
	bh=sMM0Td1pTUZfgcV1XQAs8U+6FRC5Dx7pl1U5YG27aiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qw15xvOdvN3D8VlSEOooilKMq8DUI7FKkJD/ZqdNst6A9F4LcwV69v5HZ4DEm9t2dCevfW1XozVm1y/tEOlWdCZTaL6g8oSXDmyUob0WKmwjuzVCsZTkJ9sr0cArrrZNcFyP8hrVo7oVuphatTt98oOhgfAmtL3YqIGXVrrZItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbvGk/bC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ag988zZv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbvGk/bC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ag988zZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763561016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43huBOvLkP9Orb60esyoQoOyuL+2DOEyrVCLCaUwMJA=;
	b=HbvGk/bCTNJRyFaTuH7OjeLZnRLi48TGM9Lqjyb2Io7Msb+QFq2maDzKT/Qjqc9XlqPflK
	lpmvxjN3LJoHpLA6UhP6n8bZXIg7RDHc/r/roBRkiAuEFZCrKA2tWovY92nbiFVO3pFSHB
	W+s3qVN/UWvkXiYhGeQU63st5PzULXM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-nDsJVeVIPIagou9h91grTg-1; Wed, 19 Nov 2025 09:03:34 -0500
X-MC-Unique: nDsJVeVIPIagou9h91grTg-1
X-Mimecast-MFC-AGG-ID: nDsJVeVIPIagou9h91grTg_1763561013
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3437f0760daso17580194a91.1
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 06:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763561013; x=1764165813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43huBOvLkP9Orb60esyoQoOyuL+2DOEyrVCLCaUwMJA=;
        b=ag988zZv8Qxt8z/mSW1w6fTmjLZi29a8OYL52vQDFlhnKipC/cSOly5eUMEkntPZxc
         1882D5ML/WCw4jH9/9Ftz/Us6OsII7+oCb/xXYOszyQvREso7V9JOGcrAWL/IbtJNLb8
         kjule9Quo91P8eQ0QkhhyGsUSJzAbZdN++7fJogo5QoiRNm103VO5uWswt1e2DO0hZRn
         cudQbpcW5Q4YC/qWezepjzMeCkkhaAUUn/nAb8fvw9maLkWjl693gk0SNhZpm8p9bTjF
         Dm/JbYQ/6tcFmfF0jIlsO8Hq36l+mVMXe6jVE6It0lPOmDwuhxUrbC4ssTb37cFPQQ6K
         iqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561013; x=1764165813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=43huBOvLkP9Orb60esyoQoOyuL+2DOEyrVCLCaUwMJA=;
        b=UI6jLIX54QAjhfc+z8c+r0qT5vvvsc3Yu8L0NwdsFjc8Rmjtr9hrQ8A0Dvit5KWlL7
         jIYaJ0aEZZb5/1AaTLUxvThV1KbMKAMhAzNt7u4RfBM+q9+sUhHJnK9QgzWj8dr3CuPA
         rHegECe8jH8UsGQPBuXeKrxAw08Cdmm6Wimx0n3B80AVTF/hMeWN/SW5Yy+mbDrhTLnj
         BOOoLUoryf8Vf6tjz+0BsTPC3POmOwm8NSXGRDP0873sPhhjuim/SD4j0d5TJcRU2Lk+
         rWuWbW8e1lk2ch+eULDtBwjhSRmuEA36RbGLUJos0sPN7YQFjFiQ06AHk7TB0XZa/3C1
         wTLA==
X-Forwarded-Encrypted: i=1; AJvYcCWJKN6b1lWREr5S7Xxcp5a18BBFYDUAqm//7PmwuBJ+pXC6DI0vUl755hvDZOXPD6Wkpixpsazd@vger.kernel.org
X-Gm-Message-State: AOJu0YzwcF79HAvWzZ7c0nNIUjvgDXQtxoa70LF4xbUoVZqUw/5RK/x7
	4LLTDFAUFEVDDwXgGAxS46amf1WaBLINbdlfg72cHy1Lkh00b97KiDRF4mCk2XxvfeM+DZ35IOJ
	uTteVvwsD2muXTqgCNSWcWB2kpIhbRFe111mH6D7+vcNl5ltZbL7W2KwNto4=
X-Gm-Gg: ASbGncuJE4UdbeAqQbPcuqFfokpnXNHfnGid4NYIyXh7iwU7mGferaWz+PxFHmhVXXO
	K8KIhThLdtnWK+Jwr89B5D/ai5hOV4Mgu5udqkNMt+/22NnBA4MnVhZH6c25ZurRiqdGzH1f8QV
	XpV8lKPe/TH5tYqNLYEdgVFX0Yj6c2yNQ/f0tNw00KsHr8vcbcjfzrTwmW4IxRAm5TspA7F5aMp
	dXtDqK52j4kxcpz2oDC+3OqstlJYxzkffSt+mvYkFEs85hQqI/1wqumyy19aithxIB3JhK8udWZ
	X4QM22R7i+wPAbcu0zcRiS3IauFNeGM2/G0QzOecMR6cd1OXX/ghv++c+fWT6amnJvPLp7lJK06
	i
X-Received: by 2002:a17:903:2a8c:b0:297:c889:ba37 with SMTP id d9443c01a7336-2986a755422mr235982665ad.41.1763561012840;
        Wed, 19 Nov 2025 06:03:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5JYdLW6VkCpjZEiTrP+h9ubU8Y8eKrRTH5BmmnLLCtVlJCYiAx2FQsMZqrDxFZTIQ2fSm5A==
X-Received: by 2002:a17:903:2a8c:b0:297:c889:ba37 with SMTP id d9443c01a7336-2986a755422mr235980775ad.41.1763561010932;
        Wed, 19 Nov 2025 06:03:30 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b11bfsm210101215ad.53.2025.11.19.06.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:03:30 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: Karel Srot <ksrot@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Fan Wu <wufan@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-modules@vger.kernel.org (open list:MODULE SUPPORT),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	selinux@vger.kernel.org (open list:SELINUX SECURITY MODULE)
Subject: [PATCH v4] ima: Access decompressed kernel module to verify appended signature
Date: Wed, 19 Nov 2025 22:03:25 +0800
Message-ID: <20251119140326.787451-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031074016.1975356-1-coxu@redhat.com>
References: <20251031074016.1975356-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
is enabled, IMA has no way to verify the appended module signature as it
can't decompress the module.

Define a new kernel_read_file_id enumerate READING_MODULE_COMPRESSED so
IMA can calculate the compressed kernel module data hash on
READING_MODULE_COMPRESSED and defer appraising/measuring it until on
READING_MODULE when the module has been decompressed.

Before enabling in-kernel module decompression, a kernel module in
initramfs can still be loaded with ima_policy=secure_boot. So adjust the
kernel module rule in secure_boot policy to allow either an IMA
signature OR an appended signature i.e. to use
"appraise func=MODULE_CHECK appraise_type=imasig|modsig".

Reported-by: Karel Srot <ksrot@redhat.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kernel_read_file.h    |  1 +
 kernel/module/main.c                | 17 ++++++++++++++---
 security/integrity/ima/ima_main.c   | 24 ++++++++++++++++--------
 security/integrity/ima/ima_policy.c |  3 ++-
 security/ipe/hooks.c                |  1 +
 security/selinux/hooks.c            |  5 +++--
 6 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 90451e2e12bd..d613a7b4dd35 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -14,6 +14,7 @@
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
 	id(X509_CERTIFICATE, x509-certificate)	\
+	id(MODULE_COMPRESSED, kernel-module-compressed) \
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..7b3ec2fa6e7c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3675,24 +3675,35 @@ static int idempotent_wait_for_completion(struct idempotent *u)
 
 static int init_module_from_file(struct file *f, const char __user * uargs, int flags)
 {
+	bool compressed = !!(flags & MODULE_INIT_COMPRESSED_FILE);
 	struct load_info info = { };
 	void *buf = NULL;
 	int len;
+	int err;
 
-	len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
+	len = kernel_read_file(f, 0, &buf, INT_MAX, NULL,
+			       compressed ? READING_MODULE_COMPRESSED :
+					    READING_MODULE);
 	if (len < 0) {
 		mod_stat_inc(&failed_kreads);
 		return len;
 	}
 
-	if (flags & MODULE_INIT_COMPRESSED_FILE) {
-		int err = module_decompress(&info, buf, len);
+	if (compressed) {
+		err = module_decompress(&info, buf, len);
 		vfree(buf); /* compressed data is no longer needed */
 		if (err) {
 			mod_stat_inc(&failed_decompress);
 			mod_stat_add_long(len, &invalid_decompress_bytes);
 			return err;
 		}
+		err = security_kernel_post_read_file(f, (char *)info.hdr, info.len,
+						     READING_MODULE);
+		if (err) {
+			mod_stat_inc(&failed_kreads);
+			free_copy(&info, flags);
+			return err;
+		}
 	} else {
 		info.hdr = buf;
 		info.len = len;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ebaebccfbe9a..edd0fd3d77a0 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -235,7 +235,8 @@ static void ima_file_free(struct file *file)
 
 static int process_measurement(struct file *file, const struct cred *cred,
 			       struct lsm_prop *prop, char *buf, loff_t size,
-			       int mask, enum ima_hooks func)
+			       int mask, enum ima_hooks func,
+			       enum kernel_read_file_id read_id)
 {
 	struct inode *real_inode, *inode = file_inode(file);
 	struct ima_iint_cache *iint = NULL;
@@ -406,6 +407,12 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
 		goto out_locked;
 
+	/* Defer measuring/appraising kernel modules to READING_MODULE */
+	if (read_id == READING_MODULE_COMPRESSED) {
+		must_appraise = 0;
+		goto out_locked;
+	}
+
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
@@ -486,14 +493,14 @@ static int ima_file_mmap(struct file *file, unsigned long reqprot,
 
 	if (reqprot & PROT_EXEC) {
 		ret = process_measurement(file, current_cred(), &prop, NULL,
-					  0, MAY_EXEC, MMAP_CHECK_REQPROT);
+					  0, MAY_EXEC, MMAP_CHECK_REQPROT, 0);
 		if (ret)
 			return ret;
 	}
 
 	if (prot & PROT_EXEC)
 		return process_measurement(file, current_cred(), &prop, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+					   0, MAY_EXEC, MMAP_CHECK, 0);
 
 	return 0;
 }
@@ -577,7 +584,7 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(bprm->file, current_cred(),
-				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK);
+				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK, 0);
 }
 
 /**
@@ -607,7 +614,7 @@ static int ima_creds_check(struct linux_binprm *bprm, const struct file *file)
 
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement((struct file *)file, bprm->cred, &prop, NULL,
-				   0, MAY_EXEC, CREDS_CHECK);
+				   0, MAY_EXEC, CREDS_CHECK, 0);
 }
 
 /**
@@ -655,7 +662,7 @@ static int ima_file_check(struct file *file, int mask)
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK);
+					   MAY_APPEND), FILE_CHECK, 0);
 }
 
 static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
@@ -874,12 +881,13 @@ static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
-				   MAY_READ, func);
+				   MAY_READ, func, 0);
 }
 
 const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
+	[READING_MODULE_COMPRESSED] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
 	[READING_POLICY] = POLICY_CHECK
@@ -917,7 +925,7 @@ static int ima_post_read_file(struct file *file, char *buf, loff_t size,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, buf, size,
-				   MAY_READ, func);
+				   MAY_READ, func, read_id);
 }
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 164d62832f8e..7468afaab686 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -244,7 +244,8 @@ static struct ima_rule_entry build_appraise_rules[] __ro_after_init = {
 
 static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	{.action = APPRAISE, .func = MODULE_CHECK,
-	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED |
+		  IMA_CHECK_BLACKLIST},
 	{.action = APPRAISE, .func = FIRMWARE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 	{.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index d0323b81cd8f..1053a4acf589 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -118,6 +118,7 @@ int ipe_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 		op = IPE_OP_FIRMWARE;
 		break;
 	case READING_MODULE:
+	case READING_MODULE_COMPRESSED:
 		op = IPE_OP_KERNEL_MODULE;
 		break;
 	case READING_KEXEC_INITRAMFS:
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index dfc22da42f30..c1ff69d5d76e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4275,7 +4275,7 @@ static int selinux_kernel_read_file(struct file *file,
 {
 	int rc = 0;
 
-	BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
+	BUILD_BUG_ON_MSG(READING_MAX_ID > 8,
 			 "New kernel_read_file_id introduced; update SELinux!");
 
 	switch (id) {
@@ -4283,6 +4283,7 @@ static int selinux_kernel_read_file(struct file *file,
 		rc = selinux_kernel_load_from_file(file, SYSTEM__FIRMWARE_LOAD);
 		break;
 	case READING_MODULE:
+	case READING_MODULE_COMPRESSED:
 		rc = selinux_kernel_load_from_file(file, SYSTEM__MODULE_LOAD);
 		break;
 	case READING_KEXEC_IMAGE:
@@ -4311,7 +4312,7 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
 	int rc = 0;
 
-	BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
+	BUILD_BUG_ON_MSG(LOADING_MAX_ID > 8,
 			 "New kernel_load_data_id introduced; update SELinux!");
 
 	switch (id) {

base-commit: 43369273518f57b7d56c1cf12d636a809b7bd81b
-- 
2.51.1

