Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401EFC6FD1F
	for <selinux@archiver.kernel.org>; Thu, 16 Mar 2023 17:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCPR54 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Mar 2023 13:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCPR5y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Mar 2023 13:57:54 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DFC1CBED
        for <selinux@vger.kernel.org>; Thu, 16 Mar 2023 10:57:51 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id f1so1767114qvx.13
        for <selinux@vger.kernel.org>; Thu, 16 Mar 2023 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678989470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pKBba47/wrHjQ1OUZy1m9W4ckVonB+fYlY062/OnzSw=;
        b=Vug7LDSaEYpgVLQ6E0Caay5mzU+/pd7XjMbbIi97fU5ulHVQNut+oo4QKVO+bbfdSl
         d+Sje1P9PqeSAiP9jPVEfCKNK44ikERlioNPf/JDhFsVts04trFBqdF1hYonLF2lDmZH
         VwkNrkXcyxf+QQoGZEI+x81IzJtLudDqH6uf5glA/+uPg0PB9LnMo9XhvgtzwH42UU5U
         BY1ho/zlpx0Ivat9oB1vav3zm9UagDcji6npI9Gzxb6xw0V1iFasB3PMqNOKUd6Nvf/R
         4rpfjcnLbAENyvWRJx/SGLdaYYvQqT+3n+t7+1gGbn/gjkpJMd+HGomc+x+JynZ2GezA
         Xepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678989470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKBba47/wrHjQ1OUZy1m9W4ckVonB+fYlY062/OnzSw=;
        b=wl+oPGWZWWbA95euJcFKJOC0Znog7kyy8b8gWB/pHxxItu/1x+IU9Ucq8rVtTdTmt7
         UU5tUFpiC/mD7A9MJAp6VbCBhnasDuUmqF5bWNuNel9GlkqNOzDr0Q4HykiwKzQtsDPX
         kpbp2khm9dLOdL/PaHqC/hYfptau2k2gDp1wt6amDc5HL2PhR8MljUR7lyhcKg3NQF9K
         twDInTpIlXlHbXaKbLXrrKq1KzjKevE+xyM3v+SoKI0wVmfS4VFAPcWUvOsrgGgO7bAa
         iKqd/vhAlZbpuX5wXJO73xeChcRV6R6J0f1/SKpSp4eJe5W5V/pTj/ltTmR5R2ne90Wl
         bVSQ==
X-Gm-Message-State: AO0yUKW3Nmhbaz1Kqs8ytPGhN3cvEBtCB0YPGpaZgv/0BNxv7K/ci5B+
        tUdPatetPuLUkpvGs9IN2lCChkv2HVVJfpZHbg==
X-Google-Smtp-Source: AK7set+5q0KFTC4RYQ3fhHse7oJeLfmWxJNgTVZ4jlZectW4osDZXNDCeJYL/XGWvm5jBQU5WF7fPQ==
X-Received: by 2002:a05:6214:f6f:b0:5ba:9d88:3d02 with SMTP id iy15-20020a0562140f6f00b005ba9d883d02mr2148685qvb.29.1678989470415;
        Thu, 16 Mar 2023 10:57:50 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm6212738qkd.128.2023.03.16.10.57.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:57:49 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: remove the 'checkreqprot' functionality
Date:   Thu, 16 Mar 2023 13:57:49 -0400
Message-Id: <20230316175749.233373-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We originally promised that the SELinux 'checkreqprot' functionality
would be removed no sooner than June 2021, and now that it is March
2023 it seems like it is a good time to do the final removal.  The
deprecation notice in the kernel provides plenty of detail on why
'checkreqprot' is not desirable, with the key point repeated below:

  This was a compatibility mechanism for legacy userspace and
  for the READ_IMPLIES_EXEC personality flag.  However, if set to
  1, it weakens security by allowing mappings to be made executable
  without authorization by policy.  The default value of checkreqprot
  at boot was changed starting in Linux v4.4 to 0 (i.e. check the
  actual protection), and Android and Linux distributions have been
  explicitly writing a "0" to /sys/fs/selinux/checkreqprot during
  initialization for some time.

