Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6832DC32C
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181553; cv=none; b=HCbZFVoZQ4UA5jIRHXczf7rku0PCFm7M/6ZxQPVrNd3UTYFZqk1r/bBelp+HhvGQC2YAiWjoYAUAF/2W7MI0llaEo2mJkXC4xNaK8FW+Z6Qqffvo1k0407EGLf/1gqksfADQbmHlQXzDQ+PSOC1WbfP8YRNnBKItlOb3/ztj0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181553; c=relaxed/simple;
	bh=h05eC0nA3ckao6jhRlhnVz+LkivSwyHC6gmfRk4Gs7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4EixKlS/m+mef7/xKqmA1FOtKU8LdvEx/woJVPYITkFVKH672qXdpURRG85pxqCrigXLbV34MrbwlvwC8JRPIXbrxS0/LYaZSpgKXriA6smpytsqS9xa4FBEdWawICjQhujvbfWPRgQ4cHGTwPL8sAtJd7n6Z0K/IqXSZ0kYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+AqljxW; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+AqljxW"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52fa6005224so25755841cf.1
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788181551; x=1788786351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0IbLYdi3MFci5nhro8ZTb29H3woqUVPl5+aLaOVjd8=;
        b=o+AqljxWbgZLmlkVy3hh6ygXLR0JpzfpbLDqTX4yaAO15NZocNePbxhyZz0bapan0u
         eRvUgefzNehZ2sGzZJQQpzj7vgNpWTSMdxgjLUxck/5DYmxMElWlrn0EcOZU4SalSPBF
         BenhwmDyQalz0HcBzrTq0THT9jtAEaZNu1L+PuQBzNtZ/QawDBheXyb0sow1tsCHVP24
         VXRSanf6+I3GzzsneID1tCe9TW7TiUGzNPg/CRa2GEkjEctb2iGkQEJES3/rbIsr2z+7
         K6V+R3CDNNBaHSyYoH/R0I9SO22RE2IUGbe9CMXicKZ2xs/Pi+qJ15g7Lzs5lscihHbR
         QO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181551; x=1788786351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0IbLYdi3MFci5nhro8ZTb29H3woqUVPl5+aLaOVjd8=;
        b=XTvSTYTqqXuuM/rNxH/5RX7dfieTOisnlDp22OniQiyLHXksq5zenDNUNoX+bIPGCe
         YguqaDPwXHTtH1Sv6KBG+eB0VluAVCDKo20U0Snxx4ekhQ5XHnqh4F5yT70lN3AgeoPr
         CRRwgbaXl8qi0C3+sfnaPI/x+4uIYyAfgyUTgAwc+/EkftsiTVXsdoZy8Q21BOpNSNyA
         HqYgkUfwaTWM7o5HhrZjYelYbsSFxRfYQz6ncYNXTrVxDdMSVBftTJXUNiv5MsSdGLD2
         HgD9IwHVAPd3nlg1U1x4GaIsiBOU6Ohm4HgKX9LVVM8yyfzPjHS9pDexhPGjAFt4fpHm
         lNDg==
X-Gm-Message-State: AFuF++mQ0qykisSIpi47bNerO/d2lQ2CtNegzGK+Vfueim8TrkHhrPRz
	N18I74OY7YkxEyeNklXWCzu8tBhRWmd9tJl8uvLP539Rux7yP3ZZo3RTkFA1aQ==
