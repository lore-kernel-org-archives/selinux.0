Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120BA26FD9B
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781458920; cv=none; b=Ev6l+fknY+atVLFa0mX38TyyodXawOnhvdyUMYJQ2NrOV+jtN0C0E82fdsRhh0GN+fVgRaFU0h6U2IxXu32y5MY0qtumdAdgegFn+j0zsuLTIVrIoAfiPojaaGHkH48FDbqs7cXMOH41p67l8jFm+PruquUxWracOftOkS93N+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781458920; c=relaxed/simple;
	bh=BZToFIL5hHLC+aRkqKFxHxyjZqEHCKhgD364hwhkdgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQlL/qLmRMWJcNzgtBnrMWgR7QdTpivGkqDUk1Kbj8pLAy1Cp6GZ8BxASjlb6uEIMTv2PXSjJNZ1YFmSvXP4CFakAW7C+TDR9plKGvTULBJXAH8Q0OB/es80rd+b3TfMmF3GBiZ9GB4oqqNqLSbNdQ26XEEH0sOSIPQ7mcsVBMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=SBeHfEIB; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="SBeHfEIB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BgydQPyz6kg8/8B/Z3YSvq6i/IhKh+PO35P3QNfeAqE=; b=SBeHfEIBxsOWB65UhSrhoBRbOa
	i4iRwvpMYEJ1dD8Dt7mYX4HcMlu4rWvqTCLh6vZjwo7ZyZv+prLMsFSE1D2UxD+LCw1DaS1lQSZyp
	pt7vngSUKdE+QtMRIevr3IVLR51/rojCGKgAbhf8ajVEJNCCSqa5FBSNFAwXhHRhtFJFy06b/8bkb
	k+rerQcsIlRX5NG0WE05aJKxE4h1ouhkLyaFGqy41XdiKVH5ZvUE6xHg3xGeodNRBBwqSFJyPrUja
	lKjCZH/MD9k4MkWUIx121o3XBCzCyQMCdkYdiy9UtCB0eQj57SPixwhQMRJEQdaG0DSw2XKy6eOe1
	x9t3Ynag==;
Received: from [87.95.76.183] (port=4603 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYoqL-00000008vpm-1BSE;
	Sun, 14 Jun 2026 20:41:57 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] mcstrans: use null character in strings
Date: Sun, 14 Jun 2026 20:41:53 +0300
Message-ID: <20260614174153.8311-1-kalevi@kolttonen.fi>
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
 mcstrans/src/mcstrans.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index ee9392bc..c494e76e 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -717,7 +717,7 @@ static char *trim(char *str, const char *whitespace)
 	char *p = str + strlen(str);
 
 	while (p > str && strchr(whitespace, *(p - 1)) != NULL)
-		*--p = 0;
+		*--p = '\0';
 	return str;
 }
 
@@ -793,7 +793,7 @@ static int process_trans(char *buffer)
 	/* zap trailing whitespace */
 	buffer = trim(buffer, "\t \r\n");
 
-	if (*buffer == 0)
+	if (*buffer == '\0')
 		return 0;
 
 	char *delim = strpbrk(buffer, "=!>");
-- 
2.54.0

