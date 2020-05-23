Return-Path: <SRS0=mDct=7F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF00EC433E0
	for <selinux@archiver.kernel.org>; Sat, 23 May 2020 19:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885092065C
	for <selinux@archiver.kernel.org>; Sat, 23 May 2020 19:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mu7ZyB3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgEWT42 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 23 May 2020 15:56:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32576 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727962AbgEWT41 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 23 May 2020 15:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590263785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eUGg17PomQKE6SAjoDWY/gpwTQIMlNPgliN0aL5y2Gk=;
        b=Mu7ZyB3/HK5P5Ev4F8NGv3PncqcHMFdyyiub/MPwuEzB3/sJm570houM7zXjFxGsx4txNU
        O5laf5jn8ORbEEAF59sl0JBhA8yNWdO+/AskYe065wgvv2DngwutMTI6wSW5JfxCSYjNLt
        zBUK827reiv9wzW66OyHQyfIsY1+KC8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-Q2YMfY42O9ukV-9lZJgTWw-1; Sat, 23 May 2020 15:56:21 -0400
X-MC-Unique: Q2YMfY42O9ukV-9lZJgTWw-1
Received: by mail-qt1-f198.google.com with SMTP id l11so15597158qti.19
        for <selinux@vger.kernel.org>; Sat, 23 May 2020 12:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eUGg17PomQKE6SAjoDWY/gpwTQIMlNPgliN0aL5y2Gk=;
        b=QIBR8P/3/cc+PKaFLzkXrIS4MtN+W+eTAoex9FoE+rXvBPYcRaQ6DrMa+jHbZ2r0o5
         2w13/MMCVdiSFIn4RX2qj1AZl8FtOyNvVkvwaXSf9pEXRPM/naAOGYyu79NtwSG3WyMW
         s+pEwZbmkDfHRaZLwjhjTK/l2KsUm0C6C9QjTyuoCZU+WsjSQfrKL7bqGC+D0cffoakd
         sruc/snfUxAKCCJqIyKHNX9VY0cLGmC4u+DKdx6aBDr62a26HcnMopHtmMErLciNSbUc
         qbysFKaatfhd3HmJYpn6sFbKq+9lAtM6eOoRp7FVHKqSdVLuOeE7AiR0rHqJ/q4x+UTK
         n8Wg==
X-Gm-Message-State: AOAM533/9rbPuL+uPEoMFFWgiAlTJY/eKSF39wjU4klgnRcaf1USOp7f
        3gaGFhtPIhOvbaWSe2QvmanT25Ttp4d1OeW9ulHmiJgFXqihq0fNkxncRhhChowytJcWR/64iMP
        u3mairpbzsGdJWEtpxg==
X-Received: by 2002:aed:221c:: with SMTP id n28mr21695182qtc.235.1590263780884;
        Sat, 23 May 2020 12:56:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqjNBynRSr+ofQ1Jx69HGYGFIPnrkkTjyVOFQwZZfq8oJ5MQw1XqwunBhVUvESh7tfYdUhNQ==
X-Received: by 2002:aed:221c:: with SMTP id n28mr21695172qtc.235.1590263780563;
        Sat, 23 May 2020 12:56:20 -0700 (PDT)
Received: from localhost.localdomain (107-190-106-186.cpe.teksavvy.com. [107.190.106.186])
        by smtp.gmail.com with ESMTPSA id b188sm802652qkc.30.2020.05.23.12.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 12:56:19 -0700 (PDT)
From:   Jonathan Lebon <jlebon@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Jonathan Lebon <jlebon@redhat.com>
Subject: [PATCH] selinux: allow reading labels before policy is loaded
Date:   Sat, 23 May 2020 15:51:31 -0400
Message-Id: <20200523195130.409607-1-jlebon@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch does for `getxattr` what 3e3e24b4204 did for `setxattr`: it
allows querying the current SELinux label on disk before the policy is
loaded.

One of the motivations described in that commit message also drives this
patch: for Fedora CoreOS (and eventually RHEL CoreOS), we want to be
able to move the root filesystem for example from xfs to ext4, on first
boot, at initrd time.[1]

Because such an operation works at the filesystem level, we need to be
able to read the SELinux labels first from the original root, and apply
them to the files of the new root. Commit 3e3e24b4204 enabled the second
part of this process; this patch enables the first part.

[1] https://github.com/coreos/fedora-coreos-tracker/issues/94

Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
---
 security/selinux/hooks.c | 55 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0b4e32161b7..3bbb9966697 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1317,8 +1317,11 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 	return rc;
 }
 
-static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
-				  u32 def_sid, u32 *sid)
+/* Retrieves the raw context from the fs xattr. Returns 0 on success. */
+static int get_inode_raw_xattr_context(struct inode *inode,
+				       struct dentry *dentry,
+				       char **out_context,
+				       u32 *out_len)
 {
 #define INITCONTEXTLEN 255
 	char *context;
@@ -1354,13 +1357,31 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 		if (rc != -ENODATA) {
 			pr_warn("SELinux: %s:  getxattr returned %d for dev=%s ino=%ld\n",
 				__func__, -rc, inode->i_sb->s_id, inode->i_ino);
-			return rc;
 		}
+		return rc;
+	}
+
+	*out_len = rc;
+	*out_context = context;
+	return 0;
+}
+
+static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
+				  u32 def_sid, u32 *sid)
+{
+	char *context;
+	u32 size;
+	int rc;
+
+	rc = get_inode_raw_xattr_context(inode, dentry, &context, &size);
+	if (rc < 0) {
+		if (rc != -ENODATA)
+			return rc;
 		*sid = def_sid;
 		return 0;
 	}
 
-	rc = security_context_to_sid_default(&selinux_state, context, rc, sid,
+	rc = security_context_to_sid_default(&selinux_state, context, size, sid,
 					     def_sid, GFP_NOFS);
 	if (rc) {
 		char *dev = inode->i_sb->s_id;
@@ -3333,10 +3354,34 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
 	int error;
 	char *context = NULL;
 	struct inode_security_struct *isec;
+	struct superblock_security_struct *sbsec;
 
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
+	isec = inode_security(inode);
+	sbsec = inode->i_sb->s_security;
+
+	/* Just return the raw context if the policy isn't even loaded since we
+	 * have no way to validate it anyway. This is symmetrical with allowing
+	 * setxattr without a policy. */
+	if (!selinux_state.initialized) {
+		/* See similar code in inode_doinit_with_dentry; for xattrs,
+		 * some filesystems really want a connected inode. If we don't
+		 * find one, just let fallback in case it corresponds to one of
+		 * the default sids. */
+		struct dentry *dentry = d_find_alias(inode);
+		if (!dentry)
+			dentry = d_find_any_alias(inode);
+
+		if (dentry) {
+			error = get_inode_raw_xattr_context(inode, dentry,
+							    &context, &size);
+			dput(dentry);
+			goto out;
+		}
+	}
+
 	/*
 	 * If the caller has CAP_MAC_ADMIN, then get the raw context
 	 * value even if it is not defined by current policy; otherwise,
@@ -3346,7 +3391,6 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
 	 * and lack of permission just means that we fall back to the
 	 * in-core context value, not a denial.
 	 */
-	isec = inode_security(inode);
 	if (has_cap_mac_admin(false))
 		error = security_sid_to_context_force(&selinux_state,
 						      isec->sid, &context,
@@ -3354,6 +3398,7 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
 	else
 		error = security_sid_to_context(&selinux_state, isec->sid,
 						&context, &size);
+out:
 	if (error)
 		return error;
 	error = size;
-- 
2.25.4

