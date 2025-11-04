Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB3D27E
	for <selinux@vger.kernel.org>; Tue,  4 Nov 2025 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289574; cv=none; b=kzQBqyQn3APvySBcEBd1iUaJ4SmBepriM25CQDbagwQqooRkqV+5vhKVQmDrqo70TO0pD3wH71TyW0qhL/6LCBW4fExYphoCTsjjO+ZQzTCxO4upfJiMnZ0n2U69kx54XwATT7HdtGIBN0DoMMtZnQH72oQhtSfzbEj0iHNDgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289574; c=relaxed/simple;
	bh=tA/NcVIhlQA7j01gl0rreKbv62JnSFKwH5xWB1hNiG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2rJGL9Du4c+yIhK1M+ISWamLbsMxzkEgZNCmLbjMBp+/0Xf0Q2psvmyrTYThhxn3TS/H7MQwp8YAQbHWHozjYOl6ttWygFRE7ce9VNJU9zBFoQN/UDFH2jVYoC76E26WXYKCFYP3PhsKyDFNZJ3ufyxmIV7FTwMXRe4diYtvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZIF8cX1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZIF8cX1"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed101e8496so42443161cf.2
        for <selinux@vger.kernel.org>; Tue, 04 Nov 2025 12:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762289572; x=1762894372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUHL42eYOgngXxcIiI9xOFgn78lUVby72O1VBywdQns=;
        b=CZIF8cX152tMLQaTW1sF22Y5tTPygzLnrpVN/fws0/Iqg1Sn/BL20SKZ2EZN5cvz7S
         sFiabcjB1z/m1nzoYvebryHkm0n99rMZrXPFF38tKYx6nT1hYGaAAEVzQ8QPoYaXN90Z
         EsyjIASNPXcB9iAFhCtLJcNO3mThWyXBycSQgZgo77bLBKHEsP+8tCIJg/pOlqckhH9k
         imwGmFsqBgVPQSWCdsyM1Az7Sz5HmJHQVp0rNuQxYxM+Bl7AiaiN645giYLiWDKxlIg1
         WAMKZoYrZO9kT6NwgBfBtgYVXMFE9nNYfxNAomzcd0W4o2h3XKrRlQs9EA0fZNqHBg3U
         rZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762289572; x=1762894372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUHL42eYOgngXxcIiI9xOFgn78lUVby72O1VBywdQns=;
        b=tMcVZLKmWfGv8zbMiFqIFQ8p4ZpdxK7SHRjmCw5Y2rgBLssTlkYyCxCRkKCq2UKD9V
         ZFnAYzcvaXJ5PuCJmzLLnd4/SV4acS/NqEcK2xBkH++AhokSHcJ9XxaWIK86DZS/7KX2
         /g/PvS4sR74/OWviJflTJ6o+rcTaEFFX4h5UgeVt5zsQCWIIah0UoaRX35gugkg/iV/i
         w6mD2GxP2GoQJ406acTXk1ku66DJ4APgjT0oDIVn6X6DWRHsttNHy3IDawqZrK4f+vcn
         GCFiy2LMGr01KE/Bfhk1K0mB+Ckg9Wsyw+0zgqvGIV0V6tGEZEwr5IRZOkjG9UG9QU2j
         J1kg==
X-Gm-Message-State: AOJu0Yzfdpvu05RKIRoP05vOcVF8Q2MYc0cJdWS7BguwDG2lsy5sETxH
	kmAv9spRsGHo3yen5Es+93GOdV60n3APR+J7GHaCkN8if/NuSOgFVXCgeSsRHw==
