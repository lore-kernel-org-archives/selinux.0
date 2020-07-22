Return-Path: <SRS0=bGuM=BB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83048C433E0
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 09:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6B72077D
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 09:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ClKEYnsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgGVJJI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGVJJI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jul 2020 05:09:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B08C0619DE
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 02:09:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so849610pjb.2
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1BVl/A4ZuZHtoqyknQZtUC9ho61FPvwu+Y4wN12Kj8U=;
        b=ClKEYnsaIWUgi6JhhYXpeesKL7NuFLd7lF4tjKH/6IFzrlaH7vmxQV3pnB1SotX9I8
         TKrMfUVFy8ezmQtDP/WwkzYqb2fHZhNkxK/14IZCG+gzoEqcbnR9lQoRgj0Eiy6+YQFy
         JQn7azDjKxHaXaHm5UZvQ20xGJaMEwVpM7P+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1BVl/A4ZuZHtoqyknQZtUC9ho61FPvwu+Y4wN12Kj8U=;
        b=PCz40EzQxJcygzsLNBDutFNlvdsmdMRdhfKJXP0qMlw25iOFjcwoZqaTD+Vz6mBAjR
         ICogYb2vloconxmM0INeZYy/ow1Aq5SHJj9iCLBNmgvBTYEAj745qjO3Q9QNGrgEf8Gp
         TjgB/sHZM/Fn7gEZsMjz9yB9A080EC2mMwIWJfRXKYNrI0cg4Bq6nEMS1oBwY10PD8z8
         W5B/8Iz6Iaa0sq5vmD42zxLbiRV/MvSKJtn5rHuTB0jOO+lKR9qyvAXeZhztA0rBiOlE
         kOD7lFHvbxuv1HSzOjnezjM4Uma8Ky+6XjB23EFIeqXg+MgTdshNzRFNFK5wLWtzpt9k
         ThUw==
X-Gm-Message-State: AOAM531LnWNd0UCW0tTL6XOuLeoqSLnEH3pME8PCkH7YBDzZ7MBwvf4L
        ECpo6sW0lvkI/m0CQJq2sXBm/A==
X-Google-Smtp-Source: ABdhPJx7qixZ1eBmqd5wgwg9yWvmiNDnCRwRP1EI/HV8JvuXsGxQCeAKlNQsN64LXXXjJ3a/zLUswQ==
X-Received: by 2002:a17:902:5996:: with SMTP id p22mr7426415pli.233.1595408947686;
        Wed, 22 Jul 2020 02:09:07 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:2:f693:9fff:fef4:2537])
        by smtp.gmail.com with ESMTPSA id v22sm22942653pfe.48.2020.07.22.02.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 02:09:06 -0700 (PDT)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net, selinux@vger.kernel.org,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [RESEND] [PATCHv4 1/2] uapi: fuse: Add FUSE_SECURITY_CTX
Date:   Wed, 22 Jul 2020 18:07:57 +0900
Message-Id: <20200722090758.3221812-1-chirantan@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the FUSE_SECURITY_CTX flag for the `flags` field of the
fuse_init_out struct.  When this flag is set the kernel will append the
security context for a newly created inode to the request (create,
mkdir, mknod, and symlink).  The server is responsible for ensuring that
the inode appears atomically with the requested security context.

For example, if the server is backed by a "real" linux file system then
it can write the security context value to
/proc/thread-self/attr/fscreate before making the syscall to create the
inode.

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
Changes in v4:
  * Added signoff to commit message.

 include/uapi/linux/fuse.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 373cada898159..e2099b45fd44b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -172,6 +172,10 @@
  *  - add FUSE_WRITE_KILL_PRIV flag
  *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
  *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
+ *
+ *  7.32
+ *  - add FUSE_SECURITY_CTX flag for fuse_init_out
+ *  - add security context to create, mkdir, symlink, and mknod requests
  */
 
 #ifndef _LINUX_FUSE_H
@@ -207,7 +211,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 31
+#define FUSE_KERNEL_MINOR_VERSION 32
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -314,6 +318,7 @@ struct fuse_file_lock {
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
  * FUSE_MAP_ALIGNMENT: map_alignment field is valid
+ * FUSE_SECURITY_CTX: add security context to create, mkdir, symlink, and mknod
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -342,6 +347,7 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_SECURITY_CTX	(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.27.0.383.g050319c2ae-goog

