Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04714281357
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212096; cv=none; b=SvatVTki/h6v5U65Bshr2NBp53Q7VG/9r53p4xaJc0pKnw599+SMfQKDNZP6ZFgD9yedzQapgf2bMjxJjSSku0Invx4RistwO7tK8rSSU6sfmtQShhjdul/m9LbH9tNbekDd4dzOQD4+PPFkhceBzR3bG2gRgjqfEDPeb6bZuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212096; c=relaxed/simple;
	bh=I6ppTevKSz4qSPY3lg/Lq3qMQ5mFXCHTmhEYBYpMo6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYiWRuNFjZMLmFQlv584EU3JWqYrLq0Ed/p7lkoighuSRWlq8nkXF3I6zmV4Ro2ECkUItKy+sXLjygaQ5MLEEZ9Tvy5gPgNSj/6oYtRYKfE36b8DVsAC7SHBIdsuoGwgfWhK3J6kuaFDyuCdgc1M18oJCqsqisOPckP/RRsMKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dY69fvJr; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dY69fvJr"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e8706a6863so156557385a.3
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212094; x=1755816894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlbKJNVrnIuy1LKQSyFS71oHYCZmuhjOpIeXDddHJuk=;
        b=dY69fvJrLeBdvz0pi+Gpcn0trOlYv1towZI0HH3UrWkwofyqE+e+dVj3EPb4cidoK+
         Opy0j1SxlbhCEH819eQdaq/hAxPUnifsDOGZ1th2qcZMF20THQ4Um98SnCjbPoU4a32a
         BuhqY7T10d4GNGEa/grrCooVA6V+TJmP+D25LUpotaGaeik7L3R8TMX64PYuwuA86Bjd
         aE/pL6VOlaklEtg63cGe6Emfvng4wrN4Hy/KWSJALYEp5w38LAa2io3sqw98X4MOQgFC
         Zb26AwR8nwtTLM9yLBo6Yo9fUWwCRu6nWALDYhXjijDWqUYUfQhMLkssGIeq8WXtlyDH
         NYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212094; x=1755816894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlbKJNVrnIuy1LKQSyFS71oHYCZmuhjOpIeXDddHJuk=;
        b=l++c1G8Bce9B9I+SggtAKTGzZz5JARJcC56h7U9XHZWDQhh12UX3VBOz3H1mb+wTSl
         BrSR4fRezq02AvyyG/7webErWUqcXvk6Dy5xL5cyfslbAdAlPDeE52/nxu3DNRTPdlme
         sqLTd1oyKscpKRmY9yQL/tBmhCLFwzQ1HGFu7sSJBpRBmYzYu2IuCDJMmLYyExQUGYaH
         dkBU5uPiNSELJt4divRNfmgYsNm90H7vGD5p4LCnoLMCChHBi1Nch+Y4h3ZlgAu0UXrs
         zEYuowWUzMDV4qhNd4Ay4GedOQGKqWFrDuYm5Cago04M4qatU0mxUxtQC8uKGh9NKmiV
         jxbA==
X-Forwarded-Encrypted: i=1; AJvYcCWzGYwlgb0YVwB13ok5iq4r/cFaBdMnanS/NWF48vt/tP8uwPAvBN27wb4aA1bnFXkb9KCIu3l5@vger.kernel.org
X-Gm-Message-State: AOJu0YyafaLjA8TPWMF1cUioCqNDK9gqLoXN+XvNO+l9SrNXjfhj9H6g
	qeQ0ChJLTwZX299wMfPZF65v9ib4s3SIxrMvF78tD7I0TSPbW3o1uMZ5haUnWGHmlg==
X-Gm-Gg: ASbGnctBvbn9cGCWkwruTeYKKUhREQQaz2nTeimb7mtOgCuEXgdMOTEskBDJ5aUVUYS
	jy27TsJYVBy6nzRjRhyXwpL7UZbzMd0ak6BRTvzGGuhlTbxZ9xcX2zXMQvDgxO15E8v0X45h8jT
	IKbS348uxcyneFdE9o7O1HGljBVsKCmPPowhosCNr6D1ry8R0k+iWZOkXopXipd6wpHEtsSlcaB
	5qU1TGX0nlc/99SLTmxvG/OYW8u0PigPqIhP8uL55DGZXGPUABHpC6KJIn3hLLah1hWwTZ6kaox
	jmPX9bFj9m0r/GkrjCGSrwtdQDcu60yJOQ84mdPt7lQFS+FvGjQJQ3VEubIe0MX3DpDNGZirs9d
	SZxau9ztYrTzlqaoq/g2dNEE0LN1mEEaxsftLZesidR+TdSDMogLNAX+zkvFKOFoMRuE=
