Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C6219FC
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985421; cv=none; b=K4Vy1NfEZ5XRNa8jVaXds0hb8Nsl/T9NpWTxueda3ex6n4eLiyLyWMFLSIksjmtyWGBSrYSaU98J8Z/sNMsQxdfxl+VlcmV+uX0yUiCuvWS7RCcMUmaNMtGOJQ9FCDWZiQgnhkbHYpHIGHdvfdUEW+nzApS4f6ioP9EZsWO0KvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985421; c=relaxed/simple;
	bh=1n3XZXUzwFIqWs3EtOL7zOF9xk4+5slZcoEw0VAu9pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fH6JQ2cgJlVuf8uutz0m9PEWSbj7aTjSBpm7O0gMryBApkOpIH0KLwCbYcai4IM2mrrt3q5VmjYD+lQQd5K9bG4LwqxPysmVA5wiR9JH4fH5f9WQZGWJDlK/0ozUkJa2HUpiq+ZRKSs7+p89ZUuFE31VoOir8cKrIwl11yCpbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnHIsh1o; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnHIsh1o"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso54109196d6.3
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777985416; x=1778590216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJddhrzmrHFpm/WPo5NB1h7CJh6ZTmn7boeHQsg5y+U=;
        b=JnHIsh1o3izZ8NS8RUXtotcYV5qOUW6cJf9vy2Dwoz+B/qkq7YIKFrIyqZHbIrHk2A
         QfWjGw2bUcjeeEa4CitLLNaur53Osr96PWeEEFt8yYXCk+Akw8KDGzI7rQc4+IElCqlP
         TblWS4LQuRqKROHWfXkpDe4uxqRNpcJtgVQVB13E2rG/gcR6NwuvlQrkchp61Ne0PC1x
         +WK7/LgOsZnKYpsAe1p5DW40NsXnsJl8XVLMvOVUJCToYHJrbuP8fjiTCuVq+7esLhRi
         PJxtvqriXCejN7WyIGIqLUE49MUryA1IIO3AzrKz27oJgjW6G0bhUjigcQm/c2CF1SD1
         C77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985416; x=1778590216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJddhrzmrHFpm/WPo5NB1h7CJh6ZTmn7boeHQsg5y+U=;
        b=mRvJ1RRIQ3iGKh80eV+/WCwuo5kSTXvTM2toHUFVCeJ8H0WTpBWKA+JvzRcWkDGN6L
         VqqQQexmxdSYDpDg93EcrSishOUMjYQlvEgWH+GTH6Qkw2DfWUPN8oIS3yAnom46rDhw
         Q0lMhXC/wQdjD5wXuwVx2C+O24++cbDS//Y4IK7+gkMsEmZ3sEn1vsmuamEm1V6JzOt8
         0yNRw70goejMCbnfjaqDR7emOfNYtWktwAAuSESuSdUu3rAZlXjeKuztcJt1I4X1QGOs
         i+q3OWhSZZYAbt3hendpQGc6jxYYklE9Z4aVUTjbDtQw3FT84T58TSld9ujs+NowNMXZ
         +j/Q==
X-Gm-Message-State: AOJu0YynuewRl71xSGKSP9Dex0Fzg07BbGr+HJ0QKAmwr9JxkvwdkLsu
	a4WbAYKSjh9Oj0Di/xeKkVV93aCptev91lvEVpZCUoVG1l3JUz6/m/5nKxcLOg==
X-Gm-Gg: AeBDieuDeQdWpXe1QGirnY/ii8tPDmgGVi1NL2HQ/JuXdShjmUvR5ujhqQe6xvZB1m5
	4UPT0GRbVqrccEnXDQXLIi9lHFQX9lN+F5bhFu4oREgj3dtRzIib4ZyqkXmK6RaHCyC7g0e8HTn
	j7celhyjnCFEHA4XR1bhi2ut1mPg38TVi8uPIHi99fJDXZ/+kiiOyd6PO9Q+HIpxqBKtbTqUjFI
	5/W8foIA+nRwxEXZHFZcwkc86NOvttGTbIDyzel4dhSS/yfRQhdKvpEKGDFRGxbJAYF3tkxZmLs
	OrTo0G4oY+xDRJaaaziJggBvmw4Ck98Bbxk2zz+ltXbmeESAbOCWLO5lYz3jtMeon34t+oN2i89
	tzLAxt6EMPwmI8fovHfNhJzjS+MNo0ES5AJpALrbwv2SI3lyPka4Z800r3hRm4sU9RoAI6W2sOs
	4GVWbU1Zac2V8FAQ69iScOMFgiVDGRGD8jcgGbBMhHp4Fl+bbnjpJtrADavYFMZPHO1net3xabi
	mzMsLiUNr14NT3MrTA4x/7+kknSp/1GPMSZfXChojhh0ht99+XGwd93z4HgaYtdn2xSVWwbuDQG
