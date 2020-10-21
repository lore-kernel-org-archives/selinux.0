Return-Path: <SRS0=8FG4=D4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A930C55179
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 14:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E788822283
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 14:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="NI0ON02y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443647AbgJUOgD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443636AbgJUOgA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Oct 2020 10:36:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD11C0613CE
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 07:36:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e7so1575981pfn.12
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WEfsWRcNH+W3tTOdYjiWYeOaRW5FMUdRotvnt4pGwbQ=;
        b=NI0ON02yrfQho1ZH+AUJ/6RiXKV4SESonYxW1x47ge+DS7hl7DFxq+/CVpLVB767ZU
         gd8SAvdrnzpM3SWznJYQAyKMDgGj5bcrVo4b9Ay6q4Oxccpm8fyj9921/brWa1Txm3/E
         5hSnX847Oo7Y1etO/i2k9+Y4LAaUtydJ/sa/+LUvIGDRneQPXlIACbJOtA69hRJnGwgc
         zWy8AO6KcF8Y6FbUOvS2ZMVVaWCzOdlvY29TaKZEkjAymA4DS3cuNu0eXFRAho4cQCQF
         D7LabGu5Uw6iVIx/GcrF3104Bp7q93rIx/1oAamiQcYZJUJw6z4b7nIpV48S99nGPWCl
         APrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WEfsWRcNH+W3tTOdYjiWYeOaRW5FMUdRotvnt4pGwbQ=;
        b=EJh8r2tIjAMpW1iDruli9KhiuHN10V7TmDdae2Ue9vsGxAx/Q/eec9hTGDDZjLNJOP
         b3rDEZCrKSSq9Nu1A5RvGjySzf9LpOqVhqAUBX9Xp8kG2jhqQWqp96V7HmJBjuy0+Mas
         reTpTpxQkZjh7o8/yt4Ik4bKmcNn1m3x72iloGXAbaprVnBsGkWxMdJi1eJV6ArO/t1B
         8mveU2mDSD+YZUmczgULzKBbTCwnhmgw602kaM9bh7ua2rHYsX0Dq0i36nQlHzsKi0dP
         cax9UcVdx2XvbO5O/GBf9RuwxTIfAYJKbvqdffDNc7rjp1TeUw+cjo2EsOOIu4oyYlbx
         qe3w==
X-Gm-Message-State: AOAM532WWOnuX7o9l0xhDu927/lrW8ObGrgmlCtaSYgah7uXeZ2mXExE
        fLQlZjMXVxtaKulqNfP//xBhkw==
X-Google-Smtp-Source: ABdhPJzCfi3YMZPbEJb2G72+C2YGxgs+ykj0jH2no0G3wtIQasr5DkYAK5/EKe4Nf/dkbN61+ApWuw==
X-Received: by 2002:a63:140e:: with SMTP id u14mr3488401pgl.91.1603290959930;
        Wed, 21 Oct 2020 07:35:59 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:4a0f:cfff:fe35:d61b])
        by smtp.gmail.com with ESMTPSA id y5sm2759196pgo.5.2020.10.21.07.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 07:35:59 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>, linux-doc@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH v18 2/4] overlayfs: handle XATTR_NOSECURITY flag for get xattr method
Date:   Wed, 21 Oct 2020 07:35:31 -0700
Message-Id: <20201021143533.115895-3-salyzyn@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021143533.115895-1-salyzyn@android.com>
References: <20201021143533.115895-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Because of the overlayfs getxattr recursion, the incoming inode fails
to update the selinux sid resulting in avc denials being reported
against a target context of u:object_r:unlabeled:s0.

Solution is to respond to the XATTR_NOSECURITY flag in get xattr
method that calls the __vfs_getxattr handler instead so that the
context can be read in, rather than being denied with an -EACCES
when vfs_getxattr handler is called.

For the use case where access is to be blocked by the security layer.

The path then would be security(dentry) ->
__vfs_getxattr({dentry...XATTR_NOSECURITY}) ->
handler->get({dentry...XATTR_NOSECURITY}) ->
__vfs_getxattr({realdentry...XATTR_NOSECURITY}) ->
lower_handler->get({realdentry...XATTR_NOSECURITY}) which
would report back through the chain data and success as expected,
the logging security layer at the top would have the data to
determine the access permissions and report back to the logs and
the caller that the target context was blocked.

