Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68A8221DB1
	for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426041; cv=none; b=EGExS02gRKXXRrC5WNkcB0vI6u+iTZYaI2kNXKBa1CBBxN83Y9/RknRSkYj60xO95uxk7c2GishTd9OUfcmY3ydq866uOqGhILfG6+sDp0WZ1SntwZtX952DkTX3C2Wf9lNznfyIfm2dF7wgCHSv5IrNc4lBbzFEEO6+4sQqxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426041; c=relaxed/simple;
	bh=1mMtdGRJ3t53cn+j8/XyNg/pXLPNEbbCdSXEvie6G9s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JNnELf3nhoDuJi1Hrvmf8g1+BWIlMoLP+H3f8Ezgo+Qtu0XEka2Mezy+EeRPo05BYRaz0TFTZZHKItSncXSCZwKmL9a6tnu1vyo9MRtgoRJoIeJvMAj0hmCnWKudiefIro0gV94a7dYWN2HYHnmR0aejKitSizjg2v6rvh6fGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bhrWlcW3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bhrWlcW3"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c07bc2ad13so18116085a.2
        for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 13:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768426038; x=1769030838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kDYfaqYaSpy5RcP9ByWgz8r6jpXpwIWbrHPc9eTMQFM=;
        b=bhrWlcW3EpYGixCTcL4qqjSHfGoq4DTWJigU6Ctz7kUFuE5ddXq7ON0YQvOmmcsJyL
         MFe1Xt9nY1+uik4cmUU5blfCaegIoPTz60aUf2/pTZmksvD1NwTL9nxDdJtNzXBSdvP6
         oiPDNA4F27yq0RQSiyV9ncC4yuuhYu2qKYRcMvG+GnSriXGWi+bJ6U0ICAXNxJaypxHL
         g+7nFXJ81lUq99Xm+T5jpMx9+BesU/kB2a//qKbI/Y/NQ9WtiophVwYdYg+Oc6mVd08v
         RzBF7tXiSEhfL1FaB283F/Rg3KETLifFBl3diQoAmDJn0zGtBfxKfTXTixMe2mYJrAQp
         DP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426038; x=1769030838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDYfaqYaSpy5RcP9ByWgz8r6jpXpwIWbrHPc9eTMQFM=;
        b=prPeE+RDU0p1NGHxS7fncxAzWWsvqPuZ1Fh6coBgm5rtJrB1HeJXorQHCiXZdZSYl5
         zf/MxKi/dw24qn0emRV+8RZ5bUCWpEnxki+Zfsg8USEQvtlfzvbbvtrJRJZNiRDv853h
         G0q8o3sjm1wIvkPVZAQfU1l533dwzj/TsL4GYxC04ayZe6kSoloBLJ0tjUmy7rmEs94u
         kR4uemQWkPHflcUc8gG/mM+ZSo2gPFPG7heOoNLYvhGcGDj53WH5AiwZc8xU3oub92Af
         ZpqFsoYYrbNx2Ko9kdkSqh2zWpNJDacfdhFuA4psxNxKbvgnkC7wDcpo2xscB/QM5G7H
         98og==
X-Gm-Message-State: AOJu0Yyjpj2DUKKn7SGkBArpsFtl7vxHhkr+ByAn5Qp2ppOB8LNXCf/e
	4BpkBsR4uBMX++Lz/MrChw87qusp0MNjvjyKYKsJc984lNoVLa8q/G/cQ4Gb54vO3aQngO2D1q3
	8MTc=
X-Gm-Gg: AY/fxX7KpqdzjGcja5aU34w5+ALLNuXbvF/TYzZrZMh1z7B36WHs20QYVsZg+eDSXFf
	rfljFZ2RGrWEPukDyrRPcm9XSlmKTjhLJjqZYCZzBsD9AiCvS58KcqTgXuUUdfc4F04JruSKgyQ
	3UxF0Qj/BBPS/1lzpqQsjQETKeV7va4wlmO0FYWh52AYPf39H+7+YwZ4zJpxq9y/80tKVMfjWKJ
	hgPmvYTvXAPTF29g4iBmt7HViNYjMWQydxjY08PER0pNEHDFycvgb1FF4fmUJYI34SLbyLTO9EI
	z/kwAIsSw4XEivgrKsNyiuAZ24rgDQkbGhuu3DyR+iTlOLFwRSloQeOjIapNV++6o3qk8p7cktb
	Mx6v1fYEuilI50FCmXzHjYlHTgowSkWXm0dsWhleCiI5EVJFRNnEcmRfAMJwMjcnVcX0vwtSBDO
	2tYTOSJ6NIlPViSF/VgVd/IXi8BQ2vZAlGgJ2ddcMBXmJlKFKK3vbrq5dl
X-Received: by 2002:a05:620a:2588:b0:8a3:cd9e:e40e with SMTP id af79cd13be357-8c52fc0e709mr566151485a.86.1768426038304;
        Wed, 14 Jan 2026 13:27:18 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530a92553sm242101185a.17.2026.01.14.13.27.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:27:17 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: drop the BUG() in cred_has_capability()
Date: Wed, 14 Jan 2026 16:27:14 -0500
Message-ID: <20260114212713.296107-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=paul@paul-moore.com; h=from:subject; bh=1mMtdGRJ3t53cn+j8/XyNg/pXLPNEbbCdSXEvie6G9s=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpaAoxurhI2astAF+nZy0nIGCn+18kug1thL5fq yR8gkvJRiuJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaWgKMQAKCRDqIPLalzeJ c3/1D/99Gj6B5mr6Y2Q2Gr/ujhSFNnAqBDfhxn5xHJaQewe5lJ8BqxrAv7OvrybgbPQ4eCjtKXh D1EXokJ329kgTrHp1N+CY3QtvHq1n6cKV5zN2l7jG7qKC8CcINlUzpyjWJmjx3all/afP6GbyhJ q5yYsD83EsbTbwJJRs5RB22EQGbaB/L8VClfN1Wig8hUoIVYRcfjTuiYyJiDVS+vDwwCkUM4vat aIMwJcA1fymJj2BToEbHvuPqZ2isv5/2IJP0W4BxkWY51S0mVO3E9icGAInwC/902P1oJw1snqR 0dlxtvn1bG+gmXg5GLewHriGlVA2VM/XLShf+1fYhy6AJHiyk5ooC4sRFdDbdqmLBn2u9uh1w9u y6DSGHsTb2KIGKtLB+ivCGQbfXQ2nN47I0GskxHy5kQyZm49qevyvn8HM4FQOcl3yStHZrMI/Nf hTSjxb3gy+yahCWXGjM6aUrhOUeUIjacfQa4s5JfDcQKS6A4uWWOlcisQE02FmOJbaBu9JBUcv9 8e4/FMngJbPmb7V6LjZDhW+5hyGFcATRXDGsgExND2FL462DNXNahPKv2VWeGYn8kl6ucmzFtOS SkTD/b4sElJNprS1JytJ0ld3cMod37lgXWFiyui1UmwEWr787O7b3EvIa95zWsDfDJJfWXvKmXQ ttS7SW4Jami/l9w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

With the compile time check located immediately above the
cred_has_capability() function ensuring that we will notice if the
capability set grows beyond 63 capabilities, we can safely remove
the BUG() call from the cred_has_capability().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9289ed89a8ec..feda34b18d83 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1659,7 +1659,6 @@ static int cred_has_capability(const struct cred *cred,
 		break;
 	default:
 		pr_err("SELinux:  out of range capability %d\n", cap);
-		BUG();
 		return -EINVAL;
 	}
 
-- 
2.52.0

