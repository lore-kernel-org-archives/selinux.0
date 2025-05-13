Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3BD27455
	for <selinux@vger.kernel.org>; Tue, 13 May 2025 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747171873; cv=none; b=O5lcLqcrSFcGhWiqfH4V4nHBVaNTa20/Mc8YSUfDgXhbtjPKmM10CIeGnEjigqA5Qk+fJ0Q2GOrkEkHlWNXKxTL6KfHK5N1gFRnaOJyjRFP7fjZvP0FhUIO+TACVUtvpG7q5+5TIEHeIGo4Fo4FPkqcpZCJDTIzb9xIT0goxSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747171873; c=relaxed/simple;
	bh=ozs3AM0txMS8iM8XHTBsqvvSLNE96r+WgCLzeQA9chU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OOXinWtfmLEQnE0+4g7N62AMQpKRcU6cJeZpQVkEqpgglbS0b5qh8spdAOvvNpGvQtl8CFoot98zWHaNqzB3PcUAUWm5Cbm7wa1hedLFzy9e+RbnURekL2saFzFASwj1z4Kxh60zEtDxe+HABFn9CCBWiuCer+jguPt1QcRB+YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=fsdfWGgu; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="fsdfWGgu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ekk17fXG7gXbTRclEiDs22XqSxrHJYjedpq2AK6L4Uw=; b=fsdfWGguSGB4r6aLMzfXEnk++m
	Nwwk4efUAQ6t+6VlQvvE2P7wUHhCeaqNxCgj4HEAmgfWOfYIqJO/YEaYZVZgxpxXC3ji2CE4ZSMmn
	bBW6yVodgxwr2eDFw7K6kASJKMRcxKHZTQ7cODsE+juombfIyHFcUqJo4cOzb419XNFml4/3s8aYv
	L+Pf4u/LevLjKYtLFKgbejl6f30e6EwW7+Ss/MF2c9CK16UcPxo4dKz6aD+je65TKAVWvDLXrcFDr
	PCM77Zobe/oHr2FDjZr7EVUIUGldy2xNKu9Xl+73sqLNlb867Zv6HzNiH8QzF/tUtN4xVZKLNEewQ
	JzCU0ldw==;
Received: from 87-95-117-63.bb.dnainternet.fi ([87.95.117.63]:23810 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1uExDR-0000000G2pE-0eyb
	for selinux@vger.kernel.org;
	Wed, 14 May 2025 00:31:09 +0300
Date: Wed, 14 May 2025 00:31:07 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux-list <selinux@vger.kernel.org>
Subject: [PATCH] Trivial fix comment
Message-ID: <aCO6G2CIPPD0dEej@14-5A-FC-31-E8-67>
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

From 30530cc4088289617ddbca600e4791b3056001ca Mon Sep 17 00:00:00 2001
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
Date: Tue, 13 May 2025 01:08:56 +0300
Subject: [PATCH] Trivial fix comment

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

