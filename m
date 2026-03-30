Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B62DF68
	for <selinux@vger.kernel.org>; Mon, 30 Mar 2026 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774835520; cv=none; b=vDhUl5ySuCYTwbgYxHEXfHVG7pFNJIQDC0WYXvtz3xH3H46lujPrGlQ7AY+kRuK59qceYgtRgpQ02/R60w0YMD7mv94ZVwEQQE5t3wCFRvaAv0iJAjfRAZDYQ2eN0not1MsAxeiUvSCZcgt/q+ji7JcM9uEsZCH/p+gmoOYbOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774835520; c=relaxed/simple;
	bh=68P1q4bmL9MPJhsL/F3MU2Rm8Ny8Lh1Pyf/oUyk44bc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=erh2EKwpqNXpOCUmxu3UDJXpQH/0Wq8Ul0U57jSooWnEnNC296rp0ehPMy/ra7tH5kQ7QOeGyL8EUPK4xnqDcp3Ip2AiNa4wUnB8NqmEsSHUl1P1vRGhvdWs2IEfHrsYiF4toSpdltn5isW1MDi1fb94rzFPtobQVvSmjHvpgRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Di8Q3k2K; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Di8Q3k2K"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0c92ff4ebso37579195ad.2
        for <selinux@vger.kernel.org>; Sun, 29 Mar 2026 18:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774835518; x=1775440318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHThRzcqschcw7VOWQeUHfgtCtCTFnE1eWmfDdA6FbI=;
        b=Di8Q3k2KtRlR6Ucqs36ZI4aq2JnxCcdwSUaZpbDYg/mQm2llazaRu4N6H+QkzDfqaK
         khJTrqIJVAKrh119kfqY0MPlk6/bzosgh2xDqPFvK0T7ANXjj7nB4BVJB+cNH0hCRnXf
         i5Kcy2FfXik9FsISO7AEOpgUFIOGX3cgiwXFEwHtDEmVyCndJkuCJKbn0PKHb7H5wdVO
         zlwTcZDaMZOIcrgjjKwnq9F4awbUhhJ7bP3PZ0nfsjNf/L8Kel8Rerpk5BoC0xYM3yW0
         AwEVHZPI1o5v0xiVaIaRuphOKOWnI//CYtoEP9lnfEoVQL0sX62enyoJVmagu80MNipQ
         VaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774835518; x=1775440318;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHThRzcqschcw7VOWQeUHfgtCtCTFnE1eWmfDdA6FbI=;
        b=tQwLgnShtFdMDEbCPKUjELLWWO1vhXxPX/tLSqo4m1FrqEDXwsEpyj1r/6GCOE2MLm
         l744X8rcEI2zKAtxgvuRHvuaV21XhzEjq5wOooGrJ9D9WE5oBQk9USWtpYWlQyOUug+R
         0qZK0gvSR7rUfYj6UnNt/Tp3RbWF5pFo2v51dbwEulbWJREe9p+Lq5l/0w2hIT7wo/Xn
         bcvhKIPylWzcngcJFKHPsoVZ6POnc8/0kjyIFrQLVYhnY0XaeAvGjKRxu31URYrRoOtx
         rafK4F+kaWpK4hrnjJg0Dqp6tgeOKuO9jghxaoOplYvpbXHMB9QqofeJb8JWQqD9eHhT
         4stQ==
X-Gm-Message-State: AOJu0Yyc3DszT9PlOnmKjw8zfHGb65xW4NQVTeESH8jfiTmqR9vUEe0f
	YP7rm5ioxeRQE3460QLfdhlS5tQ4KOX+VjL6538QxVDxUzEiGU/5fMQOFRWiZJKssyRTC081GvN
	AQ6/fk2P6aUwVYXnFBCvdZ4JQBig09r1aIsBdVOX0IIu/ze3fZfWxiUUGDowdyQJXfvEMyFq5aV
	dPN0G+tnXhvjdFDAC8srfq7GszUOAmH+tT
X-Received: from plbkm5.prod.google.com ([2002:a17:903:27c5:b0:2b2:4588:2da9])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea08:b0:2b0:ba14:fc70
 with SMTP id d9443c01a7336-2b0cdd91799mr113120155ad.42.1774835517796; Sun, 29
 Mar 2026 18:51:57 -0700 (PDT)
Date: Mon, 30 Mar 2026 12:51:48 +1100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260330015148.1482594-1-tweek@google.com>
Subject: [PATCH] libsepol: Fix off-by-one error in cats_ebitmap_len
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In cats_ebitmap_len(), i-1 was incorrectly used instead of i for looking up
category names at the end of a range. This resulted in an under-allocation
of the buffer for the CIL representation of category ranges, which causes
cats_ebitmap_to_str() to fail its safety check and return (null).

This fix correctly uses i (the current bit index) to look up the name for
the category at the end of the range.

Proof of Concept (PoC) Policy:
  class p sid kernel class p { f }
  sensitivity s0; dominance { s0 }
  category c0; category c1_very_long_category_name;
  level s0:c0.c1_very_long_category_name;
  mlsconstrain p { f } l1 =3D=3D l2;
  type t; allow t self:p { f };
  role r; role r types { t };
  user u roles r level s0 range s0 - s0:c0.c1_very_long_category_name;
  sid kernel u:r:t:s0 - s0:c0.c1_very_long_category_name

Reproduction steps:
  1. checkpolicy -M -o poc.bin poc.conf
  2. checkpolicy -M -b -C -o poc.cil poc.bin
  3. cat poc.cil | grep userrange
     Before: (userrange u ((s0) (s0 (null))))
     After: (userrange u ((s0) (s0 (c0 c1_very_long_category_name))))

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libsepol/src/kernel_to_cil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 06cf4498..49040ae4 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1018,9 +1018,9 @@ static size_t cats_ebitmap_len(struct ebitmap *cats, =
char **val_to_name)
=20
 		len +=3D strlen(val_to_name[start]);
 		if (range > 2) {
-			len +=3D strlen(val_to_name[i-1]) + strlen("(range  ) ");
+			len +=3D strlen(val_to_name[i]) + strlen("(range  ) ");
 		} else if (range =3D=3D 2) {
-			len +=3D strlen(val_to_name[i-1]) + 2;
+			len +=3D strlen(val_to_name[i]) + 2;
 		} else if (range =3D=3D 1) {
 			len +=3D 1;
 		}
--=20
2.53.0.1018.g2bb0e51243-goog

