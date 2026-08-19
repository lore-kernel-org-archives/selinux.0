Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636DC3A759D
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149860; cv=none; b=GCWp6DX/6P3lREYP/zEHAkum/y1uYFCnPYjVuCpYAeFNGDxiw7cyQinR/xjuVJ2oAkFxXsJl71z3wV+yThl0IRX9zSNX/uZkQ28jl6JE3PdIfrBBpvZf5fH5jzS/HxR7hAmLWnGdVihnsvxGrMgvn3yJFIoK6ea9mfEPkkC/BI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149860; c=relaxed/simple;
	bh=PzOiuasOiUNv9uQhdbvxQtNHuBnqcN+QI7TOzThZtCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqTscm2YJA6A5rHcSMMByxDUs1j8NgBgZittRpFV6Oaj9KNCLNRSLUhIK6VPKUJVykP7Dx/eDVPE1xf/XEVPW5JAxa+yqsbkkJqIN5G2kwFZ3jGI4n7MwozoKWbkocjXKgY/Lq5d+yutYJ0hHmeqRd5EFEdCcSHTT8+Jt2jmMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaKTeXJ5; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaKTeXJ5"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c0cea8883so8348511cf.1
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787149856; x=1787754656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6DSEzj31OW3Eirc9fYxaMyTaPLZW6Z9IDX0lxTXs5SI=;
        b=BaKTeXJ5P/hHoduQJf5f6ycHeMQcyCkfqVXlX2pLzMFdzqTAA1Zx6jiiC+EoS9ITn8
         PGz8JJ4DmtrKVbHWFbqclytHmJO3jhO0fZ7n7qe8wj5vMP7ZNqKTABXca8H5vQQYD6nC
         YDVuqnmE4P4d5z8Ci9O+375cxYA6C4aDnK0DKuinx/gymJ3ETyuUEQKkxvNKI0FktIEe
         93Ryz9rV3PQMpE8VIz5ejxoRNlac8Jvv+kjUSQLJDq5SEbFsW63diq2E/8oKG9UgGdVi
         1zbHgIQWXLxXXxyQFX0cLqorPtRZNUf2ZWBjpvZIIKn40ELyQcjqTP6Azu2q5G108OSr
         8qEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787149856; x=1787754656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6DSEzj31OW3Eirc9fYxaMyTaPLZW6Z9IDX0lxTXs5SI=;
        b=Bfdk2UhT/1D44lx2RnsoXzZOCg7cRylOmxKBF1W9ZALw6l+icI2cKw+3ruS1+G2gD/
         FkIWYjG7BKkyUvzq6ZWoFGp4BMry/41GkHDPn1HWjEiY+d0Epl3kWPub8vBKudy14U4+
         s3VHHWHzj6jkkyfk+8pnLPFISVf3WfOc89udM2aMYwqCu1bH6XkDBNI1pKO8/6t11zla
         4xi/dGqdlzLd6sIZfD7pjz/SD6OfCxzSVejcqQ4r9MWsl0uzaVT/FzZ8jGaiIMSj+5nG
         8JkQD3g7rZMCtGRkh4c0DZQEpF+75fqoXkfLAN8uLZMgzY8//wjAbqAd0cwTH6r2md8V
         TUYA==
X-Gm-Message-State: AOJu0YzBsg3Z7z5wQRaCGCtMsvZb3qbNX7+HFb4sNJxXFeOc7uTVD2sM
	vEfhmyc8udVMiaIHF28rx2hdW9+XkaZwXmFkyyppp8J5mCOs7Y5xpu3wIN+8FSBu
X-Gm-Gg: AR+sD13qxPHcLc9+TS3SdKlkH/ufZ0yEAxj8OJPquwVCTBcaWCWUFvesYS2wQtAmx7Z
	4qJzx4IOQLpbDy+tWhfNPcfgnaGmty0u39SZ4PZarrteduJq7mhZC8RK4CNFts6ElnayVY7gRGX
	tsnBtjR/68rkt66LtFg4ryuFkHwanwKMDuEKhrlppL/7VQqntwmzkiimj9DDzRlNxkt6iNzYjOO
	MgaMubt9TFQjzs/+8PH47LS31DSt/W2B3aI5r1lWqyWrwQyDWW3vcsiG2EOmUCRdEkKpGHFWc4m
	AOdr9BUS4cRUGAM3enqwvLQwXxVrZT6xMs9IzrYvOT8uZjR/HGE5sVA9dqT6IDdv+g2JG2sk3Rs
	CUKuwn4TM7DZfy55DdlFant3fdPOCs8XkyTGNqtnv84JBHMNDeZPb6wbRmgtyoF6+xZNmh0u6Nn
	An5Ma5yV/BGTcMW1vj/u4lB4hh+7z6QA2freQRbqxhQeQQtaYhC7C8mu1sD747tu2mszLL
X-Received: by 2002:a05:622a:4d47:b0:51c:b91a:33f9 with SMTP id d75a77b69052e-52dd4919725mr53108371cf.13.1787149855336;
        Wed, 19 Aug 2026 07:30:55 -0700 (PDT)
