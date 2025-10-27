Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A81FDA82
	for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571825; cv=none; b=n0rtmsjHVTswj5BEI65EGvFvSZI40RQla8+lOYf/oiY0DAwgvDFbzkNdLorjv8U55NgW6wiauE4noKHJoFgFLygD8p4VtODgqxLJ7evgkwJaSJ7P4NGJwLlkNyt+AItWRGcMrJygRJF+qzzAp/suHobdjQ99YauuBFlJhVqR3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571825; c=relaxed/simple;
	bh=651dh116pfflQVStd/nTSxoV/oNwMTxr7ndzbhtWKIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXGsEQ1L/nEsDADV+uv2rztcKKPOyt0RxlCfoNZ2pIpRP170gNjG3K4TgVUFeupUYzixO+9PqnVj9yiJySh9QUg6QEzczQ5/ciMUCqHAwR6MXEZVvkphhVejaWExqUo17CIpLVZjCqHVCe5vUXyGpye4tmKuIoN3qNvYSATSNcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1u450Lq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1u450Lq"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so877788366b.1
        for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761571821; x=1762176621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMgEmndEgqbjuTCWt9pky0TqXAO+s1A7rEsnTL+Lesg=;
        b=H1u450LqJ0Fe98BAEnHI/s8j2NSR75ElTBPix61eh+5NhCKEYWti8/vug3NFsheqrP
         h5CgrzWtAPMc3SfRoIeTVjJCQM7R/X1wvGF0twBuDPCMOZsYZ1VSHBajZRwulKUwReMp
         To5QypP7PbZNn2lqhhkQOiOrPynAmx8RbJxMTUiak+gkxmB83J9bhwszRCFoa6cDW/KH
         pgmor7nb24EWpjxfShbtAz1Zbw0YMJkF4uAF/wM3eYTaiCoivJQ4dJCb3CREG1H1lrwk
         CMKKtv6jAOGo52ESjL5mOqywStQVI4HvTwDbWAnH1ehBU/rfN+UyXyU8b+Qt/okYOIBv
         zHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571821; x=1762176621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMgEmndEgqbjuTCWt9pky0TqXAO+s1A7rEsnTL+Lesg=;
        b=FYPaMj8HDCvTtStNaQCDWnJ8bb5GOcN4naWYW3pQAL+bz4QjXrrFHHynqw4s/UvsWO
         3GOlxcTkfP6W5O8O/CmnPyin5F/oqAp2oqoBOLPZW4kGpjUOn1Srfafc4jlN5WbytjCY
         JYOef/pBRW59X8N6F8UyKIYWl5IVp0oXXRIvy0gEeJdRdk8wt7doZr1RFEZ54gsbVEvn
         epenjvdDLmJiRJwLSqT6JUY+cVfmaAgogRWCiL1SNRNtoqcsvFFn0xOeJ0yi1PdFFTBt
         Axdyv9myXitXNLgD3dLGla03mmNsYWHAUvaoqISYGIqv5XSkecbst9XOFzxyi5VyK6Bk
         nrmg==
X-Forwarded-Encrypted: i=1; AJvYcCULj5+9NsxsW4UnbkV52UwD8R0MGO2U4KGsJWkQsvGMVY+2P7LmN2QYMsopMBnl1hdiigFJ+NWO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1aeQKZwD+9KRFJQgx8qT/wxIO8C78N8O5g4uM24GaUF4zvOsm
	QWsesqtAZiOWy6HbzDysY0R7OLY10uSXkEpJedh8losPd5/C7VewwYcQ
X-Gm-Gg: ASbGncvzlvNtD74B3Ii5Rt3ICULT+cO4f0E+mNEHdDsU/wAfBXaFj8YhfTOls2kQvJ5
	YMs4dEwR8Av6n1WqIc31Cew2+DyAZdY2nB2BJkZMjKs3w2wVJfCD8GCSWd9/53JtNFjWPE6aMNK
	C7Ef5CB7ZMME01oDyHo6CyEaARLrThzgIEdbiZYunccDheUASNbSVhbutd8STnRzIDN+zicY1Gq
	TgvdnrwX6tFYprynJBlUXwZbXyQFDC5LX0+xNLb6ByoexEOpaYDooECVEXGlCp+ln2cjfLIubGl
	/SvncwAkgCnX0RMrF1NgzWdy5QDityWh5+YQLGsnHu5TJTi9HriCO35kIsfIiwEINttcWVHCSVt
	Pf980xiWmAB6jAal+QlyF3ndh830T7yO6gBzs23ZTWOPYVgqT9qZRdlTv4zj08dIipIkCIoMDrH
	pTlyBpNV4=
X-Google-Smtp-Source: AGHT+IEIQzTbeHKdNVU7VJ8uGt5WnRHNkLt7zT4oZQP8NjvlOXHVyMWjNgOw+ZRVvO6PnvLfKwvm6g==
X-Received: by 2002:a17:906:ef08:b0:b50:94d1:8395 with SMTP id a640c23a62f3a-b6d6bacdb0amr1221188466b.9.1761571821122;
        Mon, 27 Oct 2025 06:30:21 -0700 (PDT)
Received: from graphite ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853fb3bdsm765868266b.52.2025.10.27.06.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:20 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: cgzones@googlemail.com
Cc: nvraxn@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH v2] clang-format: add check-format workflow, update CONTRIBUTING.md
Date: Mon, 27 Oct 2025 13:30:09 +0000
Message-ID: <20251027133009.27951-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2b6896af-0fa9-4498-b33d-aa6729d320eb@googlemail.com>
References: <2b6896af-0fa9-4498-b33d-aa6729d320eb@googlemail.com>
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

v2: bump actions/checkout to v5

diff --git a/.github/workflows/check-format.yml b/.github/workflows/check-format.yml
new file mode 100644
index 00000000..9be8b629
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
+      - uses: actions/checkout@v5
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

