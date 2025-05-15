Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145FE298CC9
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314636; cv=none; b=tkKb/Ll/fz5Q/LARMmkSu5IlBpnFNN+Rz+C98ILLfzu02fXnABa8MvJWj//YJSDKmau4NM4ut/iRaMvHdNzLtgIJqLKc0AUG+78GAOrpLZ/6IeS+VShdyo6EXeKaAquIklBHN8HdA8WA3msARbYuidH6D10Nf78Px/c27F+J1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314636; c=relaxed/simple;
	bh=uCB15wSvB+05e90ZjwgfPmk/Nru6J0bxLB1oA/GTCl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MALiAe1l/t4GF0zMMbDV3Tu5iEBq5zyENOUC8xEAYD9HLbmHW7G4Pd7ntvri9EbNUHJ8GbqLr8P5dcmCA+A+2F647f6nfiuojENSaCSZv1wqXJ9AbEMkVlA+Me2BpcL94hBMuzUVUA/kAhjcYCn2wfACAfUl4wVrDEPtqvcWRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRYCUjeP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRYCUjeP"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7cd0a7b672bso52173285a.2
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314634; x=1747919434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SQ08wplB6SEmfk8RZfo951eE7yc2331jEBV4f+z1ak=;
        b=VRYCUjeP/Kfpuw8tpuZpiatN2eM5FJ7J+jQ46qRtJFjxIjFiq2bYGRB/Q04uFPIBAq
         qrg4v9daJg8oIIiFx9WSitb0y0qQmpMcXQnxUrF4uu0duWQqkX9lZnvyWUcIbIH0ruML
         qy/qzlz64lW6avYTJSJQNsWgY83s15enfeJGclQP6dCo8Afknvb5FRSZsTPjqAGfN3g5
         CS56Sp7WJcXBWY87LqZwLylRrBokV7u0sjAdSbMZVDj3jjRU6ttGplZdAwVl6GaVVVvX
         rcxbCVF5v8tb8PPQTrQHgThFjscoJWIxtdgZIJzD+kdwXHFI9zme/nvpY1E0yZmH05tW
         pUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314634; x=1747919434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SQ08wplB6SEmfk8RZfo951eE7yc2331jEBV4f+z1ak=;
        b=fs7sxYC4wYzCjs2/pVQAOu2QGGx7pLNlLa6nQH02wu3xNCXjZIknRe9F4cHgVZB4mn
         Tebi6Kxh7NKoy2zxtuJgsNiM21KLu4ucpZEAiSY2T2Qwr6pkbC93SvbW4+brfZ3VLdrB
         siN+Uy0MpUZzThAbQPwfJ8FOWr0ADFPC4o5uA6MJ/u0+pTxfufQu9iTROJVrczLyn/NQ
         W+c9Jgzzw1sNO8qs+eyT6Ia/wHmy9w5OMIVy+Fpu/3rsQJ9KLmt+NEk0se6H385KCy+E
         ArexKzHlOvm/eW/N5o9sbc8WqYtNFq30cLaz5KEEi2HhoGA4y2d6y7HfXnbXqtQTQv5c
         DykA==
X-Gm-Message-State: AOJu0Yy3xg2us38X25zsb8+7qCd83R5xw0/o0zlq/VZyMsuYCmixUf4Q
	zTMNi5dUOkUCFg+brUyn0CjQ6p+qAnM2SvUdVYyoN/AS2kRlSbnGxaJIFw==
X-Gm-Gg: ASbGnctJeTWi6yPIgxg8U2oKPB3GD796syGGJ59dz8QiYhCb7wrACPvg+JFU7NEVG3L
	1jkI+JVk9iMmb9WN/aAzBbGMVbF0FBtdlXxLjzjHjay7GdCp8L4wkB5iAO6wZVLJK2T3cqmRcK8
	DulUOM9+2CkSBzU79PS/pfkymKVEb3B3YNGZcCMlcOcRYFO8FYJ0E9aSg+1bFmtT96kiiYkINXG
	+T4yrbbIWFjYaFJzeLBlgAMbwJpXL4cL5TzaR9QKUEEbfJoMQtevvYvm3vGHMdnsqZCy0uvsBmK
	HwZzVi2pTDTfjQ5YUtkCpPH41NGY3l7wQfEe7XzC+xEaDL5yUow2P8LoLQCK9vjgh0s5hexvoMZ
	mfmAp8PDLtSZqhkTexxVIFL4e51WVO8xuKD7YK0KNmB9o7/bONVMPvvXxqQCUSpIb
X-Google-Smtp-Source: AGHT+IE/xb6XQr0+PCEVKn59kIwm3DmccYho1L9PtVJoRJVZN/vygNbAw2lpMjEno9QceQdq7n75Mw==
X-Received: by 2002:a05:620a:2a14:b0:7c5:4463:29aa with SMTP id af79cd13be357-7cd28877a0bmr1121559085a.40.1747314633609;
        Thu, 15 May 2025 06:10:33 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 19/49] selinux: fix selinux_lsm_getattr() check
Date: Thu, 15 May 2025 09:09:17 -0400
Message-ID: <20250515130947.52806-20-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the selinux_lsm_getattr() permission check to use
cred_task_has_perm() instead of cred_has_perm() since we need
to use the target task's SID in the same namespace as current.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5944643077cd..2c478b42a76d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6618,14 +6618,14 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 	u32 len;
 
 	rcu_read_lock();
-	tsec = task_security(p);
 	if (p != current) {
-		error = cred_has_perm(current_cred(), tsec->sid,
-				      SECCLASS_PROCESS, PROCESS__GETATTR,
-				      NULL);
+		error = cred_task_has_perm(current_cred(), p,
+					   SECCLASS_PROCESS,
+					   PROCESS__GETATTR, NULL);
 		if (error)
 			goto err_unlock;
 	}
+	tsec = task_security(p);
 	switch (attr) {
 	case LSM_ATTR_CURRENT:
 		sid = tsec->sid;
-- 
2.49.0

