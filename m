Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74B1A2630
	for <selinux@vger.kernel.org>; Fri,  2 May 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746205532; cv=none; b=WpR7wsNMgG217Y2cPU2ZGNRchqtELWZVGs7qwneA1++vjJVXmwjpJREdHf0hD+Lzw7FlG57sSCvJBtJWtVz9cTyi6HRK1WDjKtdCp44F0BgGMkGpEHVRzWFzWcmEb8N0q4cgejhJWsVADnMu4P6+G3OnybGP7IUoScIJNES5nOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746205532; c=relaxed/simple;
	bh=eX0eeH9PV34YUVEgFE2rU8zJMiPCyq4W+ur5D2PEpvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RF44MnfMNgN1XUsaFjX4Ot80kozXRBnoVW2L3SHMddgjYlPaSqhIMavyEVSeZ7qGQom9L7EZ3QipITs6gzaWJZuIWcSEvNVgWnHn2TN+7B9p/X+qVjCks11VDaOODmqHZPi3WXztsTinwtRstqHqGxWJ+85eW203XKRohC+FSrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBS0fgBQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBS0fgBQ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5b2472969so246494985a.1
        for <selinux@vger.kernel.org>; Fri, 02 May 2025 10:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746205529; x=1746810329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDSW8YTIaCbPpcp2YS26jgRwokaWcAzIJe8SPZFXrsQ=;
        b=EBS0fgBQfTLHb7br47Yb2AmThnfKCiE/X1e4TeCWzLQh+VBzi9ZkHc8e6T7X+KkcOq
         18dlJwAXox+VTHs8f5KOTrDiZELR6yumky1RrD7sHSGCdaOPZqdN3EDmN+gv3NNIAQwh
         Qa0d52GikPvRjsYc77wRfJ0Or28gVR1RdlgmM1H1XBxfQ49XkIt8o97EDJNHYXdvbo27
         jBOKVXjIFREslPlhgcmocpdLOGAEI29oWYRW2j7hhpwtos8f7dggZ3YsE1osb1/enXw/
         1wZiMTkafwoUsikyBJXLKYq73CtDflSsfwJ+Ug39I7nVtrsnsspcuW8DT/YQ/8epBr/Y
         rrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746205529; x=1746810329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDSW8YTIaCbPpcp2YS26jgRwokaWcAzIJe8SPZFXrsQ=;
        b=S+2ST5rqysvOv0PyjVk0oJTRQmFLIQqFTPHQ8IpNsdDsCVG7QGuJ/Ni/CkmNsoVPoq
         si5wUI2fTSN3YIIWiXFp1AxPo+rAtVQ3p78F6L0vufXLw+P61L18BP5MpKNgpvQfKYTr
         e8OCAtU25Pexoho8e99L6QZuBOw3NQaF763TgJCSdMRvEHs0vuUVhlAT7kU4Fa6pLgbo
         k9qwZKdJfbD3V/aTI8oWWgZFdI95mz8RpEQY6mfpA5+oQ1QoReBerugLiGDC431zroc4
         kpK7Qv/CPQIT3IKE+hyDLfIM3flD38y0u5Opy70LhEKiDVwb7zdOk/kgGsSvV/HOnWWZ
         x45g==
X-Gm-Message-State: AOJu0Yw7bEAIjZ4r7S15BVhdc+BMO6XaHzzg/UOF6eP5kY4HT76NdkZn
	16OOtP5lDe3yTqjmIuRxxl/rr/h4zDKP0eNQ1yoo+OEW/MIkwAErFveS8g==
X-Gm-Gg: ASbGncsnfe3IRgUDhAfS4yuvELveA8hnb8ar0LwpVZU+zN9Oi+3xt/uwzaB69yxc/+s
	r8QexxRVVed/bWo8hq9OfLxrjCHjID0bxBUNgrYgwTa2ctv/j3FSTRaD3fxrxgCPbwizktI0X4f
	ZS9R1orsUqoYhNB97/katipCe3vnErHyhblnwYI2vxu+og7kuHlHfmKldKb/u2TC/BvHK8mZAyg
	QHTQHPlU3UJUIsCEWuuokq9E9fGIqtOD0vnOVkPLfFBGEkT5H5Ss0jeAwyj3g92pgj5/6EqBy/i
	rc7NvDyFRV+LHRW0pq81+pmAYr/hUKP+t/azOFFszXFzy9G8LgH63bcAAfLDeS1tNiu3DBYk166
	cd9YusLUQIlpatpJ9rkAI5OqzrMwL9r9Aq+0cY2sQYzmpwA4XoUPauuyLalb6HHhAazLs
X-Google-Smtp-Source: AGHT+IGUFYcrPxgFquYxbxoKDMD12AshiJZrHjMWQzr1U7F9hUTAzcGrm9S38kI+I3t3cr48CppT9Q==
X-Received: by 2002:a05:620a:290f:b0:7c7:a537:7ce2 with SMTP id af79cd13be357-7cad5b5a834mr495579985a.32.1746205529477;
        Fri, 02 May 2025 10:05:29 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad242b66dsm207358085a.86.2025.05.02.10.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 10:05:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] selinux: optimize selinux_inode_getattr/permission() based on neveraudit|permissive
Date: Fri,  2 May 2025 13:04:51 -0400
Message-ID: <20250502170450.27160-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502170450.27160-2-stephen.smalley.work@gmail.com>
References: <20250502170450.27160-2-stephen.smalley.work@gmail.com>
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
your selinux userspace, build and install libsepol and secilc, and use
the following CIL policy module:
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
 security/selinux/hooks.c          | 18 +++++++++++++++++-
 security/selinux/include/objsec.h |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b8115df536ab..1a3806fdf3d6 100644
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
@@ -3210,10 +3212,15 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 	if (!mask)
 		return 0;
 
+	tsec = selinux_cred(current_cred());
+	if (tsec->avdcache.permissive_neveraudit &&
+		tsec->sid == tsec->avdcache.sid &&
+		tsec->avdcache.seqno == avc_policy_seqno())
+		return 0;
+
 	isec = inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
-	tsec = selinux_cred(current_cred());
 	perms = file_mask_to_av(inode->i_mode, mask);
 
 	rc = task_avdcache_search(tsec, isec, &avdc);
@@ -3277,6 +3284,15 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 static int selinux_inode_getattr(const struct path *path)
 {
+	struct task_security_struct *tsec;
+
+	tsec = selinux_cred(current_cred());
+
+	if (tsec->avdcache.permissive_neveraudit &&
+		tsec->sid == tsec->avdcache.sid &&
+		tsec->avdcache.seqno == avc_policy_seqno())
+		return 0;
+
 	return path_has_perm(current_cred(), path, FILE__GETATTR);
 }
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 6ee7dc4dfd6e..51a42b1a61a9 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -49,6 +49,7 @@ struct task_security_struct {
 		u32 seqno; /* AVC sequence number */
 		unsigned int dir_spot; /* dir cache index to check first */
 		struct avdc_entry dir[TSEC_AVDC_DIR_SIZE]; /* dir entries */
+		bool permissive_neveraudit; /* permissive and neveraudit */
 	} avdcache;
 } __randomize_layout;
 
-- 
2.49.0

