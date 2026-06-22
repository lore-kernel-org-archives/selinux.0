Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1546333B6CC
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160767; cv=none; b=fQCk5v48uJtTQ/oksWxW3akL/7cNAQecudQdSgMdstLkbcdyWqr253w+sYu3+kc4/H/OSzD66W764jdfOiNexMyEZ4weBys4QppY1hfJ0OJYbV9TXYaOCbHWiP3hNwpCgI5WH2ozvoMOR4DLrdMROd3FQ5uv0oatpsORikyfOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160767; c=relaxed/simple;
	bh=t7Hkc8vN5o7JMem7bPxhEHkgFjovJdGB1MLfDj0+fAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s47j5qiw5L4HO1nz2NQ6VduUVkhT13PdcIXWBEZVXXdSj7+Mpy4oB5NdNyDJONOLhWwQ05c3UbFU0LhPWsaxwjWK3eagQ3sHp1lxLut7a9hxdLCpMLsTstY78BU8ga9xidWeQ6dyaYaxMlKvEmxr9lOP7poPdJcm655B1w7w718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=tFw98ho2; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="tFw98ho2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+aVy4byIuOqWsIWh57FVX4aav3u5buSTBL3Bpy/1w+M=; b=tFw98ho2JlZynTalN1qTWFuGwf
	5tccRCDIWkcL9Cg9FFy+yGbe46sC/zna8zRgNe6FhO0u9do5RERS26lZxU38fNsfukUdySdRvlPKg
	+AjdASX021StZp7UA5j9q+/st5oXDWy3cTGSsrDXjhpYqZ9RKaQaZvUpImH748IzoVVbF5a633js9
	J567f8A30MFl/KJkAtcMdER5zTish4ZDMAMMYH8QWp1tFT/Nas6oFDhbqKi1eFnw7zpk6EKNuGF3a
	07llSI2MOjcj5BcQSLRl7GyIHoTHujcIOFC4ZL3XzDLhwNA+lQM4aHpeuzj12mYXNCWzctHeSvz4o
	ujPwdVlQ==;
Received: from [87.95.76.183] (port=4433 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wblQR-00000008ivk-0vug;
	Mon, 22 Jun 2026 23:39:21 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH v2] selinux: drop unnecessary goto and label from avc_alloc_node()
Date: Mon, 22 Jun 2026 23:39:12 +0300
Message-ID: <20260622203912.80430-1-kalevi@kolttonen.fi>
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

Since avc_alloc_node() doesn't need to perform any cleanup on
its exit paths, there is no benefit to keeping the out
label and goto statement. Drop it.

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

