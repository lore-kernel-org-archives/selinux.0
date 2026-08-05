Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03238DC47
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940592; cv=none; b=Vf0nV/1Y76OCqp1D0VCSuLtzt0ADla3xTy1klT7hTNpB7GBOX+KND1tgjwINjH/HYlYLeSt05D1YCSna+SJCqbKjYVpM/uvZ7pKgRk1aY4Ayjv2vLd5fu4lOhQk5Hzf3hFk4dhh0mDornjusaOgW7abIHOF82d/41nVMqkDRaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940592; c=relaxed/simple;
	bh=Ay/iRhx+29Eqc6lkDoWZgZ2DQwcih6BEF8DVyG3kt+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnKMONGTgiWTaIDO5YhXFO6E/e0sjcjgiGAhJO1N6xpGtJ67alJS7xU5br7m/lU7qjt+blEXOAm7LAS8hroo83baTqYkcoshMLpzX1TgVoDZz8heHMphH1eWDKVoetI2rSV7HWtqot8qYn17psnVSZ1Yy+BN5k3J13ZwB2eXdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIuj6K/c; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIuj6K/c"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8efef6533aaso6454526d6.0
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940581; x=1786545381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uXdSesiGWLr/O6mmf/Qg76mQ30R6lIf5Ae2IC7wWZ8Y=;
        b=dIuj6K/cOeLAYKYL9f1l0YKPQ5ApNfjqeZUc/5MSA4/fczssY+A0dV3Ni4OApmmfOm
         52HL18c3T5NdZ8X/OAVRwM2bvwUxgf8Lgyvz2CCVhqKdbY6tsOVpkfgUAPPFr/zUdDuS
         qxulNSpENY5lMpNdije07z+lLS8xRFUsvpGOwTs2xYenTSe7xh5FLoNMAJ+DAVWHTto1
         ufmrTAwhUzsr3pgmUw/L1zLIchbQBRwYL6ZfFhnJmSgL2U0GCoXgkukIevNOZMIli3vN
         2LxQIox9bZBCsFuKd5g/2lHK3OSsaPJCAZbAFvvwCZm3tmaGoHkX85tFH9yne1+MNVKU
         LKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940581; x=1786545381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXdSesiGWLr/O6mmf/Qg76mQ30R6lIf5Ae2IC7wWZ8Y=;
        b=F+XVqJGvzQ+/EapNI6m+ll1IU46evt0tAb5nofTZgxhqOVSPnqhjX+1Wx8YjBZ1T9l
         ySYHPprGyQPaXbFIy/KiKCyiRPT/pqfE/KB22QgIT8MmyHFumQGgb3gaXNWqzy9IaVZY
         F/ZJedlJlP5rJh7LGoULwMXkAMiPd5864wOa+pK/cu/CtxOyoEA9y9/F2BYLLcRaZPGM
         wx4llfRfuUc2BKf1eNBSQwRvAhCfCa508Z/Y6hwVPouaGJBIgUtyOak1vEfWoBjCtKUl
         vXCes4bgKqLi8BCJdUl+v82S82uX4WqOf5W0jRjtO0/KS5sYjmt8IbkfUWVdS9MZ14Au
         Kbcw==
X-Gm-Message-State: AOJu0YxVdqXnFtGuU19kr/AsErkzCPI1+iv5ExtUi1nrGS2f4tu8Pxri
	wKL96NofrIZYkxDMO2KCM2IPm+g6PNq/NEl9I7pvFJQmexuT2SBZakAcqzJITA==
X-Gm-Gg: AR+sD10bIJBzylc5fx99oRWcZL55lkzJ7vWIz4/tXgY9XsfO7KcYaZxjCcxTSGLHKSO
	wk3CzyEEeBu4Go6pgXobWebzHv18Yzj/f5WVSMEZPU2+/NxPAK0tM+4A4sg48EMH7nw0BQdZPFi
	RXeo97nVlWsZY2HdtYdTz1jY840+/I3wbkiQ/O59Hx5Sd2Fh2mpgtZgSjFw7Klp/dW5W5qyLj3M
	oOay5IpZmUpW/ntI3u23hEqvN5m3B2ZhuBDD//CsQg0xY4oRq4TwFTqd5cHjLSeBQw4CUMi7QcA
	zpXUPVZLN0dRxlenOHFiX5HLydsvrSJSa98KFBpTFbkzRwLjGCKFL/bxQgMU8SyoYXRa9Oinv0M
	xFQnT1Hw3pAonX00l0w0EN1GDqwnqDlNKoI9oZdfEoKs0+I42AQhgfCVvVvNb8l/4wJh5vdkOXr
	ww0/KP3y8PC8B7yTnumulMzXnIuH3kEGLVhaFU5WU/ONuY87WgxlAhLGl33eoC98XodkHnvtv+B
	hO0lmdtXRp1BwugyKFfrg==
X-Received: by 2002:a05:6214:2589:b0:907:52e3:1c63 with SMTP id 6a1803df08f44-90881380a5bmr75647136d6.20.1785940581277;
        Wed, 05 Aug 2026 07:36:21 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ff9d04csm28613636d6.3.2026.08.05.07.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:36:20 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol: Validate any levels that appear in a policy
Date: Wed,  5 Aug 2026 10:36:09 -0400
Message-ID: <20260805143609.6756-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Policy validation only validates levels for MLS policies, but it
is easy to create a non-mls policy with levels (just read the
policy in, change the "mls" field of the policydb to 0, and write
the policy out). A maliciously crafted non-mls policy could have
levels that cause an OOB access when processed.

Because of this, validate any levels that appear in any policy,
even if it is a non-mls policy.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: - Old subject line "libsepol: Non-mls polcies should not have any levels"
    no longer fits.
    - Don't differentiate between mls and non-mls policies just validate any
    levels that are in the policy

 libsepol/src/policydb_validate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index fc66a4c7..ea53da86 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1024,8 +1024,8 @@ static int validate_datum_array_entries(sepol_handle_t *handle,
 			&margs))
 		goto bad;
 
-	if (p->mls && hashtab_map(symtabs[SYM_LEVELS].table,
-				  validate_level_datum_wrapper, &margs))
+	if (hashtab_map(symtabs[SYM_LEVELS].table,
+			validate_level_datum_wrapper, &margs))
 		goto bad;
 
 	if (hashtab_map(symtabs[SYM_CATS].table, validate_datum,
-- 
2.55.0

