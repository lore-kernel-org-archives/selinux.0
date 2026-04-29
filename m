Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C963148D2
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482533; cv=none; b=SyZPlT3w2e0kbRToTtIRIBzyqa04nhaTfCVkObMInhXWfMyT6aMB5XMawvLsIM+4PoLxY04yjZABqS2tkWAUgIIUg1WvkwdXw0m6QqcH4Uk5NK/XU3x8ox1Y3aC2vbPpsMT6HRJ/UiNRtALj0557wbUNfO2miHxymQoVgJGVl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482533; c=relaxed/simple;
	bh=jmA0zXMXGsvFIdyuuRaHlzDbrCBzxa7+kvQGcqchbuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqs+z0zLa57fDCVtwgT1fugiIRQA/ckSfn2GB38VQF2+BnTyWlyUW/gSGS7OhdFD0lSgqwwCyDvf8PjOLyYmQWrGRI/MMDeFWkpAH5cUtRz14En7lQKUWLzf/JoKxIMlxyOY5n3tAN9pZyrxn7kNYgPF9zV5UXXW7BVdNXx6jfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGvTHFRc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGvTHFRc"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8ea8563c693so1192304485a.2
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777482531; x=1778087331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUqsDdeqYysJRlztNkqWk+oi81ooIzTQa0nRtnGv+bc=;
        b=XGvTHFRccj2Fd2qBR2EgmRv8nYa2fMGTWnDPlCyw7hJSkpgP935D8+7DgUBdsyPvCl
         y5v72oxp3OjPoWdaKH/kR+XavFea0pbn5/rY/v8TzZJg2MH9yHhvcCzDkiPx9Hl2XMwd
         yXqxVHH7/7vXkBtSANRrBTWVtXOJWFTpHYQ8uYn1vpQ7cRRZr+XWU8ydVe5OQrATGMZh
         /p8fmrEvKjhcpTtXufx4uH7sePxtsl/Kxf5V/6X0OU76G5E23/RbUOVcxVYmyDYl4jCT
         8EIotkDnylqVuPau8NwKyNRaoBf96TtpLRpEOUsANWhvjMS9CrQ0H8La0mKcY1MU4kRT
         dxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482531; x=1778087331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MUqsDdeqYysJRlztNkqWk+oi81ooIzTQa0nRtnGv+bc=;
        b=M50GNK7925MQtQs3JAOIj6evStPZIMqzL14yCwGX5FMLXGcKh4jf8FyTtuxDp5K5Gb
         oQsxt74oGk6rdR8HPFmrQ/DCA8n5EyU3ezub6UwoY4Ynbfz7ny5E3/V7LbatQ5YT1WGk
         Q1eoDbJMndmJix/fglZNpYnmfUu6iDUO6ZTWqMOPdWppzdKIvMxYz7mpcjV3ZqyTUXMG
         1TEokP+CqL6fD1qtbf3Lxs8qH1Ygrk4CepqaaDtg1AIOoDd3kNReJLdhPg6i8no7S4yy
         +p2WLdSGV+n7Wi1VkiVK4G3dWBTKTLdVLxqH8wDBYD+sKnj8qRtEqQJb1wqQzpUxYaxl
         v6yA==
X-Gm-Message-State: AOJu0YwCdFti4/qgdIAt3YkM4CxIJO2kKsyJdsPRi/9djPi916Sw5jr2
	LpEVSD4YIYAatiT2qv88e3BFbjAf5ijJSfaUWtmOPoRqdyyEhe0dUV5VL89EHQ==
X-Gm-Gg: AeBDieslnigBUU+xtTJy4GsdzGY28aaEYDWWhCah7PtOS3QvaAGr2TU8hqFpTlfGH54
	4J3uX59BCK5MCEhKlCiHck3lWznWNNsZrEL6T69FKowq8cBkV+vwxzxvHKVyCRSyuiUY6cTUZLa
	ZQ6rsrgpskhbgiDNCR1D0auviVznjdaUyO063vUvbhsH7MHxMzgvy+CenuUXYMjLbapZeii+f4E
	5W7MaGSTAUnRpngIDR8R3O4LV0zOMZfh1U4UHJ18jl813KLQ6YTPLDJGfNUOLV/eMK82qO7kGAH
	tTus8IibNDyTTF0vGsf0qfArwapBPthuLA/fQC6e83U/Q/W4j9j9OZAKYiPctWds27ZMdVhmPpx
	wPjTRgjsqZJOTzBTLIdFX6CP/AwQdXTgdLHL6S6Tuk70xGyLb43U6e4oMTMA6OInFSYuHVXFyvM
	OsSfrlhPW6nmhA8PvkZS4naGgaMuwf481CGmL7gK8gQ3wxHXppEHZ6dQiTTUG2ZpKaBrA2ntbz4
	zbdibPnganUTgX/SqdfObPg1jHL9N7IFxd7b0CeRNkQkgV4inqBBRNBPXznZO6BOg==
