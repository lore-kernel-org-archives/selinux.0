Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BA8C43172
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 16:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E7F2054F
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 16:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfAIQ2y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:28:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35704 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfAIQ2x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 11:28:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so8320992wrb.2
        for <selinux@vger.kernel.org>; Wed, 09 Jan 2019 08:28:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gSGo71MvUVspkie9GwhrspwHi6UUZoiqR33nTq1pDDE=;
        b=nG1YnU6XX633DpQqj8NIjf1VIZGCyny54F4Iltg3XAuy/bzOPEs/4vJtosX8LOLNae
         usMhYUC+OF7KKVHCkSEqCkJUQP7LQ8vFvgYt8hBtlquAs1igzEXUCBgN27cu+NtiiRKq
         B0lVyDkBC4M11TgszXifAkcFF33Nt/IE9iv9eMPFfZ49bifkhY2ZsE0uGovtU4YMD1uu
         1YtexLbOt6Ik1vXfJqF8v+OICuDtoI9uAMGjxtRyfOv1nFCu9CMjcwfksAbkEdFJosQv
         EOwROhYOfHH1TV9YTXu0esyYKOsRdSpULTWoFCOtCq6JMEnlWNkAIEbJXhmDgCdp57Mi
         ruDg==
X-Gm-Message-State: AJcUukf+aFX+5v9d0ZxaM8hVWk556krN6D2EGbfdAG/0zUSqCvQk8DwD
        5UjNGKNHd281D6f8r2fOudvdBzshKZM=
X-Google-Smtp-Source: ALg8bN5z+Kc3uvEW27PAqliKYup8u1mgW4Sjhrer+xcoqph97R9SKccYCJH5gQ3HhVRTwpPoULgpgA==
X-Received: by 2002:adf:e488:: with SMTP id i8mr5908936wrm.10.1547051330463;
        Wed, 09 Jan 2019 08:28:50 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a17sm13661438wma.15.2019.01.09.08.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 08:28:49 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2 1/3] LSM: Add new hook for generic node initialization
Date:   Wed,  9 Jan 2019 17:28:28 +0100
Message-Id: <20190109162830.8309-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109162830.8309-1-omosnace@redhat.com>
References: <20190109162830.8309-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch introduces a new security hook that is intended for
initializing the security data for newly created pseudo filesystem
objects (such as kernfs nodes) that provide a way of storing a
non-default security context, but need to operate independently from
mounts.

The main motivation is to allow kernfs nodes to inherit the context of
the parent under SELinux, similar to the behavior of
security_inode_init_security(). Other LSMs may implement their own logic
for handling the creation of new nodes.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hooks.h | 30 ++++++++++++++++++++++++++++++
 include/linux/security.h  | 14 ++++++++++++++
 security/security.c       | 10 ++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index aaeb7fa24dc4..3a2399d7721f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -429,6 +429,31 @@
  *	to abort the copy up. Note that the caller is responsible for reading
  *	and writing the xattrs as this hook is merely a filter.
  *
+ * Security hooks for special file-like objects
+ *
+ * @object_init_security:
+ *	Obtain the security context for a newly created filesystem object
+ *	based on the security context of the parent node.  The purpose is
+ *	similar to @inode_init_security, but this hook is intended for
+ *	non-inode objects that need to behave like a directory tree (e.g.
+ *	kernfs nodes).  In this case it is assumed that the LSM assigns some
+ *	default context to the node by default and the object internally stores
+ *	a copy of the security context if (and only if) it has been set to a
+ *	non-default value explicitly (e.g. via *setxattr(2)).
+ *
+ *	@parent_ctx contains the security context of the parent directory
+ *	(must not be NULL -- if the parent has no explicit context set,
+ *	the child should also keep the default context and the hook should
+ *	not be called).
+ *	@parent_ctxlen contains the length of @parent_ctx data.
+ *	@qstr contains the last path component of the new object.
+ *	@mode contanis the file mode of the object.
+ *	@ctx is a pointer in which to place the allocated security context.
+ *	@ctxlen points to the place to put the length of @ctx.
+ *
+ *	Returns 0 if @ctx and @ctxlen have been successfully set or
+ *	-ENOMEM on memory allocation failure.
+ *
  * Security hooks for file operations
  *
  * @file_permission:
@@ -1556,6 +1581,10 @@ union security_list_options {
 	int (*inode_copy_up)(struct dentry *src, struct cred **new);
 	int (*inode_copy_up_xattr)(const char *name);
 
+	int (*object_init_security)(void *parent_ctx, u32 parent_ctxlen,
+				    const struct qstr *qstr, u16 mode,
+				    void **ctx, u32 *ctxlen);
+
 	int (*file_permission)(struct file *file, int mask);
 	int (*file_alloc_security)(struct file *file);
 	void (*file_free_security)(struct file *file);
@@ -1855,6 +1884,7 @@ struct security_hook_heads {
 	struct hlist_head inode_getsecid;
 	struct hlist_head inode_copy_up;
 	struct hlist_head inode_copy_up_xattr;
+	struct hlist_head object_init_security;
 	struct hlist_head file_permission;
 	struct hlist_head file_alloc_security;
 	struct hlist_head file_free_security;
diff --git a/include/linux/security.h b/include/linux/security.h
index d170a5b031f3..1e7971d10fe6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -315,6 +315,9 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
+int security_object_init_security(void *parent_ctx, u32 parent_ctxlen,
+				  const struct qstr *qstr, u16 mode,
+				  void **ctx, u32 *ctxlen);
 int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
@@ -815,6 +818,17 @@ static inline int security_inode_copy_up_xattr(const char *name)
 	return -EOPNOTSUPP;
 }
 
+static inline int security_object_init_security(void *parent_ctx,
+						u32 parent_ctxlen,
+						const struct qstr *qstr,
+						u16 mode, void **ctx,
+						u32 *ctxlen)
+{
+	*ctx = NULL;
+	*ctxlen = 0;
+	return 0;
+}
+
 static inline int security_file_permission(struct file *file, int mask)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 04d173eb93f6..a010bfbe3fc6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -879,6 +879,16 @@ int security_inode_copy_up_xattr(const char *name)
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
+int security_object_init_security(void *parent_ctx, u32 parent_ctxlen,
+				  const struct qstr *qstr, u16 mode,
+				  void **ctx, u32 *ctxlen)
+{
+	*ctx = NULL;
+	*ctxlen = 0;
+	return call_int_hook(object_init_security, 0, parent_ctx, parent_ctxlen,
+			     qstr, mode, ctx, ctxlen);
+}
+
 int security_file_permission(struct file *file, int mask)
 {
 	int ret;
-- 
2.20.1

