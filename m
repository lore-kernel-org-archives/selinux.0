Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A0421F10
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577904; cv=none; b=ZwqSrKq9V16R7W3yGfs/mi++QuNToBo6dS6yKoqIRVzJUUiVuq9kWBbn2ktJZ5xZeekzNbQ3JOB4mfUpIFRnttkndlwklf4NAZOdk7gEcgDdwOh37spz+muVdaM5P+lh0SvoU7t/dQqnH7wGP2W4cNGZb8I16MwyKR27H1Llz60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577904; c=relaxed/simple;
	bh=w7Pt/tC4imck1O1BtBNoJxKZQN64UfQAHRYAP9Zb9v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMcYD6OGxUKcP4r5cMLFLQDZkzRVdUghajurzDoCvt4fr8ehqPSoG0CCWxhY8s3o6x9HACXhJBHefZUY2jlXgS1quviVvxeoKEjFdLzPdiQEI/s+VNsFK7jLglzinVk7zcFRe+PZYb5yYpjTi5v6/F+kQycWdvClULXw/5TQZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImplFgnB; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImplFgnB"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9158fbaa4bbso91643485a.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577902; x=1781182702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BeyEC5jxiBPmcssiWn6iIbBiV1Io3iSXetSWwvjig0Q=;
        b=ImplFgnBnENf0cMYQtHpVHLtD8j5Vs540bhUQ+uRAKGUzHbTpyEyXQxrtMTP1eJUYq
         95rBe+hjy9w9jI0PQR2RONG8nktb1zQLpoP2rURFd0ONKp4b8l7ZWTx6aAFyUdg/bKVv
         8VFYg19QJetH9PFXlx0ZHxy+KzPcj8FUvjo7Jv7toy480BIfexlvSBCKPVCb2xRKByQ1
         eU0MZlQFhE/1MaMCeeTEy+6FVAYOLsOMOiZ9oPU0lVCTq8l8J04Ngn5uzrHxSUaiB0xa
         Llcog3wuBpUeIV0Hgd0vrJumgK/MB+M3D4MbZPTBF5bxOZzxuWi8SJlKihcZyfqg/tfe
         6TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577902; x=1781182702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeyEC5jxiBPmcssiWn6iIbBiV1Io3iSXetSWwvjig0Q=;
        b=XkQf1X/QXFAXCUKxVU6PDEOqGlTwkKCecwSg5LKhNz0Q4sMvnBEfBp0dgP45thexEK
         p6df8GEYYb+DbepyvtuROxR+juydK3VysKWDVxu55dapbf6Fssjy5AHsXdaMv2Pj1W8q
         9xzgWhrrOcZg6dnBz/WcJnUD6dRaXHbU30bJ29YHZjO0RG/E4YomFmOryDYwrWs3+EE7
         wp9PGmu0R9QxezZQn7d+bXPY7oCRNYvFd3KFE/jCjsqHlfazfzNAN5VeOyGsGMEE7MNc
         fl0/MQ8uive+mSGYKb5swN+ENLtxtyKnot+LZLPd9YSEJ0vMwSWjr5KOlwMu/srp3ub3
         AVPw==
X-Gm-Message-State: AOJu0YyLfKn2JVND2rGDSkByHVkwhChlNh74BFMTlu1Ust1sxiue0cA2
	nPmJJAPhBl8zTMixOUHK/afsNe50AuWLq2LvLzytyCHe6HZ07QY3JGTEGdTjZg==
X-Gm-Gg: Acq92OFWIokUuAzyTKF/fETzedsMUgn/iuOfnX/qqAsOKs2CPe/ZcUfZeSPfbRKM/B/
	0pdUu1DijeGbJi6CuJbQgSvLqlY4bod6v4N7BVySWUrIC15z6YrWfyHwexyw/DMXbacQhBX+9nB
	cToNgNWujdOLB82lAGADVNi1GSQI9BPfho2i+jHo0CnrUbtIgzBrINZ1/7uARwUGuZik6VUTHkr
	bl9qAmm6BCVrxRyTDDQIgTWWWQ0jdwTVjGZgX+RW+wEp+P8ztJ8JS12/nmU8md28i6Tv0VztcA5
	UKoue8lPSOD3YRUm9oepF5UFsdFXyvmRhltlsjYEa4rOm8xrKsePa29x/cTqofp7ZBtXNhiknKq
	+S+/eOfXfe14E38eaFfnDPFVA8uC7PfWNPc3mkdzp8PsAbkVV6MnPChcYVFYpS4gFbfFPm9TOMV
	LK68TmgRy6knDmc/OGaribbn8qj3jP/oW8x8BrYzPuIjy4qatnQTSZc+O+yeeMHz6DBl6O69GDP
	pkrXKTQtENk9kpCJpXl8f+I4hfPyLsDMtuPjw==