X-Gm-Gg: ASbGncuFz7zF9GHwHnrtRFlM1t1cEaJcCgj/EHa86riSc5uJFsW8LImjbzz4qLK2pEC
	M0Y1RU1r/q7MzhDe/8rwB4ZgZiVht6dHkecvjTUWPlAqluKYgzkIi6Wltji+a0jZT3ww36deP4V
	Xq34UUuK6hURAHCbYCIK5o3XyH7S20R/GlCjQJ889rF8Inly8MLFCUi2D5DXUw4vD5JsiA4l9Q5
	fcFEw+UArtIug5hAnyBCLdCp9Tj9QkWu1BVjYeRdQjPGc0rxDu3Tr1iqGRoynQ6Vqne7G52u1jv
	5ozVarKu4KoG9rb89WHndkya+vJosv5Mj+MDYI/OiqvAHDBaZQhH3/HtuYJRXcmkcqAOCnzqtQH
	UO+lN4i+RFJ3Dx223DTGBFdnM7ua60zkxZ0QaaVUj9oLTJgZW9IfGd6+CzIj1ZPgOnn3GHDQf0+
	FZRnF9HLAil6ChiwfGFIo=
X-Google-Smtp-Source: AGHT+IHbjXCEQw6d+kUO9n7Xg8UAhR/nRJv89MVJ4n4QXSEA49fBub+sZLSnqkAacbKbrcrmBBVXXQ==
X-Received: by 2002:a05:622a:248e:b0:4eb:a27b:b47c with SMTP id d75a77b69052e-4ed726381b2mr12208501cf.80.1762289571919;
        Tue, 04 Nov 2025 12:52:51 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fbe2c2fsm23472791cf.21.2025.11.04.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 12:52:51 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	russell@coker.com.au,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] checkpolicy/tests: Modify tests to check handling of initial sids
Date: Tue,  4 Nov 2025 15:52:36 -0500
Message-ID: <20251104205236.60931-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251104205236.60931-1-jwcart2@gmail.com>
References: <20251104205236.60931-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For policy_allonce.conf and policy_allonce_xen.conf declare the
first three initial sids, but only assign a context to the first
and third. This will cause the second initial sid to be dropped
from the binary policy and cause the handling of a gap in the
initial sids to be tested.

Update the expected and expected_opt policies to reflect the new
expected resulting policies.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/tests/policy_allonce.conf                  | 3 +++
 checkpolicy/tests/policy_allonce.expected.conf         | 3 +++
 checkpolicy/tests/policy_allonce.expected_opt.conf     | 3 +++
 checkpolicy/tests/policy_allonce_xen.conf              | 3 +++
 checkpolicy/tests/policy_allonce_xen.expected.conf     | 3 +++
 checkpolicy/tests/policy_allonce_xen.expected_opt.conf | 3 +++
 6 files changed, 18 insertions(+)

diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/policy_allonce.conf
index 4b1edb4f..5e09f74b 100644
--- a/checkpolicy/tests/policy_allonce.conf
+++ b/checkpolicy/tests/policy_allonce.conf
@@ -7,6 +7,8 @@ class dir
 class file
 class process
 sid kernel
+sid security
+sid unlabeled
 common COMMON1 { CPERM1 }
 class CLASS1 { PERM1 ioctl }
 class CLASS2 inherits COMMON1
@@ -64,6 +66,7 @@ constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
 # sameuser will be turned into (u1 == u2)
 validatetrans CLASS2 sameuser and t3 == ATTR1;
 sid kernel USER1:ROLE1:TYPE1
+sid unlabeled USER1:ROLE1:TYPE1
 # fscon statements are not dumped
 fscon 2 3 USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 fs_use_xattr btrfs USER1:ROLE1:TYPE1;
diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy/tests/policy_allonce.expected.conf
index 17eff98c..a88d8785 100644
--- a/checkpolicy/tests/policy_allonce.expected.conf
+++ b/checkpolicy/tests/policy_allonce.expected.conf
@@ -7,6 +7,8 @@ class dir
 class file
 class process
 sid kernel
+sid security
+sid unlabeled
 common COMMON1 { CPERM1 }
 class CLASS1 { PERM1 ioctl }
 class CLASS2 inherits COMMON1
@@ -72,6 +74,7 @@ user USER1 roles ROLE1;
 constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
 validatetrans CLASS2 (u1 == u2 and t3 == ATTR1);
 sid kernel USER1:ROLE1:TYPE1
+sid unlabeled USER1:ROLE1:TYPE1
 fs_use_xattr btrfs USER1:ROLE1:TYPE1;
 fs_use_trans devpts USER1:ROLE1:TYPE1;
 fs_use_task pipefs USER1:ROLE1:TYPE1;
diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpolicy/tests/policy_allonce.expected_opt.conf
index 6b0f73fe..3d21c310 100644
--- a/checkpolicy/tests/policy_allonce.expected_opt.conf
+++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
@@ -7,6 +7,8 @@ class dir
 class file
 class process
 sid kernel
+sid security
+sid unlabeled
 common COMMON1 { CPERM1 }
 class CLASS1 { PERM1 ioctl }
 class CLASS2 inherits COMMON1
@@ -72,6 +74,7 @@ user USER1 roles ROLE1;
 constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
 validatetrans CLASS2 (u1 == u2 and t3 == ATTR1);
 sid kernel USER1:ROLE1:TYPE1
+sid unlabeled USER1:ROLE1:TYPE1
 fs_use_xattr btrfs USER1:ROLE1:TYPE1;
 fs_use_trans devpts USER1:ROLE1:TYPE1;
 fs_use_task pipefs USER1:ROLE1:TYPE1;
diff --git a/checkpolicy/tests/policy_allonce_xen.conf b/checkpolicy/tests/policy_allonce_xen.conf
index 6402683a..dfdf979f 100644
--- a/checkpolicy/tests/policy_allonce_xen.conf
+++ b/checkpolicy/tests/policy_allonce_xen.conf
@@ -6,6 +6,8 @@ class dir
 class file
 class process
 sid kernel
+sid dom0
+sid domio
 common COMMON1 { CPERM1 }
 class CLASS1 { PERM1 }
 class CLASS2 inherits COMMON1
@@ -53,6 +55,7 @@ user USER1 roles ROLE1;
 constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
 validatetrans CLASS2 sameuser and t3 == ATTR1;
 sid kernel USER1:ROLE1:TYPE1
+sid domio USER1:ROLE1:TYPE1
 pirqcon 13 USER1:ROLE1:TYPE1
 iomemcon 13 USER1:ROLE1:TYPE1
 iomemcon 23-31 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce_xen.expected.conf b/checkpolicy/tests/policy_allonce_xen.expected.conf
index a4573ccb..e72517f4 100644
--- a/checkpolicy/tests/policy_allonce_xen.expected.conf
+++ b/checkpolicy/tests/policy_allonce_xen.expected.conf
@@ -6,6 +6,8 @@ class dir
 class file
 class process
 sid xen
+sid dom0
+sid domio
 common COMMON1 { CPERM1 }
 class CLASS1 { PERM1 }
 class CLASS2 inherits COMMON1
@@ -56,6 +58,7 @@ user USER1 roles ROLE1;
 constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
 validatetrans CLASS2 (u1 == u2 and t3 == ATTR1);
 sid xen USER1:ROLE1:TYPE1
+sid domio USER1:ROLE1:TYPE1
 pirqcon 13 USER1:ROLE1:TYPE1
 iomemcon 0xd USER1:ROLE1:TYPE1
 iomemcon 0x17-0x1f USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce_xen.expected_opt.conf b/checkpolicy/tests/policy_allonce_xen.expected_opt.conf
index 8fd3b226..932ff1f8 100644
--- a/checkpolicy/tests/policy_allonce_xen.expected_opt.conf
+++ b/checkpolicy/tests/policy_allonce_xen.expected_opt.conf
@@ -6,6 +6,8 @@ class dir
 class file
 class process
 sid xen
+sid dom0
+sid domio
 common COMMON1 { CPERM1 }
 class CLASS1 { PERM1 }
 class CLASS2 inherits COMMON1
@@ -52,6 +54,7 @@ user USER1 roles ROLE1;
 constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
 validatetrans CLASS2 (u1 == u2 and t3 == ATTR1);
 sid xen USER1:ROLE1:TYPE1
+sid domio USER1:ROLE1:TYPE1
 pirqcon 13 USER1:ROLE1:TYPE1
 iomemcon 0xd USER1:ROLE1:TYPE1
 iomemcon 0x17-0x1f USER1:ROLE1:TYPE1
-- 
2.50.0

