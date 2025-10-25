Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA0270ED2
	for <selinux@vger.kernel.org>; Sat, 25 Oct 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761381578; cv=none; b=fWF5DbQK9R0DHlMISJwpyYvxJ+ZItEpXp4LmvBhKAAVbqvCsXPopf0ljbQtbdA6f3rOEGbnVrCMO74geJ4+Exi46EyQAnYWB/tJNd2FXoHgGuSxtECEXtCBBx/w0o6keuwUIUvpH2Xm8yiw3XXGv+eL5ZQzmd35n8sOHyjRK0Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761381578; c=relaxed/simple;
	bh=DKjC+2ZM+tJBKy7cL/OcuojJiwNu264S8C94L9QZQhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hquJ8mkg+Ek1mPCc8GJ31VlxEfx9V6N6QEfA1/Lztkyo1ddkVOvVZaZv7ZZ+IVamiO0hxujrLYP17I5vSd0Vxwf4wP4y6t9RJ+TBy+apCpmM1YKaTKgNWNtEyDU2AJksAq6Tx+P52DEvE4LR/Ltj8RsOM+ZQvZTVObbylhpu39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuCwoI07; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuCwoI07"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d83bf1077so125491066b.3
        for <selinux@vger.kernel.org>; Sat, 25 Oct 2025 01:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761381574; x=1761986374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3ARxdiCSWCi4/1AGi7iKA5m3Tp5GDauoRUTZs5Rgjo=;
        b=QuCwoI07o+6YBtprM6QCWZUnwbIQo6T0KqPOOVAlwA+Ay5DmTXqmlRnoI0CZJoFN4U
         ecStaDKWoCf06YLUw5RJfhMu3zMsFWeflsiP4Agj+IP0b9zHBSUzrN0zrxOIpl6m5anA
         oALBKUYV2Kpg+n4IfKstQec5T/t9Y9nRTiGmBsNl6nAO0A1YLjxTs33hZ8L6xxA/vu4g
         zUMe24CrUw77zsj42LRdB2AYaWgp8CzEzn/F8AGOzUIq1+Okuq1bre4q45/NcSvVsJ5e
         B4+OrstGRyu7imdVq98znimgzeBZtUbQypU5UXRu+wygJ2m4eiY6zQAbg8nlrMLp1sXY
         i9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761381574; x=1761986374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3ARxdiCSWCi4/1AGi7iKA5m3Tp5GDauoRUTZs5Rgjo=;
        b=RoAaxGd5d0nco85M78Ub8mMuxa43PtSX6lAHyo4DbO+pQub/xO0UVfA4zSSsP3LtHL
         xqosCfLyIdu1egzyQ1+BNe3MNwyixwVaKv2mK+QmotCNuuhRrmmzkMjdfJnWUHr5ljAg
         yU8P8NwOGf97ssIH9mr3E8C0hl8FXdptZeP0Zol2W5IjQ/nIo4FZ04kMAOVAZCJ6/Vyk
         K+X++ChhWdUvUjcJiZ8hSO0u8GdCraoeshS/7FqcgiCgfXKwgpLR4W8KCxyR4EKqR8H/
         LcjaVYXcdb7xXKjohViTvwrWrNDtv/yUyVxg2YiU89Z/v1L+H04egrr3u8FwuosGzWL1
         rnCQ==
X-Gm-Message-State: AOJu0Yz/JpGZakcy6yfHDfIGCadFf5kIMTo3zPo6r9Cl6yvsFSLObcjG
	DcreErQuJWEfna5Q+nV0m9v2U8ECKLwBaXrn5AD3dD1VNGvtw+asa1ze0DOleg==
X-Gm-Gg: ASbGncuhNDGBBRZeqFb6KMjlsnExoAJDeGJL3YBSxw93MKYA9XI1nfIETBW1l1iGx6D
	3OjsLHv5VYiwQ4OU1U6cEI9W+Q2u9wzB+96Pe2vMjOEOSdNo/zNfr+lOEWu2kV5JsVnkcwgl0Ev
	GlGkKdLyQUe9Degg7xQzQfujqM7Hsj19L3UIn3yFBMoeoPXyoeYcrS9Kn8FMUVbGeI7h9+6cUoV
	ytbMdxKtCa0j3/Mv7OtcyLeKDqT82SCd9CNAd9YO0l0Lwc6yeCbDkauT3tB2pyUeBvuRU+Ttt0T
	fdmBMYJpMIWPY978tDD8LI3RaomuswjDI/IsNlHUjXsS7p4ot+qZlN++UUZwqHgwVvJvbA++b5l
	I++EFKq274k53SdB3BN75sNSLWM9cnLscn7dXl0cSnWV53iYr+8iCivovTWspAL1exqluVyMI
X-Google-Smtp-Source: AGHT+IGCcv2T62YgaY020rLN/hlMjs+RWc7tegW5uPJQDCW2Nlo+RCFegpK0tlVtcHjHW1+/b1coNA==
X-Received: by 2002:a17:906:f589:b0:b04:61aa:6adc with SMTP id a640c23a62f3a-b647195b6c9mr3390147866b.7.1761381574334;
        Sat, 25 Oct 2025 01:39:34 -0700 (PDT)
Received: from graphite ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0e23sm1176894a12.35.2025.10.25.01.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 01:39:33 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] clang-format: add check-format workflow, update CONTRIBUTING.md
Date: Sat, 25 Oct 2025 09:39:16 +0100
Message-ID: <20251025083916.56013-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 .github/workflows/check-format.yml | 13 +++++++++++++
 CONTRIBUTING.md                    |  5 +++--
 2 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 .github/workflows/check-format.yml

diff --git a/.github/workflows/check-format.yml b/.github/workflows/check-format.yml
new file mode 100644
index 00000000..a15cec05
--- /dev/null
+++ b/.github/workflows/check-format.yml
@@ -0,0 +1,13 @@
+name: Check format
+
+on: [push, pull_request]
+
+jobs:
+  clang-format:
+    runs-on: ubuntu-latest
+
+    steps:
+      - uses: actions/checkout@v4
+
+      - name: check
+        run: make check-format
diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 7ec8cb0f..98467d5c 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -53,8 +53,9 @@ When preparing patches, please follow these guidelines:
 -   Separate large patches into logical patches
 -   Patch descriptions must end with your "Signed-off-by" line. This means your
     code meets the Developer's certificate of origin, see below.
--   C code should be formatted using clang-format, using the .clang-format
-    configuration file at the root of this repository.
+-   C code should be formatted with clang-format, using the .clang-format
+    configuration file at the root of this repository. The targets `format` and
+    `check-format` are provided by the top-level Makefile for convenience.
 
 When adding new, large features or tools it is best to discuss the
 design on the mailing list prior to submitting the patch.
-- 
2.51.0

