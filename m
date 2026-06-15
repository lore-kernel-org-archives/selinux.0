Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A393D3329
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544473; cv=none; b=kUIcnAbnk2f4VpHr5MCePX7zfuYtJR4yKg6qw5fdYzL9nuYXYfC9GYYgMb5N9TfR4bSOig5L3rBi6veTpa/btZx0jMsTYno9WofPWgHjxeDHiI+Kxw16T5Xsr9Xfdvq7K22WHTY+ZEtjVZiyhDI+ua8Rj20M2jVSUlKvJN/A21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544473; c=relaxed/simple;
	bh=4xQ7SjyVp3u2PrDOxamGWGHcn7uvXiXe3s0M+80WZCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJz4Xr51pT7WpUbUirQLlSgP0qXLpU9mzATBBFmB8t3LleUHfC5M+3bZPqacxMR3mmQlXLjZRYzntJX//qJiIOJlfrWzVF5kWkWyEBc16VSUA6qoqGI7440MpFKkcwO61NJFDqFE1YAWjSyIPb73ESrMeRV3/yBJUL+uU9OX94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOpetcFT; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOpetcFT"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9159951f05aso402885485a.0
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781544472; x=1782149272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhKLwkEgIsXqx4nV2IswgWqgoNmMyfA8l85LN9Y5E0k=;
        b=XOpetcFTXQVxb7uMEir8M69RsfStXU8u/ASTd88azaC1qYI7YA9zCvBegN36RSzVV8
         0dHVQZZprqJCdszZzvQujlICvWXWIus8b/+MDPnG6gymG58IfTCDft+yAz5BGxDJQ4x4
         8nwb6xQnGejaDqHA5LFGgzjTObjEd09Jio3wje3phYVrH6D2k9jgNHsWVyX49dalrQpc
         ERlvXltZQCd0Wat66HY/K0P/Op/EhEhAHrOd3tadLjsDkMT8Fdf4BbbQk0znHQ4R/6Nn
         fPhGdyow/zqregs0uHMjly9cHLhuI+ZhiUHp2Um/ToudM+Y3OSGjf1Q2YsDnK452xLgj
         rqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544472; x=1782149272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhKLwkEgIsXqx4nV2IswgWqgoNmMyfA8l85LN9Y5E0k=;
        b=l7aae3S3OKKqUbiJfHicyC1gRMqSOYUcCsH5cpS0/o2GQqYD9gKxXhqVC+LNJ7S+Y4
         P0JEQp6/JOIpBj2qw6Doo/6Rp7mSjgkAd6RE/MgHPwlSqMNryhdaH4NvDpDmYSX1RL+V
         EepviiFbcESnRieKg0lA3SIgSftTTJ2h0s2Lqq8HCb4eJ1OrFimvbqgYeKdKiUPFYOgg
         5IPaTloIDitagBP71zLUQb8ODb2vc2RiTgnahqxARsQb/E1QLLUAJySPuEAJYORzIc36
         BxHDr4ejRIxSH+fJ305Sr/8e+4dVW40xQGiBSWhiV0lXNMPu++140h2sCwqf7Uhc/vlv
         tS4Q==
X-Gm-Message-State: AOJu0YxHKPEhDXKyTT/+uEpONKlHZmi9wdcqEiXWa4mjc2BlOBc2GDgU
	HA/zMdzrvWzZiXx57doKzcu+Kf+H2TcVi4x9QZ8FBsl735p2z78JEj954CDC0w==
X-Gm-Gg: Acq92OFaNI3p3pFj6q0cbqjJNpPJ3shPJmq0dZgJfZUhyLJ5JUQF/BUmtkLwkJ4WNNI
	POZh15VshdFcTJeGSPgkv3HHWM7GhDJNkwjQ8T3lF/N9qHrpudPOCvpyafb1urkyDegNE5CXLaa
	Lv1orWuPV4haBjCPNLRSGffnlbyVVfEqt09gsGVw2pqtGGLap0XyVvBZ7IhTl7nf9SYL+5Ax1pw
	u4mT9uwgpEZLiiQ5Wy7decxjQwuNCGSAHmeHJid/CxXmlM/YzKpPqv7FJAkU1Wn323C/UDYytzO
	faaI7t9EibYIwooXpD0nQfKCQ0iC/DMGcltuPr4zbcybB/c4BVk4ThEmJHEgqQVUP2tbSAQhbiG
	DfJkHmGBT78t3envM4+5WVkZt/IZO+XpxWuGMoAiJ1QMq2v8vIiZqhGEacdG0NybKRrq6SGg1zf
	XzNZI1Gb7SWtKjf2YKEaQjUFonKTeL1f7pxmNRxynVqn+xJNQkPkQh9aBnbTokUiuqmTSOHLX8B
	Rvm+wcfitRg8Fo61vRDNiAod/o=
X-Received: by 2002:a05:620a:31a0:b0:915:9f28:6741 with SMTP id af79cd13be357-9161bc1ffc3mr2256756385a.11.1781544471530;
        Mon, 15 Jun 2026 10:27:51 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed8aa6sm1172432185a.2.2026.06.15.10.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:27:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Pepper Gray <hello@peppergray.xyz>
Subject: [PATCH] libselinux: Add EXTRA_LD_SONAME_FLAGS for musl+llvm builds
Date: Mon, 15 Jun 2026 13:27:36 -0400
Message-ID: <20260615172736.45712-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce an optionally defined EXTRA_LD_SONAME_FLAGS variable for use
by musl+llvm builds to pass --undefined-version. This enables such
builds to link despite the intentionally omitted
matchpathcon_filespec_add64 symbol.

Fixes: https://github.com/SELinuxProject/selinux/issues/512
Fixes: https://github.com/SELinuxProject/selinux/pull/513
Link: https://lore.kernel.org/selinux/871pe7n3w3.fsf@redhat.com/
Fixes: 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
Reported-by: Pepper Gray <hello@peppergray.xyz>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md               | 4 ++++
 libselinux/src/Makefile | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 5e65a049..a458a930 100644
--- a/README.md
+++ b/README.md
@@ -151,6 +151,10 @@ set when overriding are:
 - -fno-semantic-interposition for gcc or compilers that do not do this. clang does this by default. clang-10 and up
    will support passing this flag, but ignore it. Previous clang versions fail.
 
+## Setting EXTRA_LD_SONAME_FLAGS
+
+Build with EXTRA_LD_SONAME_FLAGS=--undefined-version to fix
+linking against musl with llvm.
 
 macOS
 -----
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 9982faad..fe8d3239 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -91,7 +91,9 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
 
 override CFLAGS += $(LFS_CFLAGS)
 
-LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro
+# Use make EXTRA_LD_SONAME_FLAGS=--undefined-version to fix
+# linking against musl with llvm.
+LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro$(EXTRA_LD_SONAME_FLAGS)
 
 ifeq ($(OS), Darwin)
 override CFLAGS += -I/opt/local/include
-- 
2.54.0

