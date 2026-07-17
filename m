Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D038C2D4
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313673; cv=none; b=NBNYQsYKvmXd8T4A77N/rybc1+amERCKqOUB+ev8lYXAqwUvWxF7etXdeQHKPTm8vT+axnRVuETzq8kI1+J6+YggCq67i79RiPVw7GjiRloYTK3fXt8GtwqIKJ18mz0t3b3tE47Hr9+cBNBaqi9b/DQj1n0ii2Z2z5Vw4nwILkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313673; c=relaxed/simple;
	bh=X5+HpdrrXY9QXv8rmyHTYVlgGa/aP11nTAxel3cbTIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5zzHcHHrxnWVFFHsAVJ3TJbQ/pJjSu4scD4hzzQPfq7YaFoH7Tsm77F/wf8M8m1YW5a/ldwVoyX8wHvHAMHG+Fdr9pVfWmewkgXlzGPsMvLwcdSMNyfFyBRh+U8Tbc4b78BplJXb8Bw8vQK0L1bNape6861mp8OXETm4NTZGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYB6LdZf; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYB6LdZf"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c167c58f2so63438991cf.0
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313670; x=1784918470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qA6oaCy8Tz41iPfUy99igJSwxpHJGjqw3Knjnhhh6ds=;
        b=qYB6LdZfs1c6VQ1epmB4kwFVW6Y+c9fCcA7CK2J73PTB6xToBLe0qUp4qy88Aj57b3
         FJ1VvtEGF+8KSqabywFj65rSonhpKotE7OKCeZg6a+tqpg6OpivdmOofUbpXRmE5HFvn
         2LbMVR8zUL8NVZ+4LFpG9f1ukgX3Q+PHJ51Q0Z2SMONq3TDWoYybqexE4PXF4Iv3gnbN
         FDckVB/WW0waSiAhfaxqUYt8gnNAiXaJL7zHLBeOf5fHtPZ3pdpV5pvhty1DGQkoxQm1
         Xcn0r8D6P7Xk9av3YyvBiAhqnWoiWAUfxoFYT5sEwZnX6wdNdReopJfZ+IqP1eYrr29X
         eD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313670; x=1784918470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qA6oaCy8Tz41iPfUy99igJSwxpHJGjqw3Knjnhhh6ds=;
        b=M8AbJNNWKLbNn4kgJwQZmdST1JLCe+y6CI3agimcrpZsHtx7bC7yj9/1gxBHQCvw4a
         sfVD2bQJ/lKwMixTrmjcTKZO/hYzz9oIKXAsj4cdNXGwf8rmTRUDiEwMvpn8wz4e/3Q0
         yVWzhkJTk4r2if0WNf8qTdXCj3fSRXxNk5SKP7aOvwYfYLoG509F9hwmSFKwJ2pdN2W6
         T9r/OriEqWRSWNMCvPTzdtprhcjjLAqXtInO0RwTPIrlhPwOR8kyMGACMs3P6MlQn7zG
         UMpl0daI+ovOxhO7GB0wyH1paG14wZ5lwlJedqm9rJeFjmUnXmic6CSxO/jjdgxyKdv4
         JZ8w==
X-Gm-Message-State: AOJu0YwUeu/cqOs6Ttapgb9ZDAIL2Y0ks1lNNrGMML3TeCt+HrDB1QWp
	zaQSTvaO0ImNxgOtsXR3oWyRPOSzO0JdSXz5ZOhUIxQywovDT66GOuTV9m5qLQ==
X-Gm-Gg: AfdE7cn8+4IEXYESWLI7hCo91ElBhXGySY3cRJSFZDCpYkMbWjib4Qug8kjrrDlwSx1
	cP4w0qzuty2Uis1/n436xxEnFlfRQyUnm53XcG5GA1w0xLeZoXi2oGkxcJSUF3iyleyObn2PTOt
	4RHFITRNDmBGYGYoPlCfqJmHAVqkLJnE7XrQKhdVozjze43xy/ynjmBHlIyw/2d2RhRqIvMtpgy
	i4/bLMjlZAC/2c8p1jSE0ul2ip1mZUrNyP+B2/DGRRfrSem5tbjJRwKyI0gmJVpKfb3oFlCxOZY
	zy4bGVp8d8r63iVMq4oPUoR9X9nd9zUq1TUGb1wS8UsUqzuQOz00qgPg7bYMOPe3+67/94iTTab
	JC80yyJwAZxOCcpvqnvwD4z7TEFUgGIQedCOvoYBa/W9aCNQi9htpEBq+5bdtcZoiOJ8+Hywa+Z
	CU+uKHAZflQFOIUC7wadzzeJymx5ZET3JWgNEvliVNruOKHQXtC8+bQANoYALGins5YUrwnWRf2
	KnQwA==
X-Received: by 2002:ac8:5845:0:b0:51c:1529:2c0 with SMTP id d75a77b69052e-5213e28fc9fmr37116731cf.43.1784313670263;
        Fri, 17 Jul 2026 11:41:10 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b539bsm22756576d6.30.2026.07.17.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:41:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 08/10] sandbox/sandbox: shred the correct directory
Date: Fri, 17 Jul 2026 14:34:23 -0400
Message-ID: <20260717183424.20324-9-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
References: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shred tmpdir branch had a cut-and-paste from the homedir
branch; fix it to shred the tmpdir as expected.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/sandbox | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index 3368a95b..8c15d659 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -530,7 +530,7 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
                 shutil.rmtree(self.__homedir)
             if self.__tmpdir and not self.__options.tmpdir:
                 if self.__options.shred:
-                    self.shred(self.__homedir)
+                    self.shred(self.__tmpdir)
                 shutil.rmtree(self.__tmpdir)
 
     def shred(self, path):
-- 
2.55.0

