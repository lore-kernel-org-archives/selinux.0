Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB624DD15
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781459296; cv=none; b=fVaGkXSM/8jsSCukWpR6+CSzt6FIkVhRFSEShP5uco4SjGC10ZNaU+Kz9CNR6t8nQpIF1Z3ScZoXHqPa3Jg7XYYnwpudUCmLTVvykYFJA963AVWcj0bfonXpKSm5BWatdJW0TNGLyhe4x2Yj6vRCuJMWSB1fxGzHCpvpzQPMAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781459296; c=relaxed/simple;
	bh=6v8y1llk2bU8a7UKybl1FSDpzmU4/ElLZfkzKuCTVFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WYU/KXhCin9yiS7gFKTCvFW6R+Bj+jCoqaYLnasXRcmgYHma+c8X0dGJofsPZMqGBfEP3lDJfRHXfHF9Yp29c/TiM9nEbFTTBYSTq1w8bgDA/A3VRPr/tBM7zrWwAibJfGJjVjJRyWX4GUegllWM1YvkxXO79QrInMLdWncv2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=C3v4+oeR; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="C3v4+oeR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R0CmRDpvpCxd3eH68EX+ljUzfvNDgABz4/oK3WWEi4w=; b=C3v4+oeRNkRHz5qhsRjwoF9kcS
	97hUiz+m0l90eyLF+g/SBlRL9ROdEWaxDiaR1UFdvk0dV8F/GcoMiF9KjP6myXI9gz7w7LSbYtldP
	gLM7bV8+49e+aZ0DRU7gKvMkCjTLaniswjv8v6cQ2Kz3BVGBOiqOksySCgro3luOVi5TSDRYAadXe
	y/pTFYQdF9+wE2McIw67ugDtdk3vu69dgjY20jvljs+/Ch0qLijAYWKQ6egdNhSKdEsdYReF15IEq
	cAuJJyUCK0JL2c98EFCLJVNwBd3wWg2xGnVt7kY5f6JYuK7K+PXMVoH377VPWZhPuYfFffUm9qHjR
	hDGux44w==;
Received: from [87.95.76.183] (port=4353 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYowP-00000008wra-1IeD;
	Sun, 14 Jun 2026 20:48:13 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] mcstrans: use null character in strings
Date: Sun, 14 Jun 2026 20:48:06 +0300
Message-ID: <20260614174806.35097-1-kalevi@kolttonen.fi>
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
 mcstrans/src/mls_level.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mcstrans/src/mls_level.c b/mcstrans/src/mls_level.c
index fedceba5..7235fdb5 100644
--- a/mcstrans/src/mls_level.c
+++ b/mcstrans/src/mls_level.c
@@ -22,8 +22,8 @@ mls_level_t *mls_level_from_string(char *mls_context)
 		p++;
 
 	delim = *p;
-	if (delim != 0)
-		*p++ = 0;
+	if (delim != '\0')
+		*p++ = '\0';
 
 	if (*scontextp != 's')
 		goto err;
@@ -36,13 +36,13 @@ mls_level_t *mls_level_from_string(char *mls_context)
 			while (*p && *p != ',' && *p != '-')
 				p++;
 			delim = *p;
-			if (delim != 0)
-				*p++ = 0;
+			if (delim != '\0')
+				*p++ = '\0';
 
 			/* Separate into level if exists */
 			if ((lptr = strchr(scontextp, '.')) != NULL) {
 				/* Remove '.' */
-				*lptr++ = 0;
+				*lptr++ = '\0';
 			}
 
 			if (*scontextp != 'c')
@@ -170,6 +170,6 @@ char *mls_level_to_string(mls_level_t *l)
 		p += sprintf(p, "c%d", i - 1);
 	}
 
-	*(result + len) = 0;
+	*(result + len) = '\0';
 	return result;
 }
-- 
2.54.0