X-Gm-Gg: AR+sD12bUIk2Np5xXNHfafB86Hxo0/IpPjh9PMl3J+8Bu23KJMDAwD7h/sSbG76hBFW
	1nEOvXK4iZ2wn2AetycS1Ehq7FbhBZbBTz4oxeQvXPj6eK6lBDUfNfoGSAVxUHBoiNk/BgAo60g
	8mn4YUYgNCELgTv5xq/lMBpjLYNFL6gXVb1pO5Z+1U+F+ThF2O8/FwFkO7oF9dTYrpUkEEp4Q8P
	lUxlvJAGMMk2hcv2Uo/FpkeDE2evV7ln3ShUNRFF9Xz05k5qhQL8iekXu94DaiyfkdkOagMffDs
	Fpv94aNHSKowxHmiEakwNedBCND1pfVOCkiNdsYlAInyvePa0RBo/qllBx1Y9pQQlG3AHaFRfFg
	Ny0Mnvkd4f5l496YHr+CC3SJTLlpK8O/PCjCwBgPQQ0EKsvb4d+Se2OOf7Q8ORV06d5qsFy0AUD
	6c0I76NawCLu7VEeAv4oPWNVkHW1SrR+sOF0ufPltfuF4Hfz8ik5V+sFRrSI5fMPlnjnh2mmA1E
	vdlNsxEPrdqDaM/gooFO0xcy87FqTMQj1Ds53CNF0m6wq+RO45ff/OEaecqWYayzA==
X-Received: by 2002:a05:620a:2308:20b0:936:69dc:aedf with SMTP id af79cd13be357-93913799424mr2406978085a.16.1788181550094;
        Mon, 31 Aug 2026 06:05:50 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173e0c95sm776321585a.33.2026.08.31.06.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:05:49 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] FUZZING.md,{libsepol,checkpolicy,libselinux}/Makefile: fix fuzzer builds
Date: Mon, 31 Aug 2026 09:05:34 -0400
Message-ID: <20260831130534.9831-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building the standalone versions of the fuzzers we always want to
build with CFLAGS+=-g for debugging, and we also want to clean those
directories on a make clean. We also don't need to do a full make
clean all since the fuzz targets depend on all anyway and only
certain subdirectories have fuzz targets.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 FUZZING.md           | 7 +++----
 checkpolicy/Makefile | 1 +
 libselinux/Makefile  | 8 +++++++-
 libsepol/Makefile    | 1 +
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/FUZZING.md b/FUZZING.md
index 1f0ebbfb..5263df09 100644
--- a/FUZZING.md
+++ b/FUZZING.md
@@ -66,10 +66,9 @@ The fuzzers are built without debugging information and with verbose
 logging disabled when built using oss-fuzz.sh. You can recompile them
 with debugging, logging, and a trivial main() function as follows:
 
-    make clean all
-    make -C libsepol fuzz
-    make -C checkpolicy fuzz
-    make -C libselinux fuzz
+    make CFLAGS+=-g -C libsepol clean fuzz
+    make CFLAGS+=-g -C checkpolicy clean fuzz
+    make CFLAGS+=-g -C libselinux clean fuzz
 
 These build into the fuzz/ directories and do not touch any object
 files or archives used by the normal build.
diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index b5a32e41..bced79b3 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -81,3 +81,4 @@ relabel: install
 clean:
 	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c tests/testpol.conf tests/testpol.bin
 	$(MAKE) -C test clean
+	$(MAKE) -C fuzz clean
diff --git a/libselinux/Makefile b/libselinux/Makefile
index 2ba414d1..c37c7ed0 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -50,11 +50,17 @@ COMPILER := clang
 endif
 export COMPILER
 
-all install relabel clean distclean:
+all install relabel:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
 
+clean distclean:
+	@for subdir in $(SUBDIRS); do \
+		(cd $$subdir && $(MAKE) $@) || exit 1; \
+	done
+	make -C fuzz clean
+
 fuzz: all
 	$(MAKE) -C fuzz
 
diff --git a/libsepol/Makefile b/libsepol/Makefile
index efa10d57..a608fdf3 100644
--- a/libsepol/Makefile
+++ b/libsepol/Makefile
@@ -22,6 +22,7 @@ clean:
 	$(MAKE) -C src clean
 	$(MAKE) -C utils clean
 	$(MAKE) -C tests clean
+	$(MAKE) -C fuzz clean
 
 test:
 	$(MAKE) -C tests test
-- 
2.55.0

