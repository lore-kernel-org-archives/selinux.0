Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99F1EFFA1
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846961; cv=none; b=NPcDHt9RYz8o46B6mGhtSf6BBG7ID1yCtMD7a3A3n4rs73i9vL5vCVPIO3QUoQUKUvMnZkJ6C+FDvjA2PX/T6m7agmap6yLtRUTFJmuutV/BjmlJrD4LirmceSWztCrE/SHD94aqOcAZ3W5V2R9hsbnVyaHzU/d8aDB7U34Gu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846961; c=relaxed/simple;
	bh=LeNTXjDXl+c6QfVsKqfwERsiwpRrUEnOAPVxr9Xj8WM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hGQoEK9hvSqBilwTuDt2s+wYYeAhca12imTc52MgBIukhrN9Ai9P/APHqDRdmVR8jZrEm6WTFca0TjXfJKGl7po0x5rRnWKMyCSBQ8HPvukeR9lV0LPb73kEfxlccn/fO3pv8TSzgoSzkx/EYaclqtX+zKstlbmV933XiSIR7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d48vJtH9; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d48vJtH9"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-512f09ecc67so63350161cf.3
        for <selinux@vger.kernel.org>; Fri, 15 May 2026 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778846959; x=1779451759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHHdO8IrZaB7JE5SIQXxApLfAcfDOhs0U8/roJx1EmM=;
        b=d48vJtH9Xlms3OI+DCvfBGzrTm5iKRLBorTmm8vhNC/ldBaTEYArJlda9iRbjIloyZ
         gfCbLJp5rmQmBPg/KP/xIR2P0TyAMFH/i8LQROOQ8eYaIrMtanR/eVOdFK7QV3z1hGSV
         /sa4yiyNZ9ywGBqb8D41p0uBRwpoyhEbC1MY75UcWo9Jb6PhPZnJAw6n9/WeP1PlfHcS
         ofSWCJN9ymz3tLi7g/oskZO7wntjZHRlocRKXw/kulyHy+7mTzMzTy4nAi4euqN4xdL8
         Amf6FqqydMjJoQ6HGCm93csByLcjZQ5Pzqd759dx61fAI7OqUMIt+CyLQ8JRjyrOjBm2
         ge/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778846959; x=1779451759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHHdO8IrZaB7JE5SIQXxApLfAcfDOhs0U8/roJx1EmM=;
        b=H4S5Oi6FavNE/aw5Si+ajqFtNY7TDYtcbtQJREiYHu0yT1FqJdgCvqhyf3yEFVtML7
         e5oq7qkQX4FaFcvClMVnLoZqI5WrHdMxAO86kTDEwgPTgXYT6Rmo5NgS0/C9JMIC5Nim
         wkosBoIbJLC+MNmzepJFHmk5b0K0T9Lj8/Cjt81M6nGZhQOJA6verKVfyQu70cLz/9Wx
         vYH03GgAgHwqT22hYqBSd+1na59WRvUmb2lPdamXEpMBXgitH3ljUS6N8cRC2hFDftWi
         n98EbpsmweaprVCXEPxxvXRJocOOsUHuRPuo/BOmfGjPjmwi11o3KayAbMIeb4E1cXt6
         Mttw==
X-Gm-Message-State: AOJu0YyX4Vb0F7RQCz6Uyl1FLDs0BbExD4xH2mSOYlVtphMnvC9Vw/pt
	SB9kHMXp/rGX3JPbW6Wza0YNhdtQ49a199Q2OgdkUSVFNZv3qGtfArf3lKb8Bg==
