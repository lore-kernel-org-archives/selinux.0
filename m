Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A2F317169
	for <selinux@vger.kernel.org>; Fri,  1 May 2026 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661999; cv=none; b=ed3CjdN2w1QMfUfTam/2Hr+yoNb0GywoKYroUy316Yh8hFDlzdnaVKKfIzbmAefLVXI+rF4AeW5Apm73MxM5OAEAeHedlpfHVwiEZ9su0Il+lWNkvlZvNXVS7r+qlZ+PK53HJ4UwM6jJlOCH153QgEYgeOvA+VKC497hcI3Vras=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661999; c=relaxed/simple;
	bh=2r2qkRGg+8/BpGiP7roz09G8QnXWmP9pyfQuN8mh6Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7V72hR2sIyT8VcDia8ui3ujBe3fYjLCerlhK3nk8xj89sAWYRlmYC71MH1Za2ClFPlnBDu9wnleyIsPW21VXvhq0h3eWvFzU9RhFts//0hArO7d0N99zOfQhUzaIslOca0RCSOATJySAqzSXnoJyOgCYSTIHQ4D0dkcYhdSIC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=IKhuyQ8I; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="IKhuyQ8I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ry4FyDAoiWyp1k/hj7mi3CHYaTkQnv2Impas7vm5V6g=; b=IKhuyQ8IVq3f7R9yu8hjd3QxXP
	VWFFkOFw69LiY3uqWrkJ0LRcMtGrIWEfhOiJcVCRJn4qFXnaAmo5qbw40/TEJ35RQSIXlCzt6EMCt
	o//axiJMjObkH2HMZ43S/Ah2tXajU1Vholtr8DQzpc85VvP1kbZMV1gfd3UX1lrRWEN3TzVIVgGhi
	ysrHEFk57ekA90IbuPdcKcEjVYLG0ObeN+4+9ERweA2rE9otrpLwUVLYD5IMhIW3hEzv8VSRpwBmI
	zhTxS9gjuMkuDAjozKX4P5eGkwuk2CnGMnqsDQ1nLfoleGaKZtzrkjHwPzaSUSyWgByrG3m0/774P
	oEajY5iQ==;
Received: from 37-33-160-15.bb.dnainternet.fi ([37.33.160.15]:53727 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wIt5Z-0000000CmBD-0E0e;
	Fri, 01 May 2026 21:59:48 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] selinux: trivial typo fix
Date: Fri,  1 May 2026 21:59:39 +0300
Message-ID: <20260501185939.31898-1-kalevi@kolttonen.fi>
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
 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c4a68d623d40..e8ffd1fae1db 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -859,7 +859,7 @@ static const struct file_operations transaction_ops = {
 /*
  * payload - write methods
  * If the method has a response, the response should be put in buf,
- * and the length returned.  Otherwise return 0 or and -error.
+ * and the length returned.  Otherwise return 0 or -error.
  */
 
 static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
-- 
2.54.0

