Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8F82866
	for <selinux@vger.kernel.org>; Tue,  9 Sep 2025 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453428; cv=none; b=hxqxQnQNXnXEp995YLuNM3NupyGarzjusyGDfLaEZggGAiQ/vkOKVtWycLkpjSDmPCHTjAaAJj2y+2jpe+LRxukfSCUIXrSu/vcY82q2CoysXh50N8ZO1giTHB8RmiWWs8r/AwsF4c27QkPIkQSyevQVv7HCfpKp6LHrzx/jHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453428; c=relaxed/simple;
	bh=DGqyMYylBCu6JE+QNVscP/0dscioVFEBw70Nhp5X9dI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=polBsK1TOgKSxzJtbyla05TlbG1888EDOGE2tUjhZbFYIn+eKxZcMyXRsIeSBGOS8u9zfh+TX5iu2ebu9s7J22L0fiCt6O0lsLDVrLnEpVLdOOoIpLvbHfgZTP/p0FoczTkBoXNrhGRjAui1ImLoRTreHp4jfBBtkPkRzJ88Lyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TveqWfBt; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TveqWfBt"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b5ed9d7e20so47141641cf.0
        for <selinux@vger.kernel.org>; Tue, 09 Sep 2025 14:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757453424; x=1758058224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hzaUi3GrUFCPgDfXoCFFB/p6/L9/axgb1V2tqDn5efg=;
        b=TveqWfBtS6kZx7PQevkN9ptvvOUaMelHL6GGPkP+mQgdXotSds1LKr4GfpxAGyCe5A
         dse9UJ5/Ph4INXsz9pEB7luNurRHpoEajyVjXH9CbrjR12qIrxCv6UGkUZm82ryw1oOc
         dFFWlMLhMbBdldRHHCKPggqN7dDYigWLXlhpjV+LuxaKo+nyFaQkCqQdod2dOp99VMo2
         tVRPkQX7I7iipDY/TL1Kb4Yz3QDu7KqbMFLuA8w0xJd1gXSz1JUda1Oj7qEaEn8iGE3Q
         tIGjzHeOKyI7Ci84O5NUsc/1RWy6QcZLyxefwELgfKKKGK847pYL+XD0Dl/XhWMx7KFw
         yGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453424; x=1758058224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzaUi3GrUFCPgDfXoCFFB/p6/L9/axgb1V2tqDn5efg=;
        b=YZUt9bPesSOqBdPS9XX/NYNUlAXPk4MxPaejAYBfDT/ZO1MuhgrKIc65+cA1LwqQLL
         Us3PsA6UBtsMF4yPKxyoTvG2cA5HR0QyE6LaK5KT5nOK3HMkG3cGvoeuX7YHl/ivE+oW
         yfnCzwDQ0N/KkUZPt4TibtmNEEfTUz14t0UMJEzIeMovoSBbaFieJjAAL04eNlx+4YGS
         L4ytt5cW1GYMizqWZM1tjI6YAuFcyQLOMN7SLXRlICgvVMA3gSnDAXz1ZsxM/dVu7NgT
         LBmbni94tNgmXbM95QDoo8MsvslJrTFT63fIdVvHmLtfuG4fZmP9SuxOvzubb/Z4iMuV
         vW8Q==
X-Gm-Message-State: AOJu0YyBj/I1uCnPB5iLdQftu/Ay68avGKYpzjoumyaCe13mO632i9f5
	gRwEGjghxcHb3Zxc2U8Z0261h2GXBKZhGvLpXdI6FlJ+h3v99tOamPoCobwmCanEOAAdFSirTB7
	EBs4=
X-Gm-Gg: ASbGncvxXAmi8v9R1auIQRnfS5citnJ4YvT3X+gunHIyvFvLb2URGRUkLK//15LVMRR
	9s9ycM7NZVLJla2z7Y5Rgf4IAaGLA58oifqkysy81gE/nQ6CJfKW9Wxa7zLF4sXxVLFy+cPk5Wy
	alDhjRzru3W2QqZUVkqEylu/JZ952EvyhK7i9UzMg0tNfMQf17GmRGbsAYXblsyTdVpRxw/H9uf
	mA4DNQde0jmZwa7HTFlaavjnn2IJXOG6dWXrz+bK6VG0jJTxcT0HzHyZsWR7xILwtVEBi4aVHjq
	d+nmJfCwHo5JMM2WS0q1P4K9tzJ2OBUnqS3v5K606ltffyEKdaHZWJaIVuMsu1geaAbcsbVb2ql
	TORtjQpaLO8a2ucnNBHOnIuGPANGAHbMR5WjQXWa4L2hZHK8AmVmWSxa7ssBCTo2ZT3ur
