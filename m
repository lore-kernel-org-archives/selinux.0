Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E46280325
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464132; cv=none; b=mbh3JEPOE5WA/u9UVdyX7IM712tMN3+p+CG8PnD3knL76KgGhHu5B9Ao5bVjZKWRleM0kay+U+XvZoOTgs2hf8bpFrWWQNX/GBLRw00p7KC+v9kmx7HH3lEUVHAnL+8u8f3GZAavdBwtl1ZCxw28N2zcet4z9cDggsHyrl0Joq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464132; c=relaxed/simple;
	bh=Heon8JTULnz0ZT21ptJOnmyc57uZg9krftq88F1IhBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKaycyKYsIdpHPal16a7QxKZkl3clcZCKb2Izq3CeGk1v6/npSWiW6s3yAnpMilGEC7teCzB8yldMnA6zcyLAYl1kLVHalV5Xlsg7YVoPy4hEe1iEEXDrf2dsQQtMB+G2qPv8wP5KXSuc60ZksWKuTJMjVs+MaOapzSTzYkcTW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=Atv3fUFs; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="Atv3fUFs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YMTqiI05VJ7Ct3vJrZBUL/rPOmGCXNfOsyBEQLpZ08Y=; b=Atv3fUFswsrkyZUZYx/X3DxasF
	U4cLEFXS7rGvIj5rN4CSBfJEtxN46TFrvlfZUXs4vzWudlC42Eg9LIvlT+YC1dAKs8HeoUQxgPeiZ
	LJjuOkYlVoY9vkVIQHNAQGmArNv0QAf6ovj1F3B5axEuEBzabMlH8GL6Cvo7GMIMz+cofDxtQWQsa
	ZiSy9rydxsPwUvVr48VQv6SyWCJFohxk0tA4+6yyEtjysm1ij+j/RUygrxXkymRopZWznem+XaNx/
	4ljGG1OxZBwt1IPD9pbFuhvpKMpiNnwJiz/58wHNh2K/1/QW/D1oFff0GvO6s4muErbjpM4zURRDm
	dwLGiHOA==;
Received: from [87.95.76.183] (port=4295 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYqCP-00000009BVr-08Bu;
	Sun, 14 Jun 2026 22:08:48 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] audit2allow: make error message more helpful
Date: Sun, 14 Jun 2026 22:08:37 +0300
Message-ID: <20260614190837.2947-1-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 python/audit2allow/sepolgen-ifgen-attr-helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/python/audit2allow/sepolgen-ifgen-attr-helper.c b/python/audit2allow/sepolgen-ifgen-attr-helper.c
index 609efb31..c8e68874 100644
--- a/python/audit2allow/sepolgen-ifgen-attr-helper.c
+++ b/python/audit2allow/sepolgen-ifgen-attr-helper.c
@@ -212,7 +212,8 @@ static policydb_t *load_policy(const char *filename)
 	ret = policydb_read(policydb, &pf, 1);
 	if (ret) {
 		fprintf(stderr,
-			"error(s) encountered while parsing configuration\n");
+			"error(s) encountered while parsing configuration %s\n",
+			filename);
 		free(policydb);
 		fclose(fp);
 		return NULL;
-- 
2.54.0