X-Received: by 2002:a0c:f10c:0:b0:8b5:6654:7556 with SMTP id 6a1803df08f44-8b6693eb569mr182355916d6.42.1777985416103;
        Tue, 05 May 2026 05:50:16 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831651sm145437216d6.47.2026.05.05.05.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:50:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 3/3] selinux: prune /sys/fs/selinux/user
Date: Tue,  5 May 2026 08:49:50 -0400
Message-ID: <20260505124949.2541-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505124949.2541-2-stephen.smalley.work@gmail.com>
References: <20260505124949.2541-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the previously deprecated /sys/fs/selinux/user interface aside
from a residual stub for userspace compatibility.

Commit d7b6918e22c7 ("selinux: Deprecate /sys/fs/selinux/user") started
the deprecation process for /sys/fs/selinux/user:

    The selinuxfs "user" node allows userspace to request a list
    of security contexts that can be reached for a given SELinux
    user from a given starting context. This was used by libselinux
    when various login-style programs requested contexts for
    users, but libselinux stopped using it in 2020.
    Kernel support will be removed no sooner than Dec 2025.

A pr_warn() message has been in place since Linux v6.13, and a 5
second sleep was introduced since Linux v6.17 to help make it more
noticeable.

We are now past the stated deadline of Dec 2025, so remove the
underlying functionality and replace it with a stub that returns a
'0\0' buffer to avoid breaking userspace. This also avoids a local DoS
from logspam and an uninterruptible sleep delay.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3 adds a pr_err_once() call as requested. Note that we do not need
to copy current->comm when using it in pr_*() calls; this is only
necessary when acting on another task (get_task_comm) or saving
for later use.

 .../{obsolete => removed}/sysfs-selinux-user  |   0
 security/selinux/include/security.h           |   2 -
 security/selinux/selinuxfs.c                  |  68 +---------
 security/selinux/ss/services.c                | 125 ------------------
 4 files changed, 5 insertions(+), 190 deletions(-)
 rename Documentation/ABI/{obsolete => removed}/sysfs-selinux-user (100%)

diff --git a/Documentation/ABI/obsolete/sysfs-selinux-user b/Documentation/ABI/removed/sysfs-selinux-user
similarity index 100%
rename from Documentation/ABI/obsolete/sysfs-selinux-user
rename to Documentation/ABI/removed/sysfs-selinux-user
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index d1f16d7f684d..0babb8992181 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -312,8 +312,6 @@ int security_context_to_sid_default(const char *scontext, u32 scontext_len,
 int security_context_to_sid_force(const char *scontext, u32 scontext_len,
 				  u32 *sid);
 
-int security_get_user_sids(u32 fromsid, const char *username, u32 **sids, u32 *nel);
-
 int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
 
 int security_ib_pkey_sid(u64 subnet_prefix, u16 pkey_num, u32 *out_sid);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index a31bb7b126d5..3421e1bfb979 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1016,69 +1016,11 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 
 static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 {
-	char *con = NULL, *user = NULL, *ptr;
-	u32 sid, *sids = NULL;
-	ssize_t length;
-	char *newcon;
-	int rc;
-	u32 i, len, nsids;
-
-	pr_warn_ratelimited("SELinux: %s (%d) wrote to /sys/fs/selinux/user!"
-		" This will not be supported in the future; please update your"
-		" userspace.\n", current->comm, current->pid);
-	ssleep(5);
-
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
-			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
-			      NULL);
-	if (length)
-		goto out;
-
-	length = -ENOMEM;
-	con = kzalloc(size + 1, GFP_KERNEL);
-	if (!con)
-		goto out;
-
-	length = -ENOMEM;
-	user = kzalloc(size + 1, GFP_KERNEL);
-	if (!user)
-		goto out;
-
-	length = -EINVAL;
-	if (sscanf(buf, "%s %s", con, user) != 2)
-		goto out;
-
-	length = security_context_str_to_sid(con, &sid, GFP_KERNEL);
-	if (length)
-		goto out;
-
-	length = security_get_user_sids(sid, user, &sids, &nsids);
-	if (length)
-		goto out;
-
-	length = sprintf(buf, "%u", nsids) + 1;
-	ptr = buf + length;
-	for (i = 0; i < nsids; i++) {
-		rc = security_sid_to_context(sids[i], &newcon, &len);
-		if (rc) {
-			length = rc;
-			goto out;
-		}
-		if ((length + len) >= SIMPLE_TRANSACTION_LIMIT) {
-			kfree(newcon);
-			length = -ERANGE;
-			goto out;
-		}
-		memcpy(ptr, newcon, len);
-		kfree(newcon);
-		ptr += len;
-		length += len;
-	}
-out:
-	kfree(sids);
-	kfree(user);
-	kfree(con);
-	return length;
+	pr_err_once("SELinux: %s (%d) wrote to user. This is no longer supported.\n",
+		    current->comm, current->pid);
+	buf[0] = '0';
+	buf[1] = 0;
+	return 2;
 }
 
 static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e8e7ccbd1e44..143021c5e326 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2746,131 +2746,6 @@ int security_node_sid(u16 domain,
 	return rc;
 }
 
