Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540622D9EDB
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170896; cv=none; b=ut4S8Avzng+Hl6+QhN5iRI3nr8Pnf1v0uLaNB0V5vR8Y8SGPbD3ej4CM9wSzZqFrNkiKu2UPJsBrch4ztdVgPpsqtbl7Qn3kRE/1V17CIQ2l4OJtq7Q2aHXTz7m4pm5L1XEQDerjfuDMMABl3vCPmcKs4TANKpl9kmSN9DlBYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170896; c=relaxed/simple;
	bh=8QVe+jSvRBCJQ/FWfKUr6qKEm9keo+EN2cP5piD6bEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWNMHP6LE19bJWpfZN9Be1FLQaBklNOeQx6kEOFYMIyCGqOa7DdLnhoQQJ2PP2/z9mC0ItIuePbtY6A3rzBhSXSBjo/SMammxXSiFYYqAlDY+lFMrAK6d2K78B/R22Ffa0DwsrLLqGJSbhpPZNLlEAFhIkJbHSuUtGuPRHdMl9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=Rc2dcrSj; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="Rc2dcrSj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wjzSJKF9zVhFZ+ZGzzzIZAPdsEP5mUSUUd1T+c2CECw=; b=Rc2dcrSjS6yzitj1WJAeO1IinV
	N+Nwi1ZKBA8qv1b+jaKd46fzMqnhHV+wFcSyIaBOeyliDpLV9o643DVQdmmwqhBu6nAC+/WcyoIPI
	rIettjmhcsDcaO5i3oVzwRLOUiLdLaDlqLUy85cz30kYO7/kMMwHOst7LE9+qwnfmECfhyLXTwwNy
	76ZJ9t1+OJ9c6k70QWwJoFaAYTtr81BmfREHAtGPW2dvkXHUr0fuabVqSYE3L9bUJZpAaxzS+n2/e
	2Xa3D8wlCDkEC6BNGMbDado1ur9obPsAkQYfed2Wt0QTZEt+rC6BeSumIbNL3x4xO+Y0IxvxvgjmX
	Q5gfb0YA==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11662 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wL1Td-000000081oC-2sZv;
	Thu, 07 May 2026 19:21:29 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] libselinux: remove useless assignment and test
Date: Thu,  7 May 2026 19:21:07 +0300
Message-ID: <20260507162107.70210-1-kalevi@kolttonen.fi>
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
 libselinux/src/label_support.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 57e191c8..3cfd92ed 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -190,13 +190,11 @@ int  digest_add_specfile(struct selabel_digest *digest, FILE *fp,
 					    1, buf_len, fp) != buf_len)
 			return -1;
 
-	} else if (from_addr) {
-		tmp_buf = memcpy(digest->hashbuf +
-				    (digest->hashbuf_size - buf_len),
-				    from_addr, buf_len);
-		if (!tmp_buf)
-			return -1;
-	}
+	} else if (from_addr)
+		memcpy(digest->hashbuf +
+			    (digest->hashbuf_size - buf_len),
+			    from_addr, buf_len);
+
 	/* Now add path to list */
 	digest->specfile_list[digest->specfile_cnt] = strdup(path);
 	if (!digest->specfile_list[digest->specfile_cnt])
-- 
2.54.0

