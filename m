Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC1C1DB365
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933664; cv=none; b=jHnjXRDrG6LBfjDakAOptTW8HYi+U6zWRpf62rh3+nAn28l4yYa5NwPPMcA3xQA0yvkKZq2U6vdwiaCXGf12eErbfbuiNBZLXW37Wb5lXWK6IMt+NDJxIzi5TStSla18jbylR7pr+I7iaFmNafIlNRU1vc0Zh/eOzsYQ7hLkjY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933664; c=relaxed/simple;
	bh=TVlapjpCKtlShviqPZF9nxquC2gaEAMp7olpcJWWhX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wm/nRN7vnZQ7gyw0GlGGJxnkmzbz/exE1tknJs9jLFJyPrl3JzjFgbZGqYxgGkWxQuLToclFsIAA+jzMxpnIAzo8b2mBsdkt3UPwPF7JXpt93A1i4JbxyVAk9hJUaB1dsENzq4HdJe3nNsPR5i/mOy41xEdtxANCGhDrzKnnr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnhG/Rag; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnhG/Rag"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6efe5c1dea4so44857697b3.3
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 08:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733933662; x=1734538462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOm8iPf+hicKQQIBNkrudAdeFPSgqhDgxXMX/AxV/6I=;
        b=cnhG/RagiIyGxIq+T06PNmh12234BDUKFB5bAQ+5xa+091jXVTsEzuWKmQhskpzbZD
         Qi9FNCND0kkm9vnEUobznj0qZyX5809BPMORdkv7WtbqRtHcxl0WLx5gGd6tOa4uW4Xi
         1fkNo0w1P09Az+KlkgBv9hkf0RxtNIb2XosEuVlw6cQ8ZdiLKGZroH6cT/s1bWmhHd8N
         bukvg+BlyH2M++J0R/SgXHNOoJktoSYNz05U6K4KW7izYb1DLZFIYthozKF+tEKSH5JI
         fM/A3qiR21JruiT6A3yteefcyTgvpgkHlfKxdga/ZmnQ2m9aMui7xub/EyyzUxORfpoe
         wruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933662; x=1734538462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOm8iPf+hicKQQIBNkrudAdeFPSgqhDgxXMX/AxV/6I=;
        b=k60Z/dmD/xuXZlpS50AdNYuNu2ZexCRuIuwJfVmfPlLklZL1nHEIjltheeVjSws4QG
         Cgf+T5C2VKWqzQ8hmVY6fUwWSXVdEUKMiXlbjrF0+kMDQKrC+NPTA8XmsXMxEA4BSPMc
         KLjfp+C5DteKKiVA+h1cIiQaTfOfphF53fBzKhNpH3/lNb/15Orf7a7//uYXNsvQ6iyd
         oeMBaTFb1iGVtXCLkiP36+AVi1bA+DDgs2c95D22L5QkDjRkpWPTNS2ui/wD7wW4EJ3z
         YwVp51ZQA35LNQNfhh/RE5wEKJFLHAKjGaTwoQ6/6kAgd7kQ6j6hAPY0TXS5LpDDkQsS
         fJbQ==
X-Gm-Message-State: AOJu0YwDKGMT9NLWsV2gy8O0F6h13tP1pYIv9QhsbuM2glhqrueb3IKT
	4DoGe0TGAwU0HShL5oobpo5tcZtQCecff4eY75fCVXY75IJea2N1g08WdQ==
X-Gm-Gg: ASbGncvNKS/EZikZHkByI5MkeUBo0wZkA0cPOj8BKcREyE9kDHSrx67n2Rvp8uDVmSn
	tXvGXMFrlDX0fSCdduR3azAYxBowYmYzHgNRHJbQraUUQlRSo+8HH5cLu7i8EScBWFLW4A/hygM
	k2ylKJkuYtL3zRm3ItDar2Ep0YB4rv5e9Qr/gxWcgedEin52pYsQU+mUJrtaQQ+H8ofAmjLOyao
	TQDc6hm4iPBFlyuL0/tJPXxgBpQqPbtVMK7JX7vJZgXXshCFtHZht9u11p//COr1EF3jD+vMFAv
	M51b+Gi3PKU=
X-Google-Smtp-Source: AGHT+IHKGk+hx1uqg2TdPGYWzSVY047fd2sXSqRlQNscuIQCNxP9AoDxb6IjlaD49RVFowOOsYJ/mw==
X-Received: by 2002:a05:690c:9c08:b0:6ef:4a1f:36b7 with SMTP id 00721157ae682-6f19e51dcb2mr578027b3.25.1733933661836;
        Wed, 11 Dec 2024 08:14:21 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cd96799sm2890237b3.41.2024.12.11.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:14:21 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	takayas@chromium.org,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/9] Revert "libselinux/utils: use correct error handling"
Date: Wed, 11 Dec 2024 11:13:59 -0500
Message-ID: <20241211161417.126236-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211161417.126236-1-jwcart2@gmail.com>
References: <20241211161417.126236-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 2db6d12a6cf097b5762d803693eb3182add19d48.

Needed to revert commit 92306daf5219e73f6e8bc9fc7699399457999bcd
"libselinux: rework selabel_file(5) database", which broke Android
file_context matching.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/utils/sefcontext_compile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 5d7ab301..23d31274 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -471,7 +471,7 @@ static int write_binary_file(const struct saved_data *data, const struct sidtab
 	/* write context table */
 	rc = write_sidtab(bin_file, stab);
 	if (rc)
-		goto err;
+		return rc;
 
 	rc = write_spec_node(bin_file, do_write_precompregex, data->root, stab);
 	if (rc)
-- 
2.47.1

