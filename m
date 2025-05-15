Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAFE29A310
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314662; cv=none; b=rkEkEIinJL1QK4Ciib9aVvhMYrGPg5OaPbUIq19lcd9qM9RS6GtL2uj4rKdsSvVkz2r1wqAyrpWYjRM41O6J7YPLypTofvNWmPki5a4kM0UBono8v6q9B5uRIYhuAr3nJ3mDsDpTpOcn8mmh5LU9r3PvjxCUE9EZjj/SPur3VKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314662; c=relaxed/simple;
	bh=3ts407Aad6q6vC9S0fiyrIW7EwOWaRXTi75ae+wIAzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjLWqZrFEzv5hNc2ovCUmSo8bxw3N3ivnZ9t0guHJXy28iKmcupSvLeAl0YZ4pxA7WHbaQhNYX5S2ORXqmByM7Jex7AuwQXoN+MTbBRZ2HzfY63+6U0HxAP423Ck5mDT8y0G/KE3hsYMXMIZWPuwY2vNFILj2UImAgEuGujOjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0bbcNrk; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0bbcNrk"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47692b9d059so14051001cf.3
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314660; x=1747919460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f75zUXlL6H/GM23zYqJlj7sRTcInCPMeupfXE1c/ZAQ=;
        b=Y0bbcNrkuH2ZdR0/wbLRbi8A9MsWgyMmoxLSbV+XG3V4Qz6ZBDvduymXWSxxN6XR4s
         x2m8yxoDwFuiZIJ+0HMFNlbMO2lt8hUsstuXcBgzNj2UZIBc7gxVOdVrCT7IVeGvAF5o
         4qGzkPX4bpeu19KrGyW0fIDRiZ8qaVQ9QPzlgF6iBgB6qwe2bIHMytuir9g2WncZsuJK
         BNIbyBFt66Zt89LHj7Oz0jIewZu1QY4/yjNDnJ/enF0MoE84+UatDRv+X0iKtd0zDCpO
         k2WzbimMz4pkSlxUtJUINdLm6Q3xxt2n3ALOavdzthU55xC3ExG4kJKvlG/b4/duZ4OJ
         mRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314660; x=1747919460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f75zUXlL6H/GM23zYqJlj7sRTcInCPMeupfXE1c/ZAQ=;
        b=XaxZmwTQDFL08y8SVVxGjLQqqeLc4keSjGTXO7W9rI9Uff0Sa8jMJd4pDFg4biwIaK
         Ep16865Az6TwJGhjCoDvYM3PkUJwkLoHhOmbOsD9casgaxVBalL6Fz3SYyx80gfuNASd
         fIXS9tImgR0ZZGql9RlCsFFBDdGBsegnycktQK+ZOGWm7LHN8OkBLmgwHCEfsA/Kz4Sc
         /r/3Tt5X9ybFLfpPzHwHZRo6KPRPVbkjXXihiyxOJUZv++UlXZwR1HVqXO2B7dIw5Tjl
         naJLHx5vFfUslu4rEioRAFPP/1HSOu0tW4c2qm3xEJDVHorM2ViCIH0QrILwP7NnPBwq
         kGWg==
X-Gm-Message-State: AOJu0Ywwjeaov68vpTOIiojWViUXe1982Myp5AsjakzH8rkY5izEtz2r
	bg4aDrjz46CfaWfqzbmDGJIj4xIrkce0gjlasKwzFKKiauSM/wBUuFQXrQ==
X-Gm-Gg: ASbGnculxE2+FCpC7TdGpT3hgDNe0gCT4qW3YhCGIDoKSWfnIWSSbAY53ZmVmYW98V+
	jZivRdU6Q6TISNjcWaowIuB6sVVuqB7w9Xt6CxNi6kFy57CUD7b0BcJwL178yLz9WGDcTwCj3Zm
	awcKnb9NbSJE+c+q99BL4PSXd8d1y7E0uR+PEYwa60RwdogGYze3Ox8/O94goQBbwp51E5ut3Tl
	ffCN1wu+G2wLatL3GrtOv1X2ehDq+WmF00lEyeLkgAWlJ4pq8b9k38jfVbaJgJKriRF9Tf75swo
	8LqnwBlEulyti12jrSJ9sM6y4E93EJABL575fUiSwkeiEtj7aU1C40JZUV7ssbWLLgQmR5rMmBG
	gI6Leaoxw7L1SsQFgGRcCrjQzY7pbrm6kJxCnYv/Q/jSEXTXxz6BzGA==
X-Google-Smtp-Source: AGHT+IEsMZRfyNxy+68QHMa2/XU4wqHMqgNjua8WcOL81NVAWui8+uzpAZFxXRqkOvaMxkZi7xg43g==
X-Received: by 2002:ac8:51c4:0:b0:494:7bfd:fca8 with SMTP id d75a77b69052e-494a346aebamr35431141cf.46.1747314649122;
        Thu, 15 May 2025 06:10:49 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:48 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 41/49] selinux: exempt creation of init SELinux namespace from limits
Date: Thu, 15 May 2025 09:09:39 -0400
Message-ID: <20250515130947.52806-42-stephen.smalley.work@gmail.com>
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

Exempt the creation of the init SELinux namespace from the
maxns limit. It was already exempted from the maxnsdepth
limit by virtue of only applying that check when there
is a parent namespace. Otherwise, if one were to set
CONFIG_SECURITY_SELINUX_MAXNS to 0, the creation of the
init SELinux namespace would fail.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5ac5c3e34729..66882d7f678d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7835,7 +7835,7 @@ int selinux_state_create(const struct cred *cred)
 	struct selinux_state *newstate;
 	int rc;
 
-	if (atomic_read(&selinux_nsnum) >= selinux_maxns)
+	if (parent && atomic_read(&selinux_nsnum) >= selinux_maxns)
 		return -ENOSPC;
 
 	if (parent && parent->depth >= selinux_maxnsdepth)
-- 
2.49.0