X-Gm-Gg: Acq92OEUBjrxKJmVQ9CYuj9Mqd1MLv+n2ZEECHGzV/cuY1I1pPL4ehg4l6JHk3TwXww
	iz5SR0t+ydeg3/UafyDK5p5xddd4ZJ9RoF5JEKyivIXYF1g8MEjmzE0rp+21Z0bKGNrAJDddLrY
	bNH/DTo+XgcFxVMgykUoVakE61LP/YxElL6fcnKWrGszvgS/F7MXLwlgbLkm15kOub1t3odia7V
	qxTnROGKfWZ3OjFn5HuiyxdTSiu34nCyt/RcTrOOV07B6/azNSex7q3PGL3zDmXgvr9SanKagqX
	WrLE7LFf8e/RM90L3zZQ64eb917FFxWkwTixVV99/Rxq5RdQ4wYwkbd8tQW7wZVz7Nv/2+ucQnN
	gqps9WQwm9dFlFnK5/jOXKdA8SLtY6U0oLV70YPTo0TVzgdZsg7eFdrAJP5KxiA7h/4JsFVjyWi
	mX+iY5kuS/csl1xcuS4R1QEp8zkg3Gm+7v0BiHRLNrB97eRWs6qTDGeOTIo6aauZq0at4wASDJv
	Iuf7/JLV6HQmE4nWYvtC9FgNKytVwY4uI3gWuAyPLOMksPve5y4xr0=
X-Received: by 2002:a05:622a:4e06:b0:512:e813:7ceb with SMTP id d75a77b69052e-5165a21a05bmr45322761cf.46.1778846959016;
        Fri, 15 May 2026 05:09:19 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm45498821cf.3.2026.05.15.05.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:09:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage/tests: fix const correctness for test_utilities
Date: Fri, 15 May 2026 08:09:07 -0400
Message-ID: <20260515120907.10699-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixes the following errors.

 gcc -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror -I/tmp/destdir/usr/include -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -I../src -I../include   -c -o test_utilities.o test_utilities.c
  test_utilities.c: In function ‘test_semanage_basename’:
  test_utilities.c:357:27: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
    357 |         char *basename1 = semanage_basename("/foo/bar");
        |                           ^~~~~~~~~~~~~~~~~
  test_utilities.c:360:27: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
    360 |         char *basename2 = semanage_basename("/foo/bar/");
        |                           ^~~~~~~~~~~~~~~~~
  test_utilities.c:363:27: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
    363 |         char *basename3 = semanage_basename("/foo.bar");
        |                           ^~~~~~~~~~~~~~~~~
  test_utilities.c:366:27: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
    366 |         char *basename5 = semanage_basename(".");
        |                           ^~~~~~~~~~~~~~~~~
  test_utilities.c:369:27: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
    369 |         char *basename6 = semanage_basename("");
        |                           ^~~~~~~~~~~~~~~~~
  test_utilities.c:372:27: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
    372 |         char *basename7 = semanage_basename("/");
        |                           ^~~~~~~~~~~~~~~~~

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/tests/test_utilities.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_utilities.c
index 70a76fe7..d5d56d94 100644
--- a/libsemanage/tests/test_utilities.c
+++ b/libsemanage/tests/test_utilities.c
@@ -354,21 +354,21 @@ static void test_slurp_file_filter(void)
 
 static void test_semanage_basename(void)
 {
-	char *basename1 = semanage_basename("/foo/bar");
+	const char *basename1 = semanage_basename("/foo/bar");
 	CU_ASSERT_STRING_EQUAL(basename1, "bar");
 
-	char *basename2 = semanage_basename("/foo/bar/");
+	const char *basename2 = semanage_basename("/foo/bar/");
 	CU_ASSERT_STRING_EQUAL(basename2, "");
 
-	char *basename3 = semanage_basename("/foo.bar");
+	const char *basename3 = semanage_basename("/foo.bar");
 	CU_ASSERT_STRING_EQUAL(basename3, "foo.bar");
 
-	char *basename5 = semanage_basename(".");
+	const char *basename5 = semanage_basename(".");
 	CU_ASSERT_STRING_EQUAL(basename5, ".");
 
-	char *basename6 = semanage_basename("");
+	const char *basename6 = semanage_basename("");
 	CU_ASSERT_STRING_EQUAL(basename6, "");
 
-	char *basename7 = semanage_basename("/");
+	const char *basename7 = semanage_basename("/");
 	CU_ASSERT_STRING_EQUAL(basename7, "");
 }
-- 
2.54.0

