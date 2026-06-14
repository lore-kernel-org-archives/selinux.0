Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569AF2EC0A2
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781440168; cv=none; b=Lv68e9/sqVFhWk1I7ZaTHmW4+K1c7cQlqwcaof3DH7KKqUvKvfIY/WjvO1pHhPtjFUhx3UnxTFRkjwnB0atQusOxs4cPRrvnVwyxFEK+okwkALSK+GjH76/L3LzdDNhNUuupjCbAgev//z7M+aJoWNMxyG/hoxHUT1r6mPACmyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781440168; c=relaxed/simple;
	bh=F/3n3Acm/4aP7m5mds4pDFcLY5+cUvZcPZdAxs8nW8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtg0CgKJP4BYR7EUmYbazKU4fym9zLMYSPSYBXtfNBvIIHaLwmk3McaInI8kC9Zf4ygpU4lmbkXZ39rg/9zto23KJgKsQcKOohi1gjnRLNQyfNeghQjhl+8rOQcy7C/8MMfhy4Vxyi0V92aF5DJe2ir+gybGlgpV+nOJoHvGc3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=WhFtTuFh; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="WhFtTuFh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eI5p8Z7Rs0uPk+OdLfod8NvfPTeyGVKTrjllh8OzaL8=; b=WhFtTuFhcI8gXxd5HccUzJydrY
	IxXsqvgcSqRj/T/y6n9B+PTMSuC6F7fHhTgS3LvP1mPwUeAHX69n0NM8Z9MOH0JY7l/junVZocBxb
	cFIGtMcGIMR5vb0JiBfVSKFd+ld/ac2S19nEg2QK9v++VU3l4ScwClb2mB+hC94ss4f5vx0mEJKN4
	ybX5cI9L1ObcSfI6okDVnrvgK/qPFQOL2XgA5JE/RhXGWvgbuGeyV0uVFdxKXN78FOcdWyEMW8pqJ
	otpVp2/Y+BEqG7MhUhTjweDxvQOU++3r6AHw5yMxI701xRpPYpq0fbPAZAGq8c9iYJPrz3lOvnLmt
	+w/s36HQ==;
Received: from 87-95-76-183.bb.dnainternet.fi ([87.95.76.183]:4557 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYjxm-00000007yqE-1gKn;
	Sun, 14 Jun 2026 15:29:18 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 2/2] policycoreutils: use null character in a string
Date: Sun, 14 Jun 2026 15:29:04 +0300
Message-ID: <20260614122904.29873-3-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614122904.29873-1-kalevi@kolttonen.fi>
References: <20260614122904.29873-1-kalevi@kolttonen.fi>
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
 policycoreutils/sestatus/sestatus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index 0effc4ad..a719f0b3 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -110,7 +110,7 @@ static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
 
 		buf_len = strlen(buf);
 		if (buf[buf_len - 1] == '\n')
-			buf[buf_len - 1] = 0;
+			buf[buf_len - 1] = '\0';
 
 		bufp = buf;
 		while (*bufp && isspace(*bufp)) {
-- 
2.54.0

