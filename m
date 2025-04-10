Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19DF1E98E0
	for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312623; cv=none; b=O4pQqV1ZltGqqFzK52se5eIwrf/M9Tcg2PlsQQBpRDGQlb2ZnrZo8iArRSCKVRjLKOtvj1/2BbEP8u/C2QDUhjJCkfG0jYct4tXDyO9r10BjPu9e4ulS0akidSVdjyIkrpgwehUUE61GNgPfkc8t9zj7pDtGREXwDiY+7ikAQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312623; c=relaxed/simple;
	bh=8MJWHae7JF1K6VLtTOzQyZhSb6A8slPWLxgD8PB87/I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DQwCTUYKiX5i9/1l8mrfHigKJYK9Y+uEcNSCWpYM38b1n1PQ0lN0AbUF486fsIj0Q/weOZosZpK9b4eM30bVgj+aC6N4sQIjDbi/VFp8+a/eU9s/C1WDy1dMkdgU9rQK+aIXM0tM9y+PZdkh24DtPP6pqTWU2efSrUJecqsvO0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Fuf4l7KI; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Fuf4l7KI"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so13425026d6.1
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744312620; x=1744917420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eaq6i8B5VdknLVzs0nUxfGXHu6PgjvKvVkcwpmOpm/4=;
        b=Fuf4l7KI22PmGH64nDzyXKHiHEIsnoo9ZSceH+WfbWnd20LQvQwk/CTNdzI1RB0t+x
         yK7+/XnhVwMhr8fLhi68ZJyLlCYUEeaUTIZcSUGC7c44yaTWyuqcEW58dI0dEDmS3T8j
         TFhQlPQPPXKRnG3eqQNXYpfCwKadniH33cu8dAbrGAuLsKoqjXN8qD2Q4P1xSEPd/wkh
         Ou0M1m+nIGVNjy7KLsC/+xYWHWOfLVFPknRLuluW8EkPoroN2B6ptoVc6OLv7O3Rl2rk
         HHR9UqFeCwBU+OD7mJzJm6gmBnKxAOJxQAPfIdpcCHOM9fYilxF3UYC7v7x4qgkEmgvx
         84DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744312620; x=1744917420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eaq6i8B5VdknLVzs0nUxfGXHu6PgjvKvVkcwpmOpm/4=;
        b=g/HyybnmP8H1pTmccoqs1r9lIDsEzYRL3amReuFM42Tyy4qPAgrAerd3B4QwsmxmaY
         EwBwM0Y+aKs9EATxZOCHvkUTPD6l1ItU2CHvCGGWZQTAsyyvoCanwgUMa579d4cJQ/JX
         yU/bruQwAKa5er4B7gArA0s3o5HnUzm1zl4qv2GyNwBzZwzhvJeG4p2WIl3+vWsqBp+X
         YYqlI5hZgVaSn3oNVtPxMPDvOzpbAKyN8cR2JTXp4DvZOhDAJei191HYWqISUbdJLaek
         G7hddekOmE+Ncd5SsRLXM/cQYeWRxRFOc6+pFZ1pBDpOzK6301/A0SD7jD9udeiSV6Hq
         XSoQ==
X-Gm-Message-State: AOJu0YySnR7W4n129GzFZ9J+cQoNkA0/9wf+odEtMq6JTyW32KuAtwr1
	uSm+I0RfCjtZJWv/SNRz5b4ShLO5OY2lMWD1TSiBM/1S354qlJ9hBnJpuFWLDWR2uG7DOO84Nw0
	=
X-Gm-Gg: ASbGncsKdBLJHBzx11/V2uPdngIOxgmU/OSEIncIKsnx69FnOzzE0SLBXhkv7f+nZPK
	ukoVFsmxCytywr92HHur7SN2z1A8Ou2YpPzUR3Jf5YWKeQuXvpqNIULu6xtEwEH/VKkoipjFEPC
	6euM4nmqMZTKhEcb/3eZA5z6Z1hXuPfphicJHTq3XP1SPQ/Z4NGZwzBhO7ZWGpVMydxPORjx6mf
	HzhqBFnKJcwVkMVrVV2AiOcGPOMI2zfo6mgMaDY/A5e4VMTwFKc1zOS/Hn/sEulFciN3gmO20Dk
	RPLA/vrXU5B7R7tD6eQp3g8WfIeV3Pgm91o9vQWMF/w2kJgBNAQO2K4UR2BxW29J6zTcm4qi6BB
	YmYYoDYnfdA==
X-Google-Smtp-Source: AGHT+IEiayFsFwUIQS9H0nFLYW8a7avG0OxeL8BuGvnHfk/KbDTWf/FOfUqDodgNei8UJy2o1Oj5SQ==
X-Received: by 2002:a05:6214:2486:b0:6ea:fac1:ef19 with SMTP id 6a1803df08f44-6f0e61852d0mr49959106d6.15.1744312620234;
        Thu, 10 Apr 2025 12:17:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea074bbsm25386276d6.70.2025.04.10.12.16.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 12:16:59 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux-testsuite: don't override PATH variable when running tests
Date: Thu, 10 Apr 2025 15:16:59 -0400
Message-ID: <20250410191659.255003-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a test system that requires a PATH different than what is
embedded into the test suite's Makefile.  While there is perhaps some
risk in using the caller's PATH in the test suite, given that this is
a test suite I expect that the caller would be aware of such risks.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index 35bb35871b48..7a6aace180db 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -184,7 +184,7 @@ all:
 
 test: all
 	chcon -R -t test_file_t .
-	@SUBDIRS="$(SUBDIRS)" PATH=/usr/bin:/bin:/usr/sbin:/sbin ./runtests.pl
+	@SUBDIRS="$(SUBDIRS)" ./runtests.pl
 
 clean:
 	@for subdir in $(SUBDIRS); do \
-- 
2.49.0

