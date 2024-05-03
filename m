Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2DFBE58
	for <selinux@vger.kernel.org>; Fri,  3 May 2024 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697941; cv=none; b=Np551IES5ZySMPoqJhe/YoNK2S1EocunjrRCFA5ElCk4iq9bEiVRYrATWLtdMGa03glMSD4/jCUdhxjJPx+tbEdG+AZbGeDOkRVp2lgAlwryfCMg5dkqT+38BGf+VrzyddTpz3Qt2vavSQ5GN64k8G84qpMB9XxUFYh8E/YPRxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697941; c=relaxed/simple;
	bh=/EYdu4J5Yrr+nX8xFUhcXqsJTgMA3B+MT9nsk8PHUVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=et1/Y11uSiD9O/+FmyZPabWgucZq8luFy/eGRo5vqfM7alom7Xc8SVNSTxs3RtXWhhKEJZm6+XhCtP0Ti0ZUtjU9I3O6/wy/enTwbpeUZ0zj8gyurBEWYIjiFrjMRwTE4EZinlgFkO2UWjWToiDq23IZ+ftN8RlZdt9Br8NaSeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YSve/i9D; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YSve/i9D"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ed3587b93bso5104528a34.1
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 17:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714697938; x=1715302738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9D4+n+3a1WWKT287lWZ6oJ8Q/WS8JryuqbqGEFZEBs=;
        b=YSve/i9D56ji1H4xKE4AfysBjQLUR7Ky35dcyXgTuWxOHBjfhewHwIZjVza6NIFd8L
         iYYUpSQ7jsiVyGgjQ2hMvuUFxjw9sNeXMua8HtR5c52VZlPKnkJrFL/ZAc8HmbzqCuye
         tbEFApcwr8K5V5EyPPqAvx+TyIHdRlr6qvUKH9U2FoE9z8R5DRUFxZsWRxI7My8GQzex
         llaxkvz6kgDwE87nkJRQDqokQ9oBN0Oh8juhqMpgoDC/ZRyVb8pXTMd1buBe2yRYZz/5
         voirMwH8rRRoITnabnz8hPk7M4Ea9R61q978k0FpLckliqNvCr/RpTtpDb1XFamo26lz
         SMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714697938; x=1715302738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9D4+n+3a1WWKT287lWZ6oJ8Q/WS8JryuqbqGEFZEBs=;
        b=l1IUObW7yMZBIStU2dIsGuvdnXBxlgCM9Thgt5enn8DwaiWg+k15uDSWyMwMNRifCk
         VcnDZ9uWwpDvVc0tiLZx3ShyMv7UK+dRFhlouSv2ccTlBn4vh1iGprBaYIhL7yEDHsAh
         qCpBvcN+hfvKVb/5V/qFbGU1OFi7kO7PUx8/zOeplsQC3PmQL5RaMO5SlOzR69sN39vx
         CUWuNFXYP+l5W79Sh2doFxhttnPSUjyXnNHRf8PpwoYFfymx/VF9b+Vzc7JrP52wlbPH
         l8eoSbBUrhnm+jRoEpua3Vuia4thRc9lgmeR/3Ixtq/7G2/bBN2ojibOm/uSvqz0BO+Q
         N/FQ==
X-Gm-Message-State: AOJu0Yxn2SYVwBLOhga6eJWqDvyDwRVtHmXdqxnI700ChclOPl6eLiW9
	K4SRb4lauNK9/qjI3A979ygj6CTFHH2sfNK2UAyAshP1/kDf8RZdq/GNash++y2p93lfoimPG6w
	=
X-Google-Smtp-Source: AGHT+IElcc9QEkTiy4t+ELMgojkNZAKs4dF7A6+ccl4lQRtYNFPZxtu7vQpaoucJRRs2DRST7uFDvA==
X-Received: by 2002:a05:6808:3186:b0:3c8:624d:35d3 with SMTP id cd6-20020a056808318600b003c8624d35d3mr2123719oib.54.1714697937620;
        Thu, 02 May 2024 17:58:57 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id k9-20020a056214024900b006a0fbcab221sm775476qvt.3.2024.05.02.17.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 17:58:57 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Felix Fu <fuzhen5@huawei.com>,
	Casey Schaufler <casey@schaufler-ca.com>
