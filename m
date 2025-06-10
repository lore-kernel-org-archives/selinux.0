Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A40263F4E
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584950; cv=none; b=sh76kZLo0l9TRIrix4Inxtlsk4gJXo1ojgC261CO7hbPwAGO7C43vbTjYZ6p2/43+HvxRpGYEVGAyuvv81+eDYduy/LeZIV0L1WXl2P+kJM9D4TMVppzNIR1Dj62DqctzNSfAXdO7T4gcUc3aZ+7FySkTWgcL79fXCDFhRikLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584950; c=relaxed/simple;
	bh=w3t2neTRZ59Zvio5Ysv+4+AAg4hXeCwgYVkMe+fiPgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7XvybB8UPE+X4jSJr/mecoH2vwOIJqHCE+Ed0gxf6o0jORhWN7UJ42HYkG/dnQeySFAP/e7jLa4nDvDHnD5IFRn+f2lyOHzW0BKzf91hoMsRw/qHnHl1jz3Zz6AiEaa/aIS0hAf2zzPjaPKBHt3mcKvt6xEoTxxaXrYndnSAI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9VzP5lA; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9VzP5lA"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7cadd46eb07so612330785a.3
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749584947; x=1750189747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BfI9eu6SPXq+XCyf6zPjWz8NpRdISF+w/eIgG6OzUk=;
        b=Y9VzP5lAEWM/4hDAIB/W6tyPOWTQEpnz1Hfx7NjDARsuxuTexzOuZfiEwmXEJvCyGJ
         hQg5UQ5/9z/v+Oe5/ukU95SjivfClPx8bFQ7IEEOsTwTslXf7sF6JP+mNfDVXPmOeGIE
         9LEKL8f2a8HaTzDaRfbixvhvVUA3D9hW71x6F4Jc45pjORbYuRLUkN0Vu5ZFPJ8SAnVR
         cLty39s4E6x2FTYN9w5zSZS6DV4tVMrEVTCPeiT0iqRlpEHWuMqwkAnll3oUZY/uFnl+
         RPEg5aWk3vr1T0eeqnL2lPdx0OKFoiB2b4gjJSj+9Vo4NiRAmXyhZjzr0GyoK0Pk3wnl
         +b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749584947; x=1750189747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BfI9eu6SPXq+XCyf6zPjWz8NpRdISF+w/eIgG6OzUk=;
        b=QxGMtV+vnwxkz7OJPoUuflSMoXTTWrUTAP9OI650HWvKiSaC40Zmh2qrzZNgY5+uPG
         0LIxdReM/mzYivya6k/gDjTD1rIf4rgFMRxugdoHCYYQWARsCUtZfRCiVyR5ZjTKYGhk
         I6ttrfoiILcSm87lxFwm6jmd49TGzY/M1hPGEmU/Jp8aTxyzSo49tsviW9VsEMH63DgX
         u82gssodtOwfuTQC5VNlR74+ktbH7UwWKfhACJvTY8Yejv5mEX7x/UXCudbm0ZL+5fDt
         ocBPvBmz13OsMq9zW/+4ivpQBCe6uGF6CQ4JabMs9KmvPsXtK1zKDnIP7sQwFowDBt8d
         BZTw==
X-Gm-Message-State: AOJu0Yw91UjuH44GvVOtFNH9rxj9udzjJ1Vs34n3WcX12eCWDeNyINsa
	iZfq2+nFi6iOZCE6C6qtJVFOx0WndPxYZQuolhdD3S2uVbnXgHeg19kYJPDZhA==
X-Gm-Gg: ASbGncu9Dz1ELl66nuo7CCLGfmPe/fVHqt/zzd45M8Yuswysu92cYQX2zyyFKT5simm
	7mandK3IvaCg55XK9Lg+H5dtgs60GYWDXTfmblEZmB26GicWVmcn6I4objx6wwNAdUV+458i/lk
	lYYYmvJBHWVMU5Q3moJZ4YnJZH/FNh5FugfqpAfeY/2M05gcp4IqXZRLC0ZkqPmgczDkhn/55Tg
	T0B2n5iIpYlDL3v8+WYk0XXimO/erCN/EfC3oKazkztROGSj9ev+WMTQg+1bAUNbrcHMhfurRMY
	lCypGrYZTm5QaOU5CYdof8486twR4+8YQYRWYtDuL98ouQyI1+LJad1JSaK3g+lG+yy6IRWNsn1
	fK2ohPBEkySF38vE1OaWfs2xfVnE+VLnlB1CxD0dFd5I9aceCFZPG5uWYYnvcPykpBac7jq8IiJ
	uSxmJEcAKR++S7d2o=
X-Google-Smtp-Source: AGHT+IHdhI6PMcqPxSaBsVFmXwynG129SjdqKspB25ySBmcW3yxgslqDSm6VRdKkIMfUyanOFj1bpQ==
X-Received: by 2002:a05:620a:c50:b0:7ce:e010:88bb with SMTP id af79cd13be357-7d3a883450amr102574585a.22.1749584947476;
        Tue, 10 Jun 2025 12:49:07 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a60a14csm739961385a.53.2025.06.10.12.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:49:07 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Guido Trentalancia <guido@trentalancia.com>
Subject: [PATCH v2] selinux: change security_compute_sid to return the ssid or tsid on match
Date: Tue, 10 Jun 2025 15:48:27 -0400
Message-ID: <20250610194826.80606-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the end result of a security_compute_sid() computation matches the
ssid or tsid, return that SID rather than looking it up again. This
avoids the problem of multiple initial SIDs that map to the same
context.

Reported-by: Guido Trentalancia <guido@trentalancia.com>
Fixes: ae254858ce07 ("selinux: introduce an initial SID for early boot processes")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 fixes a compiler error.

 security/selinux/ss/services.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7becf3808818..d185754c2786 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1909,11 +1909,17 @@ static int security_compute_sid(u32 ssid,
 			goto out_unlock;
 	}
 	/* Obtain the sid for the context. */
-	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
-	if (rc == -ESTALE) {
-		rcu_read_unlock();
-		context_destroy(&newcontext);
-		goto retry;
+	if (context_equal(scontext, &newcontext))
+		*out_sid = ssid;
+	else if (context_equal(tcontext, &newcontext))
+		*out_sid = tsid;
+	else {
+		rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
+		if (rc == -ESTALE) {
+			rcu_read_unlock();
+			context_destroy(&newcontext);
+			goto retry;
+		}
 	}
 out_unlock:
 	rcu_read_unlock();
-- 
2.49.0

