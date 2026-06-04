Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCDC4BCADB
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593539; cv=none; b=di540RMlGy45NldjGkClBGJ1gvKbwVJ9SVnIIrSZdjLrpEyhR4VZe1uo9s5BVsHXHLz3pMpO3EZta3UsFwcGOJzzmzp917b5YdBHV/Ld4DFatX9EuziJVPnYrhMXxUJhe3ce4ujbnuxjbvRfC3tJiitrCt8XgS14UbCuYB6XeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593539; c=relaxed/simple;
	bh=j35u0Qjswz1552twwrCt+tabiGH0X5sidwQDo2vVjCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WdGYpMppPdArm6uqzQi0E/iy/iegthA/HitVgrhWW47Ry6XQkITL3QNkTSq5wVJpR4KgN9F95u0CGNanWxm9OKe7Z8ppOe8ihpT42j5/aHYrUCspYNAWN7+D5/FIbeTa4rcQ1oxq6zSBkjCPi0/0NSfNjmiC1l/Tv/DclfdsH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGDfKZMr; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGDfKZMr"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-6cfd9f4d6f5so382771137.3
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593537; x=1781198337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rc1A2iJx2J+5v5uuSp2ZfeYtZGS+wOWRD4ludB6eMuY=;
        b=pGDfKZMrRJZJORYA5LPjyXj7Lgr9E7SmnQp/U1eYjePLkFwP6kESZinYSZ+K0g9xHU
         dEfJnE5Y4bKG1uDvgrtWPLaFT1NNucg1MD+KjsCDHFQIlsDSL9aZ4EHJ+v2cSaKIRrtS
         wAd7gsfi1zm+2zImgpS/nfrCgrA4E5kKGHRfyS7noJZDp9GWqXOnxPwgeS2kTILnXLcQ
         qP7Ag/BGrPJ7R/D7FHR2WJpyq5aEydRBubPfL+mzZu4Qdi1U6Ybg3mZX57fglOr0Ekg6
         1qvwBQWtxYD94dJDtP6HWSBsh5zdBcluixc2vCcbysiHr/5rSqnnMBw86iPQglN7uKPK
         dsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593537; x=1781198337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rc1A2iJx2J+5v5uuSp2ZfeYtZGS+wOWRD4ludB6eMuY=;
        b=looT6LvvJqdKWCnhnAQh08SL6YUhuDm47qy1uTNJO8VqFatncwUiJf2Hu8RmMa4otv
         xpjuXHMU4EwVSc9g3iw9ZyIZXswMf/DeiPWsIjYR/Ye6kkOmAVnwFxWXHuHfgyxkeki7
         STuxwCugaWAn5wjZvfK0dXoFRSCp+5Q72/9hg7LcaRIVhp5DiOGtWv2f5GyNmWFbQVV0
         TT4x8YTeGYPJQxZfp/wCoRj9ZNrncxunvU1+uGsXxDT7BVthSLnpr0cGaEaXhsVQivVc
         OQ4ej8sUs2OUkQKbv1k1BfyoWJdAgeDyWXb6LRAleDJOmjJT6NGrRuKyC3wYkgkBXu5Z
         8/4A==
X-Gm-Message-State: AOJu0YyVck9BotTKaDS3I34cWTE+ZDySxhMN+ydh9MZ3bmmGEI2GQgUd
	ZOgi6Be6SChdUGHRK12GncNl6XxO+e9c/VCza9Zp//9EWjWMry2I0Dur9eUqBQ==
X-Gm-Gg: Acq92OEhf0tpKCBwe6ruZW7Nb43Bw10bIo/wnOXcgmS/ao9N/6OeIb+/pdamriqlgWg
	FmXrzA71iLCFxx8LINKJCTOB5m0V8/hB9jhEXuwY3vjJw7UDtwSyL5xYn/2FrE9kkEcrsKkixuq
	BM9o9k5aJ7DJjsKoSVBCuowuZ9mrDSiVaYyU2h9fs47f4jh7z9T6VUqSKxiChndb5km+stvZ8k9
	Nq2cysqWgHsMu0jigrCmwd1n5jUiKr4uGjGsYPKgiqrGgkHJy2BsBiBYzFoInjWGol5oqLCHEIG
	hKPQhv2GNPJJrtp4zpBVLLgRICTHd1eIhY9fFqXMnum0dOWIp2CTTYbAFtnZbanDdoBRavQhAC8
	AqyzNrHL+wYT9gMcRkJh3BxyyPQrFtO4loA1zneJyFUbucAgSidf0BboTSSLU5lPwyO8JTSwDT1
	/bMU+vyQspCjzyqWLPBMhM08vVIRdiRatruwdCZFcPj+t2rElgpam/YGHdjl8r21PMscJwcNlID
	JT9QcRc9TMBXmRSB0e6sovmmmBANWht0EVzUFYh4+IuQQhz
X-Received: by 2002:a05:6102:442a:b0:632:8eb6:7a1d with SMTP id ada2fe7eead31-6ec2e66dcd6mr5105572137.9.1780593537001;
        Thu, 04 Jun 2026 10:18:57 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb915csm57722106d6.14.2026.06.04.10.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:18:56 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: restorecon_xattr: clear dir_xattr_* after freeing
Date: Thu,  4 Jun 2026 13:18:37 -0400
Message-ID: <20260604171837.263447-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to clear dir_xattr_* after freeing to prevent potential UAF on
a subsequent call to selinux_restorecon_xattr().

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 224a5a33..10807867 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -2021,17 +2021,17 @@ cleanup:
 	(void)fts_close(fts);
 	errno = rc;
 
-	if (dir_xattr_list) {
-		/* Free any used memory */
-		current = dir_xattr_list;
-		while (current) {
-			next = current->next;
-			free(current->directory);
-			free(current->digest);
-			free(current);
-			current = next;
-		}
+	/* Free any used memory */
+	current = dir_xattr_list;
+	while (current) {
+		next = current->next;
+		free(current->directory);
+		free(current->digest);
+		free(current);
+		current = next;
 	}
+	dir_xattr_list = NULL;
+	dir_xattr_last = NULL;
 	return -1;
 }
 
-- 
2.54.0

