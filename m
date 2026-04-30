Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E339FCAB
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591491; cv=none; b=lnK3cS7cSlSqlXNMdOBnxa2Cxj/IoBRIOV98CSiMc+DllPi6YUwItvk3e1O2ZLg1sRajbaYJVj2f+sDZbX7hQsu1js8R8UUHgVb0C1QJ/q75sq1VhaFoIECZ+ndqzM55JoOuclcdV6b8kbYk7Aw7BmKvPJANpjnevU7fEHksN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591491; c=relaxed/simple;
	bh=S8aI0tJ/N10LN1adlaHlNK4ex0HUvTcYCK/sxoaZszk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pnafU7lhy9oZWukboV0s4TnHJNKrtk1P9vThjCplhadzF4hqQAD68Hq0EjpE8+kMbAOM7Bbj2w1XVeE7pY18HJqr9KvN7BdqmjnWa64+9sdKR0djB4sDGmx3M2q/43HNf7TlOMDlZb4RnWstJ2U+9yzcusnoEo0VMjlLPrRKfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=Al+1VzXw; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="Al+1VzXw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0iCD6M7pX2KGXyTJ7Ty01UD4jcptTZ1RfqJtp9pCzJ0=; b=Al+1VzXwJpovsYD2lHts1pk1+0
	uptGbYDqYINvC0XNJsRM6Qe56hnZNBTb8YTLbuPUDBtO1psHHurQgy0dFp93TxJA4mbrzencV+pep
	sPIGQ+a4mYoaE8mt8PV9pypbckblWfOnDAezanXIdrU2wxf+N/hKIA8qx+oyj4aeTY01P/nFyUdHE
	8efCR2r6Whmbn2z9earh53wZa8OgNlMPbOD8tRdrFUln4INLVlGmzE2wEVcz7S+rKCleqol+LbzRA
	Fg5r0upmuFRjit3+st/aUiZnaKie15ge6WBoBUqp88urgCzobZAAjFxVysPWWRVHPKow36npB3yt2
	0WC0sXdA==;
Received: from 37-33-136-133.bb.dnainternet.fi ([37.33.136.133]:13818 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wIakQ-00000009Iey-2xua;
	Fri, 01 May 2026 02:24:46 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] selinux: remove unneeded goto and its label
Date: Fri,  1 May 2026 02:24:37 +0300
Message-ID: <20260430232437.56079-1-kalevi@kolttonen.fi>
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

