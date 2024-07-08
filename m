Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E61D69E
	for <selinux@vger.kernel.org>; Mon,  8 Jul 2024 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457438; cv=none; b=AQCQwKnjuOZ6RNekCDt3hhwsy7dsUrEPL49y5ClZp3kwcmeZKCzEVojriYJKUr7pxYGPMzYKK1+JefivEVmNRjqum5WRflOuNgf2F/in40pFFLG4Bwqc4y+e62pABL1I4UPEqDuw2fQElUg/6XmGqzDd5ozCQxccBnernnFZPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457438; c=relaxed/simple;
	bh=MKhFGM0qHV6QwKinCXZoVe6STDfOxyiQxkiX/akHIuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxGLVAEskBxE3HHc52pQj+2DrnxSu71VOCQzUl2/ubj2Xz/Q69M46YrYQGmzkiQzCPvUpd5z7ofBBEfB7QFq0yyixMdWJ5JUxj27fgHE1VCGiYuuwBsWbr+Hcz0iSNX6aZPFiA6fHH0aTTfyACSPdGn01621t1lwtiMwKVzAJMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZrqYYEN; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZrqYYEN"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b5eb69e04cso25106796d6.1
        for <selinux@vger.kernel.org>; Mon, 08 Jul 2024 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720457436; x=1721062236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5zXbrUIgGN+fBxyVfr43mxyX0IUHm6Nd0Rqzu27CGew=;
        b=QZrqYYENSKGaTLZIa248rgriXXuJ17d461EqZmH2YUWOEm4q0v5lk2qNmoOf2sEp97
         jXZZ5303VwDm7ERkhByZIb02cK8sLD0W63qgdl2QEAGH2Cr+gV0O87l4H/Q6Kf3KgZ6X
         HcmSxArWZDCUiZfmZrax1rFyvFV5hqIODpp0XaD/e6YCIxPvflFHJnvQzwEvJiffsuVZ
         +WeFqVxC5/LzmQTH/4WZevvlzjt5mt9+pMoswppZdGLdyFinxskLsEZwR/bCm8XrGZYN
         kb8RGoKJ2EPDYuAsezkATMYdEM6KrjpMXh7nkBZ29vTRa5WcRQHbsE8Id79hN7sY1QLF
         UA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720457436; x=1721062236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zXbrUIgGN+fBxyVfr43mxyX0IUHm6Nd0Rqzu27CGew=;
        b=XRiKHP67GSOM8NSfuTO1HemgjaNEsFhWUTlW9NhavyCUCPe+L3d8fM16Yty2FtKYq7
         yn8vZltVJK9dfXKCDSePJtfv/qgpcBZhX9VKHDOjbGdZlXLcQGnYXlAIIRW7SCNdwAuF
         NfwPVGy5t+0SawVggR3rlBGynwtDw80Fr0uP/2zSgREPDr67wFycRLa7EAg7HejNFx/R
         j8p/2Nk2u9G2X6s9XliEd1N0eRaRMPvDqAxPkLo0qgUywimJtQ104s2s60F5tDgh5+w1
         yPwrMOudibaYqZXiZq+ESj95rx5Zkq9d0+H1r7gu1XCRr/yTbaQWBVixH3/RObrETeyz
         5FGQ==
X-Gm-Message-State: AOJu0YweTGb+QfLE6COF/l4pkimEpgJEE+LYWoylBA0ndUPp6JiXyVut
	z+A6CBd53q6g74w4HUtjVwT7uhmxfufuoHc1bb7QpcUv6QkdkN+ii32Nag==
X-Google-Smtp-Source: AGHT+IHbT3k/JgSBFRnMNN+35IevR8za490n7OukZZJAql5ulnXwcmqoJRZJsO37FZBNvR6krPujdg==
X-Received: by 2002:a05:6214:410e:b0:6b5:46bf:be21 with SMTP id 6a1803df08f44-6b61bca7e0dmr2551516d6.21.1720457435909;
        Mon, 08 Jul 2024 09:50:35 -0700 (PDT)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9dc37bsm1046906d6.42.2024.07.08.09.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:50:35 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] checkpolicy: Check the right bits of an ibpkeycon rule subnet prefix
Date: Mon,  8 Jul 2024 12:50:32 -0400
Message-ID: <20240708165032.86647-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lower 64 bits of the subnet prefix for an ibpkeycon rule should
all be 0's. Unfortunately the check uses the s6_addr macro which refers
to the 16 entry array of 8-bit values in the union and does not refer
to the correct bits.

Use the s6_addr32 macro instead which refers to the 4 entry array of
32-bit values in the union and refers to the lower 64 bits.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/policy_define.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 4931f23d..bfeda86b 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -5036,7 +5036,7 @@ int define_ibpkey_context(unsigned int low, unsigned int high)
 		goto out;
 	}
 
-	if (subnet_prefix.s6_addr[2] || subnet_prefix.s6_addr[3]) {
+	if (subnet_prefix.s6_addr32[2] || subnet_prefix.s6_addr32[3]) {
 		yyerror("subnet prefix should be 0's in the low order 64 bits.");
 		rc = -1;
 		goto out;
-- 
2.45.2

