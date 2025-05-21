Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8761D1D86D6
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838672; cv=none; b=YN029Uv+Md3EObhb07YJnNBgdxTK3UhSj31wrSt5K2LXrjAfZeRLgTQESATnxVTSxz5kY13i+yfoQyreP9VnX+XvfFG6xL/zWhU5xYrMr6T6P48oZS/9j49EqlM5vbJv096TvLN4FnTPPVdofHgkKh04vhkmtzhvNKG4emgvJew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838672; c=relaxed/simple;
	bh=H9I3OYk2ij0EGDS/iKIHQLegj1Uig5Zx+NpGuzXssE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5UzrHOQacp+qcKZxMZE0Jxh3SK2CmxsKq8BG/SOuPBLZaAweQjqhsmr6qxybJw9uqOf4K/dCnRvVqUZu/i4zaQiA7mhi6hWLPhMLzQj/svrDU7TUUWJ957gVQmg6HgKBAj4MzAOmadiX8SPk8WiFIYsVMtNUG7fcm6Lfaujhcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSLXFJ85; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSLXFJ85"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f8d663fa22so50643516d6.0
        for <selinux@vger.kernel.org>; Wed, 21 May 2025 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747838669; x=1748443469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J02961rsOuUxseIWOVGLUFghrisZK8AT6U+QdY+Feec=;
        b=PSLXFJ85MZhBF+yV+phD2Teq2LkeTqqQOwxVHLWOrRdOqbzt6iviTmHfbqhyXNQp1y
         Y6xuftbYq2jKX5zch4kK0qcC3EkubmmmEqVqq1j4k52oWcMu6SRecqPJpo7FyJIbGUnA
         D8wiKYlwHEPCsWOqC0mI+2rbLuRHglddyE98HC3nRHmdA8pKBnSPM12hi2etCkl5eq45
         90EztjQrbyDqSB6B8tUa/T9UU5yrL2Xgz4ydaQxCNQZgT+DHw2mFYqUjMC5tLQTPnczj
         /UXzawbN747sDeCH3AFEMCNyYZVzoSsTiJogHX+/JgMtTgENn5HCt8JiDMnV7zCYOywa
         4IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747838669; x=1748443469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J02961rsOuUxseIWOVGLUFghrisZK8AT6U+QdY+Feec=;
        b=tHRD1BNCObBb6JobCWTASd60Mt+qjooT4UVbKXMhwodaM0ra6nfJVfgrIsUVPHhL9n
         3uCXAHOOMvHZCeBsInwhJIYa7NvIxxU9NrP4JmCU0lY8inpsb9fd1p1+bTvwanyOhPJV
         yrqqjp0x3DMmy2xXrTFB/bfxBu6z6WE7Q91UbPvgoXh+L8QiXxExGAktpbfHTuH6CKfa
         fhFWnxLYymRpNl3DKIY6nByIslmN16w8re1WHHpq7BbtqkLYDIWGIJuaHfjbDR0hn1ZM
         AafTD5JGrlq9jLLv3BRHrtKrM1pfgaYphNQx1GwOmiY5/UYRHf1rvjNoq7k3c+ehRO3t
         Ck5g==
X-Gm-Message-State: AOJu0Yx/+7LjBdnug2cAHEvza9bJE/dYJ8AdtXAby3AktA+ANA2sWHE6
	5RwSx1laSLKhz4AFLp7AXXETZKO67HmMJkT89zVQfR6CjSxZI8ZBz/EWa18Yeg==
X-Gm-Gg: ASbGnct3b79IXQQUmmBUOaLfyLgHoUrilGYMYM5LWB9+R7ys71tcy5dKAkxfzukJj+p
	MzIXyxjUd04kKGSBZNMz4q8nD9fGuv+EzHxyY676JSNeNX6y/QXIyhIY4Qf1Oucai75oc7LFiEZ
	QWMrecR/KKfEt4KtPlG8L9aT2KfsXQH4s4QgRF3d+H26IwL8SDXwq4KkZTVBk/tpA7fYtp8d5sS
	50e/9DZ43QqHWrHZg5TnX2MrWRXOPDj0yoIaR2KguICiXnj1h7cTE2UcVaO9QJEp+esNRpjCYbr
	ZMawQetXCJZTrYHj0Xs7FnT7ZkNl+pfY2ArpRonZCSbi+0Wr2A0Be2YyZ7RCH/4gQNcJhaMBlQ9
	+Z0EijVRTjVVEC2EWwjFg4m7xieosa5UuLyRJTImSZmeBeqOfSmUEgQ==
X-Google-Smtp-Source: AGHT+IGMFReRelJvrsAOy1sUFwiNHUOI217DFVoi+mtbjkZCsNjhK7cRVh+ltttLjdFIr3TdTKf+uA==
X-Received: by 2002:a05:6214:230c:b0:6e8:98a1:3694 with SMTP id 6a1803df08f44-6f8b2c32bfbmr362404346d6.8.1747838668994;
        Wed, 21 May 2025 07:44:28 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b0987570sm86275176d6.121.2025.05.21.07.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:44:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/2] selinux: optimize selinux_inode_getattr/permission() based on neveraudit|permissive
