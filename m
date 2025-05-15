Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5A8221296
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301068; cv=none; b=KLiCM4J84dbCB+wp7KvDKriz+Ufm56KXYrCXI8hFo4yRg8/W21jFrEdNesxADdRNvH7g6xXdX47Hq0uwxLpF7/ivcjsCanwxjBc5PFLmxULYhXHsMJy0U5Kpc+DzqOshlauagR9HIlYV0/+oFXbSw1XDF1Ex78MOUZEmCEfc0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301068; c=relaxed/simple;
	bh=h5JQabOj+/xoFeySdPJR/Rj92fNpTsM1414Yto4PopY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmZMq5Je1DNF1VWKAwAgCmi2pDjCffeWNKuXiQXdo/kBK32uOF8mdPuaaySlvOElXcRXSXB6eRHlx8HtrKzsa0uwBNfSURPNNXoVaBBJyykg8zswLpn2bz46aFWk97csdWfMF30LBajSj+eolmlFzCh2YguSRPXoGCgT1qkTgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=lbSRi5QN; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="lbSRi5QN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2bXkz5uuMXGc9juIEI/h2WEyC0vns0u+8y4v63Adn2A=; b=lbSRi5QNDDj1IOeuG420MTcBC9
	gbu2bIAi5nS4w6Y7x2u/cc6YbkxxGqZhMlFH5zx9JtRzwPcVu/1DKDVwnVyetA2S0622fLqApWVwG
	uOFNSFkyDWNs8uBaewiKMpyFKPLL6CYeLCZ5QvkYIBHFMisO603XLBxh/x9Z8taq836t8eE5zABhm
	S/cM5hjQJZyezXfj8MNzA/e8b6Jh7mHJik0dz5NTbhrJ0nu4CiKwEx+IcD3fNz4H/F8kS6mpDbbf5
	sjIZfVddG28nGN0R8YrjOZa7TzVoZwmZc4jtR+AA1S7c6uDEiU5R3SWNCAL/VEc9jXmtOhMN1Z8d5
	CwgYYdVg==;
Received: from 87-95-116-80.bb.dnainternet.fi ([87.95.116.80]:11730 helo=fedora..)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1uFUpC-00000005BFj-2cnv;
	Thu, 15 May 2025 12:24:22 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] Fix variable type to be 'bool' instead of incorrect 'int'.
Date: Thu, 15 May 2025 12:24:02 +0300
Message-ID: <20250515092402.14564-1-kalevi@kolttonen.fi>
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

