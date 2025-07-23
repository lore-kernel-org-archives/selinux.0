Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0A1E7C38
	for <selinux@vger.kernel.org>; Wed, 23 Jul 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295230; cv=none; b=uwZDImUnpHU40fRJJFQYj2QoJI23uq6XKK4Ju6stnGtUV3lzVXEpHKLuKdk7Q6ETxFitovJimE4H5vQSrB1+oi9P1wu1XMpcDMzvuKC57jFLkNXIKkpUx09/iVmFDHXlvdAq8IdPN04HPLWZ4CsxMzlCQ/5OJGlIPfkusqIBUXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295230; c=relaxed/simple;
	bh=Y5BQ+NE/cClPMvzAiUp9uXYIo9nHctfbiAs0zfTw2/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lG8+qSEuPrxio6d+9P9RHoqdhWIHuiB2OhLAF6+dyOHX5etXL60lbdeA7vlPYscahXnC20gmk25BM6hLMkdyzMWAwcLj89hJxtNqNf2om4Bi91/oeBXtZrLDUKBeerHR5cmmneax1dWWngXCFk1iaOF2f8TOOvr8ZapeRH6qPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmuJN5+5; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmuJN5+5"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e050bd078cso19683085a.3
        for <selinux@vger.kernel.org>; Wed, 23 Jul 2025 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753295227; x=1753900027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBrtjngQMD12dJeSH8dwKTYZuShLe7o6rR6FKejZ3CQ=;
        b=ZmuJN5+5XbZzDR4/WTnPUaqnQOWB5Pm6akMPQxINZndvHQgOpvtJOxE4S+6yVWJzG1
         NqLPqr++j3fwGSpLjFVF+EnzeBwynGGT7HHN40yRFFfxlD6853vWeuiC94WUmKvVsnjx
         rm3AbKpRBt7+D49Sx9AGPHcAgBWV2scZkL2SU74CMLipkYfORHC5b/dzfeyPlyDiA0Gj
         gDHHODBiHvENIxhsC8LJk9Pn5QS72a5U/Z11Q0mfa63SH3C1T706AdT22uVO4T9C6jr4
         LBrtDLTIOv5lZfEd6ag4thZkCvlcCh6dOWGiDNXdnjK+QAPei+n9USmQPnuu/eW/+dVa
         3RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753295227; x=1753900027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBrtjngQMD12dJeSH8dwKTYZuShLe7o6rR6FKejZ3CQ=;
        b=fX6txcgVHw1IG9JBae6TAEOorQiZqd0HuTv4vULlapC4RY+yEhhdjKBOqXvd3bmDls
         owv4cZ6IXLXY8kgJdXmSxfutU9qFFlR6za+6FwMcl03IQMT61K2gOuc+htM+Bh7NBxHs
         L8e7S+bbQUV494S2lqKBaw3Su9L0qTkhFktslR0D4wLIbzDCsem5L6GPNZBzyqO1Akj1
         LwLNg6wIDBeVeqUNIeJAhkQVkuJDT57GVayJfbe+zjWnXobKvImaig8en4kM1cU6jCUT
         lgDzsbZSAc1w+zibU5o8IY0FgrugThCkzucSKfKjAaq9cEW8xVQRWHDchxFKIaWsF17C
         Bw6A==
X-Gm-Message-State: AOJu0YzmDi647kpMSVTDP2jlJmaPE4nBh4HMX2GZ+LbmxTwUh+YI2w5/
	Arx85Bm1srWtJWVldZyY9UmRWum/f77coNfxOzU4G8CFL7z1hXYvEh11Bwd0+A==
X-Gm-Gg: ASbGnctrRwOEjo1LF9fRjIwPxLqKPBjhXiSmJp+Tbd76WzuF0dF59UVOhvBC5IGc6LL
	lgdWEtdWMXZ5/b+VxJdsdZbrFMOVZ7ERNTSUlr09rahUo1iCfLfjetdL+TGL9DLHOCanQC6d7OJ
	FItLGPYzIo1aC+tiFsiKWalxA6XpE2vdaswivBpW8l4HMZS5wyp0792Pa1C7lq4DK3Fm4L7dPJQ
	njQ37pmBhkErziwE8aJRmui51BLzQcyQ/6C2mT5nf02KPUxeqa2aJhQjukOPEMkQpEWalQ9hB54
	FiBAPn5NCu3h5XZWAZQHqD/+2a0soWoCn3KrYmP7lJQ2uvxONmqDytywKVeaBfZNZl+cIq+xCxd
	1q44JGISQRo1i/YGDP/+3oBPj+JTtY34T9ZO9prQfOUUyxwIU+Lte7Cf+lZfFZRK8wIwG0iCAIO
	O3q1l6Rh3J/fA3pIqLgzLwxZTg6A2YYBAlou03uF4tH2nxq/mHNw==
X-Google-Smtp-Source: AGHT+IEjMgHUecwBjIFEkTxbrkmTfGeWaTcR+ncOOBqpsuAepyL7slhkSCdEFi5ARfbaRnGmwjkarw==
X-Received: by 2002:a05:620a:2697:b0:7e3:45a8:52a with SMTP id af79cd13be357-7e62a0c5341mr519218185a.2.1753295227250;
        Wed, 23 Jul 2025 11:27:07 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c90396sm678413785a.90.2025.07.23.11.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:27:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	paul@paul-moore.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH userspace] SECURITY.md: add my email address and GPG key fingerprint
Date: Wed, 23 Jul 2025 14:25:51 -0400
Message-ID: <20250723182550.1065144-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This key can be downloaded from https://github.com/stephensmalley.gpg
or
https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x578c4211832f0a7ea2c5a7c221a46e603f744ecf

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 SECURITY.md | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/SECURITY.md b/SECURITY.md
index 4f624f5d..2a7ce5b3 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -33,6 +33,8 @@ the issue as quickly as possible and shorten the disclosure window.
   *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA 62AE
 * Paul Moore, paul@paul-moore.com
   *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8A
+* Stephen Smalley, stephen.smalley.work@gmail.com
+  *  (GPG fingerprint) 578C 4211 832F 0A7E A2C5  A7C2 21A4 6E60 3F74 4ECF
 * Jason Zaman, perfinion@gentoo.org
   *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF
 * Steve Lawrence, slawrence@tresys.com
-- 
2.50.1

