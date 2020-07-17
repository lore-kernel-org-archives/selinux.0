Return-Path: <SRS0=dl6L=A4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3671C433E0
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 17:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC83207EA
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 17:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Obi84u54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgGQRoO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgGQRnU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jul 2020 13:43:20 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2974DC0619D9
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2020 10:43:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so5753377plm.10
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2020 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkxvPLCCbkaCa7brsK8xPc93mGLBdRO5INApECzM/44=;
        b=Obi84u54vqzQUVtvmNddMQRsiTpR6jcSCi+mhXq+0efSHn07vMce2E+mN9kUGTbp+F
         2FXZ3yXSaDc9Ydh5nTVBDcBX+MOwccFRzQBjjvdINPBeGImq8RccZ4tYxmhLz8xvCNtl
         b+gIUrlrkMgjIBGEAjMj4K9iO+dYUW1OsqHC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkxvPLCCbkaCa7brsK8xPc93mGLBdRO5INApECzM/44=;
        b=mmUxcCAvfaufpd9ov3lPUgl94jJeInDE55YMLZ02FM+xNuOwBWlHuF2v51n76YsLmS
         pWkiKfIy52aEMRM817twvVpDVyy3/N1mk0zr1e9iYbPxpBJjDWpZRJP3uHSsjK/+WvJ/
         CFWxwDLjTXR5156S6/GWSPOzI5rE3cVucff3EENnuEtZ1hx1wdGy3PgJ4DZ1fD3KqcVX
         gbXzfVU41srvwKUZkSzcJC3U4MBT3S7kZ4/9kRfq1LdHvrzRLqKBb5lbW1CNLQqKPjyd
         Fw1lBeDRtb6EPR8lY84j35je/JtY5VSy80IgzAVpiNM65zSiFvF+G9xRHlTxFXiLMiik
         djsw==
X-Gm-Message-State: AOAM531vncrOVP0CVBHYbl1p9nS+UTcAD383HpQBpvKIIH9cKBSNMrdO
        eEk5RCntBW7oKjSrZbV6lYlEVQ==
X-Google-Smtp-Source: ABdhPJxlLBTqEDONzerAn8vcSCSWIV1dPJqkTL6s7MaBj7bR8TaR89/ROwSp91ZRyzwEhP+rPP0muA==
X-Received: by 2002:a17:90a:ed87:: with SMTP id k7mr11358336pjy.31.1595007799518;
        Fri, 17 Jul 2020 10:43:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p12sm3261945pjz.44.2020.07.17.10.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH 05/13] fs/kernel_read_file: Split into separate source file
Date:   Fri, 17 Jul 2020 10:43:00 -0700
Message-Id: <20200717174309.1164575-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
References: <20200717174309.1164575-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These routines are used in places outside of exec(2), so in preparation
for refactoring them, move them into a separate source file,
fs/kernel_read_file.c.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/Makefile           |   3 +-
 fs/exec.c             | 132 ----------------------------------------
 fs/kernel_read_file.c | 138 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 133 deletions(-)
 create mode 100644 fs/kernel_read_file.c

diff --git a/fs/Makefile b/fs/Makefile
index 2ce5112b02c8..a05fc247b2a7 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -13,7 +13,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
-		fs_types.o fs_context.o fs_parser.o fsopen.o
+		fs_types.o fs_context.o fs_parser.o fsopen.o \
+		kernel_read_file.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
diff --git a/fs/exec.c b/fs/exec.c
index 07a7fe9ac5be..d619b79aab30 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -923,138 +923,6 @@ struct file *open_exec(const char *name)
 }
 EXPORT_SYMBOL(open_exec);
 
