Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888A34E741
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081055; cv=none; b=ulXSLEUDIiQNtQd4Kw5kxEq0mSUAb+oAH0nSv53VHiBZW4YqH7mHjddioPXdv05pyKcLxfEyaOedMcuAfzYmYrMEEchaylIc9U4aYQ8Ddbr461T0aQhuwdYcvesOteCE7xeRNIBWUpgyKSP7+bKC5KD6dcjawGUCSIRyFom890s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081055; c=relaxed/simple;
	bh=usaLGPFImwFUH9ljH5wkDPmsIZwhYJkLEDXWT/hpHBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyzk6B8LFEvSL+XSEshpHyYTwXInN3FBpgy/yV3nFP/VBPq7104z6UuTonXTH2OrJSdkucdaU059Q3Ra1tSZ2vHFBniRoO0PWBt78bv9vaB6pFU5INh0HgDlE6ggh74zF7iODga/jEE71qQOR4fEHAYMB8uJ8H8dC4qNhq7L4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEbLHICJ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEbLHICJ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0006ea8eso1458171cf.1
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 12:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787081052; x=1787685852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tx10CxSwoI7XVhCse+pS+1Zx3caR7MsdiDa8+7dhsl0=;
        b=AEbLHICJtgYCgddNJ+EbKJK2o8I3q5/gSVQDQkA7SlxGKa9/hBvZzFa3Iz1SazKizd
         G7dAVNpHVhmrJROEVnI/yBxEv0RmrcpdEstvd3J4o/uG5Xk1x+mckQYMOtTE0nj3yc+G
         /K85kynW08ljPMLfwYyTITO4tMKsfaWrR/SeWwOEOkC4Ct8dSv+cUaECLR12HqjekSuT
         lY6te1v24pRfubWj7AyF5iRkPKda0ipz8My+TtO3iOgTI0rEw+Apa3ef2vCjlVe4XGiJ
         GUyLEGP52oY/o+wI4/3KNTp4MCvoei7tMh/LUIdD4blJjoKp8o9Ett/e2Skm1iZmZTqq
         Q76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081052; x=1787685852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tx10CxSwoI7XVhCse+pS+1Zx3caR7MsdiDa8+7dhsl0=;
        b=UOaTwk4tiA6ChXutEf65gxUqImZfrfE6n5yTROBQZm9wtX1cHx08TuaOLFoTYB73Kv
         /rHhoAtpOrgKqF+6zm15f8XcIo4dR/H3PgY/QQaWjUJh/dj5K0065Icmyd6XPSCJUsm9
         B02UoYT0DsasjkR0g0hpegjo9Y/53jQqAl3Mz4BsOpPKr6UGCnx64o0mhKAYeENPOn7c
         QML+x0AJ+eEPzIBu7CXU6tJVE5a1Jtv3+FD+qWJYjMaLECumgrX2otacuPOch6/2Duk6
         BzaHFX64eNub1jYBaMTXP8RPlKw2ZQO0Q4M+L+WvHPeGmOnBysJS/7orQMVF9effQdHb
         lbyw==
X-Gm-Message-State: AOJu0Yw6U6BLyUM81PbA5xI1A1OiZ9CXyq0FSGbt/qSAVI6Ytq/5IHif
	FOeBvkUXC8IqXGTrbXSElHDbfa4EbfxslVAqAKlz+fHxvTPWtYs6stIthnBC4w==
X-Gm-Gg: AR+sD12OcXwJeBCURoeKnBmUk0+jESyxfj41cHXJMLiNLxcGZQ7ARepkDigkqt+HH3o
	OGX+4ESSL7fbrZwnJD5bC4S2EIeXxba97pBaNe80NhgJOFHzqjaG31I9JWtmSpyJNUIU4Mhhl2v
	cVp4Kb9FoXNpuem4EUe7wg6BvUm62H+Uuxq1/1rH65ysFdZs2HhrnhIgTDnpf1eVW3L7Bc9vxe7
	/rOftYELwYjb4J2TTr0umjsHAefxouVp6SgiVhI7eLxlcBVLFjVPmP23Si6kQLOTFSNRed0FegZ
	moqvHGlCONYITQh33EqDehz1u3YuAhmoAyjSz7nlxXwTjTfSLZjkHVKv0VBkMv/RKwC7peAOMXg
	icOJbP7AZqwJ04f4u1cW/V60AZIBIA6+o4pF0pFRvrRSKN7YI+Ixzu87geZq2UYgR7RI08E39D5
	jTbsYkiLx0sO+y+fJGg6I666lfDCV+08AhuPRDn6da/LBNUgbSYpXIbBHXeg==
X-Received: by 2002:a05:622a:11cd:b0:52d:3352:f7ac with SMTP id d75a77b69052e-52dd32241cemr3757631cf.28.1787081051879;
        Tue, 18 Aug 2026 12:24:11 -0700 (PDT)
Received: from z840.flat.mawenzy.com ([2603:6000:acf0:3410::10d7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db62175b1sm48784351cf.19.2026.08.18.12.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:24:11 -0700 (PDT)
From: jboero <boeroboy@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	cgzones@googlemail.com,
	Johnny Boero <boeroboy@gmail.com>
Subject: [PATCH v1 3/3] policycoreutils/setfiles: honor RESTORECON_THREADS
Date: Tue, 18 Aug 2026 14:23:33 -0500
Message-ID: <20260818192340.119297-4-boeroboy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818192340.119297-1-boeroboy@gmail.com>
References: <20260818192340.119297-1-boeroboy@gmail.com>
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
to break an unrelated caller.

This patch stands on its own: it is the brake for the new default in the
preceding patch, and equally the accelerator if the default is left at a
single thread.

Link: https://github.com/SELinuxProject/selinux/issues/489
Signed-off-by: Johnny Boero <boeroboy@gmail.com>
---
 policycoreutils/setfiles/restorecon.8 | 17 ++++++++++++++++-
 policycoreutils/setfiles/setfiles.8   | 18 +++++++++++++++++-
 policycoreutils/setfiles/setfiles.c   | 19 +++++++++++++++++--
 3 files changed, 50 insertions(+), 4 deletions(-)

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
index 4c860755..ee0930b7 100644
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
@@ -246,6 +247,20 @@ int main(int argc, char **argv)
 			exit(0);
 	}
 
+	/*
+	 * An explicit -T option takes precedence over the environment.  An
+	 * invalid value is not fatal, so that a bogus setting inherited by
+	 * every child process does not break unrelated callers.
+	 */
+	env_nthreads = getenv("RESTORECON_THREADS");
+	if (env_nthreads && env_nthreads[0] != '\0' &&
+	    parse_nthreads(env_nthreads, &nthreads) < 0) {
+		fprintf(stderr,
+			"%s:  invalid RESTORECON_THREADS value \"%s\", ignoring\n",
+			r_opts.progname, env_nthreads);
+		nthreads = 0;
+	}
+
 	/* Process any options. */
 	while ((opt = getopt(argc, argv, opts)) > 0) {
 		switch (opt) {
-- 
2.55.0

