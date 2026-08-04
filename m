Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD584756AD
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859708; cv=none; b=j96+IuWp/8z8tGH2i7LLG5B+OEj3Rs123U0TaLGbWD/pgNEzbonSYC3R8YOWNNteEplClvNeWm98oqYhwfBXIEmb2xBDK77+NTra/eqdG0IL+nPk2w9d/ArgsJfexOqFxStN76yplyAISb4XQhfjes+5GBK6YapPic9K1iuHVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859708; c=relaxed/simple;
	bh=zmFCAkc0fsbPHcEYvsOUZAOhKnTIo3++PH2wlmtbc+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K39ni1xUMebUmc0UDfLS83uwHkWzI50yyCBVUXQR/L6NHFhQ4sSpe6qwB5W72CUwdk0l49GnIuIEQZgxCEMVKuYEattsS0NHKxFAJA8PlvxjTf+F3ZubYarwglxpQTcSBSegzY8EX68qgOvlAM3m4HF5tUUUneGXmBcNnwhdHqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6P/YU6c; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6P/YU6c"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e7632b193so850285a.2
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785859701; x=1786464501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Um0Ck4lTHndUbiRX3LoBOrbvRjuAvikL3pcCM/Oe5XA=;
        b=U6P/YU6cIKaJUgQW1aBbnd7/FpDsUrNPBvEFjjEJsj4umeb3ynRB4UqcMWFAmvgt2h
         oCcaroE8wP6sb3CsApeujfVfMimqmvvQK+o/0eMof8PfoWcDqq2IIQeTHhDN5Eur8frM
         Or/7bQwkMU6ZaE9o22JTCcrjtmFpM5rIhi/H2EbmmstVALkleztoR0lrR7QtMC4Xh2JJ
         fCnJWAWjXNFIlsTEHYQagATnh8jPx0SwnU1Qa3XTBV8sFHDa8Bo569voyd5L75ASAGuc
         8GEtD3zByLGr+69lCCB35DnIzr/UD7+28VWLDhPQEY8wbLvDNGQj0Kf0CvYEkS6Mccan
         XFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785859701; x=1786464501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Um0Ck4lTHndUbiRX3LoBOrbvRjuAvikL3pcCM/Oe5XA=;
        b=B0NWlIHysbG85C94zi0qVOEjN17kcI3ZqE8C5q6qhEN0fEuj5H+aLXHRtHiMF/Tu3K
         bWNZdfqGltk35X1+9WdJb9557YhaYwYDSWVGa8LBAYxp1WJQ32pFJqLEg7kED1UYg4W6
         Ufy8vkPyPvebSyvDwqxaj5fzoZAbU+NaFp+nLDZxGswdC7a7jxpdK/tfkcBE/4R1boka
         Jld4dsHwTpw0IafYfWZdZj/fXXZnpA8rixeFvB/9BgK+nd+p1gdCMF0IKyXSH/t1ivUn
         jJzpxfhLpw/4SzSDXLUmauoSMUFk7iHehP6rnLBSyxNUzXqF++ilf3I9s4OzxKbVFVWT
         4pOA==
X-Gm-Message-State: AOJu0YxLmTKSjiqVlMfDGTr3mQkdW/2FT7BK95S0LbKOj1E7HUw6QKy2
	vHefok6fyi/rg+mUhgdYohNegdi0TkjcF0qFgTAnc9L4PTjv3DREQRUYS0sbVQ==
X-Gm-Gg: AR+sD12ThZ1pDaVfdnkM2YYw7zn0oBLn1JqvYzpMmtn+9kFtG7wqX8Lon76/4klR2LO
	c6TS+1Ys8revHSAmRFvkKblgfdFWA3X4UwtfUK7ZOrDizjDT+BKZomyCklDkbKh/R8tagRxGTWi
	Pc3vjYPqnW7PWcwh1c+KnEtTIFZrYmTaauJ6sx8dXlt+xygfMFBHkrHLZLK/94pMKQRMK4mG0mg
	gOaVpHSLbLDdxUlpOpjGkqAYM6c99YHTzw6uaCNpjda6Hft5YH071A/WHmJcHg8LW5DNba7NfRd
	3h2kdENkeqUjJDdQ0mRmJ2wTildkJiN8R2aEI1UaOffD2FB6MnzhjoPRFFfP9g7nlb2Ug8hpXmC
	BDElbpnYZIWrA374fs1ZOm+5drS3na8yExHmljgWrXNsXOp5CVzUcd2YT1toZxEpOtcgNGLWcWV
	jn+Nh0/YXN3p0KCelO/vbcr9aI4XiGOQpOyKMi35sUgxhNmNFAM+JzLGXeIQ9QRkHiSiCyWsybV
	u2hGpFUEIfiAbbQxqVZ3VFxPCDBWvLnzoQrrq7z7jIIYwP1RROGYWCOclK3vMgb
X-Received: by 2002:a05:620a:9142:b0:92e:e1d1:49dd with SMTP id af79cd13be357-934a078e741mr2219294485a.21.1785859701002;
        Tue, 04 Aug 2026 09:08:21 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93641703383sm112001685a.7.2026.08.04.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:08:20 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] README.md: add Check format badge and link
Date: Tue,  4 Aug 2026 12:08:06 -0400
Message-ID: <20260804160806.21979-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Check format badge and link for the Check format workflow.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README.md b/README.md
index 08e82d0c..fa135a22 100644
--- a/README.md
+++ b/README.md
@@ -6,6 +6,7 @@ SELinux Userspace
 [![Run SELinux testsuite in Testing Farm](https://github.com/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml)
 [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
 [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
+[![Check Format](https://github.com/SELinuxProject/selinux/actions/workflows/check_format.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/check_format.yml)
 
 SELinux is a flexible Mandatory Access Control (MAC) system built into the
 Linux Kernel. SELinux provides administrators with a comprehensive access
-- 
2.55.0

