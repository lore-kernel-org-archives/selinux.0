Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753F3806DA
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025745; cv=none; b=JQjEC5F5UZXpwoJFnnDw8h9JXwa44x4mzc7kJf+Sdv0Qe8d8DdkOmOANsNhyXfsGqdHFgqRdism/tBa71pk4kvyPEs3tdMInNxS90GmNWJnblWjcWQf7k5Prz97xybuh2qCu5rzcnR49weuZj+qrlFZNEjeSGHiFmJc7rYQZ+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025745; c=relaxed/simple;
	bh=8ZtRdF4LXJTgWDkeqck/69t/HQtYzVqSPoLs/cwPFNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvgX7tcBdikaDLX/PIZsBPJH+ITTx+jU7IctHjeDrDA93sy0IkSY5ANtNMmd8C9xQ9kTiHCdC1eWnXhMuukFNvnkMOB0GvdF+mbUJ88T5rIG7HIlCs1xaLtMipDT9Us0v4unGKvJgFS/aTWKpuHJg4gYzJB7r3vGFmhxsTYoWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HF1Lusyk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF1Lusyk"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e7c6ec9dbso109155185a.0
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2026 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786025741; x=1786630541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vdQwzlRsVnAf3tRlHz+YMIBRDRVEEI8co9vWIq9v5nE=;
        b=HF1Lusyk+LAKb6FCOEdnCDX9G6nu2Cx6+oSEtEEutFbQUgVQobEGWWB6HJUP/nEOaN
         9v+PTtSSdn9XdWtf4cbViMjqbw4ZoAUzV8NnN6ZXI1yaIUKK4Ls8eTqlYoZkPwzeAH1K
         oLaRW3Ii5VDkmMsuYTa2klmd4Sf+P8DixTj1XkqbUyG7fGNnEa7Cr+/Rp1dAIMVVIY82
         6Y3b9GjIUoBU8jHOwQFxpK+bpcvusvK6zszNJoEhen+hv7O9inRQiYEzP08csfR4nWuY
         XhVQe6hgV1gAsBCnzmZAa+ip6EcLF5z3kJSH7O9Ujium2c6zNgrWDQXDhccUMwc53ckE
         JlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025741; x=1786630541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdQwzlRsVnAf3tRlHz+YMIBRDRVEEI8co9vWIq9v5nE=;
        b=doppOT4FvywSgDbpaaOSsCbQGjTETf50+6MaChMvPTbrIY38O+48pERqolFXTNo/eX
         8Dawn5UX5gUdbzGr0PpHyYCbhec6M6udwIFWAOpNMx6U0sjMnfOV76jI9n3ugfsFFST6
         v/02yEu6tgsR0sidyy53T9RpoVIgzDZLufQdQVUv1e9ZsydweW1tNoxSv7zlKjjuxIGz
         0e/TvGxPWhHeoAtilM5o4VgvORUbVTRhEPLf+G+XgNfls4WO6Dkr9Fn2i6a45A1ncemz
         v7lXE0nT5RHz9ZpLAyJByZpg6joEGtyl3oRIFHn155Oce3sLc0HwqWUpdx1XCQ5PbUm7
         B08Q==
X-Gm-Message-State: AOJu0YxVw4MQSK4jY8kVW2tPxKP8YQ8xKHXZqQCF1WPNMiCbqXTZC5xq
	gd5HL7RzcZJyUtJMlKoUKnyIOEJhGwe8jYRCO1X64JZA9pOeQOgDXKeEqIm2jg==
X-Gm-Gg: AR+sD12mW/ordIVG4Y5kdcCn95DJtASwjNRu7NME0nepTbP7/pznC0fqymKAMP5LLop
	Hoavsebjj0GgL1KVZnPoEbpaud835qsb0ORKX3U5gDRaxsa1UMM3A/pXsNDZ3Yt/2POD29bI2gs
	Xa3166XLPwC6R1GrGy0OYv/0C5mWMtA2BmlpfhOd6o4rDgwmFtLblKl9teCSeXnh3spZPbLQN1Z
	wt6/T9QEKIqe2RUpU5dX6Amdp7vVBXLQU14q0COt4aA8JnJkkUSRFDc8zU0E+mRFIahAlaCc2DS
	xc+zVYogHvj3klyiWgX2bLbT2V+4TAS4suibGUWeFGjMRR/YOeXrfuDGpABvVidNSfsc3Wnpm4O
	58PZkN/HW1ZJlc9oCYnA3hdHKDF8rpsFp07IYiH4cXzkpSe9fpHhYKnsOYSHW6xHn4yumZIfDvq
	FU11j4FDms9TA2R1jJB5pF9AJPtmjf/xer7YsrXUDeggOt+LLaQ2mpPgb8IWKfEE/2bog6T5BCX
	6PBl0kVoiCbnTNQE3x6N/3+2EZiN2MpsmP0bOvxZEDl+m4hr7gke5uX7sbWGXKt
X-Received: by 2002:a05:620a:4415:b0:92e:fe59:d619 with SMTP id af79cd13be357-93649104413mr1366033485a.10.1786025740986;
        Thu, 06 Aug 2026 07:15:40 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364ad38197sm400095185a.28.2026.08.06.07.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:15:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] checkpolicy-fuzzer: drop invalid assertion
Date: Thu,  6 Aug 2026 10:15:15 -0400
Message-ID: <20260806141514.101723-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checkpolicy-fuzzer has an invalid assertion; checkpolicy
intentionally tracks errors via policydb_errors and does not always
return non-zero from yyparse() if there were any errors during the
compilation.

Reported-by: oss-fuzz (issue 471491765)
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 removes both asserts.

 checkpolicy/fuzz/checkpolicy-fuzzer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index c58d10e9..401f24e3 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -106,8 +106,6 @@ static int read_source_policy(policydb_t *p, const uint8_t *data, size_t size)
 	}
 
 	rc = yyparse();
-	// TODO: drop global variable policydb_errors if proven to be redundant
-	assert(rc || !policydb_errors);
 	if (rc || policydb_errors) {
 		queue_destroy(id_queue);
 		fclose(yyin);
@@ -120,7 +118,6 @@ static int read_source_policy(policydb_t *p, const uint8_t *data, size_t size)
 	yyrestart(yyin);
 
 	rc = yyparse();
-	assert(rc || !policydb_errors);
 	if (rc || policydb_errors) {
 		queue_destroy(id_queue);
 		fclose(yyin);
-- 
2.55.0

