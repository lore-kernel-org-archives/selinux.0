Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3329373E
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300745; cv=none; b=b7YqFWfQzfwzUeNWwrhedmZkgKM3Y5TCri5GgGnHnePenoU9g8fuRiF7sSVDP3XjlF/vPOH4t0FkLdcUdcR/d872msl085hGsfbCBv8oEx0DNdOINUGIi5o5HUz26O20dK0pfn7ycH4xJrZ5DyKErY7xGKBYw0LSzmvMglORmnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300745; c=relaxed/simple;
	bh=cF9ZnAv9OnzUKRKf9g/REhfHF2KUyuJ11/4KAnSqVLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1X+yRbLCipWYZ/C8M72qU+AJ1kZqKjLM6hjf2AT3lK2iiub3KHVbf5irtrPtlSHKt8gLihgsL/VLRu2N941uM+CiLhnwNvp1vcBk7aVKmQSGJoa3tS7JCTY8PLXms7MtbGlKgg5BWylsKWNzp/t0JB5EbDX/tMrm+uT1GfCg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=Lp6c5+24; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="Lp6c5+24"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oWA4PXzB+kxFE9bOekomo0q82/qy56rGb1svIVpimGY=; b=Lp6c5+24BHgqtFthZHnbb68TYd
	KI4qxLRNvoXREmGRExa+mmGYwvYEXbxm/D+/KONvt+SYKzoOsdt6zsp1WFfZaaM2Xb3a7SrcJXcux
	9loX8TLFaoA0cT/RBoStAH+WcWV4A6rptlL5m4HgrWEUig5lXyV9HxrJKN7I+j8F2f/eZ+SOOh7Yk
	HAgvazg8ZNp2/sH+Su+bmfd0v1zfns/zhpm1rR8cB8FjbKwLO3FJirLFGftk4djXGvSf+b24n9YDC
	GZD+kALxYabpL0+Xq5UzjeFibuHb0VnzBW5W8KKcKcihx0KHArY3PA2lOGCEAaA97xREL3ZIEmdZw
	cYWUb1AA==;
Received: from 87-95-116-80.bb.dnainternet.fi ([87.95.116.80]:11690 helo=fedora..)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1uFUjy-00000005ADw-0YwW;
	Thu, 15 May 2025 12:18:58 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] userspace: Make git ignore files '.vimrc' and 'tags'
Date: Thu, 15 May 2025 12:18:33 +0300
Message-ID: <20250515091833.14378-1-kalevi@kolttonen.fi>
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
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 6ff61265..34aa2b48 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,6 +20,8 @@
 *.pyc
 *.pyo
 cscope.*
+tags
+.vimrc
 .#*
 \#*
 .*.swp
-- 
2.49.0

