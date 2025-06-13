Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE0226CE6
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749843475; cv=none; b=OeQgbtEGJTB/3y/2g80RuT/wwv/6upUz1JwGhODUGQgAhXdh2oaAys4eQcrv7DFb0oqe8cY/ZrilTuctOU5XzukvPeDb2Qya/6TkgAk+Ehn4HcXQN3v9wThGNuReUWjqK9AlaHG9CwLjzx6skhDuNbhPG/iDbH1gk24gFVXPTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749843475; c=relaxed/simple;
	bh=EvgBe+jdAmaSXGfblFOenKwIZxivbjvuAL3obj4r5Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eo0HxHT84cX1a1VTKTvRTBdy0XpVW/9bpnZ5Gx5Ku6+dDe/zwfKbwLNyljWReh0KcUKGsw+z+c1+YTao23rowLC9BEzqF6trS4BxYkJS5EcTnO0UqoNYB5CvubZP/fVcVTCdhz7y1X7pzpqcPdiRmEhWXa7R/UcAXCX3VKFpHn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdbIPOty; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdbIPOty"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fb0a05b56cso46124626d6.3
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749843472; x=1750448272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gR3d/qJYB1wZft4kTbc6ddrocN7ZpyyS1r32I9+V6B8=;
        b=MdbIPOty04ZEObBfgqphyutDQQuVi89F2ZWTGD7FkmG5QwInmyPkxaYOFtKn5hoMX3
         bTl3ATmM3/yn1w15kinm8e6E9vK7ZpCPlJr7lX3gfI5Gf+eRMXB7OSQQXle9V9322y/h
         3ZA+/JLu19Seq/vUS0itKXIxwpUQ39AgtWoekJVwtqa3ioVu+bL09duGjWzZkEANiX2t
         ejswATyDLSLrcUXU2KwSYL0Pi5RGRBnAp6FKGTZ+8lcV+JcofRnkVpt1TbAbCnurtXQK
         kw8n1AwZCRnm7ZP9PgVrb+j2mpYoufg9Fv2ox2Wn3UoreICC51vR8boC9OWNFWiE6J0D
         1WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749843472; x=1750448272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gR3d/qJYB1wZft4kTbc6ddrocN7ZpyyS1r32I9+V6B8=;
        b=Dd/GYFNWvhrVcJVdfSl51Q+cJv9Y7DyBzI0kfpSDwRaa00Rjx4DynkwRhPPDCewDp0
         Nt0AVWQMy7Dmf5EJZN3OrJwKrgHa1alDAnfI1RUnFZGxla5+Rb+LjX2NEK5Ehqd7h5PB
         C1TEBOkqUcAr2fFFU99Cirt5DGgmc4tmGsBj03k29kC3Mg9Z7EIUP2SwXl33RnClURhY
         TU9va5oR8AHXt2yDH6vZyBP6WFxl2B4smyyA6D4B7FdApogoZy6OtmIFMvHxFp89G8ff
         GpVNnTgjYlaI3Ad9X8JbNHRZt9n9a20hsKpGse/0Lm3Zf4RSZu9HdS2PCCSGq6Xm8bOm
         hKGA==
X-Gm-Message-State: AOJu0YxurCSKZSAQdUYe5VjTlzjlMz6CtvXKPQJgznOyOOQNnRBcroJN
	VXAFHRtSedR2y2mTMFcUZtcHGF7slSA/WuaU+Qu+7MEQcRBUh/BXa/PORNZKtw==
X-Gm-Gg: ASbGncvX3zxOldspP0L4tDysjxjRYrwmFiGeDtxLQWqweCROl+cjKGCwcOAdFPy19sC
	FrOKwuN1XeyZXC95d9+dzodSCOuxBrlKrM4iHesfBrOaCOpGO2FXiKoXVIafpv+ZjrEqe3By5XT
	vSg6mK3Ej8IHeyUrCiJcPvOcSuELrvGwWWvlieOhNefBwNqfRoVXMxLkOt2yF2jsUVShcJ/rv8v
	LbhW4aR0+MPf8NmOX5HTn7L6Uc8WgQRdcTtooVMFl/kOzEoBYM04VOqwWoRqnR5S+ZieLoYp3mN
	DLqLnzeIXWjPkPdyhrgK65PilTfLjZzA2ndbMK7ThuzhawIlhWOCgKtgZsDL2T29pIgotMLYBMv
	PS6l6SOBAfQhbG/gskGDKTwta1eOiGY0zvpmCEnCbncOO7NKViknPpmFjEPvAMbjsSvPMvIeOYK
	FAMDmQviW3fRXYta4=
X-Google-Smtp-Source: AGHT+IEK5gTLkyR8+o2XOXcyBfHodD4DIyoGKYOQ8hkD5DBb1GLNqFNiLpMilOKmoCf55f4055VLnQ==
X-Received: by 2002:a05:6214:508c:b0:6fa:c41e:ccee with SMTP id 6a1803df08f44-6fb4779e090mr10016946d6.19.1749843472364;
        Fri, 13 Jun 2025 12:37:52 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b3db65sm25212176d6.49.2025.06.13.12.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 12:37:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len
Date: Fri, 13 Jun 2025 15:37:05 -0400
Message-ID: <20250613193704.12261-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We should count the terminating NUL byte as part of the ctx_len.
Otherwise, UBSAN logs a warning:
  UBSAN: array-index-out-of-bounds in security/selinux/xfrm.c:99:14
  index 60 is out of range for type 'char [*]'

The allocation itself is correct so there is no actual out of bounds
indexing, just a warning.

Suggested-by: Christian Göttsche <cgzones@googlemail.com>
Link: https://lore.kernel.org/selinux/CAEjxPJ6tA5+LxsGfOJokzdPeRomBHjKLBVR6zbrg+_w3ZZbM3A@mail.gmail.com/
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/xfrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 90ec4ef1b082..61d56b0c2be1 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -94,7 +94,7 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 
 	ctx->ctx_doi = XFRM_SC_DOI_LSM;
 	ctx->ctx_alg = XFRM_SC_ALG_SELINUX;
-	ctx->ctx_len = str_len;
+	ctx->ctx_len = str_len + 1;
 	memcpy(ctx->ctx_str, &uctx[1], str_len);
 	ctx->ctx_str[str_len] = '\0';
 	rc = security_context_to_sid(ctx->ctx_str, str_len,
-- 
2.49.0

