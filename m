Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446B634F7
	for <selinux@vger.kernel.org>; Mon, 29 Jan 2024 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535067; cv=none; b=tjMEcZhUHgQ21HhxL58BMnUciQ/rteatU20KTmtahAfRikHEkq981/g2/t+9xlUwTZX0AsHmQfA/r1ajrJHF4tvKDliu6YagZCgAgtqIdxlPzSvo1oUYhggn3g8jE3JOCA74tqKP0RXXEp7VsbSn8YKb4U+m7jrCec0pbkTAi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535067; c=relaxed/simple;
	bh=TcQPhnGhHflnVjo1sR1ToQXkVEdTUiFUQmB7F49MigU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxG60omPf+sER5+6bszzzZDUYhX5d6IniMVK7gtNH6KhvrSGNeTurgR300LhZKp4hj2hvGG4CvrB2cHDHsrKAQ61TW9wRBJSDmAz/PHrb+xd8j+VKJ60QDQfJzBqdo9Hw0ViN2zo00NqEMk/dUN5xxCaqiAIEnHHo32Mx7P10B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMgdtfB5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMgdtfB5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706535064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XGzr+g/CFu4w/bduE8AgyfoZDHpvNuUvHNG+rOrLSxo=;
	b=EMgdtfB5UvST7S8QltK4eQa96bXgZfHZ8R3XIF+edVkKBtZ6PMOF2SjZvoKMYPCWR8NQQA
	UHfWcN9bj8Dwf6rwpBN9HEYR8ZMBGKY7+T8Ms+4pabuZjF7GcyMJqy8Z6YgqCORaX8GsWE
	YCAA1IpKyRQg/smoJGQGgdvKTMzgIr0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-H8en7-NqPu6Vls_9VbbygQ-1; Mon, 29 Jan 2024 08:31:02 -0500
X-MC-Unique: H8en7-NqPu6Vls_9VbbygQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-55f208b9b45so173674a12.2
        for <selinux@vger.kernel.org>; Mon, 29 Jan 2024 05:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706535060; x=1707139860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGzr+g/CFu4w/bduE8AgyfoZDHpvNuUvHNG+rOrLSxo=;
        b=bpQI9tt7F/vyEaxjhbEWixFAMAmYSygGyWMDyLlsAkkr0mXBe1M8FV/c5hrENCCBpi
         kMhG/Rl2IrNnTAIm/iEP08lbGsK80MShyBtfRLqU8ow8rhJJnr/2WcefMxUpneu4thNl
         BEPDq3YctEptL7LgMbBFB9QDpFEwuDPuQS8o70tLSMC6oi8Bdx+5HHipGXFdbVR59GgF
         HP5xMY7gvpsTjgtxYej9MTzaIA/uQ4gLQTXT5I5QrUMnwCpnNdHPyI9523DamzwFXZyf
         IOzjLTAxhtslFbhX38KrmI3S3NNTdOt/NlTtNAbwRqUOjEnNN/gfiuWYgMNW5HRn6HRn
         YUxQ==
X-Gm-Message-State: AOJu0YxttUwGV3oi727ptxQAJ0mlbp64rVm9VNG8gug+DdcDTMDRvwGC
	jfAe86hwtYfrkMvSgeUc5R/iORCGfAVnrXwJ6JRv6XC0efDSJHdZ51ExJTXVu/+Swjs6KDzH8Rg
	ABoldPfjGCfLfi/RBk46SUXwlEX/EPMmlMSdXVhfuDAGIsIWKpmrAqv9paZTWADk=
X-Received: by 2002:a05:6402:2692:b0:55c:85be:f280 with SMTP id w18-20020a056402269200b0055c85bef280mr4445914edd.9.1706535060773;
        Mon, 29 Jan 2024 05:31:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDbhpGso8CY5az7K8Iiiax0R9Bv52yZ0mp18gW+tw9y12xh6MG1GsBe4xAoA9aeInqT3Wr0A==
