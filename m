Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2580C2D7DEA
	for <selinux@vger.kernel.org>; Fri,  1 May 2026 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777675445; cv=none; b=r4JJFb0Z9PfBOcYK48Hdy9ts+u+9qmJp9qgsbn87k/khSLrX5zE/KwJvbO5byoyRETWVwINpHDZ9RJk+V7BDCFPFdSAvHiVkAriRqDNFs9KV5FtX2oavG7iGgN7GiTqJJ0rOt2aea0pdkVJFfORgRN8LfkRzCgMRKBugli2S14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777675445; c=relaxed/simple;
	bh=l16ZKusAnZirGO9n15o80ZC25O72hdgfHpYlvrbRvsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMwLB+wLyl3P5YP1wc3dG0cC622PBNIAmNuKyo3++G8PLOVNKCWEHni7CT/MjcoGK3hDPNMjM+RJ2Qffbrz0+qdlgfMdWtJiq//qIgW0QFREv0c7TfGUFk8mYbVK1yMfmi8XUwHekysXp94F6n+CisKN66rG8ppcitQypUfYSZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=vtTdAMiw; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="vtTdAMiw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i1my1gLj0vtu3q4TMY8CJ5C++lpQrtwGSmqq+Om/m/U=; b=vtTdAMiwxn7gHP/pBdi8g0qwv3
	T1M4oaWD6GHfGnZpUn2zIPyIDTMpV3mYWtjIHXH/rYFAFuPwF1SpUu3BJiAHTnFUljD7SZWqx89qQ
	OotGCRYYDJFXV1126oDfVcaervjcEXoCrUwwbu69QDRt4bOBlvV/zxy2MHJQ9ZTrfRvCg3obfuKgd
	U2+3/prMXgPgKVOOUOkr8PiNia8oj7zQkXP0dB56TQgHkoDB+BzIVX4mCCbuEJhW994QJaJNJ7C6h
	tDnH726NawEOn/uIHi5bu994Pj6lsTYMyeOLPH+0MdD1TKUH6cfvKZPWQyU2T1NrFiOXipP8g1ksy
	iXzE0vvg==;
Received: from 37-33-160-15.bb.dnainternet.fi ([37.33.160.15]:53602 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wIwaX-0000000DSei-1h0E;
	Sat, 02 May 2026 01:44:00 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] checkpolicy: use calloc() so no need to do memset() afterwards
Date: Sat,  2 May 2026 01:43:56 +0300
Message-ID: <20260501224356.63682-1-kalevi@kolttonen.fi>
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
 checkpolicy/module_compiler.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 4b2f98d8..c36773cb 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -842,12 +842,11 @@ int require_class(int pass)
 				return -1;
 			}
 			allocated = 1;
-			if ((perm = malloc(sizeof(*perm))) == NULL) {
+			if ((perm = calloc(sizeof(*perm))) == NULL) {
 				yyerror("Out of memory!");
 				free(perm_id);
 				return -1;
 			}
-			memset(perm, 0, sizeof(*perm));
 			ret =
 			    hashtab_insert(datum->permissions.table, perm_id,
 					   perm);
-- 
2.54.0

