Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74974398F0
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327179; cv=none; b=MemX7PprfCQA06X/Nhjcmh1ePkGp94rnnVmD5gvja10LPV9BZP4f9kNI0p84rcWV+PRxnEzfKGILAC9XBo15zr0xjaAhW03CWYGBu0iMmOA9myxD5R8UELlz2CmKjCrTGZZDPCgQkwLW2LDHRrvJDVR2DY0hyRI38kopjpXj378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327179; c=relaxed/simple;
	bh=GrMTffPSe2oWz+H07vTWvo5XYA/Vl5toz+wz7ViG2fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nS11RWE2dT+dlxDBfvljCB49w/Ra+OcJfieQObL82gtpLfvWgBXA2XSvWDvd6/OaAWL+oTGgTMEdFBIeKhZHIjsU0SQiG8InvF6sGvBGshg2n5IV0ptyhMKkO8tIb46Z9hj8cCEvQ/yHnI31oPcWZC/SCM9ADyfLVY+Ti+lxPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB1XFWLP; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB1XFWLP"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-526f963372aso5972981cf.1
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 05:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785327176; x=1785931976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=okcGtyvm9o5TATucyRgC0asbFDFhoLEnXjxq54S68wU=;
        b=nB1XFWLP35I2DLGmRPpOMh2tXjhJPVI7dOxpyA6Wm0qrcP8FgNAuL9v+oSPfrYJBU8
         Q9eTataO7M2owYd+GUadaA7CU8n5fTrdnSEtmIUEo0HwENkJjI45OrWJ5ifxY2qtQIBE
         fDahhYCmZxcYVnHYZ2/mpNQBomQJyxL/EJgWtwCPdaY2j15+vLO/WDQfSvZGCyVikXDX
         vKli50JW0R90T+mAw6IhTzVUnHtmraqapEjXx6XWPGAVQksfA7C0887yjF4n0WlZFCR/
         E/MyUMGFk5Grmg7mCeng6a8nEb/yJlMENX3GWLVlhvEV+FoILPlMnZmgW/LLvEPFSZgp
         8BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327176; x=1785931976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=okcGtyvm9o5TATucyRgC0asbFDFhoLEnXjxq54S68wU=;
        b=Bx/dFV6++pgdeUVxOQE95VoZlf8sSxxfVJ0etluJ2pHj19xcfqAVL471G/1PoGk9f7
         qAoHIYfCLONG+fdEiIHPaFBS+p+dHHyC5+K+7Hr8U2gG1qRr1kdkC/7B7UIjN6fg5yIZ
         YvHDUVQXpTmtXqAdEZRsx9GiUuQauxqrHm/v8eKnwR/H2onyRatybaCd87mTG7mqw9Bz
         u2wUgH5zzGdnb0QF4DCbrV539AUx2nDm5PculMeNIYbTBvscu0KRaWcsGoGGDPY+RqU6
         Hu5NFO/afJ6VIlkI9GQ0TYh1qArLmw5BXj5Qlj31ZwwdIyA7akwXKfT/Df0iFU+YiQom
         nYPA==
X-Gm-Message-State: AOJu0YwHFHEqTY3gwz3QvLVssJ8nPaMgLUMl8MS3Mn4YKh0Vr5dRFE/+
	XLk9Ktvojip3ffGCJw+HzxMpnVO++9fLieDe4U2kAQ5I7GRRMBoVjAfnyLcFpA==
X-Gm-Gg: AR+sD10qpagOVzXkvI6QuiFN8gT+unZznUIp3UgGnJVcctjX5u4GAwWOdAh9oHT4Mu5
	+FxAY7Aukt2DzX3Q5475LQZN/kSz2CWzSzhlfE90NL5ACMC+YBS7IJEzl6OyKLxlKiSxxW3m/S+
	KqWhLVFH0aMxkck63YBZ3dkEHHGVz8N0Y4qggQQ6dcj4cKrINGy/A7iqwcAUvbEaAZ7rGqf1UA/
	YGk5GrD/1VrC+TfU7sZkGcUl2Na3mlyNADRAvQnJf0uYY4BdFJtThTVEOzUaNzGiVYswY20ouis
	CF6UK4IdK0SE/ds/WtE1sH92eUEaEMbKSgr5hsOXN3TrKWEBBJ/t55QOiXZdOxDCT//Zzdps2eh
	JS7ilChBS9GXaDYBZKx0paQBaSjJ5GeNf5hS6/lPW0yTqCEU0RhQbZ2yZums3ST5UFqpyG0uHdM
	9D0LdvA2oUtEmtsJ1HDUzDf0ucEbjv1uSX6FqNBsa5fNepUk5WpR+GEZpc42rb1ZyLbl55G5NGo
	HB538ROuWEbseLCY4tRVwqL8UTtTqbkA0iD5HDie+jpq2JA+NZDNUpP+jE/DOUE
X-Received: by 2002:a05:622a:588c:b0:51b:ff45:bc82 with SMTP id d75a77b69052e-529d70d6b88mr58697491cf.54.1785327176402;
        Wed, 29 Jul 2026 05:12:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2db86dasm16888731cf.20.2026.07.29.05.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:12:55 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] tests/file_contexts: update .gitignore
Date: Wed, 29 Jul 2026 08:12:33 -0400
Message-ID: <20260729121232.53444-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test_multiple to .gitignore.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/file_contexts/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/file_contexts/.gitignore b/tests/file_contexts/.gitignore
index dd877b4..8b95fcb 100644
--- a/tests/file_contexts/.gitignore
+++ b/tests/file_contexts/.gitignore
@@ -3,3 +3,4 @@ test_lookup
 test_open
 test_open_base
 test_validate
+test_multiple
-- 
2.55.0

