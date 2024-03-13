Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFD3E47B
	for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328235; cv=none; b=d14buXVCquVWS9hAyg5nkHUYCVWbuI3gmfYmO8KPd5ZojAyc7uqLqGeyvMbgeiFeDeVZu8DuGduX2t1/4UusEbVSj+a8ZGbX2CnthK0LLKRSl8P/YDcWw9UQ2bdeEujSLF9MpbRq3fzHAWtMkNztf5z/lvgl9bgnqEZ3FaJ/d2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328235; c=relaxed/simple;
	bh=bQYDVkhBgBOdmA61qu81po4LJ64Z487VJCIMbOgdgwg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V87fjGmN6IMuzetaNfcLVT0ixHTFYH1qNhWO2GlfSwZQ+OtDwNDtdHrG5jWAiUv3lPpk5r6jMIS8tQQBi8fsC2qIcaoP26NylMfYqK3E1rH9Ak3ds/A7ZMhAvW0nLeVwJ2C/GGjwCcwyUoNMeSl5YYgCT617GRTo/kMaYuPnxp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=C31hZm1P; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C31hZm1P"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a44f2d894b7so115695966b.1
        for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710328232; x=1710933032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Nlr0ShxQsXechQCG3JvBvFo9DZYTPenBB00fdvURE4=;
        b=C31hZm1PO/OkeyWEtKj+otsh1JrvhSjJ8DXSZjIrzKgexmt6Zc0qbCSAp4OrwxQn94
         zdCofJJP4E6SiDdkbWerQGT+ljlJVmLne+ojoy0RuuHtVmaEan+ysz2W/5fttOUx6EOd
         lKwdVUv+wxRURocfc6bwx1E8H5G4UwoMwDfJBrLq5sU9z/fXl4PQHWCLhgKcfhQJk5mQ
         PrDkRx7WSpe4blxPt5QeyQNWC1JsaHFTIRemJeGjITVDB7PIHLLUGuh6tQgZSl7tyBRG
         VJl3alkpBVHxmkTfzAMVoGeVmT5N4esn2RcTz3XIR37BhI7uN0+O9PDgvwMoWwGHSq+f
         1+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710328232; x=1710933032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Nlr0ShxQsXechQCG3JvBvFo9DZYTPenBB00fdvURE4=;
        b=Q9x+4W2o97hMTBtN1yrAEsnfXzkF8PMgUfhzeRVDh9/26Quwe3azMid5QhjQi/F/am
         ktVIP8DMNul+c4FQHrHU54cfqn3SMex3CGCJluqqmFXrkHV2dcFwaRJIh6AMi0FL8lBM
         sldB/fd8XO1FXG/k3Cj+bcmLSCGvGAbIHCQgukkwfBKMOld8UBEg1MoCOLm4Ao+/gQD9
         mG6oI4rlBnQKjLqZMU9Q0ppjk9ueX98Byvh7BFVl+Mn8jysmp/Jneheog9rtPhK4Bnsh
         bo9h1s1giNPunI+wmDN4FX/o7ekGXV61u+WzwdpquilBDHu0GnJzPUSB1vg+m8VZ2KEP
         2awQ==
X-Gm-Message-State: AOJu0YzxNy8ODcSBhdFCzHULZHbOdF9SQg3LMrrQssLRPZ7vMuWL9zjo
	Xc5yDSekBQ7AXGt9kAhVVNaM1IJ/XaX/3qV7tzYu7mziO3rSj+aX69tbWJ3caEA=
X-Google-Smtp-Source: AGHT+IH8DuG9/u/Vye82OWxn46S40kJruffUWSiU3PJmmp09xbiDPKbqh7RfVcsCnPOAGE8+/vo2EA==
X-Received: by 2002:a17:907:785a:b0:a45:f468:581d with SMTP id lb26-20020a170907785a00b00a45f468581dmr4613854ejc.65.1710328232114;
        Wed, 13 Mar 2024 04:10:32 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-077-001-104-044.77.1.pool.telefonica.de. [77.1.104.44])
        by smtp.gmail.com with ESMTPSA id hg22-20020a1709072cd600b00a463c821e4dsm1794319ejc.10.2024.03.13.04.10.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:10:31 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/5] libselinux/utils/selabel_digest: cleanup
Date: Wed, 13 Mar 2024 12:10:22 +0100
Message-ID: <20240313111025.43720-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313111025.43720-1-cgzones@googlemail.com>
References: <20240313111025.43720-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid global variable.
Constify read-only parameters.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selabel_digest.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
index 50f55311..db0d443a 100644
--- a/libselinux/utils/selabel_digest.c
+++ b/libselinux/utils/selabel_digest.c
@@ -6,8 +6,6 @@
 #include <selinux/selinux.h>
 #include <selinux/label.h>
 
-static size_t digest_len;
-
 static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
@@ -25,11 +23,11 @@ static __attribute__ ((__noreturn__)) void usage(const char *progname)
 	exit(1);
 }
 
-static int run_check_digest(char *cmd, char *selabel_digest)
+static int run_check_digest(const char *cmd, const char *selabel_digest, size_t digest_len)
 {
 	FILE *fp;
 	char files_digest[128];
-	char *files_ptr;
+	const char *files_ptr;
 	int rc = 0;
 
 	fp = popen(cmd, "r");
@@ -64,7 +62,7 @@ int main(int argc, char **argv)
 	char *baseonly = NULL, *file = NULL, *digest = (char *)1;
 	char **specfiles = NULL;
 	unsigned char *sha1_digest = NULL;
-	size_t i, num_specfiles;
+	size_t digest_len, i, num_specfiles;
 
 	char cmd_buf[4096];
 	char *cmd_ptr;
@@ -181,7 +179,7 @@ int main(int argc, char **argv)
 		sprintf(cmd_ptr, "| /usr/bin/openssl dgst -sha1 -hex");
 
 		if (validate)
-			rc = run_check_digest(cmd_buf, sha1_buf);
+			rc = run_check_digest(cmd_buf, sha1_buf, digest_len);
 	}
 
 	free(sha1_buf);
-- 
2.43.0

