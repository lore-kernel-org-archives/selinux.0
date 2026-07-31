Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB343DA31
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511798; cv=none; b=QfByDxPeanGq9Kjg0O2WWJT5KtE6bXEP2v3CO72K0t6VrErbdbR/3dXdGVdUEeQo8LL1tiQmsgj9NTPh7efd+3sQ5EF5mzo03CYdl+/6jXgSYsk2QWDqV3Kw7r3JyMihjxxBgj9uGCQh6qToDdxjBkhZrDs9BI8nSLEyQayxnaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511798; c=relaxed/simple;
	bh=K8rV0h1M3t2cLUqWpOvIfofMxze0JUgi7z5ikCTl8z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rK/7/ffgVGs0cB4ykDFB1s4lWFirwO7pYeDyKVahWza23nbb5ZBwQ0Gmft4Fp4wfQP7R6kgxh8uVUh7CJ9rjsGNThgEgTcTnQRiErAY0gOKKZEpEByAz1/vdr/GyqLAbPc3oSv8ctqJr4vTCG8d4NDKL9fipOrme5N0LAXWdfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoV8cDzA; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoV8cDzA"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f0e5e36912so6555286d6.2
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511794; x=1786116594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mt76mZ374d8ZCDDLBZR+NwooBAJ/Z86k5N17UOS4HmA=;
        b=OoV8cDzAfPWs4UGnebBewpBPzcvccpsrzTecnCaImIGbGVX1qJnTRr7xNqHDOzycZI
         Hr82DR6DeSCQCflLO47oEyQYd/i8HZU38zF0kFGLq9KOKQ24MxnKoNoS3HtNl/Nf0sxl
         AGhH91mdN+D5KbD5t0cSt5doFxAMWbOWlJnJdy8aqFZ32a4QBgAO5UD35gBFGpTPw36x
         Pb7gHaMNSlf9HYtGbAQnYWy14NLqcWgFWe3aXobADPpOZ5sM83zRQBNUvhYXUT5aGsJj
         rk5LuUliOVrOj4JWkT9l/RlVZTVSBwdqc/y//4ll6xxxvgnELAqJWcPFJiYwvQAbe4Yx
         rRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511794; x=1786116594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mt76mZ374d8ZCDDLBZR+NwooBAJ/Z86k5N17UOS4HmA=;
        b=byFdwEgN84VtEWMgCrZMcw1DaDO/VY3v8uKSeIHFomQzsdVIzz30nVO4w/2ztKaARG
         S4+CD0nYn1mR+KQ74GNai5BiItvvDqZgGYF/G0+yJ+OSW7TjK7kWqiLRYTJ5eQUI7a93
         S6B7qRtZ/HQawXjQFS2MwRLkyQ/Kr9xuTv1ynAz8OxPsi7D5C0sHUTCejaSXd7gGEyoB
         pLyZLUJqa57h5a8vd3rQAeui/c/ym6/lCwdTMJg+cPnxa6WPjPM+LdguTrB2faM8IP4s
         n9fBZSvFdTmrZS0VdFotmhahSFee/8CuejMLEoNq+7YbK6ObWyPu3L2qxrnMM+XpbrBR
         8VFA==
X-Gm-Message-State: AOJu0YzeccrDwNVt3dbmzX23i/dxj3+jhjc6GQUczF2VTRCIH2/CSQuP
	Udeest4cTJS4xaPZych7LR/dTKHpEZ/HcrlzGC8qsXna2+ewviBZ/ZFXBU5Gnw==
X-Gm-Gg: AR+sD10v5ktXOWU2iVvksCTRodBVZx9nhvIpTC+2K52bkoKIrzQ2FWM2oaLB0owbmkH
	KRzu4SqUXXF6xA0lOldhTLBOxL2qJr5yKNLUqfwsbD13uYI/ZbJdonI8JSnz3x0yiTpo+MlH4mx
	YQKicmGd9oCMfc1zPaCEEmFzYBBfJr8t3v3TN+ULdJCtYia24y23y7uXrBX/06SaHXvp6nnB1fl
	RMJKxDuAq0GNnXO8S9YldYfE8fubuBst2TrCe3N3T2ZXjgq/11XIPwXK1eREQDe9kaItk1msJl8
	EfJWhZ3Z25jpV1JbPXkaU3Hab2kUDyonLIQFt1CfwFQQAs7Y2INdvaJYucnjdBgzQWsr5Q04oX6
	NNlL5RisPDXcS6b01oRw1ImPknra/WhCMVTj9BOUqv10cD72ZrX8v9IHMsC4clH8mumM01AjVPY
	v48rC9cPMFby5bfqPirOMphFclcyFvCYuhmD0kRT7PTfE0gZXYaV+5uhKd5DEAD6pE43At4lOAa
	jQooTFLl9SdWgXY6ayzCbFldI9Y7pQwSbYII0YixuogWelQp0Yr8Ex/E4MLSHSP9qhrFrih9XVr
	OU5X+xnFmXY=
X-Received: by 2002:a05:6214:27c7:b0:8ef:cfdb:29ad with SMTP id 6a1803df08f44-9084954f154mr5767696d6.2.1785511794453;
        Fri, 31 Jul 2026 08:29:54 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908434a2bedsm12610016d6.17.2026.07.31.08.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:29:54 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] README.md: drop broken CIFuzz status link
Date: Fri, 31 Jul 2026 11:29:42 -0400
Message-ID: <20260731152942.17268-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The status link was broken and I did not see an obvious replacement.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md | 1 -
 1 file changed, 1 deletion(-)

diff --git a/README.md b/README.md
index 08e82d0c..93a464a6 100644
--- a/README.md
+++ b/README.md
@@ -5,7 +5,6 @@ SELinux Userspace
 [![Run Tests](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml)
 [![Run SELinux testsuite in Testing Farm](https://github.com/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml)
 [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
-[![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
 
 SELinux is a flexible Mandatory Access Control (MAC) system built into the
 Linux Kernel. SELinux provides administrators with a comprehensive access
-- 
2.55.0

