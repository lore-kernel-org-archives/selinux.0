Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA433557D
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680149; cv=none; b=iKHR6C4fzprOWA8eUYkkTMAdXEWUjfCU78pAb/TJT97TBSee10cEpCRFnvMDOMirYN6fM4V53GWZOccSkJGfFoc+Q4+giO3OhsYHVV/EIQ1yl9N+7QzxES2RrgyqFRdpZoYwdwpHcUlHHrwvctEFl9j6IjtDXeYAVHxZlqJhFOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680149; c=relaxed/simple;
	bh=B7PgDejcho4apuQ416ckl8RXO59zIvgovYQ7GU+wagc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoVXx/yF6bTnwdhZiVvYKovjHF5klac6bWlO0jwN/fPQ3G0hn8w6YXy9xuTPCSoguDGiuJzGEpoj58vDeMBsSlFyGXDr4CQrHarft7plhhpfaYLCUeDs27rRmv2etdfejnz+UrUNSrGUsapHISPQf3nr23n7Xt3wGp4TJNuiabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=NDEG6r0y; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="NDEG6r0y"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780680145;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZ1mq3ZgT1PJfOTKgMsCZz5OgSrI8tzzWzfwu0DdG9s=;
	b=NDEG6r0y7BKcFDF0jbe6y2Qp9zLtPsWG4xtc3df/YkWkGrSSPt6IYqF/Ag88kli5Dq02LM
	ON6B/nv9M8D+KeL1G3+vDhYEeMAKWzLt6LyWB2gyYkXiC4zG9vA5Tv5Ai58KGCAWUxw6gF
	wsEhRmyZB8BcbOMoNUK1Nvp6nafc8qk9GSJxLsbIgFS4kfK3au2UZttV1TjTZvj8QNV9es
	dyGxMOoeK1ouwO8EfZyfIglr6U9YhcWsZse4/7hoHmGfYBR49xncsB22TtupriiCD+Lqk+
	7FFuKweR4051/IvrT+1l614Cbs2E/eO/ioiKxqjuPv6CFUU9qMu/SGuqRLF4jw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 10/11] restorecond: drop unused macros and variables
Date: Fri,  5 Jun 2026 19:22:05 +0200
Message-ID: <20260605172207.222382-9-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-1-cgoettsche@seltendoof.de>
References: <20260605172207.222382-1-cgoettsche@seltendoof.de>
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

After the recent cleanup several macros and global variables are unused.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 restorecond/restore.c | 16 ----------------
 restorecond/restore.h |  1 -
 restorecond/watch.c   |  4 ----
 3 files changed, 21 deletions(-)

diff --git a/restorecond/restore.c b/restorecond/restore.c
index 622de773..d46439ad 100644
--- a/restorecond/restore.c
+++ b/restorecond/restore.c
@@ -1,16 +1,4 @@
 #include "restore.h"
-#include <glob.h>
-
-#ifndef GLOB_TILDE
-#define GLOB_TILDE 0
-#endif
-
-#ifndef GLOB_BRACE
-#define GLOB_BRACE 0
-#endif
-
-char **exclude_list;
-static int exclude_count;
 
 void restore_init(struct restore_opts *opts)
 {
@@ -49,8 +37,4 @@ void restore_init(struct restore_opts *opts)
 			exit(-1);
 		}
 	}
-
-	if (exclude_list)
-		selinux_restorecon_set_exclude_list(
-			(const char **)exclude_list);
 }
diff --git a/restorecond/restore.h b/restorecond/restore.h
index 17f0bc37..51b105ca 100644
--- a/restorecond/restore.h
+++ b/restorecond/restore.h
@@ -45,6 +45,5 @@ struct restore_opts {
 };
 
 void restore_init(struct restore_opts *opts);
-extern char **exclude_list;
 
 #endif
diff --git a/restorecond/watch.c b/restorecond/watch.c
index 30dfb8b5..a795ff59 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -25,10 +25,6 @@
 #define GLOB_TILDE 0
 #endif
 
-#ifndef GLOB_BRACE
-#define GLOB_BRACE 0
-#endif
-
 /* size of the event structure, not counting name */
 #define EVENT_SIZE (sizeof(struct inotify_event))
 /* reasonable guess as to size of 1024 events */
-- 
2.53.0

