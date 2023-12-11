Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CRxEn5W1"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B7BCF
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 07:00:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54f4fa5002cso3934135a12.1
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1702306838; x=1702911638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+i3fJpta+YZL7Kqt3KB1G/o84dul4fXPO2DxheMfn0=;
        b=CRxEn5W10NOLVM7Rtwt5T/9zI2/lKyp3J4EZ9TxErh6sTWJX/yps+poJHibT9GJaWc
         +7KphUM+Ned71ElJMdE3K1Z11ic2W5Q201ZymS5zenDmh5d5eQh7EoIuSd/mVzSAR6zF
         pxTy++uGSr9Vp+Qfc4Dkovrux44CU0Xjo4rUnf8WEqhc6XJkmUvQ98u6crtkqu352VeD
         Nnnfkoh9/4uHcuSyKVHu29Ztn5eTZN697j/qhFDvVOKlmp4f7uN4wJHJPLGnxXHLx1JF
         UJXdYDhKRMbH8HfWA+wICWUibaHsERr4+1mqZT93GOTyDO7cEBtQnrA2FdrPakk18TJ4
         yBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306838; x=1702911638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+i3fJpta+YZL7Kqt3KB1G/o84dul4fXPO2DxheMfn0=;
        b=Rvw9E0BpXVZ9sVQ6fsOsPxkeFRejaRmopIyMcwADFpkflKZmF15SMEbKBP0KyAC0jG
         rQSkS4m/rXvQVPOtcQ895cQQ76eWpDBMff+HMpelzdBHP1H0jR+fOgFRGj32PidKIDsQ
         do0NDnUxD/NL4vqlxdXUat3is/ZnENccD3qJwPlPu8FjcRgaIeouuyCm0fEM5fkXEIoV
         c/NAwlcsi3i/Q3E/ZeCaLXyfDBWgFyAmu854wx4Cjh0SQA5uHcMiDUEp4lcIrLxWieyU
         i9J0PiD93qMBl2g5teVex+/LN9kHb4RCn1emudgOCPX+FKcEMlsLphIhWM86AJfDWqoM
         xSag==
X-Gm-Message-State: AOJu0YxMceI521wJvZKmSiY98Pj2QD2shPAePXohAH0VW8yP2xNyVrAs
	sqjZIKjn6g/nIbO+FFncQWDqg5xj4Ek=
X-Google-Smtp-Source: AGHT+IEj373zTzE8MNOslq1N1xKAThDERkMsaclPDj1sROpVTktvNmMetTdJrzd2Z7yWwX1frPnOAQ==
X-Received: by 2002:a17:906:ac7:b0:a18:7b92:d8b9 with SMTP id z7-20020a1709060ac700b00a187b92d8b9mr2126889ejf.38.1702306837991;
        Mon, 11 Dec 2023 07:00:37 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-001-173-175.77.1.pool.telefonica.de. [77.1.173.175])
        by smtp.gmail.com with ESMTPSA id vq6-20020a170907a4c600b00a19b7362dcfsm4983559ejc.139.2023.12.11.07.00.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:00:37 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 3/3] libselinux: state setexecfilecon(3) sets errno on failure
Date: Mon, 11 Dec 2023 16:00:31 +0100
Message-ID: <20231211150031.127850-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211150031.127850-1-cgzones@googlemail.com>
References: <20231211150031.127850-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The other functions (getexeccon(3) and setexeccon(3)) from the man page
also set errno on failure similar to the getcon(3) function family.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/getexeccon.3 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/man/man3/getexeccon.3 b/libselinux/man/man3/getexeccon.3
index 9cc24e8c..edaa6669 100644
--- a/libselinux/man/man3/getexeccon.3
+++ b/libselinux/man/man3/getexeccon.3
@@ -89,7 +89,9 @@ then executes the specified filename with the provided argument and
 environment arrays.
 .
 .SH "RETURN VALUE"
-On error \-1 is returned.
+On failure, \-1 is returned and
+.I errno
+is  set appropriately.
 
 On success
 .BR getexeccon (),
-- 
2.43.0

