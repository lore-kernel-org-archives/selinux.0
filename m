Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208540DFC4
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686856; cv=none; b=VUTPjHHfbHQ14JLekkq4la8aud1j4BNx7rkPgTwf2mKHXFWKdqgWkhjto0DtSGAYAyN0QG0IWdljg095NUQMZ+RRu3TYhidVRfGHp+Igb96Utd7hP5pgHALRnN9KVFTT+M2MfdkvYvH6Bu19b06B5dxjdebdu/WXgwMzUI6UStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686856; c=relaxed/simple;
	bh=fERt3j9WwhKiST+F8jxWvYQNR31anQnCXJ+hN+nZI9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYGKDjFVKzJ7v9eLcOPMt4EEeNVqgqJcJO1GzoWtoNDH6dxYGp4XRvt01IHYwXum63UEXLDiIzYkFb4f9Z0B5vbEz+RDydC1iVevffcxVWhg0ggwXXjVv4+iIhUh305j7IRfyi7OeEdYwpIFN/1Zm3vzU0h91GMSlak2U51A7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw8wJWsJ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw8wJWsJ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8cd45d4b7e2so26293796d6.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780686851; x=1781291651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/tgsMe+QU9oAzr2HswXAps7VAUZcVGG+FphNztHhxE4=;
        b=cw8wJWsJvJaClSr0ecBa4KTUGtn1s/IKX+g1uyKCGOi8u38ZvS1NoXubyHsI/rQboR
         HBO41RTd0HB2xG35gWcTVLHVkFC6mEKPH5mKBj1nbZiZqOPkYi11KgBNDLUKxyRyxevP
         bznVxHcv7EnGc5Pr+ID858zbacHVr5aKkCbIWKs7AOEhl5DZTNXvMq1y30AGAG/fCxIo
         cqC7plMWkBhS2I/8nJFnSFYd+Dh6aOCrAJhetj3SkCXfR+tVRb8IMMsxMEHW3T6treDA
         PufA3np2zBEsiBNBPx7XV89RyLq6ggy2jsYLSXhjj2yjGfzmss9G5ynOSGE5jvzhLTF8
         mpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686851; x=1781291651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tgsMe+QU9oAzr2HswXAps7VAUZcVGG+FphNztHhxE4=;
        b=n5RBP9dFedOB3+qBHCbCX0wG7dUeuFcaSEfnYbtwSwo6uZXXrL4WEHdzhAZU4NPkzJ
         WYeS2l1zAvXRXf8RbsbQDlw/6Cpk80h1+SJV+XA3mna90bkHux46H4safgpza6fKlvoV
         eOw0rDR7Wuz3zbaxePKF6fteXw0fIrUa4I0OwLqEKjysBDPBnJb3PBHZ/LYI1YbpN0Ut
         SwD3jNPyuaGiIHb3PA92oRHtciJb7Pfz+SO9+SCk4CvmfxHrVqxKyVXaJebJPu3qT23/
         ArDR77Kjud7KmyhAg32aqwbDZF/WhMJZWoAVz/k+23jpGF5TEA1gSV82oD18f6WLc9Li
         84mA==
X-Gm-Message-State: AOJu0Yxsl4oZNIrxrFBTRrJtuJPDhpdUwwMxHYenDTlJgK5rHTrOiIu4
	wSheo5yqaTp/uFKmZegHoW4eXpn9IuSXjoO7iQyfInCeAi4oi+Yfwz/dQ2X1nA==
X-Gm-Gg: Acq92OGEbntibL+Qo1p7Nh1qzGMdO/cKudOrYwTq2lW6jT7fQMLGL5SH2YjNJu0cZA2
	LLmyb+i6/zX/do/GJ985eWGv0ZbD5Mrv/dmp+mVaa8m2VGUnvpDQs3cSqDyl8zK493liuPDp4Qh
	ZyY/ErfSEsf4bMS3BIrY76BwckSSZm5V+eSXq09hScOus0Ue0Xz2G2e9eO6yvYWJCSac9p6STWa
	Ato5KLgFErRbAvUuRZtZiKApDQtuF0MUYMn9dQOJ22jbm9ff6VQ2loFVCJ2qxPj/n7aTMp1W3rg
	k3188yfI4AvPdsvXBhKz8rI/01j9mir2XJr04unpeQmh7FultU0efjor7Q1yI8hZTqX1OCpxvIP
	qwST4tCNCilx+Z9ziW6Dc9PE/b+3fsPg4cvjtAvsHEZsUyn3q4oLOPq9xhHRjSLJ/wW8HFUltgL
	eZ4V6KGtgnq9vfbwkYO84p+6D/npb+PoIxs7g9li5c3PMLd25/7s8ocHKwpqamztFGAzLXRx85M
	Fw/5NwSQ0rftA4rbGd9r/xfb0tf6gxxKTEPrpvQV9XaPe3L
X-Received: by 2002:a0c:ef42:0:b0:8cc:d765:4fb7 with SMTP id 6a1803df08f44-8cee62aa08dmr65012416d6.35.1780686851332;
        Fri, 05 Jun 2026 12:14:11 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd051facsm89099366d6.32.2026.06.05.12.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:14:11 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Pepper Gray <hello@peppergray.xyz>
Subject: [PATCH] add test for fts_* availability
Date: Fri,  5 Jun 2026 15:13:55 -0400
Message-ID: <20260605191355.281484-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pepper Gray <hello@peppergray.xyz>

check if fts libs are-builtin (glibc) or add -flts
to use standalone fts (musl)

fix: #514
Fixes: https://github.com/SELinuxProject/selinux/pull/515
Signed-off-by: Pepper Gray <hello@peppergray.xyz>
---
 Makefile                | 6 ++++++
 libselinux/src/Makefile | 3 ---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 0e70f3d4..0e465f94 100644
--- a/Makefile
+++ b/Makefile
@@ -27,6 +27,12 @@ else
 		-fno-common
 endif
 
+# check for fts_* availability
+H := \#
+ifneq (yes,$(shell printf '${H}include <fts.h>\nint main(void){return fts_close(0);}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=implicit-function-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+export FTS_LDLIBS := -lfts
+endif
+
 ifneq ($(DESTDIR),)
 	LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 	LIBSEPOLA ?= $(LIBDIR)/libsepol.a
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index c0e18321..9982faad 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -99,9 +99,6 @@ override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
 LD_SONAME_FLAGS=-install_name,$(LIBSO)
 endif
 
-# override with -lfts when building on Musl libc to use fts-standalone
-FTS_LDLIBS ?=
-
 override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 
 # check for strlcpy(3) availability
-- 
2.54.0

