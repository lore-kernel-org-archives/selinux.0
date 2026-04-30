Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281303B27CA
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583923; cv=none; b=npmzihR/9uNz907xfm42pFQregvJ6RAblYyvb8/zH7W0Dyb6ZNvp6TprimneAEJET0NwhOfG4oNba794opMRW0B7d+QIn7SePrKTXNt5EEmlOSW0ZCWVTwVkrmtSrzaxq9sLyVWXexhfyrO+E/8vUQdsekJxY28a2y0qEPodLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583923; c=relaxed/simple;
	bh=S8aI0tJ/N10LN1adlaHlNK4ex0HUvTcYCK/sxoaZszk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cArndXm6yZcn1RQ08pB8OBIL6DslAaf4wxR9PcZU5mfINe8qpdGDRXkiSNbQ87nLj1W3KHICwJ1GT4Ua9dYB63xTzjyYAvz7XzBP5zd6uELQWoy+JTyaRvMuO/fVTLkrV4iCKGhqJeNiHmVc9fGcC3xYgpTAXZTroABugDf40hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=ZsS69l+F; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="ZsS69l+F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0iCD6M7pX2KGXyTJ7Ty01UD4jcptTZ1RfqJtp9pCzJ0=; b=ZsS69l+FfWJvQClloNQF2O0jFQ
	Ts7sPTo/Hly5nj0JHDMzOFNVP9PS2vJXDa2QOEpF/0xofct7A77IKSL2eBn7jKWtKGLigmZLrI0Gi
	/qJVZAObzwf8dW51YX5c/Q2SHULrqF+/vz1rniUwUQi4nj3IHjvgwjh8N0wGZJGAxGb49FANZG/ZK
	UbN53SzxaAjUC921mZUDdtZQT4MjJ2QWcBSNM6GdzhgQswOzn0FPhkefGLhqNW4TaeHrgcYuFF3yz
	7JEyshHTZldaX8YXtctG2nBkEtUE0rFnfpNyRG+k6qI+P/f0TmERvE886XsC827TRXQQeOWMq+k/4
	w0W55e8A==;
Received: from 37-33-136-133.bb.dnainternet.fi ([37.33.136.133]:13379 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wIYUb-00000008pst-2fB5;
	Fri, 01 May 2026 00:00:17 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] Remove unneeded goto and its label
Date: Fri,  1 May 2026 00:00:01 +0300
Message-ID: <20260430210001.56995-1-kalevi@kolttonen.fi>
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
 security/selinux/avc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 813e82bcfc27..a9401d6c2e5f 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -497,7 +497,7 @@ static struct avc_node *avc_alloc_node(void)
 
 	node = kmem_cache_zalloc(avc_node_cachep, GFP_NOWAIT);
 	if (!node)
-		goto out;
+		return NULL;
 
 	INIT_HLIST_NODE(&node->list);
 	avc_cache_stats_incr(allocations);
@@ -506,7 +506,6 @@ static struct avc_node *avc_alloc_node(void)
 	    selinux_avc.avc_cache_threshold)
 		avc_reclaim_node();
 
-out:
 	return node;
 }
 
-- 
2.54.0