Received: from z840.flat.mawenzy.com ([2603:6000:acf0:3410::10d7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5edb45besm15731856d6.2.2026.08.19.07.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:30:54 -0700 (PDT)
From: jboero <boeroboy@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	cgzones@googlemail.com,
	Johnny Boero <boeroboy@gmail.com>
Subject: [PATCH v2 3/3] policycoreutils/setfiles: honor RESTORECON_THREADS
Date: Wed, 19 Aug 2026 09:30:27 -0500
Message-ID: <20260819143027.574025-1-boeroboy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johnny Boero <boeroboy@gmail.com>

Relabeling is invoked from places that cannot reasonably be given a -T
option.  On a Fedora 44 system, 10 installed packages run restorecon
from their scriptlets -- filesystem, kernel-core, container-selinux and
selinux-policy-targeted among them -- and not one of them passes -T:

  restorecon -R /usr/bin /usr/sbin
  restorecon -e /run/media -R /root /var/log /var/run /etc/passwd* ...
  restorecon -R /var/lib/containers

Influencing those means patching every spec file in the distribution,
one merge request at a time, and only covers the packages one happens to
have installed.  The environment is the only knob that reaches them all
at once.

Add RESTORECON_THREADS, with the same meaning as -T, which takes
precedence when both are given:

  RESTORECON_THREADS=1 dnf update  # keep relabeling on a single core
  RESTORECON_THREADS=8 dnf update  # cap parallelism during application load

An invalid value is reported and ignored rather than being fatal, since
the variable is inherited by every child process and should not be able
to break an unrelated caller.  parse_nthreads() does not touch nthreads
on error, so whichever default is compiled in stays in effect.

Link: https://github.com/SELinuxProject/selinux/issues/489
Signed-off-by: Johnny Boero <boeroboy@gmail.com>
---

This replaces 3/3 of the v1 series; 1/3 and 2/3 are unchanged and still
apply as sent.

v2: drop the "nthreads = 0" reset on an invalid value, as Stephen
    Smalley pointed out.  parse_nthreads() does not write nthreads on error, so the
    reset was a no-op with 2/3 applied and turned an invalid value into
    all-cores without it.  Verified by building 1/3 + 3/3 without 2/3:
    before the fix an invalid value ran at ~1000% CPU, after it stays
    single threaded at 99%.  Commit message reworded accordingly.

 policycoreutils/setfiles/restorecon.8 | 17 ++++++++++++++++-
 policycoreutils/setfiles/setfiles.8   | 18 +++++++++++++++++-
 policycoreutils/setfiles/setfiles.c   | 18 ++++++++++++++++--
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 8d7b46f0..001039b7 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -187,8 +187,23 @@ use up to
 .I nthreads
 threads.  Specify 0 to create as many threads as there are available
 CPU cores (default); 1 to use only a single thread; or any positive
-number to use the given number of threads (if possible).
+number to use the given number of threads (if possible).  This option
+overrides the
+.B RESTORECON_THREADS
+environment variable.
+.SH "ENVIRONMENT"
 .TP
+.B RESTORECON_THREADS
+Sets the default number of threads to use, with the same meaning as the
+.B \-T
+option.  This allows the amount of parallelism to be controlled for
+callers that do not pass
+.B \-T
+themselves, such as package installation scripts.  Setting it to 1
+restores the historic single threaded behaviour.  An invalid value is
+ignored with a warning.  The
+.B \-T
+option takes precedence.
 .SH "ARGUMENTS"
 .IR pathname \ ...
 The pathname for the file(s) to be relabeled.
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 53cb97cc..101556a9 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -192,12 +192,28 @@ use up to
 .I nthreads
 threads.  Specify 0 to create as many threads as there are available
 CPU cores (default); 1 to use only a single thread; or any positive
-number to use the given number of threads (if possible).
+number to use the given number of threads (if possible).  This option
+overrides the
+.B RESTORECON_THREADS
+environment variable.
 .TP
 .B \-A
 do not track inodes with multiple hard links or bind mounts that would
 match different contexts (saves memory)
 
+.SH "ENVIRONMENT"
+.TP
+.B RESTORECON_THREADS
+Sets the default number of threads to use, with the same meaning as the
+.B \-T
+option.  This allows the amount of parallelism to be controlled for
+callers that do not pass
+.B \-T
+themselves, such as package installation scripts.  Setting it to 1
+restores the historic single threaded behaviour.  An invalid value is
+ignored with a warning.  The
+.B \-T
+option takes precedence.
 .SH "ARGUMENTS"
 .TP
 .I spec_file
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 4c860755..7f1c0a31 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -65,8 +65,8 @@ static void set_rootpath(const char *arg)
 }
 
 /*
- * Parse a thread count, as given by the -T option.  Returns -1 on invalid
- * input.
+ * Parse a thread count, as given by the -T option or the
+ * RESTORECON_THREADS environment variable.  Returns -1 on invalid input.
  */
 static int parse_nthreads(const char *str, size_t *nthreads)
 {
@@ -166,6 +166,7 @@ int main(int argc, char **argv)
 	struct stat sb;
 	int opt, i = 0;
 	const char *input_filename = NULL;
+	const char *env_nthreads;
 	int use_input_file = 0;
 	char *buf = NULL;
 	size_t buf_len = 0, nthreads = 0;
@@ -246,6 +247,19 @@ int main(int argc, char **argv)
 			exit(0);
 	}
 
+	/*
+	 * An explicit -T option takes precedence over the environment.  An
+	 * invalid value is not fatal, so that a bogus setting inherited by
+	 * every child process does not break unrelated callers;
+	 * parse_nthreads() leaves nthreads alone in that case.
+	 */
+	env_nthreads = getenv("RESTORECON_THREADS");
+	if (env_nthreads && env_nthreads[0] != '\0' &&
+	    parse_nthreads(env_nthreads, &nthreads) < 0)
+		fprintf(stderr,
+			"%s:  invalid RESTORECON_THREADS value \"%s\", ignoring\n",
+			r_opts.progname, env_nthreads);
+
 	/* Process any options. */
 	while ((opt = getopt(argc, argv, opts)) > 0) {
 		switch (opt) {
-- 
2.55.0