X-Received: by 2002:a05:620a:2989:b0:8ed:45b8:de90 with SMTP id af79cd13be357-8f8f5e95358mr708637785a.39.1777482530787;
        Wed, 29 Apr 2026 10:08:50 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93f58333esm225980685a.28.2026.04.29.10.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:08:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/3] selinux: remove /sys/fs/selinux/user
Date: Wed, 29 Apr 2026 13:08:31 -0400
Message-ID: <20260429170833.2581-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429170833.2581-1-stephen.smalley.work@gmail.com>
References: <20260429170833.2581-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Finish removing the legacy /sys/fs/selinux/user interface.

Commit d7b6918e22c7 ("selinux: Deprecate /sys/fs/selinux/user") started
the deprecation process for /sys/fs/selinux/user:

    The selinuxfs "user" node allows userspace to request a list
    of security contexts that can be reached for a given SELinux
    user from a given starting context. This was used by libselinux
    when various login-style programs requested contexts for
    users, but libselinux stopped using it in 2020.
    Kernel support will be removed no sooner than Dec 2025.

A pr_warn() message has been in place since Linux v6.13, and
a 5 second sleep was introduced since Linux v6.17 to help make
it more noticeable.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .../{obsolete => removed}/sysfs-selinux-user  |  0
 security/selinux/selinuxfs.c                  | 71 -------------------
 2 files changed, 71 deletions(-)
 rename Documentation/ABI/{obsolete => removed}/sysfs-selinux-user (100%)

diff --git a/Documentation/ABI/obsolete/sysfs-selinux-user b/Documentation/ABI/removed/sysfs-selinux-user
similarity index 100%
rename from Documentation/ABI/obsolete/sysfs-selinux-user
rename to Documentation/ABI/removed/sysfs-selinux-user
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 8c107af5140e..678cf0ad1d6c 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -53,7 +53,6 @@ enum sel_inos {
 	SEL_ACCESS,	/* compute access decision */
 	SEL_CREATE,	/* compute create labeling decision */
 	SEL_RELABEL,	/* compute relabeling decision */
-	SEL_USER,	/* compute reachable user contexts */
 	SEL_POLICYVERS,	/* return policy version for this kernel */
 	SEL_COMMIT_BOOLS, /* commit new boolean values */
 	SEL_MLS,	/* return if MLS policy is enabled */
@@ -818,14 +817,12 @@ static const struct file_operations sel_transition_ops = {
 static ssize_t sel_write_access(struct file *file, char *buf, size_t size);
 static ssize_t sel_write_create(struct file *file, char *buf, size_t size);
 static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size);
-static ssize_t sel_write_user(struct file *file, char *buf, size_t size);
 static ssize_t sel_write_member(struct file *file, char *buf, size_t size);
 
 static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 	[SEL_ACCESS] = sel_write_access,
 	[SEL_CREATE] = sel_write_create,
 	[SEL_RELABEL] = sel_write_relabel,
-	[SEL_USER] = sel_write_user,
 	[SEL_MEMBER] = sel_write_member,
 	[SEL_CONTEXT] = sel_write_context,
 };
@@ -1071,73 +1068,6 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	return length;
 }
 
-static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
-{
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
-}
-
 static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 {
 	char *scon = NULL, *tcon = NULL;
@@ -1971,7 +1901,6 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_ACCESS] = {"access", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_CREATE] = {"create", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_RELABEL] = {"relabel", &transaction_ops, S_IRUGO|S_IWUGO},
-		[SEL_USER] = {"user", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_POLICYVERS] = {"policyvers", &sel_policyvers_ops, S_IRUGO},
 		[SEL_COMMIT_BOOLS] = {"commit_pending_bools", &sel_commit_bools_ops, S_IWUSR},
 		[SEL_MLS] = {"mls", &sel_mls_ops, S_IRUGO},
-- 
2.54.0

