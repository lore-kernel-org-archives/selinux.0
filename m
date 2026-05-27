Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2F380FE0
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896415; cv=none; b=K0m0iZEoO0OS/0KxkKu1akwiDUc8R6f9WKKYuJLFfvmM1D44JDkSudMvsYbtCsA1pnOXheIXXgqxTXAiMGP8DnApd9La7671DUnyNEWuhLgT1GDpu18R5eWY7YIaZn6Lu9hwc+l4ffVipZwPjnsEo5jY50enWXtItZ8+YEAm688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896415; c=relaxed/simple;
	bh=qtKCLThqW9qBlgebsfVFcK1eyWy/NzF+OzZqD3kc7/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+hN2o8P36gZGBNhwD5FRSFpiT4A6x5i7xXFdgUMJCqD2RP0nAMwyycK3qx1TAWHFNc9ewEzguE6HtuUoyBiVa+0Kp7I+H/VS+BKE2vQX1ambOba9bc86z5L0bBeUtVWHbiUDiughrPhG5PtpMI50itDOUPzw5v8vuzPr4zKd5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6W3u/oQ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6W3u/oQ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-914db83362aso372637385a.1
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779896413; x=1780501213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51G/WWDudqwpajnPDsnYSMvfc0IWgWYJh83+b7zfDp0=;
        b=n6W3u/oQI+i3ujEHoS+zTTj2q67a8c30oLUIuwR40PcRmTF4xeVpmZ8Qc1vuI6R2LQ
         3HS/YQ5z4T8N+6bHCAuD0Da2EnPnsDgC9GYEY6pkW1IntQh40wvO1q5jgqHouIVHHoTl
         3n6p/P7C1DDMLAcQga4WN7dE5y0QXFYbSlPnEULmlYK/zragfxF0J40PJw4tiSuTlKuL
         iFIXI/qFwI2ubxZDF0uT+lq99NfF6BDy8DyffE8S9pHCSh1gGyNA4ac/umvK0AYt6j6h
         By+C5RNPzhaXWlAqx7Us5y/J/w7AfAREdW5ZEqrP0uIif92d07PYD/lbO0SDNsAGiQGs
         bMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896413; x=1780501213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=51G/WWDudqwpajnPDsnYSMvfc0IWgWYJh83+b7zfDp0=;
        b=Um8bfv2Dsx4+pW4DeePV7C11x2vzEOJiemCFcgIvl8kiAIc+Mu/AwKjhdaPmASQgZY
         AR4iFTI2IWrTKYQkl1BA5zmzzlIfRdFHHh6dZ4ZJg5kfmEzj5uyK7pIWXcroEV0/QmGD
         fAk0jtqEFYgQ2QZhQe3cu1ZR9yQdgPDLeaJg/rHlO1PIKRI1rbI8OyANVdji5tPjy0XH
         TdEiechxzDgMUYibTaRq/dDO9ukWbNt1P984cqkjtwUZDFnAO8KfG53JjZC0S/vWYDeW
         r8I2oeJvG9z2Nx4t7YrVvgZMGmZAhc8zGQpnZwivT45/+Dt6nsHCYTPl+iUj4xd8dr/8
         HJag==
X-Gm-Message-State: AOJu0Yz2ra45PMbtzVMXhmUiXJV/ZCjDYNyw/IS+jvs63ra7p2B/vtDZ
	LToW4WawQAzuimLll/fI2hC2JTxQ5vOLBi8/blChVl2LqvI0ILd1MvgB7vgPcg==
X-Gm-Gg: Acq92OGQ3MQqUKSEPy7xRUVMiTlt9FnwCogWr/VruXZNWzrPS5h+XCmLa+4Xm8mouYq
	c66QW+F/LVYRLG/AiuAaJf+YsWIBmr07hT0wNRGeQ3f4Vxi/glWUNgs3LoiKdORPBxn5dTTiBxk
	wL8mB2DDrnEsWjhPaCW7QTaptoUZXmDYncAndQW27g1hQj6QRckyJKSmm3+pMS1madzTAgQBttC
	frFpomhdXyD2Q9Lhnr/aQL8MYwyjUliVIZlfmWnMirmDfeMG5BevE8d6ePbpKuqnJWGrRDMS8g0
	+a1/Mhk9mUgDylYRd8BPWVefzTmglZ7JfwID5DcL9CBYo4zeR+MMSR8Y+NQPcRWXSmrdFibALW8
	W7oPzQLaXrs7XdqEf7bcroc+rP4Osn6VA6dLft5dE5bG1jX6sKta6f2y9ztZeJkuGezf6wSGeuP
	AApZMBBuAr5iiuBGpFUytB4k8h7ZwKYp+L9sfCva7hDJPvb+9dx2EtH/LjGZj7ENP+9vLOThC21
	NN8grthFZhk56F4IWn/gwEleZuz1RcbLZD1ICIYbSG4hS8g
X-Received: by 2002:a05:620a:4408:b0:912:671b:d0b1 with SMTP id af79cd13be357-914b5029320mr2662646285a.2.1779896412951;
        Wed, 27 May 2026 08:40:12 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f880c526sm494679785a.39.2026.05.27.08.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:40:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/3] mcstrans: fix after base classification pointer computation
Date: Wed, 27 May 2026 11:39:52 -0400
Message-ID: <20260527153953.27606-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527153953.27606-1-stephen.smalley.work@gmail.com>
References: <20260527153953.27606-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovector[0] is always 0 because the match runs with PCRE2_ANCHORED.
If it were ever non-zero, the computation would be incorrect here
because ovector[1] is already an offset relative to work.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index d12ea587..45935540 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -1216,7 +1216,7 @@ compute_raw_from_trans(const char *level, domain_t *domain) {
 		}
 
 		memset(work + ovector[0], '#', ovector[1] - ovector[0]);
-		char *p=work + ovector[0] + ovector[1];
+		char *p=work + ovector[1];
 		while (*p && (strchr(" 	", *p) != NULL))
 			*p++ = '#';
 
-- 
2.54.0