X-Google-Smtp-Source: AGHT+IFe7qtfQHuE8AarUumnA4K3QomVMhQviPuZJrheQfsZRaTkngJ4hD0Iq9+KF4LTRuNKmSp9EQ==
X-Received: by 2002:a05:622a:1646:b0:4af:1912:5966 with SMTP id d75a77b69052e-4b5f845cbbbmr132400991cf.55.1757453424592;
        Tue, 09 Sep 2025 14:30:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b61bbf161dsm14684981cf.44.2025.09.09.14.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:30:24 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
Date: Tue,  9 Sep 2025 17:30:21 -0400
Message-ID: <20250909213020.343501-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=paul@paul-moore.com; h=from:subject; bh=DGqyMYylBCu6JE+QNVscP/0dscioVFEBw70Nhp5X9dI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBowJxsSZrGHAAALbnSJ2zOZSX+ZBo74uKbNaetw NS+TeUlr+6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMCcbAAKCRDqIPLalzeJ c4x0EAC261unQPbWFl4bos4NBmVdPlQpIpyNABRsY82G3oJGPfrYYgtenqs45SHIeku/baJ0UTO xV56VPsL68cNbqb4Fci2UkSXKQtogTsOmsOIQP2LT4WFcXWPiUFBH4k23Op+K8+8YEztonCa/Js igqbNTDR125amM+/lS9j/BOYWoivjsFBKr2pdcFEAt861pjAY6SR94t2RvuawptQxlYkqaF7LzP xDnyFUVwaF1+JSumaAqFy4jObFrwbuzXWAc1zUlKG/DgEjTr5evBvi1gQlqT5ZzxTojgNRArwl6 iBCmXadHnf9J3qUksQrcBj4dOXTQcREyLX5dvA8aQeOPgwcQAr6E5WYcwKUvMRIhML1Djby5Gjt rrogY2kma4X64JUYKG+noLi3XnAp1W9EMiyLZ3hZY4HOOoRqdq1rFaCnVN5Bsa7XxzA3W8RperE cLzPIZXMzOK1Ypg7itnx8LdIo7VTs0Qvfv+eLyi00d0SqMiYZhzeaANiYOY0dIaQzMXTTulY+kD T+rTY/Ma1MJG/0RS31Foeh393t4FKmUsK9JqMEfKQkCTvcTRAks4zRgpO1cBrZoNGfxR5c+nvwU mnUzyeG0clPA6gNMQkzkodBsMz5MHGPcV5WDeVuTtVdFOrbqgucqQCrjt1cOPWiwGtnNu2UYRPW GXMqfI8fRANcYMg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

A prior commit, see the 'Fixes:' tag below, added support for a new
object class, memfd_file.  As part of that change, support for the
new object class was added to selinux_bprm_creds_for_exec() to
facilitate execution of memfd_file objects using fexecvc(2), or
similar.  This patch adjusts some of the sanity checking added in that
commit to avoid a "silent denial" in the case of a kernel bug as well
as return -EACCES instead of -EPERM so that we can more easily
distinguish between a permission denial and a fault in the code.

Fixes: 084f547bd8e3 ("memfd,selinux: call security_inode_init_security_anon()")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b2ad83353c17..2b685f9dd61d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2320,8 +2320,9 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	new_tsec = selinux_cred(bprm->cred);
 	isec = inode_security(inode);
 
-	if (isec->sclass != SECCLASS_FILE && isec->sclass != SECCLASS_MEMFD_FILE)
-		return -EPERM;
+	if (WARN_ON(isec->sclass != SECCLASS_FILE &&
+		    isec->sclass != SECCLASS_MEMFD_FILE))
+		return -EACCES;
 
 	/* Default to the current task SID. */
 	new_tsec->sid = old_tsec->sid;
-- 
2.51.0

