Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D9D37A481
	for <selinux@vger.kernel.org>; Fri,  1 May 2026 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673886; cv=none; b=KWj2bsY3KA08Mjj08m6TL7zUD6AFZ5yfJxVDSW8g4/8PmeQE4+vV/fhsvuPJleV4rg98Y1C1DSzcqHtdrU6jYgWE8PiesneYG9S49s/E7mCiRtNfNIQvCjm8NA5BjQ/3tBpXkcen4J+nq6w9GXLqP3Lp3kiD3NieMHop2IG3MdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673886; c=relaxed/simple;
	bh=uooI3LouQwQ8uHH9rklrHY6DqoKlNZa3nf/Y/Zi1TQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a89Fe8CX8cAgNfgQkvVkQTxuCCvY4lsEw5TFqolPkDo65o7cQeOVlmBn0kvqGyMXr4IMhNqvX/OJIdGSowso4kbMh4TC0oR1PdF5fi0mUQBRdNYAEWNWi5jFxj8SyMErtLeqkBUdmabpTqLGOMrpKmIgrMU2o0DHYWK7aFVCqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=txfdm8Md; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="txfdm8Md"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aZmsqlvqCrm0cyvBgBiQFjoKdEN/g5M5DUlP8VG26wU=; b=txfdm8MdA0DbOvMPOSCYPKI4sA
	5fYobAjXS/Cg2tfkLuqHyXhQx4EHhKsE+rwj84jFEMD3J44z4uQbnHSpDO3vgIrclNTC61QfkDy4h
	8jjhdJBFWtFKttQqU6Vvko+LQHfyBKc5GvfH5qypzAIcd/D4i+y5ENMnJdgOOBNzMGawRmlI/dud2
	sgId+E7oOBjTj0EGgdsLt/8H3PpJKCWHjWgBGub2B0ODqYFf/Yi7bDO/Jh2Rqx+2K+DEEAEebhOga
	Cr8h2IcxCCu9at0L0iTC5/at5gQ4PKuZx7sWkLyJhYRUAT5OjK6cbhylbKkaDV43XAcYa2J8nZS5H
	RIvb9Obw==;
Received: from 37-33-160-15.bb.dnainternet.fi ([37.33.160.15]:53517 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wIwBI-0000000DOHt-0NGs;
	Sat, 02 May 2026 01:17:55 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] checkpolicy: use calloc() so no need to do memset() afterwards
Date: Sat,  2 May 2026 01:17:51 +0300
Message-ID: <20260501221751.49065-1-kalevi@kolttonen.fi>
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
 checkpolicy/checkpolicy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index b808e4d0..dd8774e1 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -235,13 +235,11 @@ static int identify_equiv_types(void)
 	 * Create a list of access vector rules for each type
 	 * from the access vector table.
 	 */
-	type_rules = malloc(sizeof(struct avtab_node) * policydb.p_types.nprim);
+	type_rules = calloc(sizeof(struct avtab_node) * policydb.p_types.nprim);
 	if (!type_rules) {
 		fprintf(stderr, "out of memory\n");
 		exit(1);
 	}
-	memset(type_rules, 0,
-	       sizeof(struct avtab_node) * policydb.p_types.nprim);
 	if (avtab_map(&policydb.te_avtab, create_type_rules, type_rules))
 		exit(1);
 
-- 
2.54.0

