Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA4233155
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734135; cv=none; b=kTHYzOnRDXbdh82QD6S1i6riCB+LLldmpKpM0BuldyisPTi+BEhzVaCI1x5GGkWqskKwBo/Xaauk8jefBNXslEDQX26cWvY/Qr1x4D/4YvYmK1bMcFxEiF8ddmJgrILA5PWPBgfY6TJXEvDasLB1gEeqsvxhjIWRVKvbXxnoZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734135; c=relaxed/simple;
	bh=Fz0k3XVK2BX2XrMpUz2cIvuNRRSyOO/JPi/9LREbpu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1zG7/CoCw7OAq00UfQnLsu2H1njS9QK/Cras2YmY4t7qR2vrEagaP2EIXlT+cPG6FFQGyYqn7jtVhDH0UD1rg2jyAHPhJivql/lTUDlS9IskZpB3K9/nUwZMBJH9dEFZe2GcFaOYHVWzeRx3pMAQeAv/RuoFZm6O2pcNOmnmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q+pxg1r+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q+pxg1r+"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88f2b29b651so335113985a.0
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734133; x=1761338933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ5J8BHN8QFmSkiO2EWOi16u+SfFMG8xOneXKM16iO4=;
        b=Q+pxg1r+wjOW/T8UMML+u2y3e3LgxXM8hi9wWcZvxNUCejIMCXCr9o+Ll8h2jKojY7
         8O00wZXP3KNzGJNz8BZ/E+tJUSb9cnW26GA1BzY+cgC/3psvXWVZIZLkm1imHkER5TSv
         YkC6uGaOKFLr4PNdc4tPQCeaV/LpVLf8ztiXBqZwXiZzxG6vt4cGIUfHlEGMMocjTr3m
         VWj9qFkJA18cYOtsm66lkaHQxWWtmSv0iubOsTJZesuT5RF4DJrS2THdUn4Yq8EffTg5
         i1saejebn63Pk+HaGh5Yr6rbW0wHhbkPAecohCN856MrKRIX8d4qlrR6yPtSAzQJPXFP
         x6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734133; x=1761338933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJ5J8BHN8QFmSkiO2EWOi16u+SfFMG8xOneXKM16iO4=;
        b=F7LeOoK6z2QTJA6veRnWCjtofZah8i0AAAul/XVJuY8GFABUcU7UB0EjqhFR8a0XdI
         U2xOxbq6Oa2R7peH2xtXtrne3RJSY53zPlW/2fjocssyjqBurSvdkXfwuWbIu/PrgxnP
         rbMkVIEHUq/Cgtksv1tDIN2H+aGslu6n2siaAWToRE+G8ElpElDITW5l9SFfMS6H36A6
         GFZnKyhjUj1wQ+9rFK+H9ALLDuoYJ3vCn9QHSCgHit1IAK+a1VXkXevJB/f900S/EjiP
         jNfsjdkCD315GnSAYYBxo4zhaCemW/eyI5VWAtO+xkMvX4B0qZrlb/Aybqt3Q08/WkRJ
         2tkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUJGL9HSDoPVTVdagI5yEngEw8+JXrbI9A0ERaeiTN2jI91My8/peHBNR2mOObClTgkVTZ6PsA@vger.kernel.org
X-Gm-Message-State: AOJu0YwiqK+zhZjShYvhpnWLmYQ5rlrlcvCu8AkJ+fcXEeA6l9O/2YWO
	3QG9Kmu233Yr4KJASr28CKrQ79N3KmB8j0ofDAOj0rYhq7VWRzrcwuIQlc5YK3bGYQ==
X-Gm-Gg: ASbGncsRm/yp1vlaEqms/D/7KkW4hXzUHUg+V2zc3v7KsJHYAIyg0NLa5MMtoHm+6jC
	WQS9yOQPN9EqsFerysEtLXdQU4f2vXUB6lEsRz9cu5jVWuCAlUWQe9hJ/l7tWhnHj2LVzZUlO9J
	Il67Ob9bnX1/44/GtljLDa+j3A3m0itCVxPhoSKKaKX+ze5/FbPV+WWAyOXCvsnlEnIqnWsqvVo
	fdlguYZleh66IJA4FgIqSo7jFz3eAXEmDisBIGr5xOA8BtvBVEO37E2bnLe3gyzNnZUpscU8b6j
	T+mTJCdFXtRBUc3N61YF5GsG5G8Z3k4ut+PeDGm4hTiLsshwgOZaSXZzIVg8wendHHz9BrN4W92
	xN+1Q51jQyuX6n2M7Br3BcbLaeLzsRnf/jtQJLH4LY0DagkH/+S90S9tksYciL2ugz0+Doj77Nx
	l6Z8LKUMEzWeZx4lEPQjBvL+4QlFNQCPu778tPMKaH/vAnqVKYpeki+LDv
