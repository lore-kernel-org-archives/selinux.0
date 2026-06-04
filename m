Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D2B672
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597720; cv=none; b=TibiXyO3EEsp7+sPQ/C2qw6gRUBPrriUaMHSAwxOM0itvqCfeJ5RpvuGpwGzuK1AC2dqCZWa2LrlwKBQ5SoOJ+0UgRm3T6b4jpoX8lv2Ow0Y1AsuAXK4lI1MhMHvcYSu39xhLpwhMnKyBlVAPy8JDR8FYsnXRoKIoATRl+uI3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597720; c=relaxed/simple;
	bh=1Hf81t+xelAZDXWgZbMzbpHP5LcYGP8pLCaNJUDNN70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+ofosh4Jt9Rz67KBVm99KrNTAou47YD6GlbM1dPN2NLHVAJfLhleaL+BDstxXamSCqdcWK0RdvzsFfW7HFjW7evITEtjr2UWmk3v0TntqAC865MIzXhLYDjuXh9996Qvrj6sH4d/5qqoGjhSnR7iy9xJxwnprFGfDRtpaL5KCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmUDUOI4; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmUDUOI4"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so8331616d6.3
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780597718; x=1781202518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qdDsebUVqNYiPIcpN9gkxS1R8cqYVkTrrmk53ukB2Jc=;
        b=DmUDUOI4R0xTLD6ujgrUn89g7i+mV5PEbs4sjqy8PG8hI4SB+XT5N6lu3BmUStntSB
         rRMClACi1vJgxuDsycwrQl7ad6SRFd0RZBfIcvmIJrqQMK+XT1dzIcw5k9oXiuhhQq7S
         n2TgjcCOzdlXjtyPWMpJqOP9gqdhnrAbaHH+iB95QWpqB+aRdXKy+mfOV3N221BoRDcS
         Hg7HPgufLzyaRAxi3N3oihLpy6l/I6elHp7b0d6mSj2Cm33a7D0j7Tpl29Tph+U8PBIK
         7nK+asHpHfH7FsGjwycT+LI3FRiDpyxhpjUVFGgeho/LaGj//1UEZU9U6FM9sVyL5xA6
         P5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597718; x=1781202518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdDsebUVqNYiPIcpN9gkxS1R8cqYVkTrrmk53ukB2Jc=;
        b=M7D9fUWKSSHhm3dD0Xo2n3Rnq1L0yhrCR4ZVCKaKdQIha7H/oTio9UIa2Be+rf9HeH
         8OWKR1X/8ylbq/pd5x8/lwTcv9CdCRkU2fcBLQ+PK/+wwwwwjJHdTFIN++lJts/Mx17K
         wM63JE1b/6VAmumFWyfPkLtD6og7/QtiwgPnDNUGsNxNseGfeE4lFx+8WIF2MO2zpFMv
         oCednAODJLqtSP8Ve3tsKbhSvjYyKt6L+2qM/+/9BefHTeF/D1TpRcjeEmdqzkTxjA68
         MjzqaQ38peXktHt6VDAXCi0A7xiGTTzgGnLSdifnkW2YzF0dlwJ0KhZs9OMH1TL3TSRs
         mNkA==
X-Gm-Message-State: AOJu0YxLfzfJWwwRAk5BHjQ+g03sm105iuAz9t0x8kK1I2aCBrYMXLom
	1D7FVAWFJDCrSG0cTsvZNRGD1mkkBmFJ8m+clhpfzYVWsDM4idmHPACWg81MrA==
X-Gm-Gg: Acq92OFJzaNw6GuaK2d6u/B4QqQX+sR97zCcqLIsbzTmQZ6D0cM4guqFd6dSbgEWPd4
	82zqzc14Px+wdjobo8q6oHyX2Gz7aHCYN3urD9ngqBnVEyPVb1jso/QwXrrh+1ym4k3nvtRrhb/
	vojG7BqvnsP+uqQAcDQO80G0B1aupU1iHNvsJooCh+WU0aUr1sKljPXbj8l4+yo1lcQQe68TyVv
	fLM+e4k0o29rgOolJHSNWccYBVGizbcE8vKHI2R8G0LGSNJfjQAMLXDrcHlpnEjO/7lezZ2BB5e
	7aE9R4aecgTa+zz9S2ZDxh8uvOzSnawZsTWoKPCtUK82J6DBpQy2o2Y9DBg4OPonCITJGm97wVS
	CxHGARBBg7au8loKpQbBXFz03aJUjyPnIwedmulVxv+4w7pMkaxzytGhUFFZ6sTVkRGyYNDd3EV
	TbYDAsimMlT1SD3+e6zN7++R/KKrOApoz4hkpTHA7VfxrbVl6W1PoLYQXFONZr9cSeOWONJqL96
	9GTwc91f06FGt5l2F8ZPgDSpPcO52HDQhcu1A==
X-Received: by 2002:a05:622a:5905:b0:50d:770f:ad23 with SMTP id d75a77b69052e-51795b4b9c4mr68161cf.26.1780597717965;
        Thu, 04 Jun 2026 11:28:37 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fe25sm60258856d6.3.2026.06.04.11.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:28:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] restorecond: avoid clobbering last character of config line
Date: Thu,  4 Jun 2026 14:28:20 -0400
Message-ID: <20260604182822.265426-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only need to chop the buffer if it is a newline; otherwise,
we will clobber the last character if the last line lacks a
newline. The NULL-termination is handled by getline().

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/watch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index bfaf4f29..41497f49 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -384,7 +384,8 @@ static void process_config(int fd, FILE *cfg)
 		int l = strlen(buffer) - 1;
 		if (l <= 0)
 			continue;
-		buffer[l] = 0;
+		if (buffer[l] == '\n')
+			buffer[l] = 0;
 		if (buffer[0] == '~') {
 			if (run_as_user) {
 				char *ptr = NULL;
-- 
2.54.0