Subject: [RFC PATCH] lsm: fixup the inode xattr capability handling
Date: Thu,  2 May 2024 20:58:51 -0400
Message-ID: <20240503005850.466144-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13087; i=paul@paul-moore.com; h=from:subject; bh=/EYdu4J5Yrr+nX8xFUhcXqsJTgMA3B+MT9nsk8PHUVE=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBmNDbKzzOytPXK7wXHf4PAan3tVzmEYvutcWUUd 4CdBWfbYvmJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZjQ2ygAKCRDqIPLalzeJ c5eaEADA4CScLy9wcojfkkfg7FifjOMlB0P2XRT+MwbyfO6dEsclY2Q4YBNHXYIVT9jCVcAGxqH wvoxvQl2+OeaGruJnzPWzUZwnqhSkZ2xkrUczjY0nPqNU7kfdJtOSzsl+FrD4h8vnAplNWncjB+ MXld/Nn18bg/n9RKjNfAQ/AhowkgE8TPgTIfEdKOAm7dHQWbcbVfCgfMtQvM2/UkMnBNX9Wbe4E wHHSXxvdaBagOVbMoOR6qgKT31htr5eJhTqrON89e8VuHKp2o/SDdozWVr2rTW5oF2YFby7mRsT ggfFRdlXZSJ9SVUX39xgkrdIm+BXXC1oPMxnaMY9U89vQkOrcaTmhe76tv7/RBW92NyHJHgNI4H ZJV9RWrHMaKx7q8GvEmouJLe47n43/teIlAcTPPUi7Cbk+JFfKDMr75qrMajw9WDS56tVTJAvqF CUDTqvok/1FoDzd4JeiDwR1QppPK0aYL5RayR+Zo6xuKhe1u7lgDwt1kol3f/CRyZoXWdYWyR4X xJCWsQ/brTtM5hwlufNHRMaLpVyKnDyx6YN4c6DGzw26l4/JCcbFU9QoG4k8MOgke1+wuYbV2PV POTvCsspSNnrBGcD+JHmtAaOXQbBp1/QL5L+QfwJqs4f1PnKPTtknwXEfqNnK7khe3cC7b57lzU unMilVId2qjz9nA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The current security_inode_setxattr() and security_inode_removexattr()
hooks rely on individual LSMs to either call into the associated
capability hooks (cap_inode_setxattr() or cap_inode_removexattr()), or
return a magic value of 1 to indicate that the LSM layer itself should
perform the capability checks.  Unfortunately, with the default return
value for these LSM hooks being 0, an individual LSM hook returning a
1 will cause the LSM hook processing to exit early, potentially
skipping a LSM.  Thankfully, with the exception of the BPF LSM, none
of the LSMs which currently register inode xattr hooks should end up
returning a value of 1, and in the BPF LSM case, with the BPF LSM hooks
executing last there should be no real harm in stopping processing of
the LSM hooks.  However, the reliance on the individual LSMs to either
call the capability hooks themselves, or signal the LSM with a return
value of 1, is fragile and relies on a specific set of LSMs being
enabled.  This patch is an effort to resolve, or minimize, these
issues.

Before we discuss the solution, there are a few observations and
considerations that we need to take into account:
* BPF LSM registers an implementation for every LSM hook, and that
  implementation simply returns the hook's default return value, a
  0 in this case.  We want to ensure that the default BPF LSM behavior
  results in the capability checks being called.
* SELinux and Smack do not expect the traditional capability checks
  to be applied to the xattrs that they "own".
* SELinux and Smack are currently written in such a way that the
  xattr capability checks happen before any additional LSM specific
  access control checks.  SELinux does apply SELinux specific access
  controls to all xattrs, even those not "owned" by SELinux.
* IMA and EVM also register xattr hooks but assume that the LSM layer
  and specific LSMs have already authorized the basic xattr operation.

In order to ensure we perform the capability based access controls
before the individual LSM access controls, perform only one capability
access control check for each operation, and clarify the logic around
applying the capability controls, we need a mechanism to determine if
any of the enabled LSMs "own" a particular xattr and want to take
responsibility for controlling access to that xattr.  The solution in
this patch is to create a new LSM hook, 'inode_xattr_skipcap', that is
not exported to the rest of the kernel via a security_XXX() function,
but is used by the LSM layer to determine if a LSM wants to control
access to a given xattr and avoid the traditional capability controls.
Registering an inode_xattr_skipcap hook is optional, if a LSM declines
to register an implementation, or uses an implementation that simply
returns the default value (0), there is no effect as the LSM continues
to enforce the capability based controls (unless another LSM takes
ownership of the xattr).  If none of the LSMs signal that the
capability checks should be skipped, the capability check is performed
and if access is granted the individual LSM xattr access control hooks
are executed, keeping with the DAC-before-LSM convention.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hook_defs.h |  1 +
 security/security.c           | 70 ++++++++++++++++++++++++-----------
 security/selinux/hooks.c      | 28 ++++++++++----
 security/smack/smack_lsm.c    | 31 +++++++++++++++-
 4 files changed, 98 insertions(+), 32 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 334e00efbde4..6e54dae3256b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -144,6 +144,7 @@ LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
 LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, int ia_valid)
 LSM_HOOK(int, 0, inode_getattr, const struct path *path)
