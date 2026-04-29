Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D9372EFF
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497189; cv=none; b=A8+psdROJndlZ6uP0jb5WXOUmnM80BRNhPPkZDXAdA2fbswcJIyNWtop06x2Hj2eykRAMihjoloXwYl9rpsiildIFs2GdzSxOXSdw0x9RjfRX+FPbUknDwLCxQLSJJUeonCZ45Fk4V5pCBJGBE582JM4/tnjKsv3wPrZNgBsgJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497189; c=relaxed/simple;
	bh=w0DOQLXVIMZ4xZR0ZB7xkP0RHLWpAIKOLq5ziV833oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fb2K4iWac2EVYMFaAb3rGvldrK0QteePROE63/atY6YKEhqdhQkzT6SLqernirzZOh3r9eRkXWkzYV569Wa/nDF2dY6AmKfcq84DxnI0HEbJNsvBlWc0XfPVHT7cxmvMcb7BCGPynAkTgbDDm0mPiP/ARAMl4+i/4JxYXq8f/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuEHYHXk; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuEHYHXk"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ed4dd182efso13002085a.3
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497187; x=1778101987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quSVpldBOdx/+N6opObR8cdyXnx/jtISeOo4Z67e2U4=;
        b=kuEHYHXkvnh4wItck0lIoiEBSWRBLny4VCJnsXgiUmCJSBQUMCsMYHoe7ByhyknQaW
         pSAX2MGqsj/liFv0HdRcFbJN4AHYiPjwGFmbRaTvmHncqJW3DYi13YS++HsPgsJvRV1P
         2ZvhW4dBuhkCvJqwTLeiObjaH8ZxKURDnYrzAYIKHxR/sWiPg2BvKvVo6ILGrRI0I/oG
         zKOs0DcoxH1QkQNZm0LDgAxO01b2K76hJQGNvEJIsDiVQnK/1Z0pQXZiw3nHEocweEp/
         KTtZ9g2xrCYgBbo1YrVPL1NZKXqgy5ehq1nY3SO3QQDBZkkYVLCE5h8Nrw4bAFFwGC+i
         HcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497187; x=1778101987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=quSVpldBOdx/+N6opObR8cdyXnx/jtISeOo4Z67e2U4=;
        b=PSf0ED8ZEG+shCqF2xOg6vuyeKbEw4atKNEB4Swmh7SLMBYWgP9yG3q47Ta2XoSsYm
         sgUpsntIQmPrG7Tlv/mNG1LutZ+hYHrexONeyd7pvm9/Smsg/U3Qz2GAxe+GrYl2Y5XY
         IqGMg2GrzwCgOLD7BEMuytD/V9G2E0Z5DiUc8Yp+mOqq3CW+0faAUVu0MYsFfsia9TfF
         SyghndCrslEs5vVzEcLYqL2Cr+Co5SHps9hlEq0zBts748qxhE37CXhPblJitLbkmlIB
         rCq0YzPb9Acblz2UvEDLFcsjzmmpfPMRCw2zggpZcatHa5WCWVWrYtv3DySwgy3kINHJ
         wbBQ==
X-Gm-Message-State: AOJu0YxN4EJDGE3CxfpEyV/KQkoeY6nqfAmbMRvz6amlWd0fCkQaZAAt
	kw8j7xMazVAKkxKWdM5/o85B7tGWO8IpfScAYQiG+yKn2WGQ1V54wYhIh/Kfdg==
X-Gm-Gg: AeBDietyC5e0v/nEjeFbOcdZVrbwMfm0DqdDobiZR57nYimNf5bCHmTjDFxtn7U8LtF
	YUaykOASiE2Sp4k3suPTYAocM9hXkR8F05E5m+ss7Tqn4ou6JnayVDcOygSvcgwpH+wGOIHbX3t
	+D7L8eYwSZtnwJhVZPTpOnFLBV4YP5p3i/1mwsRmeD5q9KCjchWU9prmB8Kd2Y1u7v+b3vd55PJ
	JnTEaxxfubxksX+gIg4THMQ6grlt9iF5PsPisFA1sDtgzFEr2qJdjtkeYq/rjh/ONjUSGphtf1a
	g430PSHtKEo9Bcu8ycFl2joQvLyMcIvdjmAe1f+80yaD7YobE949JI9IVnxNDQPuPdM17lUoM44
	QUd7jZZHHAk1AZdLHTuOLtqz5L32fssb8pYpwknkjf4+x5xlEtLpLG+7s5bF64Rh+5zIV+hPSRR
	NiOCDwolK3Q5h+UynlqY71N8bgUi1QAPVC/BIJjaMehu9G3ECvKOfk6umofCuFxJ8/TPHKe3f0G
	6YUNzmEoPawpvrC9EGan199ltLaBoSvD39qFpKa8OJz/gxvkZDtD3WCDFpO+RegN09NHYoOlCaw
X-Received: by 2002:a05:620a:4886:b0:8ef:7934:22d8 with SMTP id af79cd13be357-8fa89bfc3f2mr71495185a.54.1777497186664;
        Wed, 29 Apr 2026 14:13:06 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93cff8e85sm280355885a.17.2026.04.29.14.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:13:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 3/3] selinux: prune /sys/fs/selinux/user
Date: Wed, 29 Apr 2026 17:12:29 -0400
Message-ID: <20260429211229.3750-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429211229.3750-1-stephen.smalley.work@gmail.com>
References: <20260429211229.3750-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Finish removal of the /sys/fs/selinux/user interface aside from a
residual stub for userspace compatibility.

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
from logspam.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .../{obsolete => removed}/sysfs-selinux-user  |   0
 security/selinux/include/security.h           |   2 -
 security/selinux/selinuxfs.c                  |  66 +--------
 security/selinux/ss/services.c                | 125 ------------------
 4 files changed, 3 insertions(+), 190 deletions(-)
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
index 2181c82b5159..fe84901ffb8e 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1014,69 +1014,9 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 
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

