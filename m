Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130FA1EB4BF
	for <selinux@vger.kernel.org>; Thu,  1 Aug 2024 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540909; cv=none; b=Ksl4AFBAEMDbSCRMsNrcLfC6ZajJ9WqbFicb+JOxAu5Vv2HIHjUKaQUIg2o8Bzr0QPpXMVRm69ydogWkcIns8nxY+3z9l+6P33cHTiCxUkJ/tyMeD6sDTqmS8C+ypyCCey9nhvR0QOJKs62vZYWFG7Hs04q5yByiV15bTM2mPGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540909; c=relaxed/simple;
	bh=Hmi+5874c4M0nPo7yAj0VUVDYsbRUzxa4xBsCk9TVe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjTi26jASilJ/SGdO8r5ZGK5CRukbGIl41F16bmeaPGo0QmvKsh80+6oftRfeYE0tEWcSzn/3TYabaHhQ2XkKqce3Ewcc0qc8suH0nl3A+oTpbLMFac2QR/5wElUAPps+hwmUfhETqNgdvz16uWl/m2FlQiW12m0AFihtavjVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siderolabs.com; spf=pass smtp.mailfrom=siderolabs.com; dkim=pass (2048-bit key) header.d=siderolabs.com header.i=@siderolabs.com header.b=VtylXWwE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siderolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siderolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siderolabs.com header.i=@siderolabs.com header.b="VtylXWwE"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso86309231fa.3
        for <selinux@vger.kernel.org>; Thu, 01 Aug 2024 12:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siderolabs.com; s=google; t=1722540905; x=1723145705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FPlEdysaS/FI3ncm/I2InwTq5DBw5C6NLnSq0DnztVc=;
        b=VtylXWwEd88bZUKuG5phE5D2U+hKEbralx5exl2sDrLyjjRNw0qeFzCtcfD1T/BiDw
         ibXrQ10tndm1pLaEqQkLbtys5fdIAmTdoAuwsam9zwe/1mlCH6rolg+7pM9XoQJB/Nt0
         U/jB+f3jVWx+Cq58zRDltk4fsvge10HlETLHyk3OPs2fe0XwneItW2qc6GWLAHbHfRH1
         QSkzy7zVZl95phQJmOz331CIjHNj8uXhb7KdjSKPmT30AqwCnNhj31ijaraiXGwZmpuG
         EuC6OXbc8ssbg595v9V6fJszJr7K9YZPra/sp0VoF5tsB2OCW0dmqEIDDEAowga93ap5
         EwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722540905; x=1723145705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPlEdysaS/FI3ncm/I2InwTq5DBw5C6NLnSq0DnztVc=;
        b=lbC06gnKcYrWZ3ZxAxRWHcKMcoMjtgpaeuIHRg+P3jy9MvaweUWr9WUrtlMhYgeL+m
         84KNc66kxOka/R0LEMItfT8IYlAF+0SLvk/7Sl0Vtq0uCqhPLWgF0PayACGb2rGQQW9+
         xOPrYbuOy0sSpAo8WG0bH3zIxnGLdFAqC2zh6/gP2ptFKh4ycuOcE+q7wvDLP5+O6lD2
         H7y0s8Me4MCbnChfKP50UqcvR7X7wGFTjM7JG6il6gIz4EmMEA0XGx/DR2eRz0TmkaKj
         cIgu4Gs3ibvHGspWiIeEEHA6sr66PFqsS6IorXQ2drirSIElfFzxkeIIym6Rg96iMNaW
         JutQ==
X-Gm-Message-State: AOJu0YyRo6xjtffj03eZ9TB2JUnAkFcvwXRB4UpZZtqjyn1BNC80AmqG
	YN7+P5iLEnZQLPLPYs8pZx9R1D68PsdDQn00yVrR8uodVQNprCznkWphInvjnLMmwdZK87tpJKf
	+8QA=
X-Google-Smtp-Source: AGHT+IE9cn3idU7C8dCOtUEfo7ouqYfTS47PLI9MriLferPLIgONlILsPnCro5HJdzWh0kGGuQk/jw==
X-Received: by 2002:a2e:87d3:0:b0:2ef:26dc:efbe with SMTP id 38308e7fff4ca-2f15ab1c2ccmr8316551fa.42.1722540904615;
        Thu, 01 Aug 2024 12:35:04 -0700 (PDT)
Received: from localhost.localdomain ([85.143.112.108])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2f15c47e1d2sm305401fa.133.2024.08.01.12.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:35:04 -0700 (PDT)
From: dmitry.sharshakov@siderolabs.com
To: selinux@vger.kernel.org
Cc: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>
Subject: [PATCH v1 1/2] sepolgen: initialize gen_cil
Date: Thu,  1 Aug 2024 22:32:40 +0300
Message-ID: <20240801193241.1627605-1-dmitry.sharshakov@siderolabs.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>

Avoid errors when adding comments to CIL output like in audit2allow

Signed-off-by: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>
---
 python/sepolgen/src/sepolgen/refpolicy.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index 2ec75fba..32278896 100644
--- a/python/sepolgen/src/sepolgen/refpolicy.py
+++ b/python/sepolgen/src/sepolgen/refpolicy.py
@@ -1217,6 +1217,7 @@ class Comment:
             self.lines = l
         else:
             self.lines = []
+        self.gen_cil = False
 
     def to_string(self):
         # If there are no lines, treat this as a spacer between
-- 
2.45.2

