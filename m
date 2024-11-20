Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05274172BD5
	for <selinux@vger.kernel.org>; Wed, 20 Nov 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732108217; cv=none; b=g43r+NUdH1n6xKi1WDqOQyqpHu+jm2G6ATGgnP8D+l//mIwIRrF48pgINcaYbC+9mDhfLgl6t4uty4jyxiB8Yg+8Aiy3x1cB5yY/1u2cJgGMfAPUTME3zv0sAvVdhjE0Vnr/iss51W1sPxQAMEGDM+QM0nyfAoCpcfjR1lZoi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732108217; c=relaxed/simple;
	bh=2ktKGbQB9Y+kc+rruJJICY2qu/g1TOziipiVsx37PA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrQ6bdyZ9Uj1Joaejs4AV9jY8mVx4KbizPwrkt0G5ivQ3nZUqYsWMqNVdGnZ5lOP2IIGTSiQhr+lnVCQSMMOik1q8au27khb1KExVYCfrOhkrCYPwfxqI8Iv9qqbGWv7oFqfazlfCdGnOr/GIBZAqfraS93TqOzZ0q4gsw4jJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=kgW0cZ2L; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="kgW0cZ2L"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732108212;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/FyZj7Sdez78sJFnARC8VQkKqtCqi1qVxZNkgVA1Fo=;
	b=kgW0cZ2L6jr1dtf3xpwYOihOU9A4glS5c7GGS/hKXJWcyeuhGUmNeFzDfpvn8vXoKcmBaF
	yfIvnTFYaC25YjwXGtr4j7gOD8CpAbZmiOGrNlpmnOBJlBri586n9XR16sNa0HrAxRioui
	K3ONyvYn1cUSESevzKTK5nv1nENNpnvH7SnpECCZJKidkpAl5rHg/zqCYwQyChyWot6TKo
	Wb8Bnooy0wwQ7j+TUtIiGONmZC6Kl95F9PI89u5dWR1j/71fsdPmBys7b4O5i5OTQpZ7iX
	beZTZaCJa0zRrwGy0I7l3xud01HyYMzHKAd88akxc3Vn1vx7VYJ4TXleokq0ug==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] libselinux: harden availability check against user CFLAGS
Date: Wed, 20 Nov 2024 14:10:04 +0100
Message-ID: <20241120131004.58662-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241120131004.58662-1-cgoettsche@seltendoof.de>
References: <20241120131004.58662-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

If CFLAGS set by the user contains the warnings override
`-Wno-error=implicit-function-declaration` the availability check does
not work properly.  Explicitly enable and treat this warnings as failure
by appending the appropriate flag.

Also include CPPFLAGS in the check.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Triggered by oss-fuzz which uses

    afl-clang-fast  -O1   -fno-omit-frame-pointer   -gline-tables-only   -Wno-error=enum-constexpr-conversion   -Wno-error=incompatible-function-pointer-types   -Wno-error=int-conversion   -Wno-error=deprecated-declarations   -Wno-error=implicit-function-declaration   -Wno-error=implicit-int   -Wno-error=vla-cxx-extension   -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -fsanitize=address -fsanitize-address-use-after-scope

Build log:
https://oss-fuzz-build-logs.storage.googleapis.com/log-88d68963-9439-4745-9541-840f6e1f7307.txt
---
 libselinux/src/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 41cfbdca..d73df767 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -104,13 +104,13 @@ override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 
 # check for strlcpy(3) availability
 H := \#
-ifeq (yes,$(shell printf '${H}include <string.h>\nint main(void){char d[2];const char *s="a";return (size_t)strlcpy(d,s,sizeof(d))>=sizeof(d);}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+ifeq (yes,$(shell printf '${H}include <string.h>\nint main(void){char d[2];const char *s="a";return (size_t)strlcpy(d,s,sizeof(d))>=sizeof(d);}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=implicit-function-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
 override CFLAGS += -DHAVE_STRLCPY
 endif
 
 # check for reallocarray(3) availability
 H := \#
-ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return reallocarray(NULL,0,0)==NULL;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return reallocarray(NULL,0,0)==NULL;}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=implicit-function-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
 override CFLAGS += -DHAVE_REALLOCARRAY
 endif
 
-- 
2.45.2

