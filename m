Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9231407CE5
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887105; cv=none; b=nCxzAgJyP+veCSSldRFo50lGKcpa9elTX4WhVBJ7zyADoQyxGAnt5YsTpBPw8C193kA0Bv7GcX1dGpW+c8VhkX2h/0taKRXkgkRULKho1jMWcGf7Z38n9oxZ9Pds4Xo7yLxECAvwYJZ7vG6PK9b3yWn2DCKetyFMJInlowM9WoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887105; c=relaxed/simple;
	bh=cO9W+W4liyT3i+p0VqoOe6FXkwYx1kGyYJf3OhWjB7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTjXyNq/Qe9mH735McW8U1V/PWPYNlOxEvVJwgqUA5m26JRfC6CbF1YFAMiLmIpoofGXEjkMng1y3CGrTxxSNgilSjVP9k8Jb3JUYglsHoxornIx5ceENynw1wEYPWvKh3JF2xRTaQTLGsAy5+f4p5jMSJM9pWh0w9PhVfnNpAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBEA3m7X; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBEA3m7X"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-512f750d4b2so124968711cf.1
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 06:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779887103; x=1780491903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N+J3cOzTweXPs5NWu0yeU91c8/88bk7ShQZpMK3/uSU=;
        b=GBEA3m7X7upEffHosyXfKZx4NunK4MybZjzu38PfEaDjw/nCwBTgHbWrn637kqh4Ql
         7b3nEDFKL5VOOauNXbAdlzyWvFPJ95aEjdu5arab3Y+1uxjuQWDS//ptS1l3JJcfr5tK
         79VrGbff5PcGE0pdPS2pa0SnBmyV7WV1Xoov0rt1oR3QK5/kR6oEHIpeCbkMA8OyOnQ/
         LFZk68VQ/mK0MPNhuVxkGv6GI/q5vqZ5LtcRh5kVTRzksIwfZf0mUaoEOttFC6tduXj5
         upgz0UroPM5KK/IY4PfegS1AtFpuKeNdTLlWes/FuOfNTXckqKKmwUkRaZ9GCuAV29F7
         mAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779887103; x=1780491903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+J3cOzTweXPs5NWu0yeU91c8/88bk7ShQZpMK3/uSU=;
        b=JxXsOpApVsBXsGOeK/w97ulkZQhjuNoDsBY43xnPI+tieQoGFIGZk6u7v+IK9XA/PT
         RXzwYGllRGCefehx1bHvMmNeB7eRf7z5j8pqkUClch5/dfV+tOI0hFxT3wHN3pXpLxpM
         4vXHOqNeUQzeEre62bYs2FuVx8Sj0j6sd8np9Jc8Hbm9Jba/8OExRsEuVFyDachuEmJQ
         nCoyAkZtfKkHc6xR/ZO6ooxyzPiVisJ6J2ChGgCuQOYp4VsNX2iVG/ZWpq97XBifuSRe
         up+wlCMkyj2Vt2Jrb7Fy6bCDbvBWlSurLQ7LhE61k5K3OhHAL8VFdABS2oH54x1lvJJa
         QxSQ==
X-Gm-Message-State: AOJu0YxiqrMw53tuscfk9lqLxmY1ZXQftuuBTARCsVIwhe7MOvTHrD3p
	X18C/gVFGbjeAzdjizKrYreHraCLviimUBHGbx9oLER7+KdFepqyF9gMuPVDUw==
X-Gm-Gg: Acq92OG5stSQeTpKPtqLqGah+1/WEbSv8uSSpUEgsX11PRQBG68vn98QozdSsYInR/h
	/b7w0xgsogyfL3tfBIZGHub7+l+0O0gbZCgXL6NVVZkrPuWhcKwxgvnY8ZXVz5Ww8o5ubE7egsK
	felCXu+fQFOjWHVDkrPWqoaCQ81pamheJbagylnU+f2VSsnrFfIFFR4gqot0GO30qkOSVEEHuc7
	mZPO6vDffahS0TBOH2OlAzRNdJ0TgPbh3RSP8nNcvCVCfaA8C5omonNHedireJGXWOAVehBJcE/
	5eNAL282uS4n7zOZjoZBFT0gMhMc2t8TZmvJGoBqJwGkoq15DVJx9OTSh8UPXzBYGASV1dndPLv
	jPHWAF/X80FKiiF7TzkdFOoN1KbnuaKoSC45TGXz5av02xVrY3/yK+Onn4tPDafBp1xbeoMzDe3
	BfbsZfe60NKCvNoAzI+ne3sU/nqACzdD9Bj791dj1pdZSoEyvKWSkcTCaffc3SICnKaal3xuHCg
	qBub0wNr2hW1N4SRjJPta8ZGbB7MXSemMBNlQ==
X-Received: by 2002:ac8:5984:0:b0:516:e0eb:d84 with SMTP id d75a77b69052e-516e0eb0eb4mr219418861cf.23.1779887102530;
        Wed, 27 May 2026 06:05:02 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706a2655dsm43316531cf.12.2026.05.27.06.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:05:02 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] mcstrans: continue on failed accept() or add_pollfd() calls
Date: Wed, 27 May 2026 09:04:29 -0400
Message-ID: <20260527130429.26396-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't exit on failed accept() or add_pollfd() calls and close
the fd if we couldn't add it to the poll set.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstransd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index 42262e58..bda580d4 100644
--- a/mcstrans/src/mcstransd.c
+++ b/mcstrans/src/mcstransd.c
@@ -307,14 +307,15 @@ process_events(struct pollfd **ufds, int *nfds)
 				/* Probably received a connection */
 				if ((connfd = accept(sockfd, NULL, NULL)) < 0) {
 					syslog(LOG_ERR, "accept() failed: %m");
-					return -1;
+					continue;
 				}
 
 				if (add_pollfd(ufds, nfds, connfd)) {
 					syslog(LOG_ERR,
 					  "Failed to add fd (%d) to poll list\n",
 						connfd);
-					return -1;
+					close(connfd);
+					continue;
 				}
 			} else {
 				ret = service_request(connfd);
-- 
2.54.0

