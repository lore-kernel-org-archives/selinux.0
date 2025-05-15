Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069CC296D1D
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301272; cv=none; b=kKDkdSStd07QD5Jy6s+QHx31/ynQGq8S52wmBKor9Og0Cp+oHIa8a+kfbK+4NjzBMWH5HEAFz4jrAI768eQApSlTv1qRuazIKUUNkWylu5G4XGB7BeEd69bbyhxFbCoc6PiOfLG2mwmf1zI+HtqpQ0gP6lvpfhNESo5epMyYor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301272; c=relaxed/simple;
	bh=US8TXUHfjanY9QdDynzkk31r7I23b9tcOx4sbG6XGZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxGdjCAbnz+IGKi8W8jhnzTFzekuCebua1KBayDtlJN8YLawmPvCAjtxs0pjmbnNpu1cgzKKUmgenxo7Bgx0mrZDJB+OVNeQRA//MWISG/XCWuUbD+lDYUI00DIXzOJCZuSIhFbnoyPmJhFN0Ry1TBhOZftQ8WQYPeIAEfH/zW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=Z+7PZlYq; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="Z+7PZlYq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2MCLch7P19hJ5OYh6HtgGFeG91ReBc1HLTbKFjWUpAg=; b=Z+7PZlYqg5SOpVNqJUqqfgZm2L
	sTizwM9PWvDHGRZ0N5tWBUhmO87FAzgFNokAOxlldx43tGyCkrU+4hU5tL0HHExod7ZAOLs2vt20W
	BQenTR4EqRX01lGmfvi3RNV4y2OiiQS0+00r+fBV2RVAv5PzEExD+aWe2MxqyoUdFszjOy16xNlgC
	OMPc6PRhevOk7TOWi1AjwfxxLG+cLcSU2fl5SzBy5PfKK43BiEsfLT8+H3EktChMztTXXzA2+QErE
	CPdtum6gjtjlnU1i+ltPoW+DXAxuMAYSu/u/Bu173/rwCmn/oWb7aO7MuJZM7hU6abF30wQy3qluI
	ISm1ZbZQ==;
Received: from 87-95-116-80.bb.dnainternet.fi ([87.95.116.80]:11265 helo=fedora..)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1uFUsW-00000005Bvm-121L;
	Thu, 15 May 2025 12:27:48 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] Trivial fix comment
Date: Thu, 15 May 2025 12:27:43 +0300
Message-ID: <20250515092743.14981-1-kalevi@kolttonen.fi>
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
index fb57e8fddd91..71cd069139aa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2181,7 +2181,7 @@ int security_inode_symlink(struct inode *dir, struct dentry *dentry,
 }
 
 /**
- * security_inode_mkdir() - Check if creation a new director is allowed
+ * security_inode_mkdir() - Check if creating a new directory is allowed
  * @dir: parent directory
  * @dentry: new directory
  * @mode: new directory mode
-- 
2.49.0