X-Received: by 2002:a05:620a:6604:b0:914:ca7f:6083 with SMTP id af79cd13be357-9158a83234fmr1210724185a.59.1780577902220;
        Thu, 04 Jun 2026 05:58:22 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3d3a0esm585789085a.40.2026.06.04.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:58:21 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/3] libselinux: selinux_restorecon: add flag to skip multilink files
Date: Thu,  4 Jun 2026 08:58:04 -0400
Message-ID: <20260604125806.255648-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new SELINUX_RESTORECON_SKIP_MULTILINK flag to
selinux_restorecon() that causes it to skip non-directories with
multiple hard links. This should be used by programs or users when
relabeling untrusted directories (e.g. /home, /tmp) which might
contain hard links to files owned by others to avoid mislabeling such
files.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/include/selinux/restorecon.h  |  5 +++++
 libselinux/man/man3/selinux_restorecon.3 | 13 +++++++++++++
 libselinux/src/selinux_restorecon.c      | 11 +++++++++++
 3 files changed, 29 insertions(+)

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index a5fdf12a..6680589e 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -139,6 +139,11 @@ extern int selinux_restorecon_parallel(const char *pathname,
  */
 #define SELINUX_RESTORECON_COUNT_RELABELED 0x80000
 
+/*
+ * Do not relabel non-directories that have more than one hard link.
+ */
+#define SELINUX_RESTORECON_SKIP_MULTILINK 0x100000
+
 /**
  * selinux_restorecon_set_sehandle - Set the global fc handle.
  * @hndl: specifies handle to set as the global fc handle.
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index 218aaf6d..9bcd3d42 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -182,6 +182,19 @@ completes with success. In case any errors were skipped during the file tree
 walk, the specfile entries SHA1 digest will not have been written to the
 .IR security.sehash
 extended attribute.
+.sp
+.B SELINUX_RESTORECON_SET_USER_ROLE
+Set the user and role component of the security context too.
+.sp
+.B SELINUX_RESTORECON_COUNT_RELABELED
+Count the number of relabeled files or the number that would be relabeled if
+.B SELINUX_RESTORECON_NOCHANGE
+was not set.
+.sp
+.B SELINUX_RESTORECON_SKIP_MULTILINK
+Skip any non-directory files that have more than one hard link.
+Use this option when relabeling untrusted directories that might
+contain hard links to files owned by others.
 .RE
 .sp
 The behavior regarding the checking and updating of the SHA1 digest described
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index ec71d456..224a5a33 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -91,6 +91,7 @@ struct rest_flags {
 	bool conflicterror;
 	bool count_errors;
 	bool count_relabeled;
+	bool skip_multilink;
 };
 
 static bool have_proc;
@@ -711,6 +712,13 @@ static int restorecon_sb(int fd, const char *pathname, const struct stat *sb,
 	bool updated = false;
 	const char *lookup_path = pathname;
 
+	if (flags->skip_multilink && !S_ISDIR(sb->st_mode) &&
+	    sb->st_nlink > 1) {
+		selinux_log(SELINUX_INFO,
+			    "Skipping %s: file has multiple links\n", pathname);
+		return 0;
+	}
+
 	if (rootpath) {
 		if (strncmp(rootpath, lookup_path, rootpathlen) != 0) {
 			selinux_log(SELINUX_ERROR,
@@ -1530,6 +1538,9 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	state.flags.count_relabeled =
 		(restorecon_flags & SELINUX_RESTORECON_COUNT_RELABELED) ? true :
 									  false;
+	state.flags.skip_multilink =
+		(restorecon_flags & SELINUX_RESTORECON_SKIP_MULTILINK) ? true :
+									 false;
 	state.setrestorecondigest = true;
 
 	state.abort = false;
-- 
2.54.0