For selinux this would solve the cosmetic issue of the selinux log
and allow audit2allow to correctly report the rule needed to address
the access problem.

Check impure, opaque, origin & meta xattr with no sepolicy audit
(using __vfs_getxattr) since these operations are internal to
overlayfs operations and do not disclose any data.  This became
an issue for credential override off since sys_admin would have
been required by the caller; whereas would have been inherently
present for the creator since it performed the mount.

This is a change in operations since we do not check in the new
ovl_do_getxattr function if the credential override is off or not.
Reasoning is that the sepolicy check is unnecessary overhead,
especially since the check can be expensive.

Because for override credentials off, this affects _everyone_ that
underneath performs private xattr calls without the appropriate
sepolicy permissions and sys_admin capability.  Providing blanket
support for sys_admin would be bad for all possible callers.

For the override credentials on, this will affect only the mounter,
should it lack sepolicy permissions. Not considered a security
problem since mounting by definition has sys_admin capabilities,
but sepolicy contexts would still need to be crafted.

It should be noted that there is precedence, __vfs_getxattr is used
in other filesystems for their own internal trusted xattr management.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
To: linux-fsdevel@vger.kernel.org
To: linux-unionfs@vger.kernel.org
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-doc@vger.kernel.org
Cc: selinux@vger.kernel.org

v18 - correct inode argument to __vfs_getxattr

v17 - rebase and add inode argument to __vfs_getxattr

v16 - rebase and merge internal getxattr operations patch

v15 - revert to v13 because xattr_gs_args rejected.

v14 - rebase to use xattr_gs_args.

v13 - rebase to use __vfs_getxattr flags option.

v12 - Added back to patch series as get xattr with flag option.

v11 - Squashed out of patch series and replaced with per-thread flag
      solution.

v10 - Added to patch series as __get xattr method.
---
 fs/overlayfs/inode.c     | 5 +++--
 fs/overlayfs/overlayfs.h | 6 ++++--
 fs/overlayfs/super.c     | 4 ++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b584dca845ba..2b14291beb86 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -378,7 +378,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 }
 
 int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
-		  void *value, size_t size)
+		  void *value, size_t size, int flags)
 {
 	ssize_t res;
 	const struct cred *old_cred;
@@ -386,7 +386,8 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 		ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry);
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_getxattr(realdentry, name, value, size);
+	res = __vfs_getxattr(realdentry, d_inode(realdentry), name,
+			     value, size, flags);
 	revert_creds(old_cred);
 	return res;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f8880aa2ba0e..06db4cf87f55 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -184,7 +184,9 @@ static inline ssize_t ovl_do_getxattr(struct ovl_fs *ofs, struct dentry *dentry,
 				      size_t size)
 {
 	const char *name = ovl_xattr(ofs, ox);
-	return vfs_getxattr(dentry, name, value, size);
+	struct inode *ip = d_inode(dentry);
+
+	return __vfs_getxattr(dentry, ip, name, value, size, XATTR_NOSECURITY);
 }
 
 static inline int ovl_do_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
@@ -439,7 +441,7 @@ int ovl_permission(struct inode *inode, int mask);
 int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		  const void *value, size_t size, int flags);
 int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
-		  void *value, size_t size);
+		  void *value, size_t size, int flags);
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
 struct posix_acl *ovl_get_acl(struct inode *inode, int type);
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f41353ba1e68..d447958badc2 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -930,7 +930,7 @@ ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
 			struct dentry *dentry, struct inode *inode,
 			const char *name, void *buffer, size_t size, int flags)
 {
-	return ovl_xattr_get(dentry, inode, handler->name, buffer, size);
+	return ovl_xattr_get(dentry, inode, handler->name, buffer, size, flags);
 }
 
 static int __maybe_unused
@@ -1012,7 +1012,7 @@ static int ovl_other_xattr_get(const struct xattr_handler *handler,
 			       const char *name, void *buffer, size_t size,
 			       int flags)
 {
-	return ovl_xattr_get(dentry, inode, name, buffer, size);
+	return ovl_xattr_get(dentry, inode, name, buffer, size, flags);
 }
 
 static int ovl_other_xattr_set(const struct xattr_handler *handler,
-- 
2.29.0.rc1.297.gfa9743e501-goog

