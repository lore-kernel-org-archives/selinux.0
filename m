Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27143E490
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626468; cv=none; b=Ha4HUba62Jirq2DWI/IcpNgYfAxBw8K1KHr3EopfcgFdGl0rEelNqcMAs+VGtMB1t4+71Z/YgQlo8Xf/LopqPLygw0OKtBCOGCNW8RdkXNTjARPJOUZJt1xcJADI0ohpDD3ueNw+EsL2Odq7ThXWhXNSZ9RFA9dF0qocvU+lfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626468; c=relaxed/simple;
	bh=Kt7hCAPW/jpVr21DM5Frb4/eT5213BbGrQ8Xn1ohD3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jsj7Cj1AdlWSxYQJBX2VqK0JsPmWFPNabRQgUnWflaYiQDoQSPUgUgrdERuTbZFtLyoWya3JGfUEt05oqgaXpIM8r5hMyGvdZg4Sf6TG7fZnvkAWhWUTToV47Q2P8/HlgcblSnlQdiuuIeILXTL6+OSux4pfOXUGDqpJQDvyHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=ryqjpNPJ; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="ryqjpNPJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J2acRzVB//jKlbqrYjsq8TkpTorhId34TYGglFr4pKQ=; b=ryqjpNPJqwFPpoYSp8YosAjKfk
	WoOReSE1TnZANX0WKBsVsxWKkEnBEVwjiTzwuqfywrmwe07od3DyEacbh4Qe2f8cjYATnTP/NDMm/
	vJNKqF4ypKrh+zf71sx+5qe4LagDVpYXQS5kI4K5NUIlLQzmegK9MKqaUyLkLTb+zk6vYZiVCTzOG
	aIsastjvXWSWoRWTk01zMFzS2520ONMq5nHUGGMfps7zIjjcrcalMLu0DhDcK0nSRLythz894Mp1L
	mAyQ6uNllWJYeD3eqPbxu0zqt+d53rgWIJLeVy2NqmLE7NyLS+TmelPWk4wHlBQjMOi1/a6Qgu35Z
	pLMOm48w==;
Received: from [87.95.76.183] (port=4386 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wZWQi-00000000CqE-2T6O;
	Tue, 16 Jun 2026 19:14:23 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] libsepol: Add missing comment to context.h
Date: Tue, 16 Jun 2026 19:14:18 +0300
Message-ID: <20260616161418.62569-1-kalevi@kolttonen.fi>
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
 libsepol/src/context.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/context.h b/libsepol/src/context.h
index 525c43df..7c99c9b6 100644
--- a/libsepol/src/context.h
+++ b/libsepol/src/context.h
@@ -13,6 +13,7 @@ extern int context_from_record(sepol_handle_t *handle,
 			       context_struct_t **cptr,
 			       const sepol_context_t *data);
 
+/* Create a high level representation from a context structure */
 extern int context_to_record(sepol_handle_t *handle, const policydb_t *policydb,
 			     const context_struct_t *context,
 			     sepol_context_t **record);
-- 
2.54.0

