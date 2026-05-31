Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209D2D94B0
	for <selinux@vger.kernel.org>; Sun, 31 May 2026 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780245498; cv=none; b=lLga7D9bDEVnwKcyvvbcOT3IfFUFR+AIFpzXVy08wvPc734QxpRX+RNk5MW6cNUQP85m/YD4m8T0UFfWNjMIKqP1KyIwVi3BQZPdeHOFlW+T+FeUW+pMZC2jDb+/+gLT0f8OOmPLTfroflfhE0c0Zcv+Uqvcx6Z/bdEP8j7XUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780245498; c=relaxed/simple;
	bh=RSEcsrU6zvUoCtuXGgsIxMcSXs3GzL8/ztXhAe6jMJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WgRnPZcHWAQib7sUvRuvY7GYFV5iYsEUcqW9PHcH12tIx1x1sZHGBkZTfl1l0bvKlxImnkZ3XYm79ZEsZ+1zWWtCBrmj8IgtkfGpzfKtUJ/mK2v+VjJZkeZkc2DhAY/W51bU55L5ecmzZZNlNmlxIm8rHVWPuEnW2wtcFTlfMZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=XR5Fr/ej; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="XR5Fr/ej"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0A841240027
	for <selinux@vger.kernel.org>; Sun, 31 May 2026 18:38:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1780245495; bh=qknQzWKJp9M664w0x6w9jJiXyEu0eJlvdrEk1qqEAHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=XR5Fr/ejIbeacbdi8Dfd2/A8Q5qRT65MQjcVa+Iu2vQnYWm346750ZOzwGIEkgep4
	 upwuyvGQAq9DYUcty6nD3kTA3LMvrSDJduNzmrWGhtd237qOBr5cnRjbMeQWmJ77o7
	 mHwuU5f19S4kcLQTRvITz87a4QsLGOF5W+hbwTV7jAFDqzIXMU7y7xjSDHOyNizytK
	 WCbQwfAk0QHISTNi0Jvdyv75NxEZzLy5riMsHBGMFIyeluMpDKPx1ujuTSCAR9EHtQ
	 n6zjH9/fgJbzqfym6FdVLpWcvWcwWGLxlvH0jeeVGCSdhYSOv/8IHv8dyCcQo9HNYu
	 fgD8Tjm+7Vm4w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gT2pG4Cqzz6twx;
	Sun, 31 May 2026 18:38:14 +0200 (CEST)
From: Rahul Sandhu <nvraxn@posteo.uk>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@posteo.uk>
Subject: [PATCH] libselinux: restorecon: add_exclude: validate directory before deref
Date: Sun, 31 May 2026 16:38:14 +0000
Message-ID: <20260531163723.683086-2-nvraxn@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=nvraxn@posteo.uk; h=from:subject; bh=RSEcsrU6zvUoCtuXGgsIxMcSXs3GzL8/ztXhAe6jMJQ=; b=owGbwMvMwCmc0Xus8aefgg/jabUkhiyZ5CMKr05YORjcPb9j7Qf7akXLUqMngpyu249fXnars vrht7tqHRtZGIQ5GSzFFFn272O7UfJ07u+jT153wMxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6 hkCGjhEDF6cATPXqRsaG64u3OmQ9rhSM+vLPpnjfggMpF170vbqrfsDmwQu9t4a/JZ5PWpZ8bsL CFdMNqucVtrt1M9bpGe7asNZ2gt7VKV9fRuxR6N6848SjSQziGgWL/6Yen9oYKRp/8qfTuaeyDC F5rHZ3uRcCAA==
X-Developer-Key: i=nvraxn@posteo.uk; a=openpgp; fpr=BFBE06D874E59DFBC5E4EB88688DC681F94E204C
Content-Transfer-Encoding: 8bit

Currently, the call to strcmp() with directory as an argument results
in directory being dereferenced before it is checked to be non-NULL.
Hence, move the validation of directory before the call to strcmp().

Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
---
 libselinux/src/selinux_restorecon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 69a53503..6a36de67 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -204,12 +204,6 @@ static int add_exclude(const char *directory, bool who)
 	size_t len = 0;
 	int i;
 
-	/* Check if already present. */
-	for (i = 0; i < exclude_count; i++) {
-		if (strcmp(directory, exclude_lst[i].directory) == 0)
-			return 0;
-	}
-
 	if (directory == NULL || directory[0] != '/') {
 		selinux_log(SELINUX_ERROR,
 			    "Full path required for exclude: %s.\n",
@@ -218,6 +212,12 @@ static int add_exclude(const char *directory, bool who)
 		return -1;
 	}
 
+	/* Check if already present. */
+	for (i = 0; i < exclude_count; i++) {
+		if (strcmp(directory, exclude_lst[i].directory) == 0)
+			return 0;
+	}
+
 	if (exclude_count >= INT_MAX - 1) {
 		selinux_log(SELINUX_ERROR, "Too many directory excludes: %d.\n", exclude_count);
 		errno = EOVERFLOW;
-- 
2.54.0

