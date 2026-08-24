Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA3383329
	for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595784; cv=none; b=l7oq2pJgjlTp0wcx+o559+Z4WXf5biyRoLTW+nNxhfilEqW1iT3bQhTzEHYYacZgcr8zbfEswgTdNoemaZkZaqZu7/1cOFrgEFcxBhAapmA1czqi/ahmICwt3Iqd6MNCUJAmVhvbhQwYtFJY+FMrLcMgKrQ2YfkM8AL6uGqv4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595784; c=relaxed/simple;
	bh=F70ZF+yuZIw8C89iy3ZlkzczHHUcTwUAmDCDgeJwZJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUlhJbnhyUOrnmgLRl6p9sVDNPJNhgh8XMA9s/93JyTHyT05naLRcVZL84AgEDELbZwadtiDVcQjdsNIJUyefEEpnQu1P0+q9+e/7bhxujwzX6+aeZz3Xic3CE6Osv7L+KHAtg+CQ3YzbL4w2W+Io6+FdU+uKf8iv0jg1ieaQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqtWU4Z8; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqtWU4Z8"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9063b380982so44640006d6.0
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787595782; x=1788200582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2qgl26Pj5FV0kJ12O782xWixUejVSveDUG/IKvXxzYQ=;
        b=fqtWU4Z8Ke085ygemARa3mG0Kx4PX4U0R9qlKzlYjvWCsLoLlqmCkFAyLRvqc0sGMx
         WXGQYf5LO65VzPCVrttirQxAk8NUMeMNEGYo3szRkgjyhXe4f9iDAPPZylUwufol2LvW
         5gY7CK230GTBkszCJtmUUBFhCeTafZ2nX/b9OOwYW3okKoRh7dRh5pijN12C+CioDITe
         Pn6QpgUIOZ7pEYFENLMS0ayVkZ1xS6ePi4MKPy2Cq1xbtadZL97nahHRpnspjMNozSDH
         8HO6Q0x34xIEVsWa/W2SAY1/SQREKCYu5FImb0l14E7et3dRDw/ushgxg0qBCFO8HNUk
         4d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787595782; x=1788200582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2qgl26Pj5FV0kJ12O782xWixUejVSveDUG/IKvXxzYQ=;
        b=MR3WSn909iNBx8A9v9f/EMn11HrjbulDvJq71TjhZkQeY65/ZaeRiaXYEUKyrAusu6
         ISLeEZU7AwPldacnMOTUXs8EsmUP+7wILL/efxxhZa2gPTbLian27Cup5xzDX0CQB6ZP
         GuGdtYek1x9WL3+zC3Qmv9zvDzpaRFYWLWGlgFzdCOFPjfq9yYz+nhxCFe/lBTi9WjIw
         GXICTHCBEPkdEJ5MMP9uocsyGk88INDkjanrOAN+3iAvFx6AP4qqCllh/gjBj+i+BNga
         Qd3vKlBgOwofMYoIvUUmUy/3T6fiba0m/IoI1Qh4vVKoOJSBNQSqlGjaa9YXvyBbmXs0
         eOOA==
X-Gm-Message-State: AFuF++nIMUQZy+nt6+1gObPRb79Ywt3KpC5lTsKk+w73U0Ar02WBBjgR
	N3e+hjeb//RaIIqb2Kr6y9wFCgPTQO3flT7iPk1AN9eHpu8jmtBMobQ7n7SHqQ==
X-Gm-Gg: AR+sD11OEEc3TO0Gg5HUWWa7enz8a+ec1oVN5dr28inI5FHTtVibVa1jGNNa28YMG8G
	zPcEp01Almw0WVHMuegApXK6rFjXmmC8uG3YaoiJ9kc4YWZQ9Oonpkvk04a68N/ZwF4QYYyZVve
	iqIKe3pnjQ2gaYYmCZTFpXBMVD8BgJAxSMC/2j1aDaFqj6gkiz3R9uOguzYa+ME9xkM+Bi9plV5
	E4Kmj2F/0uSkt0n4vhYcxtUYqK5ooSzA+xCUh4l/kHOTTFKu60v8GDGNg13/QFm9zgCt7dCOmmw
	28fJaRKeBgntaE6CY9konT1+YmadfzCL6s1vcgFFjC4qbbOfq3sLruejgiIuirLITeN1sj1+IGU
	T84XdyJRpjHQPoSdUJMvzTICEA4bMNkquYxtPgwbsmwm2KX43LzubVIhgFhP4bS8yicQVmmm7r+
	dwlM0jx8fWKcWxoSb+UxunTjVIYCW7WrXgVRL9e0LkKgVzJdUK1uNlkgGZhrsG+NkiS061e3nM+
	/JCd0wbe3rLp4cVGhI1dG10GmlB0Lyn9/Zt5PrAA0PxfWEBKPkmroZtadSPFIjduOxSEQ1Lv/g=
X-Received: by 2002:a05:6214:438a:b0:8ef:ea2a:2728 with SMTP id 6a1803df08f44-90c8f9f6e1emr238439736d6.19.1787595781721;
        Mon, 24 Aug 2026 11:23:01 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c935e228asm68499126d6.1.2026.08.24.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:23:01 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] checkpolicy-fuzzer: do not abort on invalid policies or other errors during conversion
Date: Mon, 24 Aug 2026 14:21:34 -0400
Message-ID: <20260824182133.75452-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of the fuzzer is to detect crashes on the fuzzer inputs,
not to detect invalid policies or other conversion errors.
checkpolicy itself does not call policydb_validate() before writing
the binary policy, so an error at that point is not a checkpolicy
failure.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
This was motivated by https://issues.oss-fuzz.com/issues/550672317
which is aborting on policydb_validate() error. I am not entirely
clear on exactly how that is happening but I don't think it is
what we want from the fuzzer.

 checkpolicy/fuzz/checkpolicy-fuzzer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index 401f24e3..9fa0bd6c 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -250,26 +250,26 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 
 	if (policydb_validate(NULL, finalpolicydb))
 		/* never generate an invalid policy */
-		abort();
+		goto exit;
 
 	devnull = fopen("/dev/null", "we");
 	if (devnull == NULL)
 		goto exit;
 
 	if (write_binary_policy(devnull, finalpolicydb))
-		abort();
+		goto exit;
 
 	if (finalpolicydb->policy_type == POLICY_KERN &&
 	    sepol_kernel_policydb_to_conf(devnull, finalpolicydb))
-		abort();
+		goto exit;
 
 	if (finalpolicydb->policy_type == POLICY_KERN &&
 	    sepol_kernel_policydb_to_cil(devnull, finalpolicydb))
-		abort();
+		goto exit;
 
 	if (finalpolicydb->policy_type == POLICY_MOD &&
 	    sepol_module_policydb_to_cil(devnull, finalpolicydb, /*linked=*/0))
-		abort();
+		goto exit;
 
 exit:
 	if (devnull != NULL)
-- 
2.55.0