+LSM_HOOK(int, 0, inode_xattr_skipcap, const char *name)
 LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name, const void *value,
 	 size_t size, int flags)
diff --git a/security/security.c b/security/security.c
index 7e118858b545..1f5c68e2a62a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2278,7 +2278,20 @@ int security_inode_getattr(const struct path *path)
  * @size: size of xattr value
  * @flags: flags
  *
- * Check permission before setting the extended attributes.
+ * This hook performs the desired permission checks before setting the extended
+ * attributes (xattrs) on @dentry.  It is important to note that we have some
+ * additional logic before the main LSM implementation calls to detect if we
+ * need to perform an additional capability check at the LSM layer.
+ *
+ * Normally we enforce a capability check prior to executing the various LSM
+ * hook implementations, but if a LSM wants to avoid this capability check,
+ * it can register a 'inode_xattr_skipcap' hook and return a value of 1 for
+ * xattrs that it wants to avoid the capability check, leaving the LSM fully
+ * responsible for enforcing the access control for the specific xattr.  If all
+ * of the enabled LSMs refrain from registering a 'inode_xattr_skipcap' hook,
+ * or return a 0 (the default return value), the capability check is still
+ * performed.  If no 'inode_xattr_skipcap' hooks are registered the capability
+ * check is performed.
  *
  * Return: Returns 0 if permission is granted.
  */
@@ -2286,20 +2299,20 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
-	int ret;
+	int rc;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	/*
-	 * SELinux and Smack integrate the cap call,
-	 * so assume that all LSMs supplying this call do so.
-	 */
-	ret = call_int_hook(inode_setxattr, idmap, dentry, name, value, size,
-			    flags);
 
-	if (ret == 1)
-		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	return ret;
+	/* enforce the capability checks at the lsm layer, if needed */
+	if (!call_int_hook(inode_xattr_skipcap, name)) {
+		rc = cap_inode_setxattr(dentry, name, value, size, flags);
+		if (rc)
+			return rc;
+	}
+
+	return call_int_hook(inode_setxattr, idmap, dentry, name, value, size,
+			     flags);
 }
 
 /**
@@ -2452,26 +2465,39 @@ int security_inode_listxattr(struct dentry *dentry)
  * @dentry: file
  * @name: xattr name
  *
- * Check permission before removing the extended attribute identified by @name
- * for @dentry.
+ * This hook performs the desired permission checks before setting the extended
+ * attributes (xattrs) on @dentry.  It is important to note that we have some
+ * additional logic before the main LSM implementation calls to detect if we
+ * need to perform an additional capability check at the LSM layer.
+ *
+ * Normally we enforce a capability check prior to executing the various LSM
+ * hook implementations, but if a LSM wants to avoid this capability check,
+ * it can register a 'inode_xattr_skipcap' hook and return a value of 1 for
+ * xattrs that it wants to avoid the capability check, leaving the LSM fully
+ * responsible for enforcing the access control for the specific xattr.  If all
+ * of the enabled LSMs refrain from registering a 'inode_xattr_skipcap' hook,
+ * or return a 0 (the default return value), the capability check is still
+ * performed.  If no 'inode_xattr_skipcap' hooks are registered the capability
+ * check is performed.
  *
  * Return: Returns 0 if permission is granted.
  */
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name)
 {
-	int ret;
+	int rc;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	/*
-	 * SELinux and Smack integrate the cap call,
-	 * so assume that all LSMs supplying this call do so.
-	 */
-	ret = call_int_hook(inode_removexattr, idmap, dentry, name);
-	if (ret == 1)
-		ret = cap_inode_removexattr(idmap, dentry, name);
-	return ret;
+
+	/* enforce the capability checks at the lsm layer, if needed */
+	if (!call_int_hook(inode_xattr_skipcap, name)) {
+		rc = cap_inode_removexattr(idmap, dentry, name);
+		if (rc)
+			return rc;
+	}
+
+	return call_int_hook(inode_removexattr, idmap, dentry, name);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3448454c82d0..7be385ebf09b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3181,6 +3181,23 @@ static bool has_cap_mac_admin(bool audit)
 	return true;
 }
 
