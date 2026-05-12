Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6552BEC55
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602433; cv=none; b=oOwVYkDa9CW9dJZChd7rdCNz6KE4I0mic+ibimFTvRmCVTJBHaj4x9f56qK5Yxz7mdmYW0QocU7vj9HZkgGqntErQNzrr89MlpGI7mMBb5oQ8yFS9ECtoVe7cwierClLWeIFnAfyXA9hbOq6sQIwhiASa9tZvwGZMOm1Ft/gaO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602433; c=relaxed/simple;
	bh=ceXtDnacQWRwgM932xO4Txd25Ve2lQvnBFh1G7f/ir4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYvzUFNl56vumTWAHctD3wBtKxbkNXfim5dgkDEttdhi1u761126e5NebU9LaErVLksAZ0yTg9BA6+nB6vHHPYyyWt6FDCSEpcJz+hGvjqnzJD0RGHLE6My3W9brogB4BmQuWi++n51U42jd7A1++xXOK7RkUYrOSxeP2dFPYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlwqI5BJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlwqI5BJ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51306c9f2a8so59221321cf.1
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778602431; x=1779207231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=beUqFfGPpOLXnWhbwTaEHTDjCZjLrpa8E38Jwtigsgo=;
        b=hlwqI5BJbD5TtPf388+9dW18xp174XlAi5k3QUoHSCaouN5tZR/I6WjtXV3g2BgL2N
         7c/tqRb4m9mcrhq3g6PTX1PuMBPgS0w5wnHRJjtJsmo6IeWg1RXrgC8+7a6vxwxd1Es8
         Tq/2SixPmf+DICUjMsB0BpEOIH3ZOCxM9CshW8r7V2nIDJ+fqXc/LUR+KXupt1N9Az0h
         mIEiPbSLQ+rBDWTzDCCtcj0QQ/baBAVmNgwULAkBE0uGFU6bxyWz5N0qjrl5kTe5UuXP
         1O2X9lfD7Pm60753ILGjQoy228lCZPI9oIjw8R1NPhoU17FuHbrcpuZge+kQ4ID9jam/
         ettg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778602431; x=1779207231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beUqFfGPpOLXnWhbwTaEHTDjCZjLrpa8E38Jwtigsgo=;
        b=Fu1+gBeLJeJ+veEpLooDaqz71QpB8fY4msIVcxYofL6yGDaNNqJgaENRlL0XwO+GNK
         KKuU9uoFXOsaHCrFVlcLA112ZP9K70gISI/cW6ouWI2C3vzayzezJMcPCjwGMgkRb83H
         pbe7/qklsv642Mom936K6FLKaGK+aEUB0oGVfDmti4m4KRx5ZAAkytjnR+h9bPkCWfxt
         rpgOxMkbIGi2zLGq/M6ij9OHBENshUd/RFa1k25i9qVtkQj65oeFJ5B15G8U0Rilz/Mi
         uio0fDwtdtS3i7Ytx5MqqUXNd42TD3+qw3J+/De5VACC85pFx8HsPOtx5coLNpRlwiqE
         sguQ==
X-Gm-Message-State: AOJu0Yyo3XXjacrUQC5uSZgyx3z0WEpJSrxNqMWsTbUG/hKO6QSZNEk+
	v6Tzhg+jRm9l2+D4EorMpF9Jl1F+u5/r1CUpBNxomvNg+RSEcyNcfjZQlWpUjA==
X-Gm-Gg: Acq92OH0scbknFLWVklHRizEv/0F0PND12yBrEiIDHjsRS2bkSmAGM6wvif08dJnmoW
	YazAPw08kMRUfR4ls5KuMq3aYwHrRSyM3641y+f7RSAGtVBAYyUtFUbYHhOXgm/hrh3ScfJk8OB
	GGXS2Th84DZke1QM6XcTfeyNj9/CIu/pQ0MAC9KJ1CLN21v+fIINDWUEUULqUyP22PB6r9kQ0o2
	4AlvhZ5oloBUS5I6/i6Vd47Yqrl8O/YzEfYkh7Y5D2EaJdIdnMPNUbgjsij4NJJhob5yGPQhLHV
	rWhGdRXpSR67MQjzy3oU76v/bWcLuqbFqHtSf2OWtaHIa3F0kz1HI/+Ij8KRFVaGnij5m/Aawtc
	2/cvd3oLn8rR8Kg/WetIaqhFvqzdmeiNRrizdsdd8ZvuWVhfOKtLK3YV3tMRGhMPWHApGM0x9Py
	xTUW8lKTX4OPxbqQ8qPWh8tGqnegBGMcxZ/mdcJF8cOZ2Gx9MRU3A6cUmtc42KQJ1MqNFpJdlag
	ym247d70RaJaT6rZY91Vv1zqNAhAXGc2j/awTzCcL8m0DEyE+7qMGg=
X-Received: by 2002:ac8:5ad0:0:b0:50d:a987:89b2 with SMTP id d75a77b69052e-5148e94fde5mr278675701cf.31.1778602430574;
        Tue, 12 May 2026 09:13:50 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5149ed7747dsm111482321cf.5.2026.05.12.09.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:13:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] restorecond: NUL-terminate ut_user before use
Date: Tue, 12 May 2026 12:13:37 -0400
Message-ID: <20260512161337.733958-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

utmp.ut_user is not guaranteed to be NUL-terminated, so
copy it to a NUL-terminated buffer before using it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/utmpwatcher.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/restorecond/utmpwatcher.c b/restorecond/utmpwatcher.c
index 86605203..140af546 100644
--- a/restorecond/utmpwatcher.c
+++ b/restorecond/utmpwatcher.c
@@ -49,6 +49,7 @@ unsigned int utmpwatcher_handle(int inotify_fd, int wd)
 {
 	int changed = 0;
 	struct utmp u;
+	char name[UT_NAMESIZE+1];
 	const char *utmp_path = "/run/utmp";
 	struct stringsList *prev_utmp_ptr = utmp_ptr;
 	if (wd != utmp_wd)
@@ -60,8 +61,11 @@ unsigned int utmpwatcher_handle(int inotify_fd, int wd)
 		exitApp("Error reading utmp file.");
 
 	while (fread(&u, sizeof(struct utmp), 1, cfg) > 0) {
-		if (u.ut_type == USER_PROCESS)
-			strings_list_add(&utmp_ptr, u.ut_user);
+		if (u.ut_type == USER_PROCESS) {
+			strncpy(name, u.ut_user, UT_NAMESIZE);
+			name[UT_NAMESIZE] = '\0';
+			strings_list_add(&utmp_ptr, name);
+		}
 	}
 	fclose(cfg);
 	if (utmp_wd >= 0)
-- 
2.54.0

