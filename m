Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9845037757C
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784229100; cv=none; b=m5FOVErY6+5pEvYSBggfHi8qyN7CYcU/kYFBy1S6tR2jl52tnLiXMBE3zsHYtZh78JoNC+XJC/O6Re58v0gofZqAAE6fjS47MMQuv1I8ObWP4TH5a2wqKSO9QqepOVpAIr3tiarLSVzTdEiGyd5YftpNYql5sezcnnZ4Hj5uIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784229100; c=relaxed/simple;
	bh=yib5hgo0Y5KXmX4PQgzmlhj3bJ64eG+iemA0MGsATGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1IDRCVSLu9K+k9b9EBuQhkekuU1VYgG5hIGlbht7zbbb53/zmcgVeZjDujplW+Z22D1Fp7U73wIR7Qwxx0U8xKAsVO8D6Xm0uPUOAtedet6hCEHbNznzTAmQZfZ7Tcx3FVq01oCSoUmp4zsU1YrA9Zgtb6k+1BgEEI9qP+L2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI3Lb9yH; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI3Lb9yH"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c2808dbc3so42685301cf.1
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784229098; x=1784833898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=INH7H0ven+8+y5xdbir2xRe2wBCPf5mzvHPy88Tt37s=;
        b=PI3Lb9yHWQ8jpwcUVi1UQ1rR/WD2j+8VnyNuBz2UPpqh+3Kk8vJ+N5FeptprIAEjeM
         k0llN/hqpZmVVb82roXSvzPZ40FJEpmEGBzczcuA737iB8p6+HK/RDWi7eKwCyzLPhz/
         dpqDz/9Lt3R5WVfsXT0a7rYANfwoi8o+C6jRanBbLrZFnlm2om3jrEpu5zCUqc/VOK7E
         YW3goIxV2aZn1WOzGkyGY4hNtIS8mTnBdRom/mHkkKi2zvoc4rR9qceEI2EQ3UWQ+KBD
         EiRvthpk4ktLSXT9S0I72NQfqaHBcDxDK8EUSM4aaHogpmIjxKjpSfSYgwlw5IiADxxv
         PGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784229098; x=1784833898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=INH7H0ven+8+y5xdbir2xRe2wBCPf5mzvHPy88Tt37s=;
        b=gzRJaptv2MgPIH1y4/EMRKn11MmvZGTqfnCJkRMtXlMKCCJPGunP3E3qr9jun9kENP
         UZX0MXU/Xy3cGntw5D+vsqoioMx5BHNkRX4enk6M9xt9X8xudh3gHtDM5vY6Z8KnQxKs
         JPlaFUl8CUZkMGQI1KC+rfE6VNkTtx+l0DWAry+H3T4GCz3IkBDYf2GC2HvfRF+rSqro
         dVLNlcQtpO1cJ9c5mDoZfRqN4G41S77s82EJu/JyMkpnSK/PIlHRKWiTHY8lHdxro25U
         trt6H6T/4q7w7zK7tJxD1vGl8Wx2l40hMG1v/hxkX9IAx61CpVIEWuIzSi1gm/FahoY/
         cK+g==
X-Gm-Message-State: AOJu0YzJckPqqOCAC3c1D7B1fdar+945+s/ecNs5dXkHBgCdu6aP82K/
	j9uNSJ+wPpfPf11vQgrkFIQcQY4z4Z6hGcgSbGSVFN0kCZXwwGMQHYVblGu8zg==
X-Gm-Gg: AfdE7cmkSdBF5XpU9S4cWpvu4wkesa205WkycFxRXJXVzCKV7hux2d0TZjJW7isoNFd
	jXD7QrOby6cXA15KshNKYM8eztLPXrvfK1cc3vuCarvcGqU5GGc/qV4F4wHbCZUppt4Ch7ceR0T
	Skv30YdH+WH17CGcngFlGtpFN5CYDP9FcdAptk0q9en3TxNbLj3sJUQbUl1Xi6BHXVd7pF/TFEd
	AZ0PwTTC7mokYg68WcouI0ago6nWOAs4PCbBGfCQ5F80sUoAQCrb5us4lKPvbFM4hyp01WzGyCQ
	nzwMJDxnpVNnVxQnlL4iT+J+P/c97H6BeSSKhWv/mf9zydRGTGE+8wN2WzT3UFQ9NMuGwx3Uo/H
	ihdoiX0/6JJmMQqt+gciERSrmE+6W0vianNw+UjVFxjs+tPZ7Pi8ZZXUQCL0wctK8HWRXbW9YJj
	zw3LbYAFW7X1NQsHoHm9D9XRFrZ1dGJpt7ZrPcaIpOsQXySMt7lx940eHRPkiVZV3eLiYq/kqUj
	4eAyQ==
X-Received: by 2002:a05:622a:1e0c:b0:51c:7b12:5fe3 with SMTP id d75a77b69052e-51e424c4ceemr127778751cf.79.1784229098330;
        Thu, 16 Jul 2026 12:11:38 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae240c9sm160263141cf.16.2026.07.16.12.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:11:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] policycoreutils/setfiles: fix -f handling
Date: Thu, 16 Jul 2026 15:11:23 -0400
Message-ID: <20260716191123.10829-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only trim a delimiter if we are consuming it; otherwise we may
truncate the last character of a file name being read if it is on the
final input line with no trailing newline.

Since the -f processing occurs after restore_init() has already
converted the r_opts flags to restorecon flags, we need to explicitly
set the restorecon flag when a mass relabel is triggered via a "/"
line.

Initialize buf_len for good measure; glibc ignores it when the line
pointer is NULL but we shouldn't rely on this.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/setfiles/setfiles.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 2d38ea8f..e0953708 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -142,7 +142,7 @@ int main(int argc, char **argv)
 	const char *input_filename = NULL;
 	int use_input_file = 0;
 	char *buf = NULL, *endptr;
-	size_t buf_len, nthreads = 1;
+	size_t buf_len = 0, nthreads = 1;
 	const char *base;
 	int errors = 0;
 	const char *ropts = "ce:f:hiIDlmno:pqrsvFURW0xT:";
@@ -455,10 +455,14 @@ int main(int argc, char **argv)
 
 		delim = (null_terminated != 0) ? '\0' : '\n';
 		while ((len = getdelim(&buf, &buf_len, delim, f)) > 0) {
-			buf[len - 1] = '\0';
-			if (!strcmp(buf, "/"))
+			if (buf[len - 1] == delim)
+				buf[len - 1] = '\0';
+			if (!strcmp(buf, "/")) {
 				r_opts.mass_relabel =
 					SELINUX_RESTORECON_MASS_RELABEL;
+				r_opts.restorecon_flags |=
+					SELINUX_RESTORECON_MASS_RELABEL;
+			}
 			errors |= process_glob(buf, &r_opts, nthreads,
 					       &skipped_errors,
 					       &relabeled_files) < 0;
-- 
2.55.0

