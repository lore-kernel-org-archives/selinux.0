Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2295CDF0
	for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370093; cv=none; b=ARd2+M5FkiGiCQ1ldiLGmbJFeaf/NOCnrQ+y2DyVfKw4ZrLZmgppOtDTg83MiIsFKSVVorvp/AAbG3Uz5ooLzqePns/N4gK82K1lpwriwM4X6VQYT6kKqCQmfqz+14dFhcuYNke1Ffv3CLGBn56xonavgoKYY3pBv0eo6Xpa8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370093; c=relaxed/simple;
	bh=oFXHpPygG078XZExbKHdeebLuaW47YzUDcxD2CzRpHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlOmze/8Q4LH0aNh4L17dF+mL/yd83EWMjaOJMgofJ/32CfOaJlVSC7qs8o2is+oP8BC8r6QuTOo2L4+tBFLWiOD8SR1S2yS9AfgQPc1zWkrk8/iY1mLf/l6pXDLk2uJW4znJrZci/hfXKC57uWISBO3uzpKpa3mLrW86e+bLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUF7K7Xo; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUF7K7Xo"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4725acb539cso138206137.3
        for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710370090; x=1710974890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XM7owhmDA7HD8TmoWLADk0dFg6YuZytg5OibyU9oNXM=;
        b=gUF7K7XopEVJUfdLsQRUavThkP0w81oshe1iDlYzYPQhTw0lB7uycZykGzex56MsAM
         bfqWCMUxXKj/pfkGwb82ZBd8dsYjc5jKWFsxTlW6rwY0cfq8e0byjqci+4r4q8ItFt81
         /EcmVdlKmbCbXxNFAke3X3E0QYgzIGSgkSttnambR4Etd5BX3uWcnP/2MVR4x7JCLjw2
         WYs3pcsl03E7fGlCNup+LWOibK/nTiq9c71UpA4BRiyTBf5pU6pRjeovoDcUEOFYJ7/c
         5zQ4OetG5XCU1eg4R4ubu3u+ptRbHZD58H+QcmNx5/fKK8xsoV2poAN9gkCv3qPkYU2g
         7BOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710370090; x=1710974890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XM7owhmDA7HD8TmoWLADk0dFg6YuZytg5OibyU9oNXM=;
        b=NsIKf7yAzvHaDS3c8Y69CF84+1HRWBNLIZ3xvm9deH22NGjRWiDQUTbK+feUT862cK
         aP5mnHfqjjg1lhCcTVyBO2ejyE5aiuC2B6RWn6hxIOWvxqdSqORM8zHNYcnp/tx8/9eS
         bWo3lEvk91MEtjrKrRS7TFlcj3pc4uEGI6vcz4qjB73msv9dJdamFCb+y3VF2VWq/+UD
         aW9mLIzrqwewCu+fsUVUyZJh3YiNxOWw8fG2ThG0b/JeAJd3ANUh3vuPfL/+8r/7ER1R
         CAN7iqz0qobUxF6F4AvR8RKgPtG9QXYnfoc7K03XfRLvVEsf9P2SD9J52NUNM4E/VO/z
         7DXg==
X-Gm-Message-State: AOJu0YznVa6yCUBWThLqwx+jv51FQrxYVNvPMtyGy7SApHQPp3a9E7it
	bW1DxXCidmnMdwoDjKeU7EbY4KDNHYpdjIzpcIUhMY3HyYHMxHd22X5bw9aW
X-Google-Smtp-Source: AGHT+IE4qCAp8AbPn9vR2Gm3IsFzj5OO//Cc/K9H+YGO8ZNV47KtgkgZphLQW7ox6F8WLQUp9YnYtA==
X-Received: by 2002:a67:f059:0:b0:473:1fcf:ed0f with SMTP id q25-20020a67f059000000b004731fcfed0fmr310786vsm.29.1710370090592;
        Wed, 13 Mar 2024 15:48:10 -0700 (PDT)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id u5-20020ad45aa5000000b00690d56626b3sm119017qvg.132.2024.03.13.15.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 15:48:10 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: jordan@jwillikers.com,
	winfried_mb2@xmsnet.nl,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libselinux, libsepol: Add CFLAGS and LDFLAGS to Makefile checks
Date: Wed, 13 Mar 2024 18:48:06 -0400
Message-ID: <20240313224806.2859045-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In libselinux there is an availability check for strlcpy() and
in both libselinux and libsepol there are availability checks for
reallocarray() in the src Makfiles. CFLAGS and LDFLAGS are needed
for cross-compiling, but, unfortunately, the default CFLAGS cause
all of these availability checks to fail to compile because of
compilationerrors (rather than just the function not being available).

Add CFLAGS and LDFLAGS to the availibility checks, update the checks
so that a compilation error will only happen if the function being
checked for is not available, and make checks for the same function
the same in both libselinux and libsepol.

Suggested-by: Jordan Williams <jordan@jwillikers.com>
Suggested-by: Winfried Dobbe <winfried_mb2@xmsnet.nl>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/Makefile | 4 ++--
 libsepol/src/Makefile   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index d3b981fc..41cfbdca 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -104,13 +104,13 @@ override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 
 # check for strlcpy(3) availability
 H := \#
-ifeq (yes,$(shell printf '${H}include <string.h>\nint main(void){char*d,*s;strlcpy(d, s, 0);return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+ifeq (yes,$(shell printf '${H}include <string.h>\nint main(void){char d[2];const char *s="a";return (size_t)strlcpy(d,s,sizeof(d))>=sizeof(d);}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
 override CFLAGS += -DHAVE_STRLCPY
 endif
 
 # check for reallocarray(3) availability
 H := \#
-ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){reallocarray(NULL, 0, 0);return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return reallocarray(NULL,0,0)==NULL;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
 override CFLAGS += -DHAVE_REALLOCARRAY
 endif
 
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 16b9bd5e..7b0e8446 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -31,7 +31,7 @@ endif
 
 # check for reallocarray(3) availability
 H := \#
-ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>\nint main(void){void*p=reallocarray(NULL, 1, sizeof(char));return 0;}' | $(CC) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return reallocarray(NULL,0,0)==NULL;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
 override CFLAGS += -DHAVE_REALLOCARRAY
 endif
 
-- 
2.44.0

