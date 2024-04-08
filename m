Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD741C6C
	for <selinux@vger.kernel.org>; Mon,  8 Apr 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588892; cv=none; b=BBDTXLcKrEcm8quWXv1+LeL3hQhkmSiJmIdkGqp3OQ1WE7hsKnvg0RllteUrWEf9OJTAOcps54LhuKDmpCm+cCbQfkbTXJsoGP5lWuKnj9M0oWiIdPRiTuuGgBCkEt9FYIKDGujk3LsC99aveuVOyPlug9G5Viv77aphXPJ33LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588892; c=relaxed/simple;
	bh=I5evE4bW+qAyAf846OfiJcppIA5WRn0Mqt7mUMeOSA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrB6CqWmElTdaiwo95cPCe+BpAenRRJhCNzCVIWUvC1/Xa8G6hpqjEfkhbfWk80gFwqBkQ/sYeVPib4wXjhSHOc6ePXrIuImWghPvWblA1YATsh2MCjPuVW/d4zzi1Jv7zUkC3BEzfrYMkGLMbAJhyyUxEaY/6nFIy6lTzkVx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=cxfsRNIn; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="cxfsRNIn"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712588887;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czm1vMHORwPbQZM/KP5ZfCDFTklC7RmW4Nf6/flp/BI=;
	b=cxfsRNInl3H2B1l5dUL8XDKcDA8zfsLRH6x6Ri1/oUkq/ZViKyFxg9lGr9Bt2TSg6XjFmV
	yUiTLtHQBMTg1ZIWuqOTQ8NPg0ysiUDHvtopEwX2RSC+m0DrI6XcphY9FkV0QcuN47Hm19
	W7Txkp/TWWCKocOBK6BLK8knE0QhhYOKXlh6q+cXHmpYO0xOfR1TUfJ9cDRI3Aq7V/lu+S
	JR0kkGcWaf+Sb51D0c0V8I8Ays4Iu9B6SfDAsaQ5oLdHUCjvGu70JVYDC46DfpxpBgKLEe
	ObAKJZZaS3PNvGdDr17QTVB8cOSKEXMvwHGgU9OM9AL8vl3u2ucHiOoKHWA9/A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/4] checkpolicy/tests: add test for splitting xperm rule
Date: Mon,  8 Apr 2024 17:08:00 +0200
Message-ID: <20240408150802.63941-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240408150802.63941-1-cgoettsche@seltendoof.de>
References: <20240408150802.63941-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

An extended permission rule statement might get split into multiple
access vector rules, due to size limitations.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/tests/policy_allonce.conf              | 2 +-
 checkpolicy/tests/policy_allonce.expected.conf     | 4 +++-
 checkpolicy/tests/policy_allonce.expected_opt.conf | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/policy_allonce.conf
index 34e6402d..54a4c811 100644
--- a/checkpolicy/tests/policy_allonce.conf
+++ b/checkpolicy/tests/policy_allonce.conf
@@ -36,7 +36,7 @@ allow TYPE1 self : CLASS1 { PERM1 };
 auditallow { TYPE1 TYPE2 } TYPE3 : CLASS1 { PERM1 };
 dontaudit TYPE1 { TYPE2 TYPE3 } : CLASS3 { PERM1 CPERM1 };
 neverallow TYPE1 TYPE2 : { CLASS2 CLASS3 } { CPERM1 };
-allowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x1;
+allowxperm TYPE1 TYPE2 : CLASS1 ioctl { 0x456-0x5678 };
 auditallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x2;
 dontauditxperm TYPE1 TYPE2 : CLASS1 ioctl 0x3;
 neverallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x4;
diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy/tests/policy_allonce.expected.conf
index 63739e1f..aff6bfa3 100644
--- a/checkpolicy/tests/policy_allonce.expected.conf
+++ b/checkpolicy/tests/policy_allonce.expected.conf
@@ -34,7 +34,9 @@ auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
 auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
 dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
 dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
-allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
+allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x456-0x4ff };
+allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x500-0x55ff };
+allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x5600-0x5678 };
 auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
 dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
 type_transition TYPE1 TYPE2:CLASS1 TYPE3;
diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpolicy/tests/policy_allonce.expected_opt.conf
index 1c969961..335486d1 100644
--- a/checkpolicy/tests/policy_allonce.expected_opt.conf
+++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
@@ -34,7 +34,9 @@ auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
 auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
 dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
 dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
-allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
+allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x456-0x4ff };
+allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x500-0x55ff };
+allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x5600-0x5678 };
 auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
 dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
 type_transition TYPE1 TYPE2:CLASS1 TYPE3;
-- 
2.43.0

