Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB05DDAB
	for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744472266; cv=none; b=q6LjZubjtBoS302IAFFk+e5E26xrNqU5x7ZECe/NBQD0Lb3Ek10dPrhllkN6M05Di665QBr8rMWsIbnx9RDs1mWk/EoEACfXusuicFxY7FUE/ORzSkZWOKQh4n76FqUWjq6TiNzkDZ/tKwoYgMgddRUUVNk0jDLKSvBGWuLOFug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744472266; c=relaxed/simple;
	bh=U2WQ8gJBCcbdh74qyQifo85bUGxUh8d3wk3kNjk3hfA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GPxXf8f/cmqfkYrdSVw/uCmjz0wWTctCv54NjGPuxHM+wbpZ0TmcHRw72kvUXqI8gXLg85FTIQMzophrJ3ZD/YS03ibFBYzoUFlluyrQVGMDD42LX7mkfMSCfjMU64xSUDJuLRtEQIAdFQPxYQT394lJtQWDkC6sol/tZhUVEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=edVwFPmr; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="edVwFPmr"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47698757053so34288621cf.0
        for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744472264; x=1745077064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKFynzWKu4tEjberjxRUHMP6bqrSlM2uxWD4CCcVF80=;
        b=edVwFPmr8uiBPe8C43qgI5dr9f+t1/xYZUK8IsAvCR6qFmZqkBvqY8PJCyvxvMCcHI
         ZVoAtm8jkKPcNLzVSFps6I2zF1j6yZRsJeAhaXuHAU40yHW+oJRMd9JNAHN5WZam8Ams
         WXcuaVFnReIq5oqHjE0x9BeNYXRR9uDslHP88Lxlwx9IbSoMDmJ2PBmDn/yIaYjIqy8O
         ffKWg1IF9QDz3fDBxIhrJ7OoGImAvkr6Pum51rcS+pR+qOwoakSb3ZJI0Fi0yz5+nj1e
         mp5DxWOBNqq6wW6F+m6YrohrwnqXX94QIVi5tCP2B+MmJ5X7KNFtNyLrdgvPC5s1LGQR
         GIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744472264; x=1745077064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKFynzWKu4tEjberjxRUHMP6bqrSlM2uxWD4CCcVF80=;
        b=NOZXG1AchXtaN22+uw7oJL7CaIkMpheYf0sdurookNZy18hmJZ2rsQPTo2fVM4cfID
         HhjNvXS+BOho2AgQD6v19SlU4/SYhp9K4dldv2DujQc4MMlEV8OogeecOEdDVxHYTaM+
         g12DM9g+1HKzYC2hA/yKZMnN5C2fHONMv7TQ17tDtpELXpAOrZKzoDhUQTpq2c3dzXb4
         VK/Hp3vWZtLBlN42k6D5vYyizmkcv46nGOoRaBudxjJso0S+2RaJaNPRwYyGeJA2IBrw
         KEl33FwYdoIotdORPH10KT76Sce8Uh11wb3HK7RhyuECLlPnSz0vv2tGHwmPpfuPTQOG
         64DA==
X-Gm-Message-State: AOJu0YzRDhr2nA0RT/H1+agBmJHsZzO2nuOO1DUOeOLTAG/MdlZ7eVhW
	JjDRRhYLzM5n/bBGdJlC5oCxmPWPvpLXiW/xZS4H/ptphIKpzZy8fl0KM+ddor8XLFcIh8XTlz/
	tew==
