Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC19446AF
	for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169044; cv=none; b=Tu46wr3oyD/5Lg93EvSL+cjhxAkjSsDL0oOCWH3CiIXgDbSOciREVgL6YizDEHWND6T/BUje/e34Tu+iVyY8ns9Khm/RnW9rWn+C95ZXZ9xOaolIcddyxGa9gV45VjAOqUI5+aekolPCOZfQnjQ9sEibvEaHZMc/sp1VQ9Uih4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169044; c=relaxed/simple;
	bh=pA0n39FFKnPjsb/rZUrl0s7KTMCvg1zZFICntiW7faU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DK4A5mwZn2Zs54pD8/yNj9PhZ6oLW2Clh6k2XV7Mats+JkrKQQNVHk48Vv8AwGxhwXsGYogINnhz6ADvdtrvgRhOFoYcgzEZ9GznQfFZJxoh7d5ThyLYsNq+woujFcuaNs8C7YPIWNOWf5q1agvGng1HmQTawdbj97A04sKIwkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Q0Cs4voD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Q0Cs4voD"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a45b6fcd5e8so538291466b.1
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710169040; x=1710773840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gmtvx7LqOG/LXpuj5qmOVl/ShF5x4+OYKJoxYdnVXHA=;
        b=Q0Cs4voDjUQfJbfINQPgHztIF/QgwzF/H90idayM2I8hj+YLMLEKuW7qbq307jZ5vG
         EqtO9R/y46FPSvAlIXC24T/4g8ocrHS6t3Cwdbr+/8rarjHx13CyZU7ug+onj1VdwxS8
         jHHmpS9yVNHwn94PXVmkaCIj1KvTq1n5FAWSXP1Q7jkFHct9kwXZotRfwsWFEIP5ww/g
         /LmCofJOzraxyPordU76MtDx5BGfljXKBOg/XeGwivW0l6H+vcHD/aQliArcd7TSbayZ
         9CL+OxYLJoWrWgVcc00xjWaBnHWtcsKbWL01Lt6v48VN6ck1VQf6VfzfyQALtP/QANb5
         LQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710169040; x=1710773840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gmtvx7LqOG/LXpuj5qmOVl/ShF5x4+OYKJoxYdnVXHA=;
        b=Y4EZwdyAxMNFEdQDIUcYqxCe70QVeDMMomM1XjE1P09CBpO91wRQptRVkfdYz3+2AH
         015mTTmwEa6AMTv/ngsJG1q8Yc+JpdZtzm0yOFuwILQ5MpKILFRR0ULP6+ua+ofeQPik
         J/qrr9ojNFnVnGKRiT1A3DAY2UdVnVPJou44dpws825MwvTFm/p5Ub7N1Co9eGRFVqWs
         3qcWmZeMF+51NGOA1Zgbvq38EGhhrtZlEUXIgNqjKlkFUH4CGjCJxKMRvJiT2odSlH1I
         pr0m04hsSFB56Wi8rnApU8b9erpHfF3Kj+YXBugJ9VOKOSVGpCrIhNAhSM6sewCEPDjk
         uMPw==
X-Gm-Message-State: AOJu0YwO1gJaa+0gIK2f/KBFQsQDQ0VYBxxwzG+m+bhEcsOIBCgZPuw5
	X72OiH06DwVj6XsHUrVWLz5sKqzXZ+osclHxJ4c1BuZ6pdU4Q+a+hWQRykXi8Sg=
X-Google-Smtp-Source: AGHT+IGDMuE8mmtMv/IkRVXImkG6nzWu4yMgGtDeBOVQL6e3RdXfR34ehi3pL9dtGiHW86UTVwuAQg==
X-Received: by 2002:a17:906:6b86:b0:a46:3785:4adc with SMTP id l6-20020a1709066b8600b00a4637854adcmr742824ejr.57.1710169039836;
        Mon, 11 Mar 2024 07:57:19 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-112-075-004.95.112.pool.telefonica.de. [95.112.75.4])
        by smtp.gmail.com with ESMTPSA id r24-20020a170906549800b00a45a62e0ed0sm2945240ejo.98.2024.03.11.07.57.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:57:19 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/5] checkpolicy/fuzz: drop redundant notdefined check
Date: Mon, 11 Mar 2024 15:57:02 +0100
Message-ID: <20240311145706.34885-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The level_datum_t member notdefined is checked to be 1 during validation
and the fuzzer calls policydb_validate().
Drop the redundant check (as announced in the TODO).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/fuzz/checkpolicy-fuzzer.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index a3da0b57..f3a17cce 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -130,21 +130,6 @@ static int read_source_policy(policydb_t *p, const uint8_t *data, size_t size)
 	return 0;
 }
 
-static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *arg __attribute__ ((unused)))
-{
-	const level_datum_t *levdatum = (level_datum_t *) datum;
-
-	// TODO: drop member defined if proven to be always set
-	if (!levdatum->isalias && levdatum->notdefined) {
-		fprintf(stderr,
-			"Error:  sensitivity %s was not used in a level definition!\n",
-			key);
-		abort();
-	}
-
-	return 0;
-}
-
 static int write_binary_policy(FILE *outfp, policydb_t *p)
 {
 	struct policy_file pf;
@@ -198,8 +183,6 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	if (read_source_policy(&parsepolicydb, data, size))
 		goto exit;
 
-	(void) hashtab_map(parsepolicydb.p_levels.table, check_level, NULL);
-
 	if (parsepolicydb.policy_type == POLICY_BASE) {
 		if (link_modules(NULL, &parsepolicydb, NULL, 0, VERBOSE))
 			goto exit;
-- 
2.43.0

