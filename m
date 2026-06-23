Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AF37C109
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222013; cv=none; b=PbStqG7xJ/ih5Uuzh9pS0L2yeMs1wT3EnWQnxyjPEDxXwInjX3aun2XvDaSEVzyiJu3Xh12VwEWsYMyg44X8mDGC9vCJ8Gh7F1rI9H1c8cbep7ABhTOv5BgF9PF3wYHzlq6admcm3x75dcij4T+bR994NCEipiF/06UsOnsCDOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222013; c=relaxed/simple;
	bh=CpoiKrbbU4Ncj3VmRkf/4bHy7X4c/Ir3IFcdnG/ehbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LsAL7exzUMNHZAGQO5fRB/AlIKkEohdHRH9gZ9CncxKCSicE51qvpa1kUAwNdxtN8L8EhUk2AOOnepqD0Xag0CBA8X5eKrF1vWGsW9g4miER7h0Putl1RoWbligjR8DgGuICspiOpE1/px4w2LFb13YEYD45mJskqbrhJzujQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=jNHMgjDA; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="jNHMgjDA"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222001;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XUj3bnfLaoNZOG+dT+IhakQRKEZ9vA6TtYEZrjBG/SQ=;
	b=jNHMgjDAR7qMXnSkQ0j7jmzn5OznjOfqa/UOP/jW7Wjveesrw3OYqhUcSXvdlE+UsLsCqq
	4FbW1f9bS9FVCBbGvxFji8RxItfBea7q/BNlBkAeXkm4xJjWl7d9I6mZf9gfvQiSig8aNz
	uChovbTM2LNIuqZLu1RUb8YGpmqcrUf1l0Kk5VYcYu8S9xevF5Ha31D65LTHC/g2BGUtfn
	GhJE95fDq2Es03RKi7R8sd2gEH/ebypDAXwN/eYh3JxkZJPrYQ7aXx3CBMQ/Ft01+gLZ5g
	sMwqyBBcKDhtobtDmp7kmhRZFnGDQKXTBB/6YtWHMzi8V7AQlRTjtKUCwz9QZw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] Makefile: avoid 0 as NULL pointer constant
Date: Tue, 23 Jun 2026 15:39:50 +0200
Message-ID: <20260623133950.96060-1-cgoettsche@seltendoof.de>
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

fts_close(3) takes a pointer as argument; use `(void*)0` instead of pure
`0` to please building with `-Wzero-as-null-pointer-constant`. Avoid
using NULL to not require <stddef.h>.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0e465f94..ae8586c6 100644
--- a/Makefile
+++ b/Makefile
@@ -29,7 +29,7 @@ endif
 
 # check for fts_* availability
 H := \#
-ifneq (yes,$(shell printf '${H}include <fts.h>\nint main(void){return fts_close(0);}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=implicit-function-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+ifneq (yes,$(shell printf '${H}include <fts.h>\nint main(void){return fts_close((void*)0);}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=implicit-function-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
 export FTS_LDLIBS := -lfts
 endif
 
-- 
2.53.0

