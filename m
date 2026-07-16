Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3AD3624C1
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784230679; cv=none; b=tInZRj/WwDRhREGXI+zHGxgZw0+PlivbWtEowxze8bVMEtG2hUzsQwEUBsI1YcDKz0NudiN662J7b5irOLx7Tvo85kGNGSG/xjNYhnvrsrbZdLjE/ZptWu7q0NXW97G2iMZgsJlWFM0lHM2Uj2ghU9a9S3/kTSDauxBjX0QL1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784230679; c=relaxed/simple;
	bh=yJaOaiKh66bHRVzYU3wUHEc0rSbe9gKSlcnVm3OULOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoPcl2CzrmL0uEsEYyE4+2L8k2HYJ/eiHozBS8R6BnSNJI1OjfLna3pvL2/qLnWRivY4C4fQGg8j2edEDuywKTNK+5EgJEfMWPGgx6XeJFmpXhI7l8GwB1Y42ZivTA+XLxkZ+bGL6beKXopcLXIqdD41hwDdxOaPryPvAyUyf08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAote90z; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAote90z"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92edb12cdf2so235636185a.3
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784230673; x=1784835473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y8KW2xcM1ImWaRq6VQstQctE0U/OS9ixvACRwcwemis=;
        b=CAote90z2Sdu7/pgsj8dmkb20yMnpmDwtIExcVN5cFK0sHW7jlq0SpMT0++PEzQ65X
         iswaYEepnKMBO+2J6bAehRo9IvH8whDwkXnF+3Dm4og8oqWkQwjFJtUJsD+Z6qJRabgY
         ap7Ll0Bs6Y8mxPBT5IclfHt9ynoIbI3tsKbI8mq02AsK6cx4eG2zR7fxjt25rowgu4Mw
         /yIYDUzUNWlJtuuRnrmuf9YrjHheQRt4DaOifHLgGNYxYTtaJAEc8nK9qELNCBii+zJ8
         CXMalIMrN6dQl+cMKT3yp10e4O7UWv7Ckn2CuDh/7w8j5NvIXnZzY1IeCfmkU8ryujj5
         TwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784230673; x=1784835473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y8KW2xcM1ImWaRq6VQstQctE0U/OS9ixvACRwcwemis=;
        b=JyfuJHCrpUgb3Mscmdc++nFSG3Bumzk01S4rxtxwFqSsMH+9PmjZlNdZXUqIQ315ek
         z2cfhqZV2erQ6/XSx1+lmp6ZGsIwCATwZ/jSb/peuQhLbOL4bhIXOXsIb/+jZNKBTsL6
         s+2AiyXtHlLpqdM2BBej/OgC0/SO7rKnMU+SotMNt6k6tmgarPhEWUMvCQePdp79m+4l
         pSc3hipBeHZLYGpV9ivVg0rMxxVR8w8s5dbQIGEr99TC4axzuTKWkshdl9jzYi1BJ5Vu
         E6PWnBHJyDm9g5MmR19n4nJbdJIjaenQWmQ9Red73+2v7jLpeajlDXpkb1FqroWz32sp
         bBCw==
X-Gm-Message-State: AOJu0YxmiQs8Aj+oRBZL15p3lukAQ26032SuJf1dYIqZh9loEU7/lkkL
	nsSUdrYgdERiHE++z4CtiD97E+iJjPdkwj4DpSLiEhrs8i7h5xZMXrYC30BYsQ==
X-Gm-Gg: AfdE7ck6cDn9Xs6adJ+S+FFZgqWaijoWc/st94AOjXEGZRx2GPM8NxvCgYZo/QqpFWL
	n5BoCKBaXBHM421YpbigLfYNuAaku6KVCk+ahENnd7E7mu8cDogAJF/OqyRfc3nKr4MUFcPHRO7
	5n0wgDZGdi+VEp2Z70YpOf6VuA0A3gPEhNvEONorMKj7PrwRHvYSdC5/tg1yYvoEk8xHFCU8QIP
	gp+38sJHr2cmhlwjX7wAzjIcj8TJp3lUm0B/V6RvkIuiPTHMuBFKwCVH7V56+OcxkGWOCalP2wV
	4ZZS6QDWug+xFBlSyuvpMrz3uxgCP/Bo7ilxuxlcX223NIQA2qTxDIgihLuA+3PzlGVMdBsoUMH
	EAB/3ICF7yZAg3oKdl2IY/VuZYIfmNZvjNM4iWzIdgRgJtDI83qXNOKUt2cwobHcyYVp61/VwUb
	9/UltO41wJKTdmA8/Ff474FVAc2Azs0US2xitmS4uQFjvTXXYG6FXMXXW6wNz0mccARIYs8UW+O
	TQlmA==
X-Received: by 2002:a05:620a:a718:b0:92e:6338:cedb with SMTP id af79cd13be357-930b091911emr77493385a.73.1784230673118;
        Thu, 16 Jul 2026 12:37:53 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b492ebsm1987760985a.9.2026.07.16.12.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:37:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/4] restorecond: fix type of utmpwatcher_handle()
Date: Thu, 16 Jul 2026 15:37:36 -0400
Message-ID: <20260716193737.11366-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716193737.11366-1-stephen.smalley.work@gmail.com>
References: <20260716193737.11366-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

utmpwatcher_handle() returns -1 in some cases and the caller has a
switch statement on it that compares with -1. Switch the return type
to just int rather than unsigned int to more accurately reflect the
interface.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/utmpwatcher.c | 2 +-
 restorecond/utmpwatcher.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/restorecond/utmpwatcher.c b/restorecond/utmpwatcher.c
index c60fe0e5..e0cb48d6 100644
--- a/restorecond/utmpwatcher.c
+++ b/restorecond/utmpwatcher.c
@@ -45,7 +45,7 @@
 static struct stringsList *utmp_ptr = NULL;
 static int utmp_wd = -1;
 
-unsigned int utmpwatcher_handle(int inotify_fd, int wd)
+int utmpwatcher_handle(int inotify_fd, int wd)
 {
 	int changed = 0;
 	struct utmp u;
diff --git a/restorecond/utmpwatcher.h b/restorecond/utmpwatcher.h
index 19880108..19178f3c 100644
--- a/restorecond/utmpwatcher.h
+++ b/restorecond/utmpwatcher.h
@@ -23,7 +23,7 @@
 #ifndef UTMPWATCHER_H
 #define UTMPWATCHER_H
 
-unsigned int utmpwatcher_handle(int inotify_fd, int wd);
+int utmpwatcher_handle(int inotify_fd, int wd);
 void utmpwatcher_add(int inotify_fd, const char *path);
 void utmpwatcher_free(void);
 
-- 
2.55.0

