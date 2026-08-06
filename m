Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28748377006
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025627; cv=none; b=qq8FrjyYBaQGQh6yii1wxhWyiV0zapkAS2I6wsDOSyLjCB/oUs/J8r1U2AhmwhxEFP15eO72jmQXifdEXT967yXqBlc0MtKTaTv23CLYCKI1AER482eeU0S/1bWPZjAlxzvr4HP+iqTbeg4syDzFIntNL9L43/BY/kELqkxK8mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025627; c=relaxed/simple;
	bh=2Iyitj+ynI76P9Lh8rtxbBOUZsOAZ1Cp8VsfVSVDxfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dc8fH6f9PiL2IeMywtyLaAGNTY2wNTbRNcLD2NL0PPx1rvhD7fiSnjfEMcf7+ep/3PURM817Q4RheZ5K2qxjjmB96dJ875HHTBOxD3V/bchcJPobk6bF82U4xR6ddSr04Q83fxNxwINdI+VANRE4lBsfMtrwtSk1hwuh86B0Afk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY72TGsY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY72TGsY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e6a434cabso107357985a.1
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2026 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786025622; x=1786630422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H/ywjtaajsj+3J8+i1dVA4+1nAhGQKDQZERMC2ZX+uI=;
        b=jY72TGsYQhW+jY2jVCVnniMvYLULTpI2DqI/T8HPfvnbN0OQ7WlUwFmOouU1dGQfYn
         890HZOXGSllPQmlBgm52PTE/DyiRXl1PVEMj3G9aEMjgR9l3ZMuwPLgwLISFWBg6SdcH
         K3HU8rxnFMkGZNEf6gTIkN9zb4TfngTwDsPmDyxD37lzD3SYOve/v8jFocAA9aVvDYGB
         rK460zN7SUaJhpXb11FYkGQldGOPkBVeB+RKaKFf3D9eVJbp99vs2zN8/WQai48GUSZt
         crFL+KFXGtq0Jm4dpJRHgfcjYj14zfjm+htXqaoE3BxBEHO2YFmjreuW1VBNFl25Twqu
         5XVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025622; x=1786630422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H/ywjtaajsj+3J8+i1dVA4+1nAhGQKDQZERMC2ZX+uI=;
        b=JCuE6bX9PXj91z5AlDCy2bTRGt8SwVF4vY60lOH1QoBsZvU/cf2tMAhYG0GJxbgP6o
         z7UDD9eYTDlBtKHbFZ3FcEvBLpTxWFLYuGr/sSPzttg+HfH0UuzqaoNg2CncV/VJVPal
         mmdrI6V7b7VxPNpdGUw+FwAd8Sd+5+k57P+58nypv6ly8dG4WaIkWGgArnZBNPNIdxJe
         3Z7+LBaCbqOUzPWxl8/vmMFaIIKMg70dxkwxYLKJb1nLwgUtj1gIKgM2p4VtVpPc9Yf9
         K8t4/QaVynhQ6pqT5KGCUVJoUlnACcRj2qNA2m//GthOyexFY8shoyGqTt3dtZIaWUsx
         V+9g==
X-Gm-Message-State: AOJu0YwvnxNF1pY10QBSCXbx4AHaNXGGM1Knobnwv67yQO8cDVcvIQSg
	S9E5aXpnGIesjAfx0Hk8d1i9NFP0fG8i3v4TlPmLuE825+Wt8QYeoNTmONg6yQ==
X-Gm-Gg: AR+sD10Kf5AgfMjlsmQdwaSxQQ/wnBlG5haNxgvOoQloGnvuGlowFL3fuHt8ayxZZy2
	GRXEgaLdnCtGHKHVmPJlCd5Xz2rkq3Zn8n8rH8TJtbYruDc6ynx9zzTXVaBHxLCsRBKXz9y0ORK
	sgh58M/BdV3lqb92hDbNgxsqryVYjmpqB4tJP+3Y8kolwwdKVLbB/ylFVNO8kQP8Jlthgu5yHPU
	1vIj9BDboii6YQGZ7+kz7R0zJ5NSxfxZEElFHpo2iyQWasxlHtIPUdJjUWejN+9jmBRt1wO5uVX
	vOz5SvElvevWL8hK7o3UavNPHe+AhKNXmWlZ8j13c+QQIEW6LX2Nueu1FBjW3vJBs3xIc4Wrjq+
	iFOI78M1GZZr6MxFIuzdi7s3HM27qt5QQ3sXUWVfruFFefqdiEs6G9DbwIQhu6+lzv9SV727tTM
	hLn4rgDz7kBLhl2t/Pj/oJEscVwOqqOEB4TwXhvSmKS1p0ZLHW65kVBXT2GUNRp70BdBLPX4+iH
	5mq55nOa//wl2XXB5dgsUW/58UNc7JSmRlRXu9jK5JaGSy93P5gPk9ubwCFZQ7F
X-Received: by 2002:a05:6214:5910:b0:8ee:756a:f1cb with SMTP id 6a1803df08f44-908813f725cmr195379296d6.28.1786025621639;
        Thu, 06 Aug 2026 07:13:41 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9088eb7e978sm26638136d6.42.2026.08.06.07.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:13:41 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] checkpolicy-fuzzer: drop invalid assertion
Date: Thu,  6 Aug 2026 10:13:27 -0400
Message-ID: <20260806141327.101661-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checkpolicy-fuzzer has an invalid assertion; checkpolicy
intentionally tracks errors via policydb_errors and does not always
return non-zero from yyparse() if there were any errors during the
compilation.

Reported-by: oss-fuzz (issue 471491765)
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 checkpolicy/fuzz/checkpolicy-fuzzer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index c58d10e9..771b52f5 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -106,8 +106,6 @@ static int read_source_policy(policydb_t *p, const uint8_t *data, size_t size)
 	}
 
 	rc = yyparse();
-	// TODO: drop global variable policydb_errors if proven to be redundant
-	assert(rc || !policydb_errors);
 	if (rc || policydb_errors) {
 		queue_destroy(id_queue);
 		fclose(yyin);
-- 
2.55.0