X-Google-Smtp-Source: AGHT+IGqgbWieF4Qa+ogfYBXO6K5bK3JKPfbrnEAi85ZWmUGuNrkMAbc32HQLhM9fzeLgV7UWwyuzg==
X-Received: by 2002:a05:620a:270b:b0:7e6:9a4f:a299 with SMTP id af79cd13be357-7e87041fe25mr710624385a.16.1755212094051;
        Thu, 14 Aug 2025 15:54:54 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b4f1afdsm42646785a.68.2025.08.14.15.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:52 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v3 27/34] tomoyo: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:36 -0400
Message-ID: <20250814225159.275901-63-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=paul@paul-moore.com; h=from:subject; bh=I6ppTevKSz4qSPY3lg/Lq3qMQ5mFXCHTmhEYBYpMo6U=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjkZjREpIWCuSqwTbW2LA6XsI/tTkqOKa1zE fnJ5aHe0h6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o5AAKCRDqIPLalzeJ c9auD/9uZ/dQQaC0bxAH4Bv8/Et+xXv32FkTYeUGaD1GEC6467HBs4Q0n9e9r45kZgg2pVA48tm ZrBt/sAJn67WCot8JV+SZZ1NwG8HVCWGhEJDdm+1Q3HPR/aaOKzrwweciEMd+jfbwd6JN0RLrNS FtxfHvySOZE0l9hKAPcAkwM7E7JMttI+4R38TBfHU8J0zoYhMWuj0bcuNaXhIQaVkZOdkhWKMJt 5JG0NYN4eh1YdzokrMC+siYctkdzMFgKAy+HjfPTE8rFpiUGFfvVZf+wDUpjZyuxEP5TU7F93Ek tpfgSUzfGmNIfRJhqRmxlDVmxZxLynpyuQfQXcIMJn1dJRHF0gO8zoMmmvdFV/le1AsOeSaB9tW d5sGF8ZNrHrzMaHiXBdFgY9Vlt8zV70wFB7mhmIzzLFglfXXxo/enMVACJkkuGNpQ5OPHFEQZpK TWfWKTvnsVxbjZSMDR41+O6hE9oQZB7IyG2uMEHCh1Ebgia9qskSOHTWKjzgk2VmZeNwi/nU7Xx 3zB4bG7p+fOPVS9tdyIy94PTQnGQOIlO0e1V3o+bFvuCkykEXc7yA34yIKXcAaD0SQ6GxHNb5L1 pO0C/ryNSZZel/6onKnzBoSAhj0QkbMxu6DqgOcbfuedvK5VzD7phWwqO7iN9lEWQh6sft9798f x+wCYHcDJQONnwQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/tomoyo/common.h        | 2 ++
 security/tomoyo/securityfs_if.c | 4 +---
 security/tomoyo/tomoyo.c        | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 0e8e2e959aef..3b2a97d10a5d 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -924,6 +924,8 @@ struct tomoyo_task {
 
 /********** Function prototypes. **********/
 
+int tomoyo_interface_init(void);
+
 bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
 				  const struct tomoyo_group *group);
 bool tomoyo_compare_number_union(const unsigned long value,
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 7e69747b2f77..33933645f5b9 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -233,7 +233,7 @@ static void __init tomoyo_create_entry(const char *name, const umode_t mode,
  *
  * Returns 0.
  */
-static int __init tomoyo_interface_init(void)
+int __init tomoyo_interface_init(void)
 {
 	struct tomoyo_domain_info *domain;
 	struct dentry *tomoyo_dir;
@@ -269,5 +269,3 @@ static int __init tomoyo_interface_init(void)
 	tomoyo_load_builtin_policy();
 	return 0;
 }
-
-fs_initcall(tomoyo_interface_init);
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index ed0f7b052a85..a015cf0c4a00 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -617,4 +617,5 @@ DEFINE_LSM(tomoyo) = {
 	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &tomoyo_blob_sizes,
 	.init = tomoyo_init,
+	.initcall_fs = tomoyo_interface_init,
 };
-- 
2.50.1