X-Received: by 2002:a05:6402:2692:b0:55c:85be:f280 with SMTP id w18-20020a056402269200b0055c85bef280mr4445899edd.9.1706535060439;
        Mon, 29 Jan 2024 05:31:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id j17-20020aa7c351000000b0055c4a251205sm3717256edr.90.2024.01.29.05.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:30:59 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH] security: fix no-op hook logic in security_inode_{set,remove}xattr()
Date: Mon, 29 Jan 2024 14:30:58 +0100
Message-ID: <20240129133058.1627971-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two hooks currently work like this:
1. If no LSM registers the hook, cap_inode_{set,remove}xattr() is
   called.
2. If an LSM hook call returns 0, the loop continues to call further
   LSMs (and only stops on an error return value).
3. The "default" return value is 0, so e.g. the default BPF LSM hook
   just returns 0.

This works if BPF LSM is enabled along with SELinux or SMACK (or not
enabled at all), but if it's the only LSM implementing the hook, then
the cap_inode_{set,remove}xattr() is erroneously skipped.

Fix this by using 1 as the default return value and make the loop
recognize it as a no-op return value (i.e. if an LSM returns this value
it is treated as if it wasn't called at all). The final logic is similar
to that of security_fs_context_parse_param().

Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hook_defs.h |  4 ++--
 security/security.c           | 45 +++++++++++++++++++++++++----------
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 76458b6d53da..a281db62b665 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -137,14 +137,14 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
 LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
 LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *attr)
 LSM_HOOK(int, 0, inode_getattr, const struct path *path)
-LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
+LSM_HOOK(int, 1, inode_setxattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name, const void *value,
 	 size_t size, int flags)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
+LSM_HOOK(int, 1, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
diff --git a/security/security.c b/security/security.c
index 3aaad75c9ce8..cedd6c150bdd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2254,7 +2254,8 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
-	int ret;
+	struct security_hook_list *hp;
+	int ret = LSM_RET_DEFAULT(inode_setxattr);
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
@@ -2262,13 +2263,22 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_setxattr, 1, idmap, dentry, name, value,
-			    size, flags);
-
-	if (ret == 1)
+	hlist_for_each_entry(hp, &security_hook_heads.inode_setxattr,
+			     list) {
+		int trc = hp->hook.inode_setxattr(idmap, dentry, name,
+						  value, size, flags);
+		if (trc == LSM_RET_DEFAULT(inode_setxattr))
+			continue;
+		if (trc)
+			return trc;
+		ret = 0;
+	}
+	/* rc can only be either LSM_RET_DEFAULT(...) or 0 here */
+	if (ret == LSM_RET_DEFAULT(inode_setxattr)) {
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 	ret = ima_inode_setxattr(dentry, name, value, size);
 	if (ret)
 		return ret;
@@ -2417,7 +2427,8 @@ int security_inode_listxattr(struct dentry *dentry)
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name)
 {
-	int ret;
+	struct security_hook_list *hp;
+	int ret = LSM_RET_DEFAULT(inode_removexattr);
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
@@ -2425,11 +2436,21 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
-	if (ret == 1)
+	hlist_for_each_entry(hp, &security_hook_heads.inode_removexattr,
+			     list) {
+		int trc = hp->hook.inode_removexattr(idmap, dentry, name);
+		if (trc == LSM_RET_DEFAULT(inode_removexattr))
+			continue;
+		if (trc)
+			return trc;
+		ret = 0;
+	}
+	/* rc can only be either LSM_RET_DEFAULT(...) or 0 here */
+	if (ret == LSM_RET_DEFAULT(inode_removexattr)) {
 		ret = cap_inode_removexattr(idmap, dentry, name);
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 	ret = ima_inode_removexattr(dentry, name);
 	if (ret)
 		return ret;
-- 
2.43.0

