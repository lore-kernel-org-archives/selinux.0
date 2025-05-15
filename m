Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C2296721
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301175; cv=none; b=Vw2saFTr9Cazykma9rU5I0aMkPtwMVCmjM4x2GeWGREGIu06boTwogVZH1lmI8sFl7OCmMOA3n6xOn5qGp1gUKnWGXZnF+eJxG7AcfwOdB3VARs8Poj8dVJitcTDDAjgxQv5R62S/Gr2Msge7seZ01KeIXpy8Ks5hYDJLzqKYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301175; c=relaxed/simple;
	bh=uW4d9cNXjRC4EU4z2w/TDL740vMqAiMM9SvfOjaiXQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eoCvKDh0GF7EIymX73SDJZL09jR6L2esbYMxfW8gcGJGwa7QO3jDAnCjwDRXbk8T6TczL1bj3cXcp3i8ucNnNKJ10NKoJLZnEM05/FEAKxvZDyxjqnp3fTLUF2UoLx8nzpg6UoiI97vgk2qgzAfQPkih02rqnnvir7aVFXOpPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=OHenVWo3; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="OHenVWo3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bGZEQ4LXvvJE03GfvgvvM8E7lJtNvf2kNL6fMyhw2zg=; b=OHenVWo3RgoeMX/Y4X85uQ7YNg
	AyLVnDQsDULheFbN1xaROqpWSOCIBV4RJja/cJNjJYlsilLcPGm3iTYGJsO68dGOIpyQBBZiqLy74
	9pZ3AuxulSfWbffLMOjq5pGLvBTFaf2CWuFSb+gqBd+pXuc6A1K+qfBxB4MEZQsSj/AqBKr64YuGH
	lyP1QpC4cKGUAosIt0WgDeOeQGpUZaf3P3AX/UZ1roi/0bHuKNVdEez99MhDuQYRrTIgzR5zTFZZp
	1WrjOexDVNyzBrHoQr0WOXq+IQGg+8QLaxBnbH5itL/BivX44djam1xlNCuXJU4+V+pGuPmxP5ERj
	coV7zYFA==;
Received: from 87-95-116-80.bb.dnainternet.fi ([87.95.116.80]:11755 helo=fedora..)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1uFUqw-00000005Bdc-0c1X;
	Thu, 15 May 2025 12:26:10 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] A trivial simplification to shorten the code a bit
Date: Thu, 15 May 2025 12:26:06 +0300
Message-ID: <20250515092606.14760-1-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.49.0
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
 security/selinux/hooks.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7a7dcab81db..337951fb81e0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6693,14 +6693,10 @@ static int selinux_secid_to_secctx(u32 secid, struct lsm_context *cp)
 	if (cp) {
 		cp->id = LSM_ID_SELINUX;
 		ret = security_sid_to_context(secid, &cp->context, &cp->len);
-		if (ret < 0)
-			return ret;
-		return cp->len;
+		return (ret < 0) ? ret : cp->len;
 	}
 	ret = security_sid_to_context(secid, NULL, &seclen);
-	if (ret < 0)
-		return ret;
-	return seclen;
+	return (ret < 0) ? ret : seclen;
 }
 
 static int selinux_lsmprop_to_secctx(struct lsm_prop *prop,
-- 
2.49.0

