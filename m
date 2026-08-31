Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37408431E47
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193292; cv=none; b=YIrsqK1qDr9kRNfGuJp4WUlDKSsR593BxwaSg51dyvraDFKck8oRDTV+LuMv2qy7KMfRu248nI0DIMW8ElurslZ43ap0AraZZF38FywrlXI+RwBqUEZE9VvtQ/nTHEO+CI6kIy3r+VQopQM+8JGwIhtNCIEZfZ2TDbkjVsUIxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193292; c=relaxed/simple;
	bh=Ox7MQc4RiKp7q5sMCcxLfIUfmZJvxrsyxCdZNAC3zHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/wtwbDD7ssTgSr8HEF1mmxGyh7BFUV/94/dcYD6hbgRd2BejVeVZsPhOw6RwevwOczZ2ViwymSF0+YJgDEqMOlyzr6DUc5sxTv9HX2SGLwgRJfzvo/MiwlZnxM39s9o/A7lZRi/V5w0ERKJh/Og+PIKrJRIU8SMTTJK/j5c0Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKRsBwBz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKRsBwBz"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfad59921so36087471cf.0
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788193290; x=1788798090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g3H1hWSQ/v1viiUrmv3P+99ArWg1M2vX8MBK5rWsCE4=;
        b=aKRsBwBzPOE8hH0MBuzl8/j6XT/TQxb69ayHL9WFEPCrTzsjYUO9wc2zT3JAnc8xW2
         YOB0Vbx64608LetUSUppG3kuIU/IRutfVw80kcbI6DCqeJhXi+xtRHWa/opXh7tB3dPQ
         i5aojshYqgo7xOoXIAEiKoaZelD5JU/sv+2X8L56rYbA3NYLDOOvzG7A4hQTwUPO5oIe
         J6Qj/+ahk/A05xD8Iq50JBPtIHFvARhi+uFHiKIKepESQqUC8P0wH+v2Fk2znDMid9X4
         KQRhX1ztuF99NkC/MjlWKCKY1Wb649ocI4XGeDXVXZbb7BOGYaBGlejUcnvQ09WGuq3W
         Fadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788193290; x=1788798090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g3H1hWSQ/v1viiUrmv3P+99ArWg1M2vX8MBK5rWsCE4=;
        b=oHN/SWzZNr9K0MQ4st4n2Dy5VLviC6d6tBl09n1My5QAcYTHX/rWCNGM0k9UV6g1gK
         WYwTXVs5NsNzG+d+cD8kBlI+a7v/nfixwzT2sYo9ZpeNh1MiZocuOcOW1reXY5NtCQGF
         cRO2e48VKipz+mOC40R8CdyehfXHvtaucwp39tPpOYA0RGqi9gDUkHVg98C4GSa2UmD5
         asFGa2i3AnzM4nEMcrRoeDkRP8msTTtpCUCAQhLST0b6l8guKJjNDaJOlnYv0RCnwWqf
         rKX/SxojRHloh7Sml/DvQbf5TuOR390GcUgjL7H3v3wRUYdmiPI6aGqn8BUR+9oVA1n6
         T9gw==
X-Gm-Message-State: AFuF++keb6Gn6hcLnzjkAjG0XNidujOxSkHo89Xclm8MtdeoQgy5ikdH
	GXraesyjbqNBDyRniApN9Y+CmJOlj7XGF/7aCR8EC1notw7eTwQFVs1CAeS0dQ==
X-Gm-Gg: AR+sD13R8e74Crk1h3dW9oh44KyY0CiFjoazs7m6wrROHA6zFS/sq7cSfUkNj7rSLJK
	h8Gmzx51Cjvn0uwRVqgSmBewot5x3/nXNwCeJn1J4Jui71LzK+d1A4tzIh8pb+4qtgijLyh1LBI
	zgz/6EAbF4xjVYy7xTawKp+8SwzEcJbDkttMJWSJ472LSdhHJ7FPdN600iucMvt/H/altlo/oSR
	82bMlWQsJAIGGIhCPiX8yglR95pCbL5AM3/T08ZGYhg/zRhf+IHcFaOpueTxn1zDQ2eDgYtZL/U
	SDbVQBlAIfjzAqlwNN5jyWqzFooyxP/o6gRnwbVM8RCLi7GzUe3rOMT0YqQw3tRekptuuvLnw1L
	8MkEM2pb7qQYOpNOoPfHU6dNOy1UV1WvBTiZhrTsndfKRbm90N9Yr3/1WvDVpCrGhBIViEBGlTb
	Qkq7DgWdzz3xvJJcgi9o+deaLCWuOBiEIf4Eev8W8WL1Oqre21lT33iBntXZCTe1Lay7Gvhs297
	ZMSCxHKZQClIcZ/gG+ktvA7fRmLF95T0GXk4w6yPGHfkNKVkJZA1rZoV1DnmhJD
X-Received: by 2002:a05:622a:5814:b0:52f:b9ad:9dad with SMTP id d75a77b69052e-53021d4c27emr28860311cf.36.1788193289839;
        Mon, 31 Aug 2026 09:21:29 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe54a568sm75606401cf.4.2026.08.31.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:21:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] FUZZING.md,{libsepol,checkpolicy,libselinux}/Makefile: fix fuzzer builds
Date: Mon, 31 Aug 2026 12:18:49 -0400
Message-ID: <20260831161848.80566-2-stephen.smalley.work@gmail.com>
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
clean all since the fuzz targets depend on all when necessary and only
certain subdirectories have fuzz targets. Declare the fuzz targets
as .PHONY so that they always build despite the fact that there is
already a directory named fuzz.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 adds .PHONY declarations to ensure that the fuzz build always run,
and drops the all prerequisite for the fuzz target in
checkpolicy/Makefile to avoid unnecessarily trying to build
checkpolicy and checkmodule against the system headers which may fail.

 FUZZING.md           | 7 +++----
 checkpolicy/Makefile | 4 +++-
 libselinux/Makefile  | 9 ++++++++-
 libsepol/Makefile    | 2 ++
 4 files changed, 16 insertions(+), 6 deletions(-)

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
index b5a32e41..22c32a25 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -58,7 +58,8 @@ test: checkpolicy checkmodule
 # helper target for fuzzing
 checkobjects: $(CHECKOBJS)
 
-fuzz: all
+.PHONY: fuzz
+fuzz:
 	$(MAKE) -C fuzz
 
 install: all
@@ -81,3 +82,4 @@ relabel: install
 clean:
 	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c tests/testpol.conf tests/testpol.bin
 	$(MAKE) -C test clean
+	$(MAKE) -C fuzz clean
diff --git a/libselinux/Makefile b/libselinux/Makefile
index 2ba414d1..48c0206a 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -50,11 +50,18 @@ COMPILER := clang
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
+.PHONY: fuzz
 fuzz: all
 	$(MAKE) -C fuzz
 
diff --git a/libsepol/Makefile b/libsepol/Makefile
index efa10d57..fe8525b8 100644
--- a/libsepol/Makefile
+++ b/libsepol/Makefile
@@ -6,6 +6,7 @@ all:
 	$(MAKE) -C src 
 	$(MAKE) -C utils
 
+.PHONY: fuzz
 fuzz: all
 	$(MAKE) -C fuzz
 
@@ -22,6 +23,7 @@ clean:
 	$(MAKE) -C src clean
 	$(MAKE) -C utils clean
 	$(MAKE) -C tests clean
+	$(MAKE) -C fuzz clean
 
 test:
 	$(MAKE) -C tests test
-- 
2.55.0

