Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1B25392C
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781447818; cv=none; b=BIFGWSm2Wt3JQs81vPPRO/9EVwKi1YxTryJP/EAFs/ca1Im8rMMVFaeFIPwBCbGDpYsrsX+9cBDD4LsJoZ2anlnWZPWg8mgJDD2w1EK4Y0z5vpp/ZHr4JX7RX9tNcHKv6hcxZcKmm7Ol8+h4pCZIoFx/pystqGRlRdAiQyEkeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781447818; c=relaxed/simple;
	bh=7FGtx1wUf65Hg8oPQp+HoEoncggBdAgw1Egp+ev/YYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc4iHK7IOHjy7PjrXkmNWAeyNkyyn6VOWUB9+I6Y3SIKe8ROe6QW70YmFDHBy7/AnX/coFrDeL0QRplSCsVzzbd1HrDKrvY4pPggZS6+90sCZ00v+fEXph6vU/uADfe9Ub/0A6zLlplhI/38jZsimg+pzpiT+M/aFJj6Q2iknZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=AFGM4G7r; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="AFGM4G7r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5xU+kh7QAFhvXoMEYJeNi+FKTQParViDWDFQ53tK7gw=; b=AFGM4G7ro6fFa52IGepWaqHgeX
	kbgmPATpCjpmf7kDEqigc9ZERvdmie3tzWAEDfjjoooaYc6ErTjosaIZgZnBZdKrYNxjRN9V5TMRE
	XNrvViGM0rqQJz7fLZe8kZWMhoGY2b+qVGjoCY+/3D7qPfY+LVHXeZe1jFk3gSY1V6hHY/epnLBG6
	ALGGV+jKKsokyz0yaR1d1saROalcRMiSKsq7Mf5htBNONPFVCew/2XDGobA+QsnAnNqXO4NLxKxGa
	7PRcS1cYZiyDu1s4kX2HT+Z6dsJuDHxpZ01GNbZE3yrXOgN4r7nQbOSvVHXX7wsECwGZzUwBvR9EX
	/qo7tWAA==;
Received: from [87.95.76.183] (port=4493 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYlxF-00000008PB3-1H6x;
	Sun, 14 Jun 2026 17:36:53 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 2/2] policycoreutils: check strdup() failure
Date: Sun, 14 Jun 2026 17:36:45 +0300
Message-ID: <20260614143645.55809-3-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614143645.55809-1-kalevi@kolttonen.fi>
References: <20260614143645.55809-1-kalevi@kolttonen.fi>
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
 policycoreutils/secon/secon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index 6d4bff94..48daf9d5 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -516,8 +516,11 @@ static char *get_scon(void)
 			    " Couldn't get security context for pid %lu",
 			    (unsigned long)opts->f.pid);
 
-		if (!con)
+		if (!con) {
 			con = strdup(dummy_NIL);
+			if (!con)
+				err(EXIT_FAILURE, "Out of memory");
+		}
 		break;
 
 	case OPTS_FROM_FILE:
-- 
2.54.0

