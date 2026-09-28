Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C592134887B
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617620; cv=none; b=JLD2GGOHrZ1CPmY1b8d+Nd2tljAfWDQCp18Wj//8aKLv81nLvW0+184pykIEqQ7EsbKAc7VIrv9rtMM8dL1PnkIm+SOyk67IuS9OfxA+Bgo6IZU9vDXRjS2rCd4V3YEmus0ZFLIfJwpKgSUYc5vs/xAeD+LgEro7SEPD734r/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617620; c=relaxed/simple;
	bh=hRYMGT8doUUN+VtXrd6pVRoOLOrEhYb5jcJlsu1uBvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBFjUQIjWikamg4VfVXSFKNAKADHXYZBT409i3rbAZ0Run1FfqEg1LMCqA0wZmItCv3SUSTem6cicAn9qqJ8O7LNItDapG5D7w710i825OG1ugp3QWlt50sHUR9sERJ33+TEakJSPlO7KwmutLVynLay6Hce8RTQBD0TFh6Zl58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=YJRQQWkC; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="YJRQQWkC"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617617;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkaPrNxtpA8MCfrmR8B4iX3vaM6Pd2xeWC2EDEg4mHI=;
	b=YJRQQWkC2DxzIjQKazGHpl19DZjLuzhjGQPQPF2h5/cgONIUPq6sW5xbGNWIDH/SeYFQkz
	e5g7CjYxUV8EKUQ3uEqsdmxFRa5U2S+sFMeyRnxrPyR9udq1FfEdr0kKu/TmOlQ8vXdpmo
	H+uf8e+mFNPug3RwNefA26T7vVfeC0XFP/s71axSDRGNTgZAVDfZQcbJIcWDo1u49WnPcF
	ZmIWaN6bOeSDvjqTMZUeNBz1E7XJ87aDUvFrgIXDi+za/s2jcSXtxoj7vaAH57pg4fN3JA
	KeZWjM0Lhos/s3b87XuIfsqz427nd7o8f2K8m8Oi8l8ssKU918GfYPVnih/QVg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 03/32] selinux: use kfree_strarray()
Date: Mon, 28 Sep 2026 19:46:13 +0200
Message-ID: <20260928174643.2458710-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Replace open-coded loops freeing an array of strings with the
existing kfree_strarray() helper, which also handles a NULL array.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c   | 21 +++++----------------
 security/selinux/ss/services.c | 22 +++++-----------------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index b3eaf3823fb1..ca821a812691 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -24,6 +24,7 @@
 #include <linux/namei.h>
 #include <linux/init.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/security.h>
 #include <linux/major.h>
 #include <linux/seq_file.h>
@@ -96,12 +97,8 @@ static int selinux_fs_info_create(struct super_block *sb)
 
 static void selinux_fs_info_free(struct selinux_fs_info *fsi)
 {
-	unsigned int i;
-
 	if (fsi) {
-		for (i = 0; i < fsi->bool_num; i++)
-			kfree(fsi->bool_pending_names[i]);
-		kfree(fsi->bool_pending_names);
+		kfree_strarray(fsi->bool_pending_names, fsi->bool_num);
 		kfree(fsi->bool_pending_values);
 	}
 	kfree(fsi);
@@ -443,12 +440,8 @@ static const struct file_operations sel_policy_ops = {
 static void sel_remove_old_bool_data(unsigned int bool_num, char **bool_names,
 				     int *bool_values)
 {
-	u32 i;
-
 	/* bool_dir cleanup */
-	for (i = 0; i < bool_num; i++)
-		kfree(bool_names[i]);
-	kfree(bool_names);
+	kfree_strarray(bool_names, bool_num);
 	kfree(bool_values);
 }
 
@@ -1658,9 +1651,7 @@ static int sel_make_perm_files(struct selinux_policy *newpolicy,
 
 		rc = sel_attach_file(dir, perms[i], inode);
 	}
-	for (i = 0; i < nperms; i++)
-		kfree(perms[i]);
-	kfree(perms);
+	kfree_strarray(perms, nperms);
 	return rc;
 }
 
@@ -1725,9 +1716,7 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
 	}
 	rc = 0;
 out:
-	for (i = 0; i < nclasses; i++)
-		kfree(classes[i]);
-	kfree(classes);
+	kfree_strarray(classes, nclasses);
 	return rc;
 }
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3cfe9c7b28c6..ce9f9c483f49 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -40,6 +40,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/errno.h>
@@ -2960,11 +2961,7 @@ int security_get_bools(struct selinux_policy *policy,
 out:
 	return rc;
 err:
-	if (*names) {
-		for (i = 0; i < *len; i++)
-			kfree((*names)[i]);
-		kfree(*names);
-	}
+	kfree_strarray(*names, *len);
 	kfree(*values);
 	*len = 0;
 	*names = NULL;
@@ -3090,11 +3087,7 @@ static int security_preserve_bools(struct selinux_policy *oldpolicy,
 	evaluate_cond_nodes(&newpolicy->policydb);
 
 out:
-	if (bnames) {
-		for (i = 0; i < nbools; i++)
-			kfree(bnames[i]);
-	}
-	kfree(bnames);
+	kfree_strarray(bnames, nbools);
 	kfree(bvalues);
 	return rc;
 }
@@ -3336,9 +3329,7 @@ int security_get_classes(struct selinux_policy *policy,
 	return rc;
 
 err:
-	for (i = 0; i < *nclasses; i++)
-		kfree((*classes)[i]);
-	kfree(*classes);
+	kfree_strarray(*classes, *nclasses);
 	return rc;
 }
 
@@ -3359,7 +3350,6 @@ int security_get_permissions(struct selinux_policy *policy,
 			     const char *class, char ***perms, u32 *nperms)
 {
 	struct policydb *policydb;
-	u32 i;
 	int rc;
 	struct class_datum *match;
 
@@ -3395,9 +3385,7 @@ int security_get_permissions(struct selinux_policy *policy,
 	return rc;
 
 err:
-	for (i = 0; i < *nperms; i++)
-		kfree((*perms)[i]);
-	kfree(*perms);
+	kfree_strarray(*perms, *nperms);
 	return rc;
 }
 
-- 
2.55.0

