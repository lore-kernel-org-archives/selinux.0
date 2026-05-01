Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43B26FDBF
	for <selinux@vger.kernel.org>; Fri,  1 May 2026 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677008; cv=none; b=mYgsYlnsYgBAaX2o1FCICZGKvRnsoyBcNVHrn3LfLEeLlIZBtZHp7lNynVPq195hbmwboD8+7gZCFslNcQyJyGk6g2WlC+uRv8xCWowuFg20BS7KJVzgTq9z2ZYKNRICM1vQlebmMSxjsGin6+Xq97DHXf6qeHa9vp6tc4J7xWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677008; c=relaxed/simple;
	bh=xHfKITfWxbQ6j5zjSDTRHWlKIXCd/zyk1Wy8vncb6ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E61YOBUT/OHBQWgFhh+IT9IEupviT41pIsnzRSxLcA4jfsn7IHYad9/AaPbPCjBukm0UvAN9Wrrqfcf2ifa101IrYjKhspSZvpbx5xtBWDFh2ie8adnw1XpfUNK8ATJPnaA2zDSPOdr6YKhFGWmxhYRwQoxj/oRxx84rBV/BS8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=tZ7z9MS9; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="tZ7z9MS9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rkAGmLcfvtM42EhtWn0yviFdsWkMqEP+LUKtIJvTglQ=; b=tZ7z9MS99zdvKNKnQeLcP/o27n
	KXA4vY6TeKruvdq/OHz64FyRb30gqxxc/aIUFH5rbK3ZEyY+FelmzzhlD9S9Jz8XKOSZwS9mtP2VF
	H0x454ex2HQis/R8l+G3h2RVliPszxiDXZNiqSedWbxo+U8TtFspuRIsBPYNraV9LtqAeX/T7uO84
	XVAgV9zn/7DgGsB9znoDnP7Zzz4VJko4qxIg4DKSVZlaj7tl0S0mIoucSp46kiVGnGXSn6iW72/Dq
	3MCZTmAKMzVijKp8y8uQyCiCJL9ouEgEh9rDT52o123Ew1+6Yd0A/bDJ/uEBmkffpDBAtH5H0gWm9
	T+1wsdBQ==;
Received: from 37-33-160-15.bb.dnainternet.fi ([37.33.160.15]:53460 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wIwzl-0000000DWcK-0gbN;
	Sat, 02 May 2026 02:10:04 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH v2] checkpolicy: use calloc() so no need to do memset()
Date: Sat,  2 May 2026 02:09:59 +0300
Message-ID: <20260501230959.65581-1-kalevi@kolttonen.fi>
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
 checkpolicy/checkpolicy.c     | 4 +---
 checkpolicy/module_compiler.c | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index b808e4d0..34c21199 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -235,13 +235,11 @@ static int identify_equiv_types(void)
 	 * Create a list of access vector rules for each type
 	 * from the access vector table.
 	 */
-	type_rules = malloc(sizeof(struct avtab_node) * policydb.p_types.nprim);
+	type_rules = calloc(1, sizeof(struct avtab_node) * policydb.p_types.nprim);
 	if (!type_rules) {
 		fprintf(stderr, "out of memory\n");
 		exit(1);
 	}
-	memset(type_rules, 0,
-	       sizeof(struct avtab_node) * policydb.p_types.nprim);
 	if (avtab_map(&policydb.te_avtab, create_type_rules, type_rules))
 		exit(1);
 
diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 4b2f98d8..a6ecc939 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -842,12 +842,11 @@ int require_class(int pass)
 				return -1;
 			}
 			allocated = 1;
-			if ((perm = malloc(sizeof(*perm))) == NULL) {
+			if ((perm = calloc(1, sizeof(*perm))) == NULL) {
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

