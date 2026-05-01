Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E12DEA90
	for <selinux@vger.kernel.org>; Fri,  1 May 2026 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662870; cv=none; b=BOdjBtQtNLIzE+U0MSaVDoUbFHm4sqyUpl/VHLzVUmbZikzobHOUpHf28s9zYxpoP0NBMVJOUbX0ONRoSvbv7CYoN5g75kiZmD2DiPDw3+gIcUM1zUGVAGJbZ8Ifkgtx98Y188ONYnR2DvzGc7mRB/OI2IEiVrkKBlHSaMPy56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662870; c=relaxed/simple;
	bh=4iRSiSp1bfpS3hes0+2xyCD9PAqMqybT80cK3zeMrWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMGZZfw0I4sUQfcDgBvjl4GanKhSqb0OB8sRqHMVNKqnnD0xHIUqClD1M64ag5yuzyBcsSQ7A15Dg9hL+3b97Vka9BJ+VBoklEqDd8F4Z6HVks170jIT7UZ6VBYPvPABq2bVqklQGjARx2/ooTMgMWLGHW098IHf3kWLbJb9J6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=zWkCuNA6; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="zWkCuNA6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mxYHOP4OgONIPH3TmJSXmmvJHdocGS3u1+SDkOh9Q+0=; b=zWkCuNA6URfP63ugwMg2Hb49IU
	nkVW9GnKvuZ0MjpJWefrbmgCLtsGMXnsb282VUGKPPwSo89uqcAJ/VRv7hOyewfSqykjUVBeKNAeL
	VaYKTjgo9OBZMbvtjUm/v/6zRFnHqY1PhaxxO9WsrtnkBOojjlS7+My33hVTUDZi5XKW5JLgSKJxK
	XO4Hm0lp0ztmJvnP9vPsQMEcLcDj/FWMqxp1ElQiGi1D1PIWu4BI/weX2pJyxqdJtWpOv3ooIUsul
	nmp5LbyMRnJj2viD4BYB99O707nNKaurUCQyxGMDP37C2MuzkqboDJm/vfYVVHxrbCC7G/DW7Ncig
	2YbwZngQ==;
Received: from 37-33-160-15.bb.dnainternet.fi ([37.33.160.15]:53508 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wItJj-0000000Cod1-2juy;
	Fri, 01 May 2026 22:14:27 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] selinux: trivial typo fix
Date: Fri,  1 May 2026 22:14:20 +0300
Message-ID: <20260501191420.95344-1-kalevi@kolttonen.fi>
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
 security/selinux/ibpkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index 93a5637fbcd8..ae09d59aaa06 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -2,7 +2,7 @@
 /*
  * Pkey table
  *
- * SELinux must keep a mapping of Infinband PKEYs to labels/SIDs.  This
+ * SELinux must keep a mapping of Infiniband PKEYs to labels/SIDs.  This
  * mapping is maintained as part of the normal policy but a fast cache is
  * needed to reduce the lookup overhead.
  *
-- 
2.54.0

