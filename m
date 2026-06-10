Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAC356A12
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120407; cv=none; b=poKGOkwptw5ZzImO4QS3ftXk7pQQ0OilQeq5BHXv8i05+JLSaTz7rWqy+bybDQKLdYaDjOxj9QMf1jNJfEnIQDXnW0f+Fk8kuGW8+J/+mkGFNgXnFCU6P8EwIvW0pAFDUtWRn0XM8vEwA9+cWd/gVEoJ3fZd+ODEDDjj+SdcyJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120407; c=relaxed/simple;
	bh=hAUZrYX/Td7rHzTqNVmfhzbIuP3IeNBwI8nJv8LLMb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KI9Tin0XBr5SQhIpe/eDxhpLckIQw/+nRMw8gxIMUJJypfEzgtfoXSUlEg/2e18WNoydqhQblZLpQcBZXHnaOKsZCeXfVcR4zYGgIlOwZpd7GhEV+Kn6Lhhaj3RK3DAf8XsW2CsgzUbqG7GzO9TMVlCeE+UWiuvAJH5d6JqhN80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6B7X4qG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6B7X4qG"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-915671abde5so622494485a.3
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781120405; x=1781725205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvfWrBU3/3upio5x6QIqG5Mw3B7yNc1/Lz5CTs4Ifrw=;
        b=S6B7X4qGGDxABHW4TXCO7QxDOH+84j5+hwvWlLDQGDtiAQnYr1h4aAz6d77tdr8mg4
         xC5j4F2oQWifhiEmI+aXOMXXu6uBsZB9EXQil8sU0NwUkyH03/YiDfrinXuOBZQkXYsg
         2F4ZWdLvKLRR5yp3eEPUyVY6cctkIBzGkFCvLgA+7DTvjFajciTOwgsHXNQPYRGoscpK
         kvzlEAS57TsEic/flfK0926lRqF2drVnSMIBacI0YPG6f2pjnWJBA3GSjoqhZxvJMhOG
         xtD2KcfX7FycjhaELrbflgvj5dhQQpSUf8etrUP6SfHkLoQM6gj+ldeRloqW+3AElPhM
         O2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781120405; x=1781725205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvfWrBU3/3upio5x6QIqG5Mw3B7yNc1/Lz5CTs4Ifrw=;
        b=cUymu57qIeGdviz8GdSp3+1+iAVTvGVCXVeFv8eoIHDyG4EHReGnNQBvZqAwOHtJba
         mMgBkJ4fvBJSSufBaRFBeK52xf3RJa9dLVOJGVJvhbiYAnScrGLV76Q366N/o5qifHL3
         1GLSHvt98se7gMc2lCTXx7j8SqPxRJi06gCNEWfkX6cUI4ygG1hmIk/LquNc82mJprdz
         HUGWnL17Efwnw76xvvUHyvG/YJadLIc/yCap/gMfEwiIPUqi3cVRo/r9CDmWuB9ppD3a
         5iU0NwuHWascIUgCCu4BziM8sIA5hFi3G4GvL2AWo/M1GprJhd6sALZK4cb3+E/p5VL2
         U1RA==
X-Gm-Message-State: AOJu0YywBOlDyvR/n0Wk2P2Vke0BoGOCrTYVzpiVK5jfybgeWFRFrdn9
	salCj4296kY8EgS4eV9pcGg/f57gf8H0sGF9t5znd3Y2SXHVjhN2R8sWdnJ/tA==
X-Gm-Gg: Acq92OFK04zbYaoGYEipU5C1WflaKUCiDy66FCfBv11eiJDDd7pJ3+NOAwqfHsjQt5R
	e9lD6X/VPfPr2Y4zGwXfCNnBrkRJfrAGWita2ZVPrKWicQG3DsdEOnDSJubGXcs20kv5YDzlMwR
	2EqhIiKNBQBW4LjUOUMH2/JuP+/y1zXxLur0x0YBV/S9zQ8lYrIS7BPd9hrKilzF0G7tivVIEAi
	DtbNgtyy1vmh2QrJohyjV8VZgA3x3AdJknJ97CAtPmFCg0yvJYpTmUrs5kr6aTcuw0U/1/gdUJU
	5jP11Co2OH4ds01Gfzrt/x+dqKNa2LgDQQaLc9hM3yHkGvO7A3KMQ5TxXjz8bT9U6WRewYvfvFv
	H+BJf0vdgRKV5rtopZ1fy+3o2Fp1cqXAEHRajm48HqmUghPsFSNTkSjSWS5uTv+DYbVmTt8Vfk4
	brN2UB1SBH7wn1LXe/RKEGtsFgxVP0cp2N3mY3YIR21rJgFh8IfRY4td7UWSUHsKFQKMGRXHN2c
	LhogoWsJ6fc0mM63QxUyHopEsToVBk1ad6XcQ==
X-Received: by 2002:a05:620a:44d3:b0:910:87f4:9a26 with SMTP id af79cd13be357-915a9da30e3mr4572687585a.41.1781120404465;
        Wed, 10 Jun 2026 12:40:04 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00840dsm2744631685a.1.2026.06.10.12.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 12:40:04 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Pepper Gray <hello@peppergray.xyz>
Subject: [PATCH] libselinux: always provide matchpathcon_filespec_add64()
Date: Wed, 10 Jun 2026 15:39:45 -0400
Message-ID: <20260610193945.10035-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libselinux.map lists matchpathcon_filespec_add64 unconditionally but
the symbol is only defined when the public header renames
matchpathcon_filespec_add() to the 64 variant.

On musl and 64-bit glibc and USE_LFS=n, the rename macro does not
fire, so only the plain symbol is emitted and the version scripts
references an undefined one. GNU ld permits this, but lld defaults to
--no-undefined-version and fails the link.

Provide matchpathcon_filespec_add64() as a thin wrapper in every
configuration that doesn't produce it via the rename, so that the
symbol is always defined.

Fix: #512
Fix: #513

Fixes: 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
Reported-by: Pepper Gray <hello@peppergray.xyz>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/matchpathcon.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 2623e5dc..292ab7d9 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -299,7 +299,17 @@ int matchpathcon_filespec_add(unsigned long ino, int specind, const char *file)
 {
 	return matchpathcon_filespec_add64(ino, specind, file);
 }
-#elif (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64) || \
+#else
+
+extern int matchpathcon_filespec_add64(uint64_t ino, int specind,
+				       const char *file);
+
+int matchpathcon_filespec_add64(uint64_t ino, int specind, const char *file)
+{
+	return matchpathcon_filespec_add(ino, specind, file);
+}
+
+#if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64) || \
 	defined(__INO_T_MATCHES_INO64_T)
 
 static_assert(sizeof(uint64_t) == sizeof(ino_t), "inode size mismatch");
@@ -310,6 +320,8 @@ static_assert(sizeof(uint32_t) == sizeof(ino_t), "inode size mismatch");
 
 #endif
 
+#endif
+
 /*
  * Evaluate the association hash table distribution.
  */
-- 
2.54.0

