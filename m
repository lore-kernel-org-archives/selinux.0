Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE8149DF0
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836351; cv=none; b=SgGQuGWunTJs4gpO/iLsq0ChWU8a/wqEo4b0co83ieqjewj47SH4nCexzG0mwVaL1/aYSkja260WtBfU1Q7hYoozwsZQUgGedEf0yVjrbvhQ+XnRqAhy02cYLWcekmnFWs+zlGunM1jXV2Fvz1Mh60/sKYnTT5O0tIyiyfuodcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836351; c=relaxed/simple;
	bh=Cy9/HthkIqjdSOIrBIHNwm4iXYkN/R1eEXhd7G85CUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hCL051/htXSE0nrmvXc1gGtYsswUAreMchNbgEvkakAgeCsQSC5W0XrqAilVPyxDRs3QuBpWkD8R3iFPlBLHC7jmD5rCiJF2yLzxjcpEtJPFH9cMc49azKOn0BvWTdpSiZHW34BbPZ3+51qKv5IQPzaiIsID7/A2RNoOi4KKjsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzWfZQQe; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzWfZQQe"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a3f1e667so66793831cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836348; x=1736441148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bzv3ZX9wa+dFK2R6j7JkfEPqTQlLW0Nl6pQBz700Uq4=;
        b=TzWfZQQerZD4ehr6UjA2/T6V+GQtZK/XWcE4S+bXHc0J9GA5QgUqtNC+NALSKqyoYA
         3p4SR72NP4Ko/m6f5IsAOXKYYBox0OYKmvLr+i2jYyJ4Sc8hCCLfHIo69Hwb8Hlukeqm
         8VmYqhahOrjuCd/ouE4TsxYSpgy8aTf8lSxFF6qAXtggCMu//KNf0S9sz+/tkZ287Ds+
         n21gJpVat1du1fAKjRFiA+sxQjD1TOYzRLzqISRoaGDOdQjuPtELFYnqVBEyvmP/nh3A
         aj4beIVdyMlZ5rKUr4VhiVqlQpyv4uiwXxzO549xDYSeu8s4r5Hx2ozVlsj2B0ib6gto
         hJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836348; x=1736441148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzv3ZX9wa+dFK2R6j7JkfEPqTQlLW0Nl6pQBz700Uq4=;
        b=twsxBoSJ8VABombHP8bgpVSav878SZ8g3Z5lcXVG31geEbaPV+V1cEDvX/TXjLUD3n
         foXG4cHNK4XKDaYyQWNUIsAqWtrXnDxau9G3QiyvuBmD2epzLDBw35RgsMYzlf8uKOap
         kbMCljpR9J7w3+nV6XEX4nAj3voDEJ1UTYAVKkpWORXYnu6jzPJ5nPZnr9361c0O0q2+
         woa9pWLtWFxdQrqQuc++6zKFc6Il3t2LfrvODBckkWmpLuL0KNAru6699A5hgc8kLTH1
         CS6fuRrCwMmBhvTGq6vo11mUcVyKrvudvAMXmsa6sbpALPhI+CJyeJMtZd2wYEgpmUA7
         q2fQ==
X-Gm-Message-State: AOJu0YwQDDiMMdu2DeO8y2T67EUc7Dn7daw/nJUbNEfBtGC5i3ZIbb84
	cO8zbLVdQgTDIVGH2XIruff0p2UxvguhaW5KZGB5ZJWp+sZSgUh7Z2GdVQ==
X-Gm-Gg: ASbGncvWPI6dsKJyb6j5O1POCtn6jgVWqVZd1GqekaWbp9XWNoKMRWkGW1jYNm9LTBh
	BJPgY289RJ9Ga/QZrmQHBFocm5kQD99YbT9eAjZS+IUAVFsr6Yo3JGD7XJwq4m6iu3j/DfoVd0Z
	3Ozq4257IFBLUmxXmfYIRk5jmmIiJsIq3iJA3WXVPirBB3ZxROgk74ZJHERJwRmWjTc+57UhJ2i
	K6ISWUIH8IG8YqBWtbgdq8ZkpTZXjFgc53liUOf82Pu2gRAf7bnwRrEcKvUqjxZjaqld6QFDMgC
	WkQ5ISkPaSU7v2c4p87Qio/FylboN/ocDd5FRA/pGJ6PPNuFQ33HbE2qyRb0ppctVNlxKQ==
X-Google-Smtp-Source: AGHT+IFqFuy9VxUPpU4T0+7zVsCPyrLBr0Hvf2dOZNFrpUcmHj6f/QcJel6hBjMEMQdN5nZRts/Idw==
X-Received: by 2002:a05:622a:1827:b0:467:70ce:75e9 with SMTP id d75a77b69052e-46a4a8e83d4mr806783191cf.23.1735836347991;
        Thu, 02 Jan 2025 08:45:47 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:47 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 19/44] selinux: fix selinux_lsm_getattr() check
Date: Thu,  2 Jan 2025 11:44:44 -0500
Message-Id: <20250102164509.25606-20-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the selinux_lsm_getattr() permission check to use
cred_task_has_perm() instead of cred_has_perm() since we need
to use the target task's SID in the same namespace as current.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a19cfef5325a..728a59aa52d6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6448,14 +6448,14 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 	u32 len;
 
 	rcu_read_lock();
-	tsec = task_security(p);
 	if (p != current) {
-		error = cred_has_perm(current_cred(), tsec->sid,
-				      SECCLASS_PROCESS, PROCESS__GETATTR,
-				      NULL);
+		error = cred_task_has_perm(current_cred(), p,
+					   SECCLASS_PROCESS,
+					   PROCESS__GETATTR, NULL);
 		if (error)
 			goto err_unlock;
 	}
+	tsec = task_security(p);
 	switch (attr) {
 	case LSM_ATTR_CURRENT:
 		sid = tsec->sid;
-- 
2.47.1