-int kernel_read_file(struct file *file, void **buf, loff_t *size,
-		     loff_t max_size, enum kernel_read_file_id id)
-{
-	loff_t i_size, pos;
-	ssize_t bytes = 0;
-	void *allocated = NULL;
-	int ret;
-
-	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
-		return -EINVAL;
-
-	ret = deny_write_access(file);
-	if (ret)
-		return ret;
-
-	ret = security_kernel_read_file(file, id);
-	if (ret)
-		goto out;
-
-	i_size = i_size_read(file_inode(file));
-	if (i_size <= 0) {
-		ret = -EINVAL;
-		goto out;
-	}
-	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
-		ret = -EFBIG;
-		goto out;
-	}
-
-	if (!*buf)
-		*buf = allocated = vmalloc(i_size);
-	if (!*buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	pos = 0;
-	while (pos < i_size) {
-		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
-		if (bytes < 0) {
-			ret = bytes;
-			goto out_free;
-		}
-
-		if (bytes == 0)
-			break;
-	}
-
-	if (pos != i_size) {
-		ret = -EIO;
-		goto out_free;
-	}
-
-	ret = security_kernel_post_read_file(file, *buf, i_size, id);
-	if (!ret)
-		*size = pos;
-
-out_free:
-	if (ret < 0) {
-		if (allocated) {
-			vfree(*buf);
-			*buf = NULL;
-		}
-	}
-
-out:
-	allow_write_access(file);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kernel_read_file);
-
-int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
-			       loff_t max_size, enum kernel_read_file_id id)
-{
-	struct file *file;
-	int ret;
-
-	if (!path || !*path)
-		return -EINVAL;
-
-	file = filp_open(path, O_RDONLY, 0);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	ret = kernel_read_file(file, buf, size, max_size, id);
-	fput(file);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
-
-int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      loff_t *size, loff_t max_size,
-				      enum kernel_read_file_id id)
-{
-	struct file *file;
-	struct path root;
-	int ret;
-
-	if (!path || !*path)
-		return -EINVAL;
-
-	task_lock(&init_task);
-	get_fs_root(init_task.fs, &root);
-	task_unlock(&init_task);
-
-	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
-	path_put(&root);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	ret = kernel_read_file(file, buf, size, max_size, id);
-	fput(file);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
-
-int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
-			     enum kernel_read_file_id id)
-{
-	struct fd f = fdget(fd);
-	int ret = -EBADF;
-
-	if (!f.file)
-		goto out;
-
-	ret = kernel_read_file(f.file, buf, size, max_size, id);
-out:
-	fdput(f);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
-
 #if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
     defined(CONFIG_BINFMT_ELF_FDPIC)
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
new file mode 100644
index 000000000000..54d972d4befc
--- /dev/null
+++ b/fs/kernel_read_file.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/fs.h>
+#include <linux/fs_struct.h>
+#include <linux/kernel_read_file.h>
+#include <linux/security.h>
+#include <linux/vmalloc.h>
+
+int kernel_read_file(struct file *file, void **buf, loff_t *size,
+		     loff_t max_size, enum kernel_read_file_id id)
+{
+	loff_t i_size, pos;
+	ssize_t bytes = 0;
+	void *allocated = NULL;
+	int ret;
+
+	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
+		return -EINVAL;
+
+	ret = deny_write_access(file);
+	if (ret)
+		return ret;
+
+	ret = security_kernel_read_file(file, id);
+	if (ret)
+		goto out;
+
+	i_size = i_size_read(file_inode(file));
+	if (i_size <= 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
+		ret = -EFBIG;
+		goto out;
+	}
+
+	if (!*buf)
+		*buf = allocated = vmalloc(i_size);
+	if (!*buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pos = 0;
+	while (pos < i_size) {
+		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
+		if (bytes < 0) {
+			ret = bytes;
+			goto out_free;
+		}
+
+		if (bytes == 0)
+			break;
+	}
+
+	if (pos != i_size) {
+		ret = -EIO;
+		goto out_free;
+	}
+
+	ret = security_kernel_post_read_file(file, *buf, i_size, id);
+	if (!ret)
+		*size = pos;
+
+out_free:
+	if (ret < 0) {
+		if (allocated) {
+			vfree(*buf);
+			*buf = NULL;
+		}
+	}
+
+out:
+	allow_write_access(file);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file);
+
+int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+			       loff_t max_size, enum kernel_read_file_id id)
+{
+	struct file *file;
+	int ret;
+
+	if (!path || !*path)
+		return -EINVAL;
+
+	file = filp_open(path, O_RDONLY, 0);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ret = kernel_read_file(file, buf, size, max_size, id);
+	fput(file);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
+
+int kernel_read_file_from_path_initns(const char *path, void **buf,
+				      loff_t *size, loff_t max_size,
+				      enum kernel_read_file_id id)
+{
+	struct file *file;
+	struct path root;
+	int ret;
+
+	if (!path || !*path)
+		return -EINVAL;
+
+	task_lock(&init_task);
+	get_fs_root(init_task.fs, &root);
+	task_unlock(&init_task);
+
+	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
+	path_put(&root);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ret = kernel_read_file(file, buf, size, max_size, id);
+	fput(file);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
+
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id)
+{
+	struct fd f = fdget(fd);
+	int ret = -EBADF;
+
+	if (!f.file)
+		goto out;
+
+	ret = kernel_read_file(f.file, buf, size, max_size, id);
+out:
+	fdput(f);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
-- 
2.25.1