Along with the official deprecation notice, we have been discussing
this on-list and directly with several of the larger SELinux-based
distros and everyone is happy to see this feature finally removed.
In an attempt to catch all of the smaller, and DIY, Linux systems
we have been writing a deprecation notice URL into the kernel log,
along with a growing ssleep() penalty, when admins enabled
checkreqprot at runtime or via the kernel command line.  We have
yet to have anyone come to us and raise an objection to the
deprecation or planned removal.

It is worth noting that while this patch removes the checkreqprot
functionality, it leaves the user visible interfaces (kernel command
line and selinuxfs file) intact, just inert.  This should help
prevent breakages with existing userspace tools that correctly, but
unnecessarily, disable checkreqprot at boot or runtime.  Admins
that attempt to enable checkreqprot will be met with a removal
message in the kernel log.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 .../sysfs-selinux-checkreqprot                |  3 +++
 security/selinux/Kconfig                      | 23 -------------------
 security/selinux/hooks.c                      | 20 ++++------------
 security/selinux/include/security.h           |  9 ++++----
 security/selinux/selinuxfs.c                  | 13 ++++-------
 5 files changed, 17 insertions(+), 51 deletions(-)
 rename Documentation/ABI/{obsolete => removed}/sysfs-selinux-checkreqprot (90%)

diff --git a/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot b/Documentation/ABI/removed/sysfs-selinux-checkreqprot
similarity index 90%
rename from Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
rename to Documentation/ABI/removed/sysfs-selinux-checkreqprot
index ed6b52ca210f..f599a0a87e8b 100644
--- a/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
+++ b/Documentation/ABI/removed/sysfs-selinux-checkreqprot
@@ -4,6 +4,9 @@ KernelVersion:	2.6.12-rc2 (predates git)
 Contact:	selinux@vger.kernel.org
 Description:
 
+	REMOVAL UPDATE: The SELinux checkreqprot functionality was removed in
+	March 2023, the original deprecation notice is shown below.
+
 	The selinuxfs "checkreqprot" node allows SELinux to be configured
 	to check the protection requested by userspace for mmap/mprotect
 	calls instead of the actual protection applied by the kernel.
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 9e921fc72538..4ea946123255 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -70,29 +70,6 @@ config SECURITY_SELINUX_AVC_STATS
 	  /sys/fs/selinux/avc/cache_stats, which may be monitored via
 	  tools such as avcstat.
 
-config SECURITY_SELINUX_CHECKREQPROT_VALUE
-	int "NSA SELinux checkreqprot default value"
-	depends on SECURITY_SELINUX
-	range 0 1
-	default 0
-	help
-	  This option sets the default value for the 'checkreqprot' flag
-	  that determines whether SELinux checks the protection requested
-	  by the application or the protection that will be applied by the
-	  kernel (including any implied execute for read-implies-exec) for
-	  mmap and mprotect calls.  If this option is set to 0 (zero),
-	  SELinux will default to checking the protection that will be applied
-	  by the kernel.  If this option is set to 1 (one), SELinux will
-	  default to checking the protection requested by the application.
-	  The checkreqprot flag may be changed from the default via the
-	  'checkreqprot=' boot parameter.  It may also be changed at runtime
-	  via /sys/fs/selinux/checkreqprot if authorized by policy.
-
-	  WARNING: this option is deprecated and will be removed in a future
-	  kernel release.
-
-	  If you are unsure how to answer this question, answer 0.
-
 config SECURITY_SELINUX_SIDTAB_HASH_BITS
 	int "NSA SELinux sidtab hashtable size"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index db6d8b68b543..9a58971f9a16 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -136,17 +136,13 @@ static int __init selinux_enabled_setup(char *str)
 __setup("selinux=", selinux_enabled_setup);
 #endif
 
