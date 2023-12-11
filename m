Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gxATWo6v"
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5568C6
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 06:48:38 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54cfb03f1a8so6144248a12.2
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 06:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1702306117; x=1702910917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0BXM2vrg08PYeB2toWV7mXKugo0/JT0s7637pl8pQJk=;
        b=gxATWo6vZTjVDZRnkOt2+ZtP3y7n0h3dYZeiZ7XDMkUTmeySpqdwNLCrOKdC0FzZ7E
         2bkMGETYJk8TQh4OkQIS2CTlwmldDIJgwHkrDInaQe2O15Neg8PbDAJrMMXasnCtsEvJ
         NXpUG32tH35/dY6twUJC5gvjfb4F3+2CIWvUtx54gRCBcAYBOT8U1b/S6F5VCC/bueWa
         oQ1oPbPOlyD5qjRAFNCpVLbiVY02qSM6srUYVAmO7rUzFI2HQ1xuzSm9thZPRpFzf8+8
         rXCpIrphXa+of86HEiA5pcQZ00JI0AhPrbNocjKqnuUAD0dbHDI8w3AEzUdvkRRfyFfd
         b5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306117; x=1702910917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BXM2vrg08PYeB2toWV7mXKugo0/JT0s7637pl8pQJk=;
        b=iXzWd22fByDA2VHSQHLO80Eok1MoDDHx0BlG79LSoEIFOLM+kqNkyCZVhm4Cjsbjg/
         9qn1KnuvD1SKFyvgEEWme4YcPZj7PEbhKze+07eojbM9CiHXl6H4eGsfp3oLC9VGWvE8
         y7p9lmvCC3dmIZc4tpC+vR7PNXe8ci2+Y1W1i7CT5O5VKRkNXn+5RqThAQ6Hf/Ln1HBy
         XcGLGchvhlmNqDymXUpVlkLPPhWR5tjaqxuT9sYHmkAN2iuIJvr2NdrsARcTpn7mpB//
         xaIXDX/9+mTZ/LTZ6HUPMyUk7WlMwfKzJafqgcL+4vdRyEB68bOPwLjEN3aoUM1wS8gc
         K+pw==
X-Gm-Message-State: AOJu0Yz9ZawWBcnqm1/VU2+AsYPFQ7tbUciGbmHvnBwwnjmRLMTxalUW
	dWa+sx8meH2ayzghNXhaf3ApFaTtkSA=
X-Google-Smtp-Source: AGHT+IHV1bI7tmTQxrIKEP+8hpSQSW/KQyOUAsVzAcZG2iwtbTc6gv7Z5qZj1VZvi6Ky6pb9rmeL9Q==
X-Received: by 2002:a05:6402:230e:b0:54c:4837:7590 with SMTP id l14-20020a056402230e00b0054c48377590mr2408270eda.60.1702306116943;
        Mon, 11 Dec 2023 06:48:36 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-001-173-175.77.1.pool.telefonica.de. [77.1.173.175])
        by smtp.gmail.com with ESMTPSA id bq18-20020a056402215200b0054db440489fsm3669228edb.60.2023.12.11.06.48.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:48:36 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/3] libsepol: avoid integer overflow in add_i_to_a()
Date: Mon, 11 Dec 2023 15:48:25 +0100
Message-ID: <20231211144827.121636-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211144827.121636-1-cgzones@googlemail.com>
References: <20231211144827.121636-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index 571f6c93..4a6f7d11 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -44,7 +44,7 @@ int add_i_to_a(uint32_t i, uint32_t * cnt, uint32_t ** a)
 {
 	uint32_t *new;
 
-	if (cnt == NULL || a == NULL)
+	if (cnt == NULL || *cnt == UINT32_MAX || a == NULL)
 		return -1;
 
 	/* FIX ME: This is not very elegant! We use an array that we
-- 
2.43.0

