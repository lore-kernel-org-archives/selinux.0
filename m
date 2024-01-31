Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E6E762DD
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705794; cv=none; b=bbKTdpfqGJT/icZGhZS+pnAB9M1WtLTgBbkQCGmLo+uHw9jTwqJ/mXhN/vnMNzNV0hGfFrR4bnschGwlf/1+lVqi1NHXlREyAUFoXSVzrmmnByV9/q4acpZA1s9KKm8zGZx5cU5MvQRUqIkvNh4g+VsKvvBdlaLD8unOi9DUBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705794; c=relaxed/simple;
	bh=1DBPw6CFtuVlh5ARAUZc5scvfXmq4VKeDmhNySoyhDs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G2o4CLApxUgSw9NHBs3SVKkuFxDDA+DmFnUjE69pVmXzK9zK44HEgwQWzoVDXM89mspLE2zNHHNhMacoOcBlUn7EDLG+/N7Eb25JEW19fX9C0QxRekMQnQRRm7zNkLzaworRr/9UJQXCwmV+WtL6Qt0HUAW91uNrjOXfxQn+bWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IDPJz8p7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IDPJz8p7"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a354408e6bfso144015366b.1
        for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 04:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706705791; x=1707310591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F5mqWTFByb4l6hIEAJItQD4osy3qPYtkQsF+OoG6y/M=;
        b=IDPJz8p7gy6zRT6qkaIKjTkE6o5tL1qeSO5CNPr4jpb5/hEBJHTqJj12OEI6kiF9bN
         VX0jNL4wzVdqbRq9vUNF7gcicjk8PXFNgmJ+b9LKNwHOQZeqxnVKpzF8kEIm9i4+pJIF
         ShRgjvTWrqS9huS4w9dpK5oBWroBNckUYbVthvSeP2PWPTICBcARvZ6kNurP+TDp04em
         kGehRlIDEeRPq4hjLmzt/JhD1Sb7NfFsWi2Mb1cHsxWgoIQuhGVd+A74lPT08upnKilM
         RCrTjWe50yRdAgT0VrLOnuBdJ8gY7bzSEyzrSZ9G3H7syUs4Y/IQPNtZ7GIdDAsxGJPg
         Mrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705791; x=1707310591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5mqWTFByb4l6hIEAJItQD4osy3qPYtkQsF+OoG6y/M=;
        b=GEyem8cM0bPgKqHfz07jsUeo8jelpi2wa2hoPtyT3AiWI3dUUNevZ7PN1J8wguq1Ud
         o2Ru3UCijwayxpnNIVEziFFuNW8OeDP0MRX53iTB8p9nu/mLigaxJ9nR2cRLHsb6w7s/
         stOaDQwJFueqxz8XxUIg72+0p2bxKtlz8i/obHlcf7f3k+WmFKFeVPF3jz3/z+C35vY/
         hsa4uE+e2LC+xBNu3e3YSuIyE3unILKnzjHeEi39VrdGdbP/28MSLyV4XcXxO5HeSJd1
         PKj70560C8xRQc2P3k5Bn+a5mV57r9UDw1NUlctf7pMlCowiyOFFYoOlEPLABQtM78mn
         HU5g==
X-Gm-Message-State: AOJu0YzTHqDcYhzfl/8oMuOC1piqYoUu2TV68+i+Z/Jgz1jpk7g5Q1DV
	+Dn6xX30w1JpETc8fRpgRClXrAAOf9CLDUj0GVz7vyWRn4mJXIQPuQ6eNqJ6
X-Google-Smtp-Source: AGHT+IHYrEF76pb3rzynxCwtRFSsNrQa6Ak4kGwvijrsWIroQYRotEiYPKBVcX3AvXaoZJkd29pSYQ==
X-Received: by 2002:a17:907:6d14:b0:a31:6a03:d1aa with SMTP id sa20-20020a1709076d1400b00a316a03d1aamr4816356ejc.22.1706705790418;
        Wed, 31 Jan 2024 04:56:30 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-045-093.78.50.pool.telefonica.de. [78.50.45.93])
        by smtp.gmail.com with ESMTPSA id fx20-20020a170906b75400b00a34b15c5cedsm6248843ejb.170.2024.01.31.04.56.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:56:30 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/3] libsepol: ensure transitivity in compare functions
Date: Wed, 31 Jan 2024 13:56:10 +0100
Message-ID: <20240131125623.45758-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ensure comparison functions used by qsort(3) fulfill transitivity, since
otherwise the resulting array might not be sorted correctly or worse[1]
in case of integer overflows.

[1]: https://www.qualys.com/2024/01/30/qsort.txt

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_common.c | 2 +-
 libsepol/src/module_to_cil.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 2422eed0..44f0be23 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -503,7 +503,7 @@ static int ibendport_data_cmp(const void *a, const void *b)
 	if (rc)
 		return rc;
 
-	return (*aa)->u.ibendport.port - (*bb)->u.ibendport.port;
+	return spaceship_cmp((*aa)->u.ibendport.port, (*bb)->u.ibendport.port);
 }
 
 static int pirq_data_cmp(const void *a, const void *b)
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ee22dbbd..c8dae562 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1680,7 +1680,7 @@ static int class_perm_cmp(const void *a, const void *b)
 	const struct class_perm_datum *aa = a;
 	const struct class_perm_datum *bb = b;
 
-	return aa->val - bb->val;
+	return spaceship_cmp(aa->val, bb->val);
 }
 
 static int common_to_cil(char *key, void *data, void *UNUSED(arg))
-- 
2.43.0

