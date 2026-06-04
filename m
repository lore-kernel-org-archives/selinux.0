Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523829D264
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600137; cv=none; b=Z3xVwalv8dAi/03t+kl+csnRZP8KiNuohNyHQSNPhi/AeFkVxzMW6pw+Im+c8kBOx6xkKa7usoUHrAjPh3JUNUariUjWaXkYA15aKJL2+HHCRSBloP+zj2KxFMme+hUeZeSF9M2Dq8IiDa5MXNDnCezfC1oy3Q8Y2CaaEuhbxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600137; c=relaxed/simple;
	bh=hsKNNZpPMSYpsEuVYb4qrw0AQdx4pdTy6BiqzdxKITg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWKjasv57K0shW9rRcsY67WGWHgGlHfa2goKwTc2k5CepKnijVAkM3fZjaQBeAv0d/6yJte+XwbR4kYVRgngdAYrqWC3Wg0a+3noxarOSU2rFaKcEX2R06fHA/u+apFV2qdeMxAkg9rHEYbbx1wtZsq1ZQUreNzFjx74mB0RO2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIrXrX2T; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIrXrX2T"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-915336b83adso128591585a.2
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780600135; x=1781204935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K27gaNrzn66NKUPH66XR99UZuBjUPAqASYFHTvevk+8=;
        b=AIrXrX2TiU1PmwsAYj7GKRslyjm6n2sX65j9NDS5iAdY5ZYueZpD5yBUj/2qeSuStM
         AbYinmp37q/0flSdavuvN/fT+gmCTRFj23otFWkaMktp0OZXyDkPxRNNVgIEj1vIlAhi
         zDPR6upoFQXGsCWm88njEiwJtg8IdXvDexvXkbr3W7NG1SCO+KfUjvqE6FUVfqAoiZc4
         ODIt0N4SCC4P4hDoyTNWNKpiXD/zMUwyyy8u5AbeX1e34QiNNu1HGH0tFfrrt3D76ygy
         npyD8uHi5tMzVcf0cuICjGQgM+JrpanAMtiHdieGVo9flUq04ZMQt8TLW1oNKrg114hD
         3bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780600135; x=1781204935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K27gaNrzn66NKUPH66XR99UZuBjUPAqASYFHTvevk+8=;
        b=f1L/KFsbGkpx+Ui/KSRla8+/saXxLzgNBQ/EtKkSxfv0U8ZKD45PqF2K2QqdUzcvWK
         HqLgXqI/s5l//Lrn2H9IslaHWIXzyWERwaHg1r0x3Dl6N28Z2x91PiT7IlXMB5kbJ3UR
         JrcSeMPHhGRLh9i9cQ4FFFz1hvT6jlslQc4vmRUo7npPUriRgn64N4rLcpv+cXKZfvA7
         2acshn9D96vfp+QSk1vRpqR5HaQbfzfE1cL8wgKDkdVGsmYwZYyZqZocBx6gal1sppv0
         yyXDwyqlfdS4lfja8PEV4qG/DSHPUs500k/LsS29jJ2ot2oEPR2pZd5tMYn+88tfDHHy
         FD6g==
X-Gm-Message-State: AOJu0YwGZU455lsS0t6VhL2UHc/nk6EXTFOauCMqb7dj99URlLYrLWd6
	waGF83yUQDMROuSMi9eJUSUV6fZF5yBo8d0HYxZzs0n1RHBAVFYelxI0Y03J8w==
X-Gm-Gg: Acq92OGM2OXKwrNJmvOl3uekzckOcQFaEze6vKFL6Z+il+8RZLsSmjXkQZmImBRB9y3
	tWmG2fThi4SysGSYeD8052/JRmQ56LHgKTe4D82zgWUUzzJePZCSu6KRYiVUWh6R0Scls0PwrpB
	ABypS0MfwkUWMAzOCkD11UUTo+8OidaogFUUr13k12Jvk02xb04sAS4E4odT3+IKnBcux9UlhkJ
	Xx6DtB8gIiCOWJ/JtefuKCm5tPyFMHqheMZW3nw7LjxkhL6G/3dyi5lvVtTe86h9ddWHK+pLjsG
	TJlaKWwDnChw3ghCDZLMpOzA2cF9Oh7PJ91znVlwmBTDbXFsV1HQSh17NmAbkwC4E54IvBOe92s
	WFzQeWKpMlFG1MNjZmhdodWfvqBcqMxsBJ/vLuwSQrCkKLIwtPLgb/3Gy15p1vmN4Lap89qvVc+
	sbCtl9hLJ60H9hN5dLmEJiasapBz0xuVwtZ/zUMQOhxgWdzjLizVe5OK5t
X-Received: by 2002:a05:620a:a29b:20b0:90d:501c:50 with SMTP id af79cd13be357-915a9c75e55mr61989285a.26.1780600135058;
        Thu, 04 Jun 2026 12:08:55 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a411333sm693224885a.46.2026.06.04.12.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:08:54 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] secilc/secilcheck: Remove extra sepol_policydb_free(pdb)
Date: Thu,  4 Jun 2026 15:08:43 -0400
Message-ID: <20260604190843.47747-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since sepol_policydb_free() gets called at the end regardless,
do not need to call it in the error path.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/secilcheck.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
index bf12a812..a2cfd9e2 100644
--- a/secilc/secilcheck.c
+++ b/secilc/secilcheck.c
@@ -78,7 +78,6 @@ static int get_binary_policy_db(const char *filename, sepol_policydb_t *pdb)
 
 	if (sepol_policydb_read(pdb, pf) < 0) {
 		fprintf(stderr, "Error reading binary policy: %s\n", filename);
-		sepol_policydb_free(pdb);
 		rc = SEPOL_ERR;
 		goto exit;
 	}
-- 
2.54.0

