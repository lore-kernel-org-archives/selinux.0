Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CE06F06B;
	Tue, 22 Jul 2025 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219309; cv=none; b=AgfwGBxkD2DURq3nTvUyfDoEfYPzwGas2MfiEBHuEBFCcB+EDz78HGs+uqSV2eNZUUCDAkQ/SeTYg0JUlD1ZwOsIaZNbsIIzt+9NJOwtTPId5Dm4q1HxpN3QUDusVJq4HXWuINF+7ba0AOmZLETUucMLUB81MzpYK2LeoG4XnrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219309; c=relaxed/simple;
	bh=XrnpoJlS+kIzusQ6wg+AgThvzL7cR2cbx2SkS3z/T2g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ikuhbt07Pbv2Sq6m+7JGLMTVulctoAgNieqyv9vaelvjfRuPmRdvhmkYUCuxqi/xvq30YW/zxILxDoN3mW7JElhQcGjze9b9ZciJSoLXfQ1ArZr6SAMYNpiCfTKD7LjU1QPjNPCLTF9nG76PP1QzVMp6LW7rR/M+BO2VAi/Vlic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dqn8K8nd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dqn8K8nd"
Received: from narnia.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3850621268B0;
	Tue, 22 Jul 2025 14:21:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3850621268B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753219307;
	bh=v2qRwMEll6JJz01rpCJMZbc9SZPepGpyWnk0eqCwAzk=;
	h=From:To:Subject:Date:From;
	b=Dqn8K8ndQ6+ZNaU0zOKnA6Zxu/oblYuD7q4Y6c5lVQX5zv4dh1KVd1Py2g9boEb4a
	 T8Pm/qYwnKHZPObjzoQpW8hY0UztPm8o6T52WyIAhE6H19TMI5PPIUOlnjGPUytARU
	 I0DgF/CbYRQBzEZvcjD4cfz3sBhRTo+iBFel4Iks=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Song Liu <song@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v2] lsm,selinux: Add LSM blob support for BPF objects
Date: Tue, 22 Jul 2025 14:21:34 -0700
Message-ID: <20250722212139.1666060-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces LSM blob support for BPF maps, programs, and
tokens to enable LSM stacking and multiplexing of LSM modules that
govern BPF objects. Additionally, the existing BPF hooks used by
SELinux have been updated to utilize the new blob infrastructure,
removing the assumption of exclusive ownership of the security
pointer.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
v2:
- Use lsm_blob_alloc
- Remove unneded null check
- ifdef guard bpf alloc helpers
---
 include/linux/lsm_hooks.h         |  3 ++
 security/security.c               | 86 +++++++++++++++++++++++++++++--
 security/selinux/hooks.c          | 56 ++++----------------
 security/selinux/include/objsec.h | 17 ++++++
 4 files changed, 113 insertions(+), 49 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 090d1d3e19fed..79ec5a2bdcca7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -116,6 +116,9 @@ struct lsm_blob_sizes {
 	int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
 	int lbs_tun_dev;
 	int lbs_bdev;
+	int lbs_bpf_map;
+	int lbs_bpf_prog;
+	int lbs_bpf_token;
 };
 
 /*
diff --git a/security/security.c b/security/security.c
index 596d418185773..e34b33ffc26cf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -283,6 +283,9 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_xattr_count,
 			  &blob_sizes.lbs_xattr_count);
 	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
+	lsm_set_blob_size(&needed->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
+	lsm_set_blob_size(&needed->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
+	lsm_set_blob_size(&needed->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
 }
 
 /* Prepare LSM for initialization. */
@@ -480,6 +483,9 @@ static void __init ordered_lsm_init(void)
 	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
 	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
