Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C32F8EBD
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242426; cv=none; b=rkj09saNk19dKVnWRIkrC4WaBFWGqol19BwDKw/lkURhDoRKnOGyu3hdr3SRONPiYEaa6+cDThr3fdCBBYRUz+rRGVv7EdTGDu6DWY89ri3lUR0wAih5IwBKua2BJHeGCkp4t4U66OVffPOpWaT5Di12hJVN9afXFB119loqpms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242426; c=relaxed/simple;
	bh=i76vVT1Cr/8Q0hxRXfB4oWoBCyQQebREYZClglLWbJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIc3FW5HPPLTKRK2ZNBIuauHBcD9MglUvNKqsod4sV3Cz3+F6u+TTpLKt73M20zJWswzF/CRHK6mGbjZZO2Q1o+okB9Idmp17ARmTj6QBhvg/UO7aTvArX2JJQrpom7PS6EcaWITIYHsZT9ogZROrLWoykNLnRYE4J5T0htrLNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=etpEWOra; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="etpEWOra"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cMkqA11/2RheBJ/GQ8XHzTIxo59e+XeTEDEwpGvtDa8=; b=etpEWOra45hnJ5djsBIf0JyRwv
	bLMZ4LACg/61Eq+ICi94CRHNrFDrcF8J9z2Dja5e4tgmMEDJs4nI9HCkoCbalEQivtxFhuxxM9iOH
	BdM8ReIiKtRn+1DaEw1mMxZxnnHc4BxeP1stOkBqvkHM+BKWbdnfNbg86FGHPgA2X9hd8EBWOzJrb
	mNIsNKkW7tgUGEotcCFKHgJneQpTa5mWRPnaWw9tYsmXxA2HaGrXaSBdbcn+pd18DMQizcKdQl7ki
	GLSM0JuiUwiN6nryMdn9meApwxD+KWx8Q4mIjvgFeNx14U0idiXLB0RBlBiihqcGqshFSK+LQpLQO
	g5/PYhIw==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11426 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wLK5P-0000000BmhC-3899;
	Fri, 08 May 2026 15:13:43 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 1/4] checkpolicy: use strcasecmp() instead of two strcmp() calls
Date: Fri,  8 May 2026 15:13:24 +0300
Message-ID: <20260508121327.91410-2-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508121327.91410-1-kalevi@kolttonen.fi>
References: <20260508121327.91410-1-kalevi@kolttonen.fi>
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
 checkpolicy/policy_define.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 02e2c077..d1511a1a 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -35,6 +35,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <strings.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
 #ifndef IPPROTO_DCCP
@@ -5201,13 +5202,13 @@ int define_port_context(unsigned int low, unsigned int high)
 		free(newc);
 		return -1;
 	}
-	if ((strcmp(id, "tcp") == 0) || (strcmp(id, "TCP") == 0)) {
+	if (strcasecmp(id, "tcp") == 0) {
 		protocol = IPPROTO_TCP;
-	} else if ((strcmp(id, "udp") == 0) || (strcmp(id, "UDP") == 0)) {
+	} else if (strcasecmp(id, "udp") == 0) {
 		protocol = IPPROTO_UDP;
-	} else if ((strcmp(id, "dccp") == 0) || (strcmp(id, "DCCP") == 0)) {
+	} else if (strcasecmp(id, "dccp") == 0) {
 		protocol = IPPROTO_DCCP;
-	} else if ((strcmp(id, "sctp") == 0) || (strcmp(id, "SCTP") == 0)) {
+	} else if (strcasecmp(id, "sctp") == 0) {
 		protocol = IPPROTO_SCTP;
 	} else {
 		yyerror2("unrecognized protocol %s", id);
-- 
2.54.0