+/**
+ * selinux_inode_xattr_skipcap - Skip the xattr capability checks?
+ * @name: name of the xattr
+ *
+ * Returns 1 to indicate that SELinux "owns" the access control rights to xattrs
+ * named @name; the LSM layer should avoid enforcing any traditional
+ * capability based access controls on this xattr.  Returns 0 to indicate that
+ * SELinux does not "own" the access control rights to xattrs named @name and is
+ * deferring to the LSM layer for further access controls, including capability
+ * based controls.
+ */
+static int selinux_inode_xattr_skipcap(const char *name)
+{
+	/* require capability check if not a selinux xattr */
+	return !strcmp(name, XATTR_NAME_SELINUX);
+}
+
 static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 				  struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
@@ -3192,15 +3209,9 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 	u32 newsid, sid = current_sid();
 	int rc = 0;
 
-	if (strcmp(name, XATTR_NAME_SELINUX)) {
-		rc = cap_inode_setxattr(dentry, name, value, size, flags);
-		if (rc)
-			return rc;
-
-		/* Not an attribute we recognize, so just check the
-		   ordinary setattr permission. */
+	/* if not a selinux xattr, only check the ordinary setattr perm */
+	if (strcmp(name, XATTR_NAME_SELINUX))
 		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
-	}
 
 	if (!selinux_initialized())
 		return (inode_owner_or_capable(idmap, inode) ? 0 : -EPERM);
@@ -7185,6 +7196,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_permission, selinux_inode_permission),
 	LSM_HOOK_INIT(inode_setattr, selinux_inode_setattr),
 	LSM_HOOK_INIT(inode_getattr, selinux_inode_getattr),
+	LSM_HOOK_INIT(inode_xattr_skipcap, selinux_inode_xattr_skipcap),
 	LSM_HOOK_INIT(inode_setxattr, selinux_inode_setxattr),
 	LSM_HOOK_INIT(inode_post_setxattr, selinux_inode_post_setxattr),
 	LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 146667937811..6e37df0465a4 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1282,6 +1282,33 @@ static int smack_inode_getattr(const struct path *path)
 	return rc;
 }
 
+/**
+ * smack_inode_xattr_skipcap - Skip the xattr capability checks?
+ * @name: name of the xattr
+ *
+ * Returns 1 to indicate that Smack "owns" the access control rights to xattrs
+ * named @name; the LSM layer should avoid enforcing any traditional
+ * capability based access controls on this xattr.  Returns 0 to indicate that
+ * Smack does not "own" the access control rights to xattrs named @name and is
+ * deferring to the LSM layer for further access controls, including capability
+ * based controls.
+ */
+static int smack_inode_xattr_skipcap(const char *name)
+{
+	if (strncmp(name, XATTR_SMACK_SUFFIX, strlen(XATTR_SMACK_SUFFIX)))
+		return 0;
+
+	if (strcmp(name, XATTR_NAME_SMACK) == 0 ||
+	    strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
+	    strcmp(name, XATTR_NAME_SMACKIPOUT) == 0 ||
+	    strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
+	    strcmp(name, XATTR_NAME_SMACKMMAP) == 0 ||
+	    strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0)
+		return 1;
+
+	return 0;
+}
+
 /**
  * smack_inode_setxattr - Smack check for setting xattrs
  * @idmap: idmap of the mount
@@ -1325,8 +1352,7 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 		    size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
-	} else
-		rc = cap_inode_setxattr(dentry, name, value, size, flags);
+	}
 
 	if (check_priv && !smack_privileged(CAP_MAC_ADMIN))
 		rc = -EPERM;
@@ -5050,6 +5076,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_permission, smack_inode_permission),
 	LSM_HOOK_INIT(inode_setattr, smack_inode_setattr),
 	LSM_HOOK_INIT(inode_getattr, smack_inode_getattr),
+	LSM_HOOK_INIT(inode_xattr_skipcap, smack_inode_xattr_skipcap),
 	LSM_HOOK_INIT(inode_setxattr, smack_inode_setxattr),
 	LSM_HOOK_INIT(inode_post_setxattr, smack_inode_post_setxattr),
 	LSM_HOOK_INIT(inode_getxattr, smack_inode_getxattr),
-- 
2.45.0