+	init_debug("bpf map blob size    = %d\n", blob_sizes.lbs_bpf_map);
+	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
+	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -835,6 +841,47 @@ static int lsm_bdev_alloc(struct block_device *bdev)
 	return 0;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+/**
+ * lsm_bpf_map_alloc - allocate a composite bpf_map blob
+ * @map: the bpf_map that needs a blob
+ *
+ * Allocate the bpf_map blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_bpf_map_alloc(struct bpf_map *map)
+{
+	return lsm_blob_alloc(&map->security, blob_sizes.lbs_bpf_map, GFP_KERNEL);
+}
+
+/**
+ * lsm_bpf_prog_alloc - allocate a composite bpf_prog blob
+ * @prog: the bpf_prog that needs a blob
+ *
+ * Allocate the bpf_prog blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_bpf_prog_alloc(struct bpf_prog *prog)
+{
+	return lsm_blob_alloc(&prog->aux->security, blob_sizes.lbs_bpf_prog, GFP_KERNEL);
+}
+
+/**
+ * lsm_bpf_token_alloc - allocate a composite bpf_token blob
+ * @token: the bpf_token that needs a blob
+ *
+ * Allocate the bpf_token blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_bpf_token_alloc(struct bpf_token *token)
+{
+	return lsm_blob_alloc(&token->security, blob_sizes.lbs_bpf_token, GFP_KERNEL);
+}
+#endif /* CONFIG_BPF_SYSCALL */
+
 /**
  * lsm_early_task - during initialization allocate a composite task blob
  * @task: the task that needs a blob
@@ -5684,7 +5731,16 @@ int security_bpf_prog(struct bpf_prog *prog)
 int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
 			    struct bpf_token *token, bool kernel)
 {
-	return call_int_hook(bpf_map_create, map, attr, token, kernel);
+	int rc = 0;
+
+	rc = lsm_bpf_map_alloc(map);
+	if (unlikely(rc))
+		return rc;
+
+	rc = call_int_hook(bpf_map_create, map, attr, token, kernel);
+	if (unlikely(rc))
+		security_bpf_map_free(map);
+	return rc;
 }
 
 /**
@@ -5703,7 +5759,16 @@ int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
 int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 			   struct bpf_token *token, bool kernel)
 {
-	return call_int_hook(bpf_prog_load, prog, attr, token, kernel);
+	int rc = 0;
+
+	rc = lsm_bpf_prog_alloc(prog);
+	if (unlikely(rc))
+		return rc;
+
+	rc = call_int_hook(bpf_prog_load, prog, attr, token, kernel);
+	if (unlikely(rc))
+		security_bpf_prog_free(prog);
+	return rc;
 }
 
 /**
@@ -5720,7 +5785,16 @@ int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
 			      const struct path *path)
 {
-	return call_int_hook(bpf_token_create, token, attr, path);
+	int rc = 0;
+
+	rc = lsm_bpf_token_alloc(token);
+	if (unlikely(rc))
+		return rc;
+
+	rc = call_int_hook(bpf_token_create, token, attr, path);
+	if (unlikely(rc))
+		security_bpf_token_free(token);
+	return rc;
 }
 
 /**
@@ -5764,6 +5838,8 @@ int security_bpf_token_capable(const struct bpf_token *token, int cap)
 void security_bpf_map_free(struct bpf_map *map)
 {
 	call_void_hook(bpf_map_free, map);
+	kfree(map->security);
+	map->security = NULL;
 }
 
 /**
@@ -5775,6 +5851,8 @@ void security_bpf_map_free(struct bpf_map *map)
 void security_bpf_prog_free(struct bpf_prog *prog)
 {
 	call_void_hook(bpf_prog_free, prog);
+	kfree(prog->aux->security);
+	prog->aux->security = NULL;
 }
 
 /**
@@ -5786,6 +5864,8 @@ void security_bpf_prog_free(struct bpf_prog *prog)
 void security_bpf_token_free(struct bpf_token *token)
 {
 	call_void_hook(bpf_token_free, token);
+	kfree(token->security);
+	token->security = NULL;
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 595ceb314aeb3..8052fb5fafc4d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7038,14 +7038,14 @@ static int bpf_fd_pass(const struct file *file, u32 sid)
 
 	if (file->f_op == &bpf_map_fops) {
 		map = file->private_data;
-		bpfsec = map->security;
+		bpfsec = selinux_bpf_map_security(map);
 		ret = avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
 				   bpf_map_fmode_to_av(file->f_mode), NULL);
 		if (ret)
 			return ret;
 	} else if (file->f_op == &bpf_prog_fops) {
 		prog = file->private_data;
-		bpfsec = prog->aux->security;
+		bpfsec = selinux_bpf_prog_security(prog);
 		ret = avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
 				   BPF__PROG_RUN, NULL);
 		if (ret)
@@ -7059,7 +7059,7 @@ static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
 	u32 sid = current_sid();
 	struct bpf_security_struct *bpfsec;
 
-	bpfsec = map->security;
+	bpfsec = selinux_bpf_map_security(map);
 	return avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
 			    bpf_map_fmode_to_av(fmode), NULL);
 }
@@ -7069,7 +7069,7 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 	u32 sid = current_sid();
 	struct bpf_security_struct *bpfsec;
 
-	bpfsec = prog->aux->security;
+	bpfsec = selinux_bpf_prog_security(prog);
 	return avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
 			    BPF__PROG_RUN, NULL);
 }
@@ -7079,69 +7079,33 @@ static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
 {
 	struct bpf_security_struct *bpfsec;
 
-	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
-	if (!bpfsec)
-		return -ENOMEM;
-
+	bpfsec = selinux_bpf_map_security(map);
 	bpfsec->sid = current_sid();
-	map->security = bpfsec;
 
 	return 0;
 }
 
-static void selinux_bpf_map_free(struct bpf_map *map)
-{
-	struct bpf_security_struct *bpfsec = map->security;
-
-	map->security = NULL;
-	kfree(bpfsec);
-}
-
 static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 				 struct bpf_token *token, bool kernel)
 {
 	struct bpf_security_struct *bpfsec;
 
-	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
-	if (!bpfsec)
-		return -ENOMEM;
-
+	bpfsec = selinux_bpf_prog_security(prog);
 	bpfsec->sid = current_sid();
-	prog->aux->security = bpfsec;
 
 	return 0;
 }
 
-static void selinux_bpf_prog_free(struct bpf_prog *prog)
-{
-	struct bpf_security_struct *bpfsec = prog->aux->security;
-
-	prog->aux->security = NULL;
-	kfree(bpfsec);
-}
-
 static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
 				    const struct path *path)
 {
 	struct bpf_security_struct *bpfsec;
 
-	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
-	if (!bpfsec)
-		return -ENOMEM;
-
+	bpfsec = selinux_bpf_token_security(token);
 	bpfsec->sid = current_sid();
-	token->security = bpfsec;
 
 	return 0;
 }
-
-static void selinux_bpf_token_free(struct bpf_token *token)
-{
-	struct bpf_security_struct *bpfsec = token->security;
-
-	token->security = NULL;
-	kfree(bpfsec);
-}
 #endif
 
 struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
@@ -7159,6 +7123,9 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 	.lbs_tun_dev = sizeof(struct tun_security_struct),
 	.lbs_ib = sizeof(struct ib_security_struct),
+	.lbs_bpf_map = sizeof(struct bpf_security_struct),
+	.lbs_bpf_prog = sizeof(struct bpf_security_struct),
+	.lbs_bpf_token = sizeof(struct bpf_security_struct),
 };
 
 #ifdef CONFIG_PERF_EVENTS
@@ -7510,9 +7477,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bpf, selinux_bpf),
 	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
 	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
-	LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
-	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
-	LSM_HOOK_INIT(bpf_token_free, selinux_bpf_token_free),
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 6ee7dc4dfd6e0..9f935ed9a761f 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -26,6 +26,7 @@
 #include <linux/lsm_hooks.h>
 #include <linux/msg.h>
 #include <net/net_namespace.h>
+#include <linux/bpf.h>
 #include "flask.h"
 #include "avc.h"
 
@@ -237,4 +238,20 @@ selinux_perf_event(void *perf_event)
 	return perf_event + selinux_blob_sizes.lbs_perf_event;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+static inline struct bpf_security_struct *selinux_bpf_map_security(struct bpf_map *map)
+{
+	return map->security + selinux_blob_sizes.lbs_bpf_map;
+}
+
+static inline struct bpf_security_struct *selinux_bpf_prog_security(struct bpf_prog *prog)
+{
+	return prog->aux->security + selinux_blob_sizes.lbs_bpf_prog;
+}
+
+static inline struct bpf_security_struct *selinux_bpf_token_security(struct bpf_token *token)
+{
+	return token->security + selinux_blob_sizes.lbs_bpf_token;
+}
+#endif /* CONFIG_BPF_SYSCALL */
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.48.1

