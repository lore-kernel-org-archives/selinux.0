Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6411E4110
	for <selinux@vger.kernel.org>; Tue, 13 May 2025 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747171729; cv=none; b=ZuB40PObTW1LF3hQ9RWij7ZSZBeUGbcbH0bBv+yYSD+Jy4K676F1JU/cyvqXli6CejlrMVPeXS1Q3vjsRx0TSWXnoJvhwuBId2z7SD5BZXIORE8xNS0k+/Eyy+cVIPPvsqLXavIQOAonZuCME9FYmtiV+uW3RPaBBbNpePhLQbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747171729; c=relaxed/simple;
	bh=1iBvGIYe30dkNLDkeLArlbEWdC+KIolq2nrs3rcJvTM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e/5N9KyM/XVY7ccw0iUbRhmTlq0GHrh0MLHy/Wocca8Ymi9v398YOrIE8uMxwrLvd92F7oejj7HLX4e2I2JCr5qU3qOMsiIcsN1GO/XhYDxB3Z1I22qrd5WE38TbAmmJY4j2JWd9VcmG9hp1tyQmasXTA2msfrtdRdh1LIjDplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=lCdE3ZBv; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="lCdE3ZBv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3WkMHhulaCaxhvubSZ0RBOtumQnLErmBt4Mf0sUe9Lw=; b=lCdE3ZBvkdAnNnJb1tX0vjKMiG
	dewkWnSgPCUXO9MMGz9qc42X4oBfu8TJsVeEFB0HFzVdbsRhkv5IHQdoColOiLnM5znNNoshFlehZ
	4m8f3UQ7LIlWuwVKBAbZ/Mr0eToRYI1qbqOF+4xVCTccTH+CyAeeC+XJ8Sz71dZtO5L+1BwZ+uyQe
	iYU48kzCTFnN5PKh+a36Q1E4V7QjsvT57wI+pnaHpn46mY3cK21WiCOuRHb8ceTo1z1TMsCZ1lQFd
	Bd/x3GfLsePxxVosG6wc8jLThe7O2SGM0w6rRnvz7bn2q+m8gXEB5zokjQom9cFGJjVZOpZFdUScY
	FYTivtKA==;
Received: from 87-95-117-63.bb.dnainternet.fi ([87.95.117.63]:23568 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1uExB7-0000000G2Ov-0et7
	for selinux@vger.kernel.org;
	Wed, 14 May 2025 00:28:45 +0300
Date: Wed, 14 May 2025 00:28:43 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux-list <selinux@vger.kernel.org>
Subject: [PATCH] A trivial simplification to shorten the code a bit
Message-ID: <aCO5i48MHbYxWcbo@14-5A-FC-31-E8-67>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From 9b209da2e749ffb869ac91b90df71d14cd5970d6 Mon Sep 17 00:00:00 2001
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
Date: Mon, 12 May 2025 22:14:19 +0300
Subject: [PATCH] A trivial simplification to shorten the code a bit

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

