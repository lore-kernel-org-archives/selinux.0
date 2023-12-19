Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CAF1D521
	for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dWEX0A4h"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2339262835so350744066b.3
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 08:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703002215; x=1703607015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BttxqXRGBCPrXk99eIkz9Fiyo5nhN/CXJX4ptKVVayQ=;
        b=dWEX0A4hGGObaDSHs+Vygx8Wba97XbLomXXPOuZKarCDQzj8RrtVKZg39BWrNq2UDZ
         fq00v0sT3vKY/lgm0DBe8HWz8PD0LXQnym0u7vkOUtAj2pyOsHw+FX/6SbLdgcq+Kno6
         gp9tn1N3SFs6YYkI+Oz+i97rWyi+Y1f7MqI6qpwwrMTZuNnP72mGMzQjp5a5x93WBlJZ
         mM3LPbKU304iVlmlPDWZzyA5jRrBZoEU++22aENZF3fHNIImxPCMT6MUFTSPpncKkQBZ
         QjwE68mLveO1qF3WX1ajxruJ2rbBVwuiL6AM2I1E3XaH7FR5slpZRyK8B7rywVFwidM4
         wTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002215; x=1703607015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BttxqXRGBCPrXk99eIkz9Fiyo5nhN/CXJX4ptKVVayQ=;
        b=FMMWBK0WjNZmn7FUvdy2DI8YXlNDPZmHgNRH+Xjl9wZBpK928PZBfHhozzDTXhhrUk
         qVdVP9YDnwa3aSej0nN87xpOIdArNdMeqov9+YvgaTwe/yhdnVStfQmGBn9EUAGc2izE
         EMVcj4Hj9Iqi5iZKJ9ntbIdmwvw6MALEBlfFNdMY1UGSgwnmPFAc+QiYEC/AHqrjTOHP
         j/MGbOzVNLH7XIfnFbriD+wYpovnIA7KwwYXXD15kdPsutqJeT6swEfGMtltRbD79cez
         UW+g1YNTCuLh5NI9vF7VdpdkNBpucXGu8AEOHYSQEZ5YU820KhMgJzd6ivK6tj1h4Kcc
         i2wA==
X-Gm-Message-State: AOJu0YzuMT0SHVtd/j9UQSSjDxrG0TAqELVfhLGNm+p0puxCwUbOtB3m
	mSH4QOzX6me3Mc/yCjy3og1Wn8Coh0g=
X-Google-Smtp-Source: AGHT+IHWjOXxMvTWPMUV8RcDVTe/dEldDKA+H3tFtLeyCDttlEFEuEHqPjYOe3SR/arRHCU7uq4W7g==
X-Received: by 2002:a17:906:2803:b0:9fc:3a70:4430 with SMTP id r3-20020a170906280300b009fc3a704430mr8256192ejc.70.1703002214670;
        Tue, 19 Dec 2023 08:10:14 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-185-155.77.10.pool.telefonica.de. [77.10.185.155])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm1936621ejq.62.2023.12.19.08.10.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:10:14 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 05/11] libselinux: align SELABEL_OPT_DIGEST usage with man page
Date: Tue, 19 Dec 2023 17:09:27 +0100
Message-ID: <20231219160943.334370-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219160943.334370-1-cgzones@googlemail.com>
References: <20231219160943.334370-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to selabel_opn(3) a non-null value for this option enables the
generation of an SHA1 digest of the spec files loaded as described in
selabel_digest(3).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 1ea9bdcd..4a7c6e6d 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -62,7 +62,7 @@ static inline struct selabel_digest *selabel_is_digest_set
 
 	while (n--) {
 		if (opts[n].type == SELABEL_OPT_DIGEST &&
-					    opts[n].value == (char *)1) {
+					    !!opts[n].value) {
 			digest = calloc(1, sizeof(*digest));
 			if (!digest)
 				goto err;
-- 
2.43.0

