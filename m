Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553B636BCED
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784230679; cv=none; b=tH4OyNRjWS+C4P5IUmUDNcftg4BpgfictzH4ivv9TqEW3U4unY7sBW+gFVwMF7Z0rl8r4T52wROFAb1eazfe7fqA0wKoUP4XMSeyMMFO5cVzklcBd6TSddDZqJGopSlHI8GbBaSlfPtycY9AFM2xGN4X16EK1e3ywfmyeEb8M7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784230679; c=relaxed/simple;
	bh=SzOsA2yqtc0osDbHs1EnV9o7EGAbNwK+z/c0tm4mw/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VM9Y1Uh5/wG4bsP/eGw3g+FMfvBqCYk7pNG+ylaZQD5gtbUAGbOrqKWR+xCdYuq/6VBOenIzN4bo+TjdYHDqh/zypkfL9baYri+QpuXEAVXNcnkbY1IcJc1Govro1YoN/KzXm9+hN9joqI1FjVG/IuxLba/CbbVzP8bI1LpTNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/PtkJ0R; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/PtkJ0R"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e65e18969so70568385a.1
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784230674; x=1784835474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBozQ39IliTitTd1xTyCu12WwYClWOkvC3YLXJnbbYA=;
        b=R/PtkJ0RMP6QKW3tpN77x7u6CLYmU007kPKgDWsXrile06irF2ctMVzk0zpou+HJlT
         SxSOIw/IMzPI9vt7QgMAlHE7cUFrkyahRk6qSTT5eMSCVPxm7Gpw4b5+y+W5aEnTNBn2
         +O2B+tUd7fALo/PRo8i10gWjs3fvBwr94bRFfk60QBZspBoyIUmOkFvfoulo5+9dbSrX
         1xuzELT0I21ksdK9iytflamNv+TaoB6V4E4aAB2rkC/xPPH5D7rlAfG0tk0rjmRG+YTx
         pDUnoP+sfXuKcO3rqOXGaBsrwhsnKIZlVIm2D16zC9QifAWyC2Pf8Y1syJulBnE3vKb4
         cmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784230674; x=1784835474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oBozQ39IliTitTd1xTyCu12WwYClWOkvC3YLXJnbbYA=;
        b=eZTQXP1wNQe35yiu1xwj4TfSNbpnRY32Fc2g3jsoghkW+ezopgYK2PKa3Ggg7NNPZX
         UvIvUfVXC8i22t1tfnNnXShEPtKvFpdDe4qfpTv1PYLTztaj+cbwWjG8CJuYzlgG1kIJ
         kkO6FubME0rTWbTMs5BFE8aBETJG3MINlcVEFURgCTt4+qfpJG1qvQKGxP8jo9KzGLeb
         K4044zEx01SW6+Xxzk+wwx28HnVJ1E8dxHy3/nGRzHWijyD6kuIaAoHYkOVBnjvFIPqp
         ZTZTTMzkJuG+hQ3do5kzVDiKhQm5lvh2JlMrikQbnSrPeM3udFMTVej+zvQXQXaUZ7yc
         kjBg==
X-Gm-Message-State: AOJu0YzYWvluOutj/8N5W6TUW9VygtxqWlF7taUW3TxL92xAaaITUP12
	ZJwJmXPKtH/PhMklHvU70HlAm0VQQgqfLFfM8hlS4aI5cB1i6mBsreLFuQ5ksw==
X-Gm-Gg: AfdE7clbU+tX5L6udHKaPhWmME8QrjTEMLODlT06S+3cwApECkwTDfCz4kqQhP6FNC1
	2EEttp6xQYzBn0vtClFGUB/cl73QQodahtLEvsdg4ZGU+7PTIxfTcWc8fR3/An9OjWImVC8w4Nd
	hPpOslRvtKEJeDsDhS7I15TL+0MivcX2VT3ydSTTWnESGoxBeaKOxbEmRypfVf8MZySrUw77Zyk
	z3/uQzx/fmJCF9Z1uEXpoKdQLd6syYC1E1Y9t/aMg9hj2cG4BipdLgqYqWHhQJ1IUdp7j8lwLXz
	J5JJ+lxJv+py2RkAfwmJZ1p9MnEyJ45U4/BD+9L/z4s4KXVZvJTWLCbIQU+3EHuKFqsL2o/blO4
	W6cRr01/cVG1A4cvfEomoVIFk7IoIUR+cr8f3pqzYKsHf/7qqYBIVkAZtJ1r0BbvFnnMoUfeqlN
	3Uoa7l622cHARn/F6KUHav+PKCvk4ZUVf04iZijFtip/hXOWaQOOho29hUOh+VRHX0Yo8eCg+qj
	mBYKg==
X-Received: by 2002:a05:620a:2546:b0:915:9f30:23cb with SMTP id af79cd13be357-930a5c38b9cmr432208185a.0.1784230673855;
        Thu, 16 Jul 2026 12:37:53 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b492ebsm1987760985a.9.2026.07.16.12.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:37:53 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 4/4] restorecond: fix isspace() call to cast to unsigned
Date: Thu, 16 Jul 2026 15:37:37 -0400
Message-ID: <20260716193737.11366-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716193737.11366-1-stephen.smalley.work@gmail.com>
References: <20260716193737.11366-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isspace() on a plain char argument is defined for negative values;
cast to unsigned char in the caller.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index 18bd90db..4e3c382f 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -424,7 +424,7 @@ static void process_config(int fd, FILE *cfg)
 
 	while (getline(&line_buf, &len, cfg) > 0) {
 		char *buffer = line_buf;
-		while (isspace(*buffer))
+		while (isspace((unsigned char)*buffer))
 			buffer++;
 		if (buffer[0] == '#')
 			continue;
-- 
2.55.0

