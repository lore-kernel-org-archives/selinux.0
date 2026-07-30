Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917693630BE
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422366; cv=none; b=iUbE/waS0irTCPzApVWKVvj+CAooBu1PzzWcZ29rwhP63okfNWP4rJn7CaQ+c2AiTD7za2aX8pevQf3X9Ht/b8FctOZpUpHqmAKz+1sBU2j0x+OBIGpZkrw9e/qYtJ6H0fSsf6wYMWAzjbT+jwl7+CfkAaqYH/n7Ww3HUblEgLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422366; c=relaxed/simple;
	bh=vtOVb7fBPFtI9tIK2KfmMCIAk/cSkWwlIBeizXjGKSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fA42wmYTM7hrSusf/OhBx4QnVQXvgC2gXYkQRj6isO5O1xViohwQjF1QuE6m6cEktmdGJKHXRbdmXya4miU4KGTMvvTwCNnPfQ2Ffdx2q9bB/4KwqFh6ILHWyJWiftB/j7+LYLTR33Rwkw5oyHfghhaGvkpRCj7wFv5daaNLKyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W78OytLq; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W78OytLq"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e85499ffbso183506685a.0
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785422364; x=1786027164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UIcSzyE+xYriQpUcYW/NngcmZde5BCmuoS6NsjfoDtk=;
        b=W78OytLqQwrAiXPSIEwX/ioZN8CG0x060vjtIsJQ2B7fq7DB+HHtCFNBAwKT46BK76
         GEFhDRHsq97ockQ4iqGi8VT5dOPQrnBNdaeIxpO8mOOT8iCE2fQmIk6TfSvk8+uyZee4
         NXktkuM/bCkesU+O0mOdWyFPxKB2qID0r3kg+Ew4AtTlhD+aKgYYgf3ORUcaF4BgGPwd
         YXr9CwDYM2frW0B9qdBWuL7nyx84xjYT+3sfXzMW6xzAqoSYv0SVtmjXPlFwPjFhY1l1
         +EUHdevFJr+iZG+unx4eqG127fv/4oY42tX7XUqzRqFyXG8m/jV1ptT+//9UkJEdHVo9
         g9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785422364; x=1786027164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UIcSzyE+xYriQpUcYW/NngcmZde5BCmuoS6NsjfoDtk=;
        b=IiSNqPbN9i6/+ct+lTzp7i0pZijy7fGbf1MbPgJ7KzBvX5lw8Nn7y/bW7c8zf+IG0h
         8L69cg+PIh7bjXYrGsD5Cvy0uQYSBEpOX0SUv2OPcK8oXsQJkH/akBe+ZZcw1WitGPHT
         OQFTcjR7GYLWWSmwA7Df5i2UNkbUG4Zv31UHkbr7r+7oCzOTojA7fbobSAb7w9AAxGHY
         t7aMm/GpLNwQyfdX5dSo1JvqX4ew6mzLC6BlwBPQEhtbsjDJecgsgzZYXlsiMju6QARq
         VyhgRoskBJ61mv/Wka5WfnMMiVWcos2rX93ezrbVF7JSswfrka/uV4IjQG/l1VIzYl57
         ZvMA==
X-Gm-Message-State: AOJu0YxyR82ipKgeMZazrGT+YJOP+H/qXZbXiU0AMSBiLBYK/GLDGabR
	StQfTXXMhlER5cAAAbScUVlfatwFmBmw3VqmDRKQk4B552TUTcCRCiTZQCSslg==
X-Gm-Gg: AR+sD10vZy465aLO8PQ8VX+X0Tx3fnpVJE4oFcSpu9WN51i1JCk2wwmB1d0aLcWkmbc
	phVxUFYYVrUjuEnEMZYqOq67/m0jQJZ9iQIWK7TIT+7sTV555/VtFZUBnUtZWUjpasJB4M6CkqA
	0OaqqsBkXkr4Sc0eCLl7I/9U96lyRZ+PGYmB13/L0VcMolj1xeSgUXCXkeqJ6gtIBx4bsIYONlt
	71IYqns2GT+ptp6t5Q3xFxxoAZ36Lktcj9BmKPQ6ckJetUPFupJTUSsHbSyhwufSrissJbLjIda
	IZI/gNxoAZ8mlexdZjuc6kxw1TI73LSG/u3I8SVRZbsltnRZzAaZ+vBXdYPYEiDl6DPuWkR5TiA
	0jTk0xmk+/MLf98v6kHQMI2JGZiNA9JmCc+a4uLaGVGV2HJTKLOyh/S9WAk9dK8cF304gB2Q3ZW
	Z2ZstFfmkHLXbIsroUBpBLEzKDCCU//FBRXupj9aaeP/MlPhnUwxGyMOlcxoijo2y/4j0v93O9A
	diY0mwR534=
X-Received: by 2002:a05:620a:a414:20b0:92f:196:209c with SMTP id af79cd13be357-93486ee9652mr219616085a.71.1785422364321;
        Thu, 30 Jul 2026 07:39:24 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3275216sm427801485a.18.2026.07.30.07.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:39:23 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/fuzz: Exercise module to CIL code when fuzzing
Date: Thu, 30 Jul 2026 10:39:11 -0400
Message-ID: <20260730143911.34320-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fuzzing a kernel policy both sepol_kernel_policydb_to_conf()
and sepol_kernel_policydb_to_cil() are called to test those parts
of the code base. Call sepol_module_policydb_to_cil() for base and
module policies to test that part of the code base.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/fuzz/binpolicy-fuzzer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-fuzzer.c
index c0d96d8f..fd9dec91 100644
--- a/libsepol/fuzz/binpolicy-fuzzer.c
+++ b/libsepol/fuzz/binpolicy-fuzzer.c
@@ -72,8 +72,12 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 
 		if (sepol_kernel_policydb_to_cil(devnull, &policydb))
 			abort();
+	} else {
+		if (sepol_module_policydb_to_cil(devnull, &policydb, 0))
+			abort();
+	}
 
-	} else if (policydb.policy_type == POLICY_BASE) {
+	if (policydb.policy_type == POLICY_BASE) {
 		if (link_modules(NULL, &policydb, NULL, 0, VERBOSE))
 			goto exit;
 
-- 
2.55.0