X-Gm-Gg: ASbGnctampI8KFtwSEvGXzocNw/KzUr4Llv1w80Ba2cj164wYKgj03CGAgYRhAkryzw
	rQR6E1yNgv/rJClz6eay1t/ZR0iaPoboFNXLAP64vr1dJZVzxoTp1iux+pVNuR4IOvqpSDjCATS
	X+o5sEbi2L11bYQQ14R5d8AoD+O9LwNAjAxZKSzLj/msxOX3nUN84NuFmxaLNrXcoeeD2Q8BxKW
	6Rsvc0LOCoCwdOWyOpN5XzYz6Lq7t2MANCxTnpVsxjUe2GvcJkgT5pchK5B6pbX//JIW9zeohcf
	/8TDxu6Vqon/mqstezdrxn7TAw5/EKqHQ7gMh1PYPi+qZSnufEjkx6uzRwWhX8hqZobjGj751zC
	e6i3SPu85Bw==
X-Google-Smtp-Source: AGHT+IFFtSn0X4xRo5hTaPDhdWaVbJGNylUK0TXGBGlSdsWriwJnESYzW4hRa6x0pXOcwtwCDBVCXw==
X-Received: by 2002:ac8:5f93:0:b0:476:add4:d2c6 with SMTP id d75a77b69052e-479775e3550mr103031571cf.50.1744472263606;
        Sat, 12 Apr 2025 08:37:43 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8951f5esm416742485a.48.2025.04.12.08.37.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 08:37:43 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: fix the kdoc header for task_avdcache_update
Date: Sat, 12 Apr 2025 11:37:37 -0400
Message-ID: <20250412153736.27881-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024; i=paul@paul-moore.com; h=from:subject; bh=U2WQ8gJBCcbdh74qyQifo85bUGxUh8d3wk3kNjk3hfA=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn+ojAiMTPV4g3dflJhGP6q6oGGC2Pl5CX5yAGr 1EAOD7xo6qJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/qIwAAKCRDqIPLalzeJ c6KgEACij3oF/El8Em+P+zVEu7g+YonUk95VcfeuDqsb5MDskU3UOhY8N+C6ZW6cd9SnERC41WF 8cPX/tk8jmc8KL615Oa/0cyIyKaCsgyjKxLOZfxE5WfUSxfGdbnWdont/HMC5ev9R+Y0M18scxO BfhP9kF/Gz6pRKcqDVlwA/KLh5WkFgtr45ofgDYi6gUL1fhJqe3eE9Tgd73HKfUPjbl4/gtYh+p sPjd1JN09DjPeAETDXiwqV9d4F9QAs6JkTTZvvw7+POmJcsD20Q0mMNH9N8RKKbX7VJi5muyhAH XBQuvhtmw2IaMVnpmy90LELLQ+uvl+1IRdtWeZ3siR66Wak7xmPE9wSSgIz0ST/AUNdMwThCpSq NH7fNQZCUQ5l6X7XVVXYpescKNOg3eH28xhJKPugJcIJkn0GF/WjYKYbMe4qFKk11dfuGwdTaAg e8uJYcozWuHoppP6mf9rUWOspJppE5rZ8ZbP/YLfWDDsZCL7fHnovSMmavhz7pS6iceFiI3Jb2v reb8WUX/Rr8wz5Pocnf2/1SPXpitpLtEFcjhhKDzzJtU/s0dpQQDPBqlPKJvLmFtw8I6+pAglF7 kB4Dg9uMzO6171DEdDVj+HsI9ECikE/KLoJP/V6prQ6+kRMSU45AEqRBwppBvGat/MBKwjvUeaQ 5SKU29PDZMWYIKQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The kdoc header incorrectly references an older parameter, update it
to reference what is currently used in the function.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504122308.Ch8PzJdD-lkp@intel.com/
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index edc9ae81e202..b8115df536ab 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3160,7 +3160,7 @@ static inline int task_avdcache_search(struct task_security_struct *tsec,
  * task_avdcache_update - Update the task's AVD cache
  * @tsec: the task's security state
  * @isec: the inode associated with the cache entry
- * @avdc: the AVD info to cache
+ * @avd: the AVD to cache
  * @audited: the permission audit bitmask to cache
  *
  * Update the AVD cache in @tsec with the @avdc and @audited info associated
-- 
2.49.0

