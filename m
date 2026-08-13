Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8628B3EB7F1
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648385; cv=none; b=YysJoVWMESsDenb8rEs8ItwBmrgdeg3piC/Y/FPgGKdGD2ATlyJfXBA1UaMA5GVuqCje9+6aY2+u3XzIPZqU1GsDkKMuX6cEwdNzEGUULVfrFlJ+MtHIlCj4A3DJmStjQ2FGHpgpP2pykyNB8eeH6gN7FXb4OudiI8YuOEIINdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648385; c=relaxed/simple;
	bh=FKfjjneH/1Zz0MrBGaaKiwoyTcYaTcXdFwMnqhWkffY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4K+k2wZrqGf92n9UE4Rxa/0C7Jb3Hh1KLdcZZHW9jlyCZ1Ys/SD4CkzWCCLcn+DC9Qzrc8g0Os0lfqWYnMVAW+oDOfYHIs0CTcW5onxvIRHHxHgRp262fx/exVAFkHYANiTjLa2NyReL85XjcyhSXNa8MBCEuGVHgqzYU0VFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fhauc1o5; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fhauc1o5"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bfa429aa6so8519211cf.0
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786648383; x=1787253183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MhGltPvFlSf1FwjltOtZnxGfLT3VbYSf+MNqZGRh0q8=;
        b=Fhauc1o5Obb5u1EOv5+GNX2rO47L1g/vFUBZ9RaLSXnyg+60QcH4Jc1Xujx3IPKvC2
         arVneOXiAzIB3hfLRq5P67ylcOlwcCHmWlHaB+Zht/8DhZ/nZjRqvSQVYX7BiqVbjNKj
         JlrKmoHmMYsaPGZLtq4S6VUdlejUsq8843tNNA+dN/66nHBAFJ4SSJVCHaEhsBX24Lzg
         MO56gfVPKP3lFoQcI1nas4d2T1QbMC0Vd4FiFut41C5EcmV2uAPkl3Fo7ighxh8+M+yY
         z4AMdQVLzuWtDAwOejbwZ1bOrzUZ/oXKCjzRitYm1Sh1B0Cri4UC8ke0avbfuNSK/hHc
         V6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786648383; x=1787253183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MhGltPvFlSf1FwjltOtZnxGfLT3VbYSf+MNqZGRh0q8=;
        b=FzcwlnTeKtld4FUWG8wgIKGmsEGrEmJ6dMGfG2xLQlvZDOnrWl+k88FjEaGAiiGlM8
         k52CV+yJoN8VRP4wuh90/8PhmzZ94ZwVEdQ96l8QTPCFOq5qNEeHS6VdQTP6ZQ4gECXu
         NNByrKHR7zc/fofjljIEpHbFDT6z1lGGC2BnPVVCtOOnV4GsHt59tvR7LbCkNhmQAPEn
         c4ECF4SUc/9dIIJVQo1AFvsEO+9sywI8f5ykHnLQkUIIZmTDtQKceuTB/FDqijSXqmcp
         2kAnSYl826f+3UhLhbCwGcOMOUbMTwnh9RvtvAm6kNCDs/1jOkkNN1jU7JpH9Tasqoh4
         x5fA==
X-Gm-Message-State: AOJu0YwWcsZFhEn4APJWjYCVepivNHG123+c8fAyaGoO892s845b6m1d
	EUFQCLHgSmw5Iam+MTeQ/hG9aSUevYJKNw1KX29eLukwzZF/pLXbP5S+yZkMAg==
X-Gm-Gg: AR+sD126Ix4CGWOPOfWIblUw4aO5uZ3AtXlvLyBXAiAHXez7i9iJEKQScikKr3Rm2Mb
	2UoVi980tpW43kRm/hEMPL27VmE8kbQ4JEkzM1nMyIxGyI+LD0Z1uVbXj2V0gZMa+WLLr66FRGw
	unvjaN45LvDDjXQECMx3L0Lf45sbilQjtRbqUuSbmJjmtoEZJQ+MzFfJCr4GX2n/BJI8On5627o
	zDuQO4UvFwO3x04BFMbH27ANMyGVMnngfYgYsKlNuVpjZ4hm/lMV9T2eBTl608G90ecl+g6Pfg/
	2nVMEStQGZHJK5+fDPk/Sd0ImSmk0xPi3X1Ro6NQPZR54wkvBesubHoJWQ6FokXOYDFipXRYyOR
	U/rk5yVUu/nue2rLwiTR6XpCJBwYM0Fi81XjwS33UT0ntPq3psx78p6VRvO4iOl0JFhkHdlYsGj
	3UGPRS567Vr42MK5VcZ/c0czD5eL5t9Z1wqJeotH6IneEAYJDmB6iJvLFYy1U3+hLj67AIbhORB
	p9CEnd7gJzJmIBVqWl5FPlXSxXYqIVYoMyP2eOIMMoPYrKFzkqc1xHNHe/95jke
X-Received: by 2002:ac8:5cd6:0:b0:51b:ef78:4062 with SMTP id d75a77b69052e-52d84ff2ac8mr5224771cf.10.1786648383211;
        Thu, 13 Aug 2026 12:13:03 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d84071799sm2797801cf.20.2026.08.13.12.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:13:02 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] .github/workflows/tf_testsuite.yml: skip testing farm on pull requests
Date: Thu, 13 Aug 2026 15:12:48 -0400
Message-ID: <20260813191248.196973-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The testing farm requires a repository secret that is not exposed to
pull request runs from a fork, causing these checks to fail on every
pull request from a fork. Skip these checks instead in that case.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/workflows/tf_testsuite.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.github/workflows/tf_testsuite.yml b/.github/workflows/tf_testsuite.yml
index 7e3993d3..3d7cf081 100644
--- a/.github/workflows/tf_testsuite.yml
+++ b/.github/workflows/tf_testsuite.yml
@@ -5,6 +5,9 @@ on: [push, pull_request]
 jobs:
   tf_testsuite:
     runs-on: ubuntu-latest
+    # TESTING_FARM_API_TOKEN is a repository secret, which GitHub does not
+    # expose on pull_request runs from forks; skip those rather than fail.
+    if: github.event_name == 'push' || github.event.pull_request.head.repo.full_name == github.repository
     strategy:
       fail-fast: false
       matrix:
-- 
2.55.0

