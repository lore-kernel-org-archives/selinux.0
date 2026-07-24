Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139AE14883F
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915499; cv=none; b=JhRuvYxbzm8CXEWVaU4ADBWdm7ul8Dc4lUfYZk02ayu+g3ETwJcTc1A1qo/bWwShFLWuC9o4mc4HejYoe5HEMaYaZajI9a/b/4BBGghdLAdDhrP07tlb8r8ZulpIh6gG9rhEfAmTMdD+WNz+l5DX17TGbERAk3XdrrDQ5XIOGNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915499; c=relaxed/simple;
	bh=qIozeaWPmMta+KH9wL4Q9yqPPokYNl8CzoMIwKPKUuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxcH4CC/K7DBay1Tuuj9f+r6lsXOqk1ni62v34bCYWsECsTP5d8pV+ox/5CDOF5kjtjgMeP4aoRIFiDde+tAiKNV8a0/ugsXH5ru6LCvbtamEgOlGtaK1+5o3Yte+eyiPEsl7ssDT7/KuY9OKfYkKH9r9A4LLTPzCN+XR0fm2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFJxtM+m; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFJxtM+m"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c4436d02cso3914251cf.1
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784915497; x=1785520297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=94jsznwOS97+Ec3i6glXyIB302Bq3hQYQX9wWEaiMeQ=;
        b=XFJxtM+m21LOtjRssGlAi6aGKODNIo1ICc0JURpzgAV3KqZtAqC7zHIt6Ulkq+gEZN
         MqIW9077M3+OfGiFr/9NIbetXoe0mc9t51fLV5NolDdq1otgTK842NGI8mYmrK3Xy5Os
         wvEZzHW+0hmDQvUh/NpL4IQeLtlFagBGojwF7bg/IPuXussOQ3WwDfqOxtzS3VVM/Gb1
         2DlUQUbphW6exVW9Wl0H0VXuFgj2Or3VwBdXjt7x+KX0qrl3fiE3jgPt7B0f0lTrC5sv
         x3wWs37WDocao/2oJQHCFavIQlwFtoCTkGgpST7MjKmtQLKyayF6010jyJeUaY0gA11f
         070w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784915497; x=1785520297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=94jsznwOS97+Ec3i6glXyIB302Bq3hQYQX9wWEaiMeQ=;
        b=lIiyPwyv8s1QqATS0ZSeB1LsH5gevQbB32R39ZWR/S90VexQZiePj8o5ze7DUAEjl4
         0t9b/VXMX3/xrNmH+LmvO5LUiXWCQl8OJUg/2IMWa7yehhLdIq8A/w5RABI52TPIPzNQ
         6ZDUlry8m0Eoxq01lyyi6AF1XH0+COG8F6gMr0lU5HXWr7WTZhgRtMHFqikUH4KCXv53
         /57jwSt0wiK2A73MEHSO2Fvbpp4X+sTewFGzlbR4Y5I/Us+iCyF+6frD06romekINKzm
         TU4i2dTyYzEWCOaW0fyr46LcAc/1J+suiA9rlxLs7wwbE4MgmPptnph/nVfyEEy/+JYo
         NtOA==
X-Gm-Message-State: AOJu0Ywkvguratf30Inuu57d/cF1Cm6nt6rnfM0YXVsgQUM1uVpcL9Ur
	AphtMKDUy7LE3ZXoK4c3HDHV1lGWz7IzoYbiJWKOYx8JZ5HFK+i/BYiPUcdEkA==
X-Gm-Gg: AR+sD12+GUFk0HGCrre2LL0fuIOlk9f5w2X1Px4RqK875SoGkfImYU5Ue91V6D9Jxgh
	xAsEK3JkGPbRMFKPSCp9+75VuUzztb0lZ//q66dg/2/m8OJyd0QYa7lBgmRNQesLZNWyNc/amgD
	3tzCuDFUEidx+kHUk+QsUSJiCvXJBqPngxmijKrGjPEurwBlqHeOQaNyU5QrgZUKxEGhvrdlOZ+
	5RWxWXSzzm4PTER3M4zg13Wv7wi8pJbwHd+WqgcRDCEMjAcm6j2I44MP56qlQDi30bJurmgIDa5
	Pi4ASnCDIMmDG1NY/jXUqUuhwGGSIUuT9Q3ZeyzYY9DBlDJj7K6P+UjYs7tgz1tYDjq4kJt3d7l
	lwSAj9FRsGmKV+B1/Cc3T1PR49RmXIO1J9byylCyJu+sPQT1wpQry/xZ4nGcmIPJH1bai1hNJav
	+FknPh8DkFY3XvmuS/xmgimJ0MaYwaKWW82OjfyDGIE2LsUsuikwYceTSCdTTpfY44si5SXevFW
	MQ7XXohCGplxO7K
X-Received: by 2002:a05:622a:1c0e:b0:51b:f217:539f with SMTP id d75a77b69052e-5283dd94d11mr80503521cf.17.1784915496878;
        Fri, 24 Jul 2026 10:51:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e8522e7dsm3327106d6.6.2026.07.24.10.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:51:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	cahu@suse.de,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/2] libselinux: add pyproject.toml file
Date: Fri, 24 Jul 2026 13:50:59 -0400
Message-ID: <20260724175059.18960-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pyproject.toml file for the libselinux python bindings.

Fixes: https://github.com/SELinuxProject/selinux/issues/505
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 of this commit is unchanged, only the second patch changed.

 libselinux/src/pyproject.toml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 libselinux/src/pyproject.toml

diff --git a/libselinux/src/pyproject.toml b/libselinux/src/pyproject.toml
new file mode 100644
index 00000000..dfc44e81
--- /dev/null
+++ b/libselinux/src/pyproject.toml
@@ -0,0 +1,24 @@
+[build-system]
+requires = ["setuptools", "wheel"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "selinux"
+version = "3.11"
+description = "Python bindings for libselinux (SELinux userspace library)"
+readme = "../README.md"
+license = "libselinux-1.0"
+authors = [
+    { name = "SELinux Project", email = "selinux@vger.kernel.org" }
+]
+classifiers = [
+    "Programming Language :: Python :: 3",
+    "Operating System :: POSIX :: Linux",
+    "Topic :: Security",
+]
+
+[project.urls]
+Homepage = "https://github.com/SELinuxProject/selinux"
+
+# The actual .so is produced by a custom build_ext (SWIG + libselinux.so),
+# driven from setup.py.
-- 
2.55.0

