Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383D56442
	for <selinux@vger.kernel.org>; Mon,  8 Jan 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQZmd/4P"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3374e332124so2112171f8f.2
        for <selinux@vger.kernel.org>; Mon, 08 Jan 2024 13:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747801; x=1705352601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aE0lgDP1nuxDzc9BPJgchaHgHJApkPYTIncMWltrXBM=;
        b=jQZmd/4PylIibO5+TSrHjQenr6JiL7mblDuWB4dAwbD9h4lbwLPqOalp9jfVHU4fgq
         n78fjn9PxAx21Z8oJuDRwj+DgPfCcpj3IwB10wNBiLESqo2K/phbA0eKv1oRns2x284n
         A+M3awDlhDqFK17r16e7OuQB2eTUkzZVs3r/eF2MmsRAVe5Ahh7E3n9H8Cs+14kv30Oh
         EDBDa/FpLCHyXLNcYgthSfyTRlVCJnPeEg0DQ3lTzADkvbHHp2aGDiQpy4lYq4t9ldoc
         xHVUMAutTXVlJhY9uXf+SGYcuyGazTtuCJTRd7jGStRlTfth4A/HZF3g02dvXEpL/HFn
         KWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747801; x=1705352601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE0lgDP1nuxDzc9BPJgchaHgHJApkPYTIncMWltrXBM=;
        b=OBR4RBeRNPYPXxUm+i2veBI+jyosvowpWwnRO5oUl9FVRJqH24I9nF24IAa/FJ8PQU
         lX5AEDj8KfuhfYAjutpPHuozad0m0MlGvuuCNQJAQS+PYwbLi8hGss/3paei6Bg9HoQh
         OhM9ZyukNmu59oNx+VlcAuHItqHD4z2CQgZWPBkGpCV29eO/EtOSf+92NHGTTPpUJi2E
         HRMOkuMqjOGGg1iqtyIZtrIrssAS1ztP5DTDeC9ns6h4uUtAuh4Go2p4vaLxevokiBRe
         C3XAFnBL4Shjt4IyRjMbprUeMfHoOPtWUs4+Bl8gaRCpreXnAPWTPKEpPrz0qga8iJO9
         44Tw==
X-Gm-Message-State: AOJu0YwU8zrKApL3xMfGMkMJRqrwalcVR5ZGR0M7CmQ15URDhCnRTd4K
	IAsFFaGGCvjbDBbgIQBMj5GdnHt7wPI=
X-Google-Smtp-Source: AGHT+IHJd98JM0c4Zc/9VqSHAAv6Trv7UNnw3mEGxadqw0Oe9OwCsAq9LYJSLsGyPv3tmsmNENjojQ==
X-Received: by 2002:a5d:53c9:0:b0:337:5a22:b767 with SMTP id a9-20020a5d53c9000000b003375a22b767mr15963wrw.132.1704747800969;
        Mon, 08 Jan 2024 13:03:20 -0800 (PST)
Received: from kali.home (lfbn-ren-1-787-165.w83-197.abo.wanadoo.fr. [83.197.114.165])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d6346000000b0033667867a66sm574783wrw.101.2024.01.08.13.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 13:03:20 -0800 (PST)
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
To: selinux@vger.kernel.org
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] libsepol/src/Makefile: fix reallocarray detection
Date: Mon,  8 Jan 2024 22:03:14 +0100
Message-ID: <20240108210314.339682-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass LDFLAGS when checking for reallocarray to avoid the following
static build failure with musl raised since version 3.4 and
https://github.com/SELinuxProject/selinux/commit/f0a5f6e33084bd83d409bb7c932256139f471e71
because -static is not passed when checking for reallocarray:

/home/autobuild/autobuild/instance-9/output-1/host/bin/armeb-buildroot-linux-musleabi-gcc -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -O0 -g0  -static -I. -I../include -D_GNU_SOURCE -I../cil/include -fPIC -c -o assertion.o assertion.c
In file included from assertion.c:28:
private.h:88:21: error: static declaration of 'reallocarray' follows non-static declaration
   88 | static inline void* reallocarray(void *ptr, size_t nmemb, size_t size) {
      |                     ^~~~~~~~~~~~
In file included from ../include/sepol/policydb/mls_types.h:35,
                 from ../include/sepol/policydb/context.h:23,
                 from ../include/sepol/policydb/policydb.h:62,
                 from assertion.c:24:
/home/autobuild/autobuild/instance-9/output-1/host/armeb-buildroot-linux-musleabi/sysroot/usr/include/stdlib.h:150:7: note: previous declaration of 'reallocarray' with type 'void *(void *, size_t,  size_t)' {aka 'void *(void *, unsigned int,  unsigned int)'}
  150 | void *reallocarray (void *, size_t, size_t);
      |       ^~~~~~~~~~~~

Fixes:
 - http://autobuild.buildroot.org/results/0170032548a38e2c991d62dc5823808458ad03b3

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 libsepol/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index d80a941f..16b9bd5e 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -31,7 +31,7 @@ endif
 
 # check for reallocarray(3) availability
 H := \#
-ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>\nint main(void){void*p=reallocarray(NULL, 1, sizeof(char));return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>\nint main(void){void*p=reallocarray(NULL, 1, sizeof(char));return 0;}' | $(CC) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
 override CFLAGS += -DHAVE_REALLOCARRAY
 endif
 
-- 
2.43.0