Date: Wed, 21 May 2025 10:41:25 -0400
Message-ID: <20250521144123.199370-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521144123.199370-2-stephen.smalley.work@gmail.com>
References: <20250521144123.199370-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the task avdcache to also cache whether the task SID is both
permissive and neveraudit, and return immediately if so in both
selinux_inode_getattr() and selinux_inode_permission().

The same approach could be applied to many of the hook functions
although the avdcache would need to be updated for more than directory
search checks in order for this optimization to be beneficial for checks
on objects other than directories.

To test, apply https://github.com/SELinuxProject/selinux/pull/473 to
your selinux userspace, build and install libsepol, and use the following
CIL policy module:
$ cat neverauditpermissive.cil
(typeneveraudit unconfined_t)
(typepermissive unconfined_t)

Without this module inserted, running the following commands:
   perf record make -jN # on an already built allmodconfig tree
   perf report --sort=symbol,dso
yields the following percentages (only showing __d_lookup_rcu for
reference and only showing relevant SELinux functions):
   1.65%  [k] __d_lookup_rcu
   0.53%  [k] selinux_inode_permission
   0.40%  [k] selinux_inode_getattr
   0.15%  [k] avc_lookup
   0.05%  [k] avc_has_perm
   0.05%  [k] avc_has_perm_noaudit
   0.02%  [k] avc_policy_seqno
   0.02%  [k] selinux_file_permission
   0.01%  [k] selinux_inode_alloc_security
   0.01%  [k] selinux_file_alloc_security
for a total of 1.24% for SELinux compared to 1.65% for
__d_lookup_rcu().

After running the following command to insert this module:
   semodule -i neverauditpermissive.cil
and then re-running the same perf commands from above yields
the following non-zero percentages:
   1.74%  [k] __d_lookup_rcu
   0.31%  [k] selinux_inode_permission
   0.03%  [k] selinux_inode_getattr
   0.03%  [k] avc_policy_seqno
   0.01%  [k] avc_lookup
   0.01%  [k] selinux_file_permission
   0.01%  [k] selinux_file_open
for a total of 0.40% for SELinux compared to 1.74% for
__d_lookup_rcu().

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 introduces a task_avdcache_permnoaudit() static inline function.

 security/selinux/hooks.c          | 14 +++++++++++++-
 security/selinux/include/objsec.h |  8 ++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b8115df536ab..29cb4d48c0c7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3184,6 +3184,8 @@ static inline void task_avdcache_update(struct task_security_struct *tsec,
 	tsec->avdcache.dir[spot].audited = audited;
 	tsec->avdcache.dir[spot].allowed = avd->allowed;
 	tsec->avdcache.dir[spot].permissive = avd->flags & AVD_FLAGS_PERMISSIVE;
+	tsec->avdcache.permissive_neveraudit =
+		(avd->flags == (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERAUDIT));
 }
 
 /**
@@ -3210,10 +3212,13 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 	if (!mask)
 		return 0;
 
+	tsec = selinux_cred(current_cred());
+	if (task_avdcache_permnoaudit(tsec))
+		return 0;
+
 	isec = inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
-	tsec = selinux_cred(current_cred());
 	perms = file_mask_to_av(inode->i_mode, mask);
 
 	rc = task_avdcache_search(tsec, isec, &avdc);
@@ -3277,6 +3282,13 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 static int selinux_inode_getattr(const struct path *path)
 {
+	struct task_security_struct *tsec;
+
+	tsec = selinux_cred(current_cred());
+
+	if (task_avdcache_permnoaudit(tsec))
+		return 0;
+
 	return path_has_perm(current_cred(), path, FILE__GETATTR);
 }
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 6ee7dc4dfd6e..1d7ac59015a1 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -49,9 +49,17 @@ struct task_security_struct {
 		u32 seqno; /* AVC sequence number */
 		unsigned int dir_spot; /* dir cache index to check first */
 		struct avdc_entry dir[TSEC_AVDC_DIR_SIZE]; /* dir entries */
+		bool permissive_neveraudit; /* permissive and neveraudit */
 	} avdcache;
 } __randomize_layout;
 
+static inline bool task_avdcache_permnoaudit(struct task_security_struct *tsec)
+{
+	return (tsec->avdcache.permissive_neveraudit &&
+		tsec->sid == tsec->avdcache.sid &&
+		tsec->avdcache.seqno == avc_policy_seqno());
+}
+
 enum label_initialized {
 	LABEL_INVALID, /* invalid or not initialized */
 	LABEL_INITIALIZED, /* initialized */
-- 
2.49.0