-#define SIDS_NEL 25
-
-/**
- * security_get_user_sids - Obtain reachable SIDs for a user.
- * @fromsid: starting SID
- * @username: username
- * @sids: array of reachable SIDs for user
- * @nel: number of elements in @sids
- *
- * Generate the set of SIDs for legal security contexts
- * for a given user that can be reached by @fromsid.
- * Set *@sids to point to a dynamically allocated
- * array containing the set of SIDs.  Set *@nel to the
- * number of elements in the array.
- */
-
-int security_get_user_sids(u32 fromsid,
-			   const char *username,
-			   u32 **sids,
-			   u32 *nel)
-{
-	struct selinux_policy *policy;
-	struct policydb *policydb;
-	struct sidtab *sidtab;
-	struct context *fromcon, usercon;
-	u32 *mysids = NULL, *mysids2, sid;
-	u32 i, j, mynel, maxnel = SIDS_NEL;
-	struct user_datum *user;
-	struct role_datum *role;
-	struct ebitmap_node *rnode, *tnode;
-	int rc;
-
-	*sids = NULL;
-	*nel = 0;
-
-	if (!selinux_initialized())
-		return 0;
-
-	mysids = kcalloc(maxnel, sizeof(*mysids), GFP_KERNEL);
-	if (!mysids)
-		return -ENOMEM;
-
-retry:
-	mynel = 0;
-	rcu_read_lock();
-	policy = rcu_dereference(selinux_state.policy);
-	policydb = &policy->policydb;
-	sidtab = policy->sidtab;
-
-	context_init(&usercon);
-
-	rc = -EINVAL;
-	fromcon = sidtab_search(sidtab, fromsid);
-	if (!fromcon)
-		goto out_unlock;
-
-	rc = -EINVAL;
-	user = symtab_search(&policydb->p_users, username);
-	if (!user)
-		goto out_unlock;
-
-	usercon.user = user->value;
-
-	ebitmap_for_each_positive_bit(&user->roles, rnode, i) {
-		role = policydb->role_val_to_struct[i];
-		usercon.role = i + 1;
-		ebitmap_for_each_positive_bit(&role->types, tnode, j) {
-			usercon.type = j + 1;
-
-			if (mls_setup_user_range(policydb, fromcon, user,
-						 &usercon))
-				continue;
-
-			rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
-			if (rc == -ESTALE) {
-				rcu_read_unlock();
-				goto retry;
-			}
-			if (rc)
-				goto out_unlock;
-			if (mynel < maxnel) {
-				mysids[mynel++] = sid;
-			} else {
-				rc = -ENOMEM;
-				maxnel += SIDS_NEL;
-				mysids2 = kcalloc(maxnel, sizeof(*mysids2), GFP_ATOMIC);
-				if (!mysids2)
-					goto out_unlock;
-				memcpy(mysids2, mysids, mynel * sizeof(*mysids2));
-				kfree(mysids);
-				mysids = mysids2;
-				mysids[mynel++] = sid;
-			}
-		}
-	}
-	rc = 0;
-out_unlock:
-	rcu_read_unlock();
-	if (rc || !mynel) {
-		kfree(mysids);
-		return rc;
-	}
-
-	rc = -ENOMEM;
-	mysids2 = kcalloc(mynel, sizeof(*mysids2), GFP_KERNEL);
-	if (!mysids2) {
-		kfree(mysids);
-		return rc;
-	}
-	for (i = 0, j = 0; i < mynel; i++) {
-		struct av_decision dummy_avd;
-		rc = avc_has_perm_noaudit(fromsid, mysids[i],
-					  SECCLASS_PROCESS, /* kernel value */
-					  PROCESS__TRANSITION, AVC_STRICT,
-					  &dummy_avd);
-		if (!rc)
-			mysids2[j++] = mysids[i];
-		cond_resched();
-	}
-	kfree(mysids);
-	*sids = mysids2;
-	*nel = j;
-	return 0;
-}
-
 /**
  * __security_genfs_sid - Helper to obtain a SID for a file in a filesystem
  * @policy: policy
-- 
2.54.0

