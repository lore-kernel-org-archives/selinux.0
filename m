Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A969BC6FD1F
	for <selinux@archiver.kernel.org>; Thu, 16 Mar 2023 20:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCPUYA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Mar 2023 16:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCPUX7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Mar 2023 16:23:59 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA58524483
        for <selinux@vger.kernel.org>; Thu, 16 Mar 2023 13:23:57 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id x8so2064386qvr.9
        for <selinux@vger.kernel.org>; Thu, 16 Mar 2023 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678998236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oeO9kAJMhKa2TrlMh+gDL4RpssBzyMl4AgRR9s8VI9M=;
        b=dYmK/8E8B4fbzUNWG6icpNJO9RHtPSqG572ikdubwX6gIJb3Bblvqk7UqyhdGdneCC
         6WT8tz6n2JpwCDBwEU7Z5fo7Wut4iwqev8tElfGvZ4MAh+AnzfbtlRq7BKrYGWkVvhGf
         Zy5xrJAWtFT0ob1tsE61hBn3XXL96lQhEUlboChacE2OOMEC9KfU4HS4xIiyqD6uVKIq
         o5PqfFoRpovVlW9tDDw0bsHKtTaFqvOdhlkhRzVPjrD9peAgqiYh+3tvfPUGfkdG6Akn
         KPHjBOiXHjwDrMcXiqvxGJl0/cYUTmmGJWi1SNWi5VJfE1Ij7zv59VsbT5NtW/k8h4zz
         raZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678998236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeO9kAJMhKa2TrlMh+gDL4RpssBzyMl4AgRR9s8VI9M=;
        b=JpHc2mFDYf5OraaUAf7sr9O7HGCTZfOHvDaue9clG6Lw8HYJ8NlG+RHZHYV7O9Pvp2
         9s3z6TzhDGcoD434+55R8OeJprt3OF6jUdoRcDVP4tSCRxfGETqJVyyH3GdrRABk02Vu
         s28Rtqz4CVae1HRMYgRR9FbrS8Q8y02KSYAerMpbCHPemphi1OhETwqKg3DmIKR6yQ/4
         7QU6dwjx6VFVeQzqlTOVFmqvhrFO93M0prw1tr6HsaBirR09yiKzfVqwm3EkLyEHmgFL
         9OwHaMvEVdTH7r9FVrCuTWOpwYp8/kX6x1/edSZDYvy0VpGCB81bno0SwL+UAjdsglRQ
         v1Ug==
X-Gm-Message-State: AO0yUKUTa3FDOVc9VWcN2I50PI9rzYohotucG3ScZK2+lDhr9K5SKrYQ
        tAJdoAf6MEBM02M8DnbWT06aTUdEJq/ajUt4iw==
X-Google-Smtp-Source: AK7set/ffIFjbxnOWeYs4WS5yc0CBKvuLj1aNhTuY+wvbNdv91/PjbM1G0MgZXj3Ehm1b0WYUtJTaA==
X-Received: by 2002:ad4:5c8b:0:b0:5a4:690b:abd5 with SMTP id o11-20020ad45c8b000000b005a4690babd5mr33091047qvh.19.1678998236349;
        Thu, 16 Mar 2023 13:23:56 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id j68-20020a37b947000000b0074577e835f2sm238574qkf.48.2023.03.16.13.23.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 13:23:56 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] selinux: remove the 'checkreqprot' functionality
Date:   Thu, 16 Mar 2023 16:23:55 -0400
Message-Id: <20230316202355.349179-1-paul@paul-moore.com>
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

--
* v2
- removed the checkreqprot_set() function
* v1
- initial release
---
 .../sysfs-selinux-checkreqprot                |  3 +++
 security/selinux/Kconfig                      | 23 -------------------
 security/selinux/hooks.c                      | 20 ++++------------
 security/selinux/include/security.h           | 11 ++-------
 security/selinux/selinuxfs.c                  | 13 ++++-------
 5 files changed, 14 insertions(+), 56 deletions(-)
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
index cb38d1894cfc..312112d214bb 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -95,7 +95,6 @@ struct selinux_state {
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 	bool enforcing;
 #endif
-	bool checkreqprot;
 	bool initialized;
 	bool policycap[__POLICYDB_CAP_MAX];
 
@@ -145,14 +144,8 @@ static inline void enforcing_set(bool value)
 
 static inline bool checkreqprot_get(void)
 {
-	return READ_ONCE(selinux_state.checkreqprot);
-}
-
-static inline void checkreqprot_set(bool value)
-{
-	if (value)
-		pr_err("SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-checkreqprot\n");
-	WRITE_ONCE(selinux_state.checkreqprot, value);
+	/* non-zero/true checkreqprot values are no longer supported */
+	return 0;
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

