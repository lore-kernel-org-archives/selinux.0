Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5C3F411D
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699594; cv=none; b=R3gPUQuRB1cFb8P08TfKB8mef8wnjh1tDNrx7gTbfzRoZ3rVupKsmigQVu2BvVeiYKGlMlEzc0zTMMtpyOyVgf5Qe+ljdv/ATGB6jMrO0IQp3KrtUEkAZkzKaey0QnIRB9XTEXmeiwAErttSVhu0e4MTkQdLMAQ+Q+yBdW36xSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699594; c=relaxed/simple;
	bh=/HDQ48ReR64g4cQGwI6wMgdoDCn3Zh+k1k6yCR8roIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZmBzvA6z0PUOwPMzO4FS5aKu0X5TjSr4e/vOPPAIpVPwoSvAeiZqbVuiRUZsboc+o7acc37nuod2yxqOEzztVUoIsyswENNzAP28G8gCQ/4qR+oNECKKPJGypl+igKx+VZYxk1oojFhxuOEDwoJLOXoZTWi9dsqn81hwmC0LWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=I+p80HlN; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="I+p80HlN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2QHY1qEWNYYYFyW5o76B+jrS7O4UWzhUe4KzX3yBrM4=; b=I+p80HlNa6GAaXe10hR0hjOlKN
	zxKeZWG75+mEiZJcxUK1BVjDmB4UGA/B87WmB4iPQLdzXLQpFTkiph0kzGoTLyR2HOwYCnoOBIyky
	1YxiZDrmJnLPq2UAMkcu3lANBf9gtdLch/TKTSQLZqwWztLRYpYqNdUVCDTQhV6cwqYlG1jjSwF27
	G1jcaTqRGF2UtBnhIEquc8SXZ+cDFSNdeJu4LzUwINhy5nn0N4UXZobtnn+58Kz2QoVsSvuMMO/9t
	O0HHg+3AaVrKYl84ZAt6OojlZrjkoIZMLMSaXOuS1KUAFdo1iYNYEv2hcRlyiVQn3r+LYAgVLqxAq
	k7C3VXfA==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11324 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wNF16-00000009IcK-1ZHQ;
	Wed, 13 May 2026 22:13:10 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH v3] checkpolicy: use calloc() so no need to do memset()
Date: Wed, 13 May 2026 22:13:02 +0300
Message-ID: <20260513191302.81039-1-kalevi@kolttonen.fi>
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
index b808e4d0..323e11ca 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -235,13 +235,11 @@ static int identify_equiv_types(void)
 	 * Create a list of access vector rules for each type
 	 * from the access vector table.
 	 */
-	type_rules = malloc(sizeof(struct avtab_node) * policydb.p_types.nprim);
+	type_rules = calloc(policydb.p_types.nprim, sizeof(struct avtab_node));
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

