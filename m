Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDBC17A2EA
	for <selinux@vger.kernel.org>; Tue, 13 May 2025 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747171813; cv=none; b=FSPxl04/YvJSoerQcFrpWJaTSzLyFLjv+Lz++7kg8hI67D8LQopaJc8+Qb+Y1irU4QafeTvW9RX8BNufjMQjbgXngdB2iOfisr2jgR6t3iafZzJjBnxPkAmTOFViZzgz1zMuDELz9ADX/MQKcRVdHYeuXABRuJTxxzOy3dRvJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747171813; c=relaxed/simple;
	bh=Tzg6fFAxi8LGeFaw2YHKYKUG4Mhg4y1Ozcy/kuNyWq4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YLHMJYz76AEVTP0AHbIUEy2vOe4Lioq+EPC1U5zcFzucLvPTfJ7pDIgDze8E1r/1PS9KFV6xPE3ulLFFnC+VIVxGkM7hwmzke4/vGmzl4Uxq1p4hfGycmy7h0kfI9h9lcGR59tAvrYTAp7Tdw+k0i8sYze6+6lXd4/W90Lbcf5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=wjrpTn4q; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="wjrpTn4q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=En8kag5Fe0xCvqeQFi5HpgeYHFN390jjrFSILyrbHgM=; b=wjrpTn4qVG4UTzK1dfmbxqtG2Y
	Pjsws6Lh4utjtjFFJQVKb8hap7m8fC+ydZFym2PAnGXdsASfSAZ/PXPvbS9fjFe7HcP+2NWAd5tvu
	HvYitiPIVWo4h4jHCym785zHFh+uXjjuqyZVpJvX36HhBtvgIlcP7PlnGCsNjB0zXj1mkEPqMahq8
	8P0yXkgHEGXEXsdO+/xvBJRaBuPGu1zWaVrPe96PcZ2HSvyzEloBcqtfPQ04y4SAPF+WGe2n5YfJV
	vRUyHky/RLDCEfXjOBqqjNdgzh9PAtBCtIRKzJM25B96BAzIfESD9m8jV59WAR0hc7s2WMZ+HUbYv
	Q5Mit9wA==;
Received: from 87-95-117-63.bb.dnainternet.fi ([87.95.117.63]:23672 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1uExCS-0000000G2dl-1FQl
	for selinux@vger.kernel.org;
	Wed, 14 May 2025 00:30:08 +0300
Date: Wed, 14 May 2025 00:30:06 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux-list <selinux@vger.kernel.org>
Subject: [PATCH] Fix variable type to be 'bool' instead of incorrect 'int'
Message-ID: <aCO53r39kCyxIDL6@14-5A-FC-31-E8-67>
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

From 58f88fd5912bfd0f9311c73ccf208d2765b74aef Mon Sep 17 00:00:00 2001
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
Date: Tue, 13 May 2025 00:16:03 +0300
Subject: [PATCH] Fix variable type to be 'bool' instead of incorrect 'int'

---
 security/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..02336de43ba9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -288,7 +288,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 /* Prepare LSM for initialization. */
 static void __init prepare_lsm(struct lsm_info *lsm)
 {
-	int enabled = lsm_allowed(lsm);
+	bool enabled = lsm_allowed(lsm);
 
 	/* Record enablement (to handle any following exclusive LSMs). */
 	set_enabled(lsm, enabled);
-- 
2.49.0

