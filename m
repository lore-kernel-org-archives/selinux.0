Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B125027AC45
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781452244; cv=none; b=NHsq//gVTbPj5o1XhbkAir2s2OQ/7HtvJdC8F+ACRBlko/1ca7/b/bQk+pjTcsAnZy7pDsc1WcQHyoZW/WG608/MONuqrl47kxUbPYQ9KlVNGU2C3RfJ69FP3rV5m6nRe/hASNDvkbhJ6n5AtNt6tZ0p5Hua8/Hknk3OXA3LjiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781452244; c=relaxed/simple;
	bh=AKp8w2/5xEtTIGqwkPXnaBgiimjtpaKgCm9ldO3zR6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVc/Sgtp1T1VljgCMVBiFkxhdaxSYMmd+TAWz1i7etYJ1vaaLnHSIhdgFnK4lIJMCbN7HV3r1D+bJmOjC0IOZIWMVOCNXMEL7LvHwkMewmmUoPiSLK7BftP45//THEqu8QsjG9VoG099U9aDvGk0oNjCBtyLoHdwblJMSe1hnOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=f38DEsWa; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="f38DEsWa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PxJULBh3GoqDXj5P56pMuK8nPCna/9E9u1sY0pV5aSw=; b=f38DEsWaxU7E3yOcalxWGCWi7M
	i+ZxPLbhUvIPBPMg9ijfT7T1mqs8kCCfyiQ3Ff772HNaJHJ7ryiOxKnFigqz++NZ4YdU5IzQZ8rgI
	OYd/90nwI965X2/W5ptjsUojkeZtTQI+6MOKcdPBTRubEDxxOyKWC0UG7naXPSxweOxGE09nCXBhA
	SUrG0RM0unfr7yVJNhWPpea6bGpGKfMcGMAMNGWh2SzxoSRP4JiMtMAC0UkPBdm23T3QfJmS7yKGI
	1ENVjDwtsTTF92hgoMpNGohqZu6RZj4TloKTNXFLyycsaK3obv/hGLLl6szm4+ckR0cRkoPtVIRD3
	8Mk/o1eg==;
Received: from [87.95.76.183] (port=4233 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYn6c-00000008cgk-2M0e;
	Sun, 14 Jun 2026 18:50:38 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 1/2] policycoreutils: use null character in a string
Date: Sun, 14 Jun 2026 18:50:29 +0300
Message-ID: <20260614155030.97082-2-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614155030.97082-1-kalevi@kolttonen.fi>
References: <20260614155030.97082-1-kalevi@kolttonen.fi>
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
 policycoreutils/setfiles/setfiles.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 9016db5f..656848e3 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -454,7 +454,7 @@ int main(int argc, char **argv)
 
 		delim = (null_terminated != 0) ? '\0' : '\n';
 		while ((len = getdelim(&buf, &buf_len, delim, f)) > 0) {
-			buf[len - 1] = 0;
+			buf[len - 1] = '\0';
 			if (!strcmp(buf, "/"))
 				r_opts.mass_relabel =
 					SELINUX_RESTORECON_MASS_RELABEL;
-- 
2.54.0

