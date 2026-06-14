Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921827AC45
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781456073; cv=none; b=PoTKe6MEOoWoZNGnacys7L2b5Mp52wL+BaJUi4My0JgYkru47R56hL0OAQPIGLx6O4mZ+tJwJo7f80RG6tZQgrnFm9jj2U9qxk5M8ZxyBSZp0vsnTnJVTGsBN7dho+l3H1nIoU/VNpDCjIxzQdv+MEBzHpVpRMG/E+1P2pbCyCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781456073; c=relaxed/simple;
	bh=8VxVe3ffIXlnz+yUnA682WtZfaHTXaZPYb8D7L/q774=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sx9lz1p7q49WxOoggvcW5UHCPPJBIRUHmu6YWl4rqW7zDm54gkpDOrxjwsTC4qAMjx7SUhKanw/qNptqfauYgsx2J6xSlZQqNC3O4RXcElbnPxXNM5bO5jeOqsFWWFn3yF3KTXpX/E9fZctgk9U4mpbS78w1OsUsR5u6L/B2hTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=gRA8bcUH; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="gRA8bcUH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=21v1fAvUbeq5fxM3FLzJEvAaPYW1v3JJ43+Z1ZUq9l4=; b=gRA8bcUHf5y8UvC+7q3ogP0lgV
	0Jjbx9WMjpPLgt/n1Ga/9YAfIApTqAUQ2hCWeFLT7+/7dh9ZmNpT76iPC3Dt1qjiv9SnakMtcldS4
	3E9hSMXDWDiV+Ofu/sAQRAKRN7DUqtbo3aWYaVRaN0RaVdWzDNMkgkWUWLRLmxi1i8FJv8s7yOC5m
	tbHHSzvyAS/NjRRfPD8C57NlveL29UHAvXBGOXoaXaqSsPPWiQx3aNAI2NYfE4vrfzDNNKtGTHCMz
	myqTs3ekR2ov/ti7RjmAn37v+3NKe3aptihJ+AZJSwAVqeFWYjds4ZEf7EyBeukpAgdnrD+xpDwI1
	3rcaGKpQ==;
Received: from [87.95.76.183] (port=4440 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYo6P-00000008no5-0VyD;
	Sun, 14 Jun 2026 19:54:29 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] policycoreutils: use null character in a string
Date: Sun, 14 Jun 2026 19:54:22 +0300
Message-ID: <20260614165422.25058-1-kalevi@kolttonen.fi>
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
 policycoreutils/run_init/run_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index f304c4f3..bb9593ad 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -317,7 +317,7 @@ static int get_init_context(char **context)
 
 		buf_len = strlen(buf);
 		if (buf[buf_len - 1] == '\n')
-			buf[buf_len - 1] = 0;
+			buf[buf_len - 1] = '\0';
 
 		bufp = buf;
 		while (*bufp && isspace(*bufp))
-- 
2.54.0

