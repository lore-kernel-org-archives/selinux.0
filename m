Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445670;
	b=W28bTMTBhZ2Ed16w+eTgVZoPJKrZX6ucoIajVuweoBJYqVqZ/2aAMgo7KkA2meh8Rpro
	 60eKRLSOZ8NGOz0Hyoon2Svpw7R/99NkDnCcFq2nk0rzhlb5qI2g+XvaKVuLlN+Wre4aD
	 BmiLgNLyYlrc8Ar7G478vZXh8QXGKFPm+oTrB3ydQbejUJ2+tYRNsceFftq5jDxaPIXWl
	 z7Gmjks1j3JrEgZdh2zx7+Fc80eW8km0vgCIdbwcheBQok3y3IHCaimRl46oeVDQ3w2dH
	 A87IHB7POUiwGm+jPVviBhZIBKYYouCYHsMBXRPi/yHn66HWBUpl5DL0Yu3Vg4QmS8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=g5rR++HqiujkqgcgFbEWWsAIqRkI/pSZhF+xjQlCrkg=;
	b=bkr8m1/HYdcxI2qnFz1xG1vXK+1deFWNdaw0qtkRM7vMZvMwqwsdet4cSqx1V2f1xT+2
	 PjsrdbY88eXrv2edCpgAMwblXTQkbk5Tbx/v1pAlMUzu0RE/VBRjPLFvkPlLVaYLZIkAz
	 xZJd5vd7pDzZJ0IUMfFrD019oULUTeXpOhLSpi98BGtl/xGcGxgCdF+6S3NqRAYd+IBCG
	 g0uMP3wD53H6TxFt5u8NNX+MHHg7TidOHA7+GThfsOcfPAODeA/B3tP96PVq1ihScrOi7
	 chH3CbGw/uartxMf5koOpJqmKTIMCkLKzuRYzyRFb7K0ALSLTeYKl+k95pkIqDuRpZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zhHRMKqL;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1E606B41A
	for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 14:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECE1E606B41A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zhHRMKqL
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5361e313e63so47063811cf.3
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 06:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795445669; x=1796050469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g5rR++HqiujkqgcgFbEWWsAIqRkI/pSZhF+xjQlCrkg=;
        b=zhHRMKqLOExPC2CN8GidjqP4Ah4IMzsmi/v4+yybrs70SX3OHzi2lUBdk2XESFcLKB
         z/mg2HJ0S9Uelb60EBtKadaMz6beBQkzMa3fLLbF8NhEBp/dYaSghrdQSUG4UMkwGiD+
         0YGlUgsHbmHFJ8MiLTWVJwX7MEk5rmBCCoxRj4qcbAalAuVI+M+gjcsK9azC2QkLi5QP
         WUEgT2RA54s5Sf7GN7qIMWNDomJ2g6YX37Qvi52kLKJo+D+f6cDHRG/wOJNufnJ5BMhl
         Lsjk3IPjqXDpeCZ13brIdJpl6cNZ8gk+DX91du4nA6tmmAplk4MviI2y6+zeEw7LVyb8
         Jq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445669; x=1796050469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g5rR++HqiujkqgcgFbEWWsAIqRkI/pSZhF+xjQlCrkg=;
        b=nD1AE9QZdaI3OMYGaf6uOQCQ2T6OTL2owH/AZfF4ZXeYB8dQ2MATUjX/hK3EBkxzZY
         tl1sw0XAs1sU/JxHqSu8nHN3x5Ull4sI2MptfU1X8WXQr+dcXYtYY+Ipj4YbbLFq6tgk
         TRaTDGD5Ko9sMqmLANQgSeVeY75doB0D/i3X8YfpT8o0m8ZbjHoKHNo8G1FpcK2ZUEUJ
         HsArsLcHhlLb5xVTwWC1EwL+7PTaE0u/Dzvqp0H0Qql2RMpIKH+A0hZo7m8u5ywmQk7d
         fWhptrv45+KFvQhSf6q6Al4EMiVyAopJQxvb0yWrbxMlCuA8Vkozx3TUb7ITzTMyh4Dt
         rSZw==
X-Gm-Message-State: APuU4Z/h9q8fppbyDa5lQ8hdYSPgnQJAWtm7eVy4hZ+My7eIeUR4YSQ3
	FEU3EFkppjpjeWC1E36WH6kyNi2zqsDMhYowLqfoaxPK+H6S/IgtehZCkFKkcInX
X-Gm-Gg: AZFdTZe1Sdx8Y14hG3UnpW0jrZ9fM8omhOgSYluzhpwCTAEWLJM93+ZDiLWStyPwigE
	CY1X6g0uZ/ShxAy44/GzAnSs4VF7xNLvIuBsUM09Hb8lrot2EyGi+N5uoJ+Ce2rZn2QUxSs/Tvn
	AMjhc4qX+Xc5WQ2xwdO2st4ejzeWCaUHTVSPwN/mo/T+SrwJvrkwbMWyM9vwGPOZq2MKNfYVtuJ
	yI2v/dHbSIzNwOXJJanl/aTLoyVeqknr0/W8/f74eVGqkhYgB9hr1PTXUazXFbgrXX8D4X8r6PT
	TXzOebdTHasdq4C1VfJfYzLObI9PZs3dxY5RPsUdTpr+YcF1ZwNeRZepSQqP3KsrDZZC61qc+G4
	4HLbnAIJ6/pXbq4sYCEhCUJKS/CDleINLqQ6fQ7Zi6R3h7eWmkv3R1SgYzlchtkBDPAR9bWmzPf
	auRuW+5DChB3sZ2JfcrkWiMxJNkdFNFS/n8uEu3b4gUcrRcfQnCcoakh1rvMuO+9zu+0xWxdHDx
	j8r/rei8ZWrArB5pJWHvzjfL5PrMBfUFz8ekCuq3UvbivYrijtdr0nM0pQVm69Z9usx9ZSEJ7p+
	Vt9lDW3pd+xUc8/EjdKvYZ4j6/2oSkBs3lvdXz89y3kTuB2E/QZL+o77gWAbJifsVIBj57M7X2c
	BbKqhkglFNjQXp27cH9evrTtQ+sy3ZKSuoE8Y4VJsZOq1lXdImu31oDTcx0u+rvdkP6ePWpMAWF
	0r2zAcjbuHK6XybVh38wTGli4VyGt6e7Eyj1bGWwjGHZiu1NlpQRozdGNekR2j1MWP+EE=
X-Received: by 2002:ac8:598a:0:b0:533:3fc2:8b19 with SMTP id d75a77b69052e-55d769e1664mr220363531cf.20.1795445668748;
        Mon, 23 Nov 2026 06:54:28 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78880604sm101869111cf.24.2026.11.23.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:54:28 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] .github/workflows/run_tests.yml: restore clang jobs in the test matrix
Date: Mon, 23 Nov 2026 09:54:14 -0500
Message-ID: <20261123145414.55475-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing the gold linker job left an exclusion matching only the
compiler, so every Clang combination was dropped. Remove that entry
and retain the specific exclusion for Clang with the BFD linker.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/workflows/run_tests.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index 749c5b4f..f379be10 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -22,7 +22,6 @@ jobs:
         exclude:
           - compiler: clang
             python-ruby-version: {python: '3.14', ruby: '3.3', other: 'linker-bfd'}
-          - compiler: clang
         include:
           - compiler: gcc
             python-ruby-version: {python: '3.14', ruby: '3.3', other: 'sanitizers'}
-- 
2.56.1

