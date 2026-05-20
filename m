Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D533D9DB8
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279072; cv=none; b=Vs5E4e7jprNUsG47vIsncQvfSukhZSKy1dBi5PuPW8W6fx+4LgZ/FB8SvkG3lTAFdMJyGxO5CwK4bp6FlnnBJB/5DwCeqkS4cau/cb2bJP+d389F1NQ+vhaFh6R9Lrvj3G2HPlrGXHKGmJ8Lv5RCje6dwfxff3MBPFqMWF2kj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279072; c=relaxed/simple;
	bh=1tEjw5F7Q1EPFasPdjwrGuj1YZeX1HtxzUv5sX0o36A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EcLDENDncMn/cP4/Ql1h0m7yTQwfK5TRH1irUuiCU4FnaNMvG+jCE0Dgqmc4W6RM6nWUjtFMAuOak2uflL0DPngQBOzkjJ56j2XTmHigNFKnH/I6hP80qn86ouvAVONO/Pz0qvUKg2jjyObF3wffN/YMVOOQNP9ZeRyEtAQSN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=dfZT4BDG; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="dfZT4BDG"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1779279066;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pIZx0yW1r0ktUBwkE9Xj67E+qYBu9cW/Q2Hr6K2kZK8=;
	b=dfZT4BDGDYNYm9z+0wCXdfo9NKqFXie2XwvtImibPm1MsJ44SIPrtdCJH+HrU5JBSyqAGo
	bDffgsuYMZFq1aqU/vR+3OJo0Gr1DIjxSgCXar+UyU/K00shaNFaVZQ/SY42ihJhyLIT3j
	sT1RGQLwxsqIAb2HGy12B4cZ3DeB+JWTJFk/+0b975b1x0uje+JKy7J/AMymdpwsC716KM
	sjqOGPR2v5CNj28LoParAonfuWcVX5B3q0od9oNSHwGVaKEVvCAeM6q96z7oadHGKsM307
	3lXOYmFmd9cifrfuCjy55bbtMPFr253DJCPfKNgLdomvESTyxQCMXpe1E1ykzw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 2/2] libselinux: reset scanned file count at selinux_restorecon(3) entry
Date: Wed, 20 May 2026 14:10:50 +0200
Message-ID: <20260520121051.20863-1-cgoettsche@seltendoof.de>
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

Reset the scanned file count at startup in case the calling process
calls selinux_restorecon(3) multiple times during its lifetime.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index b4d58b05..b7defffb 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1446,6 +1446,8 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	int error;
 	struct dir_hash_node *current = NULL;
 
+	fc_count = 0;
+
 	if (state.flags.verbose && state.flags.progress)
 		state.flags.verbose = false;
 
-- 
2.53.0

