Return-Path: <SRS0=dl6L=A4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FFBC433E7
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 17:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66BC20B1F
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 17:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U67vlHLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgGQRnU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgGQRnR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jul 2020 13:43:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE8FC0619D9
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2020 10:43:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ch3so6887469pjb.5
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2020 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3IXKqn7F4SFd0yKw5rLsiOBOS5nVWQ+gMXsoHtaNrvM=;
        b=U67vlHLwnlPfLwmDS1R8C5bGzWkJxePdNnEspX2sTBiA4ok7EgEBR6xtTLhbVlsxLp
         ATjWtMTbSDXn6e1cBgpJrsFO/Y6y48VUplzFt7erDVtM5UxdnJKscaYAfHfv4t/nO6uJ
         1BubEajP8c3in43OGBwoNCOhckse5w2aFUjVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IXKqn7F4SFd0yKw5rLsiOBOS5nVWQ+gMXsoHtaNrvM=;
        b=Hnb9ILgR9bgaQf7CTZRttHjqB0906Ouk7kXJx6tzCL4/YpnXjr9LQ32jOazgUAepzX
         iv3KOeKd1qK/7O9ASGXQ7aU8NeGyVheCJuxudtk1pKuOpqKoli6lGrMROoKs8VESdU1L
         AnebFVujGkv8sGMDFKrh2O856zpe+QHE6Nm1HGpqH2oqvh1E3SRbTySmlcIGNQOT5Oge
         zDia5W+HTPgDK+ZqXosmGZiNx4ElSVvXrmCwfsCJ0x/EDeksuWnz8nLcTsXoIeacExqY
         yZ0GcdAomilW5Q5vxe+eR4SbSwQyZsuSNaBJ3oG0UCbbg7BHi+kO7lLl0JIN9W2BvHX1
         9ShQ==
X-Gm-Message-State: AOAM531Kg5cDSos9Q2dwsQ7tvYdsE4NjNSmeHSM+1Kqgo1uJVwVz66XK
        kaCPa/tH//h6x/7yMMaTdJg7Tg==
X-Google-Smtp-Source: ABdhPJzUkt826uAizvlg3lqTuwsp8AQf47DSZ/Zd4XzY23H6UE3ZjgLkX0UcfeKzR6N5EFvD5P/fxQ==
X-Received: by 2002:a17:90b:916:: with SMTP id bo22mr11237160pjb.100.1595007796907;
        Fri, 17 Jul 2020 10:43:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t126sm8219227pfd.214.2020.07.17.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] fs/kernel_read_file: Remove FIRMWARE_PREALLOC_BUFFER enum
Date:   Fri, 17 Jul 2020 10:42:57 -0700
Message-Id: <20200717174309.1164575-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
References: <20200717174309.1164575-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

FIRMWARE_PREALLOC_BUFFER is a "how", not a "what", and confuses the LSMs
that are interested in filtering between types of things. The "how"
should be an internal detail made uninteresting to the LSMs.

Fixes: a098ecd2fa7d ("firmware: support loading into a pre-allocated buffer")
Fixes: fd90bc559bfb ("ima: based on policy verify firmware signatures (pre-allocated buffer)")
Fixes: 4f0496d8ffa3 ("ima: based on policy warn about loading firmware (pre-allocated buffer)")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
To aid in backporting, this change is made before moving
kernel_read_file() to separate header/source files.
---
 drivers/base/firmware_loader/main.c | 5 ++---
 fs/exec.c                           | 7 ++++---
 include/linux/fs.h                  | 2 +-
 kernel/module.c                     | 2 +-
 security/integrity/digsig.c         | 2 +-
 security/integrity/ima/ima_fs.c     | 2 +-
 security/integrity/ima/ima_main.c   | 6 ++----
 7 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ca871b13524e..c2f57cedcd6f 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -465,14 +465,12 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 	int i, len;
 	int rc = -ENOENT;
 	char *path;
-	enum kernel_read_file_id id = READING_FIRMWARE;
 	size_t msize = INT_MAX;
 	void *buffer = NULL;
 
 	/* Already populated data member means we're loading into a buffer */
 	if (!decompress && fw_priv->data) {
 		buffer = fw_priv->data;
-		id = READING_FIRMWARE_PREALLOC_BUFFER;
 		msize = fw_priv->allocated_size;
 	}
 
@@ -496,7 +494,8 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 
 		/* load firmware files from the mount namespace of init */
 		rc = kernel_read_file_from_path_initns(path, &buffer,
-						       &size, msize, id);
+						       &size, msize,
+						       READING_FIRMWARE);
 		if (rc) {
 			if (rc != -ENOENT)
 				dev_warn(device, "loading %s failed with error %d\n",
diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..2bf549757ce7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -927,6 +927,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 {
 	loff_t i_size, pos;
 	ssize_t bytes = 0;
+	void *allocated = NULL;
 	int ret;
 
 	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
@@ -950,8 +951,8 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		goto out;
 	}
 
-	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
-		*buf = vmalloc(i_size);
+	if (!*buf)
+		*buf = allocated = vmalloc(i_size);
 	if (!*buf) {
 		ret = -ENOMEM;
 		goto out;
@@ -980,7 +981,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 
 out_free:
 	if (ret < 0) {
-		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
+		if (allocated) {
 			vfree(*buf);
 			*buf = NULL;
 		}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea7..95fc775ed937 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2993,10 +2993,10 @@ static inline void i_readcount_inc(struct inode *inode)
 #endif
 extern int do_pipe_flags(int *, int);
 
+/* This is a list of *what* is being read, not *how*. */
 #define __kernel_read_file_id(id) \
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
-	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
 	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
diff --git a/kernel/module.c b/kernel/module.c
index 0c6573b98c36..26105148f4d2 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3988,7 +3988,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 {
 	struct load_info info = { };
 	loff_t size;
-	void *hdr;
+	void *hdr = NULL;
 	int err;
 
 	err = may_init_module();
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e9cbadade74b..ac02b7632353 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -169,7 +169,7 @@ int __init integrity_add_key(const unsigned int id, const void *data,
 
 int __init integrity_load_x509(const unsigned int id, const char *path)
 {
-	void *data;
+	void *data = NULL;
 	loff_t size;
 	int rc;
 	key_perm_t perm;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e3fcad871861..15a44c5022f7 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -272,7 +272,7 @@ static const struct file_operations ima_ascii_measurements_ops = {
 
 static ssize_t ima_read_policy(char *path)
 {
-	void *data;
+	void *data = NULL;
 	char *datap;
 	loff_t size;
 	int rc, pathlen = strlen(path);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c1583d98c5e5..f80ee4ce4669 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -611,19 +611,17 @@ void ima_post_path_mknod(struct dentry *dentry)
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
 	/*
-	 * READING_FIRMWARE_PREALLOC_BUFFER
-	 *
 	 * Do devices using pre-allocated memory run the risk of the
 	 * firmware being accessible to the device prior to the completion
 	 * of IMA's signature verification any more than when using two
-	 * buffers?
+	 * buffers? It may be desirable to include the buffer address
+	 * in this API and walk all the dma_map_single() mappings to check.
 	 */
 	return 0;
 }
 
 const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
-	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-- 
2.25.1