-static unsigned int selinux_checkreqprot_boot =
-	CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
-
 static int __init checkreqprot_setup(char *str)
 {
 	unsigned long checkreqprot;
 
 	if (!kstrtoul(str, 0, &checkreqprot)) {
-		selinux_checkreqprot_boot = checkreqprot ? 1 : 0;
 		if (checkreqprot)
-			pr_err("SELinux: checkreqprot set to 1 via kernel parameter.  This is deprecated and will be rejected in a future kernel release.\n");
+			pr_err("SELinux: checkreqprot set to 1 via kernel parameter.  This is no longer supported.\n");
 	}
 	return 1;
 }
@@ -3712,7 +3708,8 @@ static int selinux_mmap_addr(unsigned long addr)
 	return rc;
 }
 
-static int selinux_mmap_file(struct file *file, unsigned long reqprot,
+static int selinux_mmap_file(struct file *file,
+			     unsigned long reqprot __always_unused,
 			     unsigned long prot, unsigned long flags)
 {
 	struct common_audit_data ad;
@@ -3727,23 +3724,17 @@ static int selinux_mmap_file(struct file *file, unsigned long reqprot,
 			return rc;
 	}
 
-	if (checkreqprot_get())
-		prot = reqprot;
-
 	return file_map_prot_check(file, prot,
 				   (flags & MAP_TYPE) == MAP_SHARED);
 }
 
 static int selinux_file_mprotect(struct vm_area_struct *vma,
-				 unsigned long reqprot,
+				 unsigned long reqprot __always_unused,
 				 unsigned long prot)
 {
 	const struct cred *cred = current_cred();
 	u32 sid = cred_sid(cred);
 
-	if (checkreqprot_get())
-		prot = reqprot;
-
 	if (default_noexec &&
 	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
 		int rc = 0;
@@ -7202,9 +7193,6 @@ static __init int selinux_init(void)
 
 	memset(&selinux_state, 0, sizeof(selinux_state));
 	enforcing_set(selinux_enforcing_boot);
-	if (CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE)
-		pr_err("SELinux: CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE is non-zero.  This is deprecated and will be rejected in a future kernel release.\n");
-	checkreqprot_set(selinux_checkreqprot_boot);
 	selinux_avc_init();
 	mutex_init(&selinux_state.status_lock);
 	mutex_init(&selinux_state.policy_mutex);
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index cb38d1894cfc..7e9511841134 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -95,7 +95,6 @@ struct selinux_state {
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 	bool enforcing;
 #endif
-	bool checkreqprot;
 	bool initialized;
 	bool policycap[__POLICYDB_CAP_MAX];
 
@@ -145,14 +144,16 @@ static inline void enforcing_set(bool value)
 
 static inline bool checkreqprot_get(void)
 {
-	return READ_ONCE(selinux_state.checkreqprot);
+	/* setting checkreqprot to a non-zero value is no longer supported */
+	return 0;
 }
 
 static inline void checkreqprot_set(bool value)
 {
-	if (value)
+	if (value) {
 		pr_err("SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-checkreqprot\n");
-	WRITE_ONCE(selinux_state.checkreqprot, value);
+		pr_err("SELinux: setting checkreqprot to '1' is no longer supported\n");
+	}
 }
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 08164d074e56..68688bc84912 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -728,23 +728,20 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	length = -EINVAL;
-	if (sscanf(page, "%u", &new_value) != 1)
+	if (sscanf(page, "%u", &new_value) != 1) {
+		length = -EINVAL;
 		goto out;
+	}
+	length = count;
 
 	if (new_value) {
 		char comm[sizeof(current->comm)];
 
 		memcpy(comm, current->comm, sizeof(comm));
-		pr_err("SELinux: %s (%d) set checkreqprot to 1. This is deprecated and will be rejected in a future kernel release.\n",
+		pr_err("SELinux: %s (%d) set checkreqprot to 1. This is no longer supported.\n",
 		       comm, current->pid);
 	}
 
-	checkreqprot_set((new_value ? 1 : 0));
-	if (new_value)
-		ssleep(15);
-	length = count;
-
 	selinux_ima_measure_state();
 
 out:
-- 
2.40.0