X-Google-Smtp-Source: AGHT+IE7nY/kMP5BaVTqHO4H6Fz26WN19JUd3KY/++QJYOkY66gqrdKvluQJ7mFnBnpYBg/Aa3cTlw==
X-Received: by 2002:ac8:5852:0:b0:4e8:a82b:af55 with SMTP id d75a77b69052e-4e8a82bb19dmr30232371cf.65.1760734132751;
        Fri, 17 Oct 2025 13:48:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab0c3336sm5193821cf.23.2025.10.17.13.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:48:52 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 01/11] loadpin: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:15 -0400
Message-ID: <20251017204815.505363-12-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=paul@paul-moore.com; h=from:subject; bh=Fz0k3XVK2BX2XrMpUz2cIvuNRRSyOO/JPi/9LREbpu4=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8quPHIC2NFq9ro/OwPM6enq3MKKHfH+Tstjt9 G0C+RyiB1mJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrjwAKCRDqIPLalzeJ c6ibEAC4D7PUz2Hk1LsUP9YTtK5nixfrrMdSfsR/TWO6umFfIFfqG30EXWIS1QULZLmadIGvDH0 eWoRjx1yCYgt7/sZGldsnDp+gsMGJHcoqJqH8/Ib9cYSXi0RqQ5g5zh1mPiAMLA5aRjiejNQ6rO slN7/Qm2J3Iil5+hMunZuncJ4Xez3RslHhLPmt1apaL4UFPFdiro8nkK7UUwxKXvx+m5eZhvsDv LLJ2qo6aWP38+OkEtAvYOIthWsFL3O1nekV9S4XfnO3DO/Fq2uR/O8wDbXR5Mvy0oDO9JnuP+PG jjfIy1nPENg51oUVsUQRNalxiWP2nhMkBK5hyZmWM+/FNkvmlkm9/JticMDIX55ChG5IUZpNduN glrKvnty/QJtmeaEEOOlyBJltEU7WdvyLj+xdqaFBX0c201D7LecmyAZKxBQD3GeyGRF41JJVP0 2bI5W0bQRj5cndZFF6YVWqB5Qj7FSVAVrs9+nX/4vmtInrNQhiGBn9lIA/fP0WgPlytlmj910JX h6MaiOie0C4FDeDyzEAQLyZDyc8G8ouZTUbmZ1sND0IMMBf3S1WCwEDOBeCrQS7w69xCzspNOGl 7y8wGSQiCkunTWBP2LTrZ8ZrSDOseVS82gLXE72sC7Af3B/5XQZe6O58Vu1nAoKgiox+fEoPhQp 4Op+wE1hhLK+hVg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Acked-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/loadpin/loadpin.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b9ddf05c5c16..273ffbd6defe 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -270,11 +270,6 @@ static int __init loadpin_init(void)
 	return 0;
 }
 
-DEFINE_LSM(loadpin) = {
-	.id = &loadpin_lsmid,
-	.init = loadpin_init,
-};
-
 #ifdef CONFIG_SECURITY_LOADPIN_VERITY
 
 enum loadpin_securityfs_interface_index {
@@ -434,10 +429,16 @@ static int __init init_loadpin_securityfs(void)
 	return 0;
 }
 
-fs_initcall(init_loadpin_securityfs);
-
 #endif /* CONFIG_SECURITY_LOADPIN_VERITY */
 
+DEFINE_LSM(loadpin) = {
+	.id = &loadpin_lsmid,
+	.init = loadpin_init,
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+	.initcall_fs = init_loadpin_securityfs,
+#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
+};
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
-- 
2.51.1.dirty

