Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6A23E342
	for <selinux@vger.kernel.org>; Tue,  8 Jul 2025 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008874; cv=none; b=pmGFg0/Ea4TSRfngePsjD8wB3CRlGefCVl7n1HGPlVB7a2CRy2FYF/VqrNCjOhienJW5J2wliAjACyHtAwiDi6HUCBicjAxe/i8Nvt18v0e0DFm5hhtcMEsWM8gAJAuP+MhTl9SFlpFh/BghtIKPPRD4wnxYcRTJ4FHWnPCsbnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008874; c=relaxed/simple;
	bh=wJS6ZfCd8ZhOCwK+ekgrfb59zrNleToshKTrmeb77dY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y0VnjFSzAMEMZLIzsi1Oz/0ajvhjBxI5cCsTOPt/OS7Lu/39z5XGK3HZox3vu6CGHb+XIekRZZC22yLgicOWRusXg83KYe+UYacJV6Png8fpBQnWXd564/4RmQ00TZCsvFlDghMUNJ7csON+XeJrIj/Dd9VDnbfYTCggJaoPK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Vegy8PnH; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Vegy8PnH"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d9f5bf544cso158743585a.0
        for <selinux@vger.kernel.org>; Tue, 08 Jul 2025 14:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752008869; x=1752613669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7MTpxYUBU/Kt5txFmgZQPXDj+NnElevOpq4M7ZGUeY=;
        b=Vegy8PnHgz0F9NjAI6C6JPUiNkhPCV5kFKMxMs3hD0QVWNyrsSxv3m4YrBZvH56utt
         b2lNhkH6mBlIJ2LbAniZ+s6p4iAdyN4kzlC5qllQZsemuazpxWKa8Vpw6MbUQ3Ym2SJ3
         yKPbsblZcRupVMFgYqiY4AdPFRFrmR+6ubfbWCKTMLAn/8tb+SxjvnKa9er1uyLmp1Wa
         7nG3y7heJvTAUH7anGf7qEtnKD4cpAo9JA28SedtPGnrmOb+0YwBhU95+kYWF8e7rZI4
         FZJcYLex0CH/ZE0T0JT1DybCYaGIppx4ZZsn+tvhejTvG9nQIo/MeZHTli76g8oWoIK9
         5xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752008869; x=1752613669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7MTpxYUBU/Kt5txFmgZQPXDj+NnElevOpq4M7ZGUeY=;
        b=gryikLAVxywqOvXsRu/DQdDQOp34vbcETFnsLqHXBmghV0B84qfbAz5t7bocqrp7oq
         bPM2jrlpQefqgbmh56LWc/iKD8a9HHKQSLZNJyy7yN2PDEzPuPk6WnfcPT3exE2h11QG
         fzsbPdTtMDYvfNujdlFwvox5XH/b8pfmzZKrTZdRc0NDLm7AMrtca8hv6uKaDPBsxiCa
         9RNGw570X9xVvT2h2KySXWCfUaL1iMMmJBxjOo1B6fpWD4/WUP8EugVW5GHvDKVULXjf
         uW/i4gIm/FRJ7iYhmwEbvRNSe4OUuH3bsu6tdYz5WZEQb98SsfaOzMXXn8DFTqxtYo6J
         Hl2w==
X-Gm-Message-State: AOJu0YwhvS/UVXPtXZC8sFOeR6zOSUioYAT1nsmNDjosOr5pMW1mZPeJ
	QgLZ0FGV730BrRJ5AaIUroO4+l1LMN9Mq15INfeCEYfs6uC7BMXRQdCgeh74DxUj4C7U1nLfMgH
	fryo=
X-Gm-Gg: ASbGncscp7UX3g3Xc3Z2Jrm/75AQRIcQ0x85CnaaDqMcqbtIkjZOIBws8SjhqmYIcKo
	zx3kK5tAS/lIiPA6jIaNyx0BQ+9LrImcfqS6pyHclp160aMt7P26GjGppzqqzpQcgoPs/u9mYJS
	pzXgGgLRCyx/WvW/GXSAzVSvEez3mO35SbgKennb5BvKwSIj8dT+hZIvmSYTd0fFriq9kQ1zCrV
	V8UyV9rzmt3txLv5u7B9h1s7nNW7OgTQiu77s4kzYGyPUHxZlwHaw3HrgEy+H9z4WagjOXnzAZd
	hY2W32bhYqwd79mNSxYMFGPIcNjaVNFzaWruK0gKw2bhY2ccZHDCKTTV7MY93NhLdKUozkZsW21
	a/ItHNLop2u6sNQkhw1F6ToKUYvh2LtA=
X-Google-Smtp-Source: AGHT+IGKRH7FG9yl3tTtAcHJwsBWyjVwxlFiUG9LT1XRuD68ZPjbqURG/ZVSK4eI1IFXiDGeUmNB6g==
X-Received: by 2002:a05:6214:485:b0:704:81a4:2847 with SMTP id 6a1803df08f44-7048b830c7fmr1197876d6.17.1752008869463;
        Tue, 08 Jul 2025 14:07:49 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-702c4ccd351sm82655206d6.34.2025.07.08.14.07.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:07:49 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] policy/test_secretmem.te: add anon_inode perms required in Linux v6.16-rc5
Date: Tue,  8 Jul 2025 17:07:48 -0400
Message-ID: <20250708210748.8782-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Linux v6.16-rc5 and commit cbe4134ea4bc
("fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass")
secretmem's anonymous inodes are no longer marked as S_PRIVATE which
means they are subject to a number of SELinux permission checks that
has been previously skipped.  This patch updates the test policy to
account for these new checks and allows for a clean test run on Linux
kernel builds with the above mentioned patch.

It is worth noting that there are still some capability/ipc_lock AVC
denials when running the secretmem tests, but granting access to
CAP_IPC_LOCK proved not to be strictly necessary for a clean test run so
those rules were omitted from this patch.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 policy/test_secretmem.te | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/policy/test_secretmem.te b/policy/test_secretmem.te
index 357f41dd7574..32cc78d01f67 100644
--- a/policy/test_secretmem.te
+++ b/policy/test_secretmem.te
@@ -13,12 +13,12 @@ testsuite_domain_type_minimal(test_nocreate_secretmem_t)
 # Domain allowed to create secret memory with the own domain type
 type test_create_secretmem_t;
 testsuite_domain_type_minimal(test_create_secretmem_t)
-allow test_create_secretmem_t self:anon_inode create;
+allow test_create_secretmem_t self:anon_inode { create map read write };
 
 # Domain allowed to create secret memory with the own domain type and allowed to map WX
 type test_create_wx_secretmem_t;
 testsuite_domain_type_minimal(test_create_wx_secretmem_t)
-allow test_create_wx_secretmem_t self:anon_inode create;
+allow test_create_wx_secretmem_t self:anon_inode { create map read write execute };
 allow test_create_wx_secretmem_t self:process execmem;
 
 # Domain not allowed to create secret memory via a type transition to a private type
@@ -30,4 +30,4 @@ type_transition test_nocreate_transition_secretmem_t test_nocreate_transition_se
 type test_create_transition_secretmem_t;
 testsuite_domain_type_minimal(test_create_transition_secretmem_t)
 type_transition test_create_transition_secretmem_t test_create_transition_secretmem_t:anon_inode test_secretmem_inode_t "[secretmem]";
-allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_inode create;
+allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_inode { create map read write };
-- 
2.50.0

