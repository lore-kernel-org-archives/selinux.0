Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE647B422
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577784; cv=none; b=k6rB+xCp2zS8ru2uxjFVJ+qDAMbvETKIyLxhDi2Zr9NIbOiX7W4B18l9ixyqpqGVV2YcOYhMUMpQF2Do3LExDeU628DNuCB41EO+Mol2tCsIUNOpPYrHIyiiUme8WPyMu/oyKr+M8TORCb5AOKeWVHCWBUQteuc+6Pgbn4E/D8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577784; c=relaxed/simple;
	bh=DU5tybJTlrrTEzvU7Urhkg1ziA08Keub0rCjBCwqkCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpI3p3WBowQIyFZw2OZOSmVMb4s8+hRdGEAlIR+ESzn6UXtZeQEOwrYFtUEzr9TiO3Wh1BnHwUx8GROiKjqHcedOhmO+GUl4rLVffgtWPd0SJmzbrDs6irioGT3IlwuL8YlXZjrqHBjfAWqc5PMXt9ApwbsIUnU2Dklfn7dslhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mppGjv+e; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mppGjv+e"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9157b94a07aso102996185a.0
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577781; x=1781182581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Kq95SFD4baLx58rfxNuDHdd70YsbTbd5oi/gGGhHgk=;
        b=mppGjv+eRbxzyTUcrt5xCTlB6LVz0aYRsZ4W3voZdSCKCM5/st3yMOLSLtkBjFzSzB
         Zqii49M/EMdoDjVRfPt8WM+a6pF/1BL6Y7cubmKvdFLD3ulXIgPxavdRUVLvLXyr+q1v
         yRn2V7aytfisYc70kZhJ5befqloMNkORB40F/SeCtdYPGGs1Fnpd7uLjlh2cI7SZ8wzA
         7E7v7xvLIzZpjJVqczVZ1J90c8hsBeu2Cc0hGzndrzZxhqoX/BZ8DOhvO2mdKfHias3c
         3dJdVLnWcvEr2VPL59wUlWB2BDbX6hDDES3uEn/ZCjpJWIIYEUHOQ3hX318qsRsSvBKE
         /ugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577781; x=1781182581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Kq95SFD4baLx58rfxNuDHdd70YsbTbd5oi/gGGhHgk=;
        b=bVhGBRZRBPXDNqxorCUCbGvKRCacnk1Kcnc6e/8cbR24ejKVJTSsKecFOZfh41YTkP
         FH0y/pJugzv0Q7h05eGQY2Z0cTi8VDAb2F1QueGS1RMj8wCM0RZc9lvtvYYwBYJGF/qP
         G1C1l+6ZuAouovBLDnKVITSYjjT+htdMu2kLQUSd8X1bIHLH3LTm2gfdjosY5wYqbalo
         YQ6cDvV5jSAOWEKUSEvoEh+94F+3c8Vic+JhT+AVaOlam4B6rzQk6zLiOD8sXyjtaw9q
         zStfRZ0hh3QAY76Xan6htp9NCYVROWQx+2Ce99Z6vk5NPPGTD5yT9gdCdyj583u83qtX
         2URA==
X-Gm-Message-State: AOJu0YyCRyPS3cs683JHF9J9Prt7yfCAnEIvY+4/drLHG9ECk20VBtiQ
	1POdoP4UzhLkghxCPaJcJRZMZO+NaYYtTzU3/khtT0d91a6DbxBxAirNXbGqMQ==
X-Gm-Gg: Acq92OEhrcCzTr0aoEYTzoJD4vETnvCZ2tsa+fFgXhF6NoLgyvV34sMw5QWuMDSpfD9
	hMFibPMb8CN9WkC0wZELYSMfDZmGPzDQ7qxvTCS+wFYSbOXsdJjAnqucBEHcvMo9b+yNNQq9mA8
	fvVZCg8UYvsdr94mB8JOhGKjwoSGWR/lMmfvVU7NYy0Diz02Zd7n9mfEZ/+H7b+RaL4vC35YvsE
	Hg5wR+I1fk1lH+zEl9wnzrPggJVo3nV0thnlSP3Fq7dsKuSB7jRGBeH0U0QWPSDzho8Z5j9pk61
	Bdtc3P1nXNxwbaFX3zbVvJ7S63treAqzdzuPLa2Y8/TgPso4zd0CLNUcRxlcekbHtP5h2xg8vM2
	+i4IoZIkx2+ha6davrJyFQWfHJIDqm8VTwOK81029alaBDATZrLcXHPG3zAZbxFWjiSiU/mC/5A
	tt8+A3XtPxUKZGPqXeIIKk2CV5rrY7vU133Vo44ZI3vdsbHFw3IQ+hFme41dTxA2X/r0BCM8VcA
	ukNzCf6w2F0iLYRi6Fyw8qO2/ST9gF4Rzh8tlovubM1Zsw9
X-Received: by 2002:a05:620a:2307:10b0:914:7b1e:a5db with SMTP id af79cd13be357-9158a656f25mr915179385a.4.1780577780907;
        Thu, 04 Jun 2026 05:56:20 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a243041sm598297785a.18.2026.06.04.05.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:56:20 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 4/6] mcstrans: cap max clients
Date: Thu,  4 Jun 2026 08:55:55 -0400
Message-ID: <20260604125557.255554-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604125557.255554-1-stephen.smalley.work@gmail.com>
References: <20260604125557.255554-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If mcstransd hits its open files limit, accept() will fail
with EMFILE and then mcstrans will spin forever logging
an error. Cap the maximum number of clients below the limit
so clients cannot push mcstrans into this state, and only log
the first instance of each unique errno.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstransd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index 6bd12dbc..8786c492 100644
--- a/mcstrans/src/mcstransd.c
+++ b/mcstrans/src/mcstransd.c
@@ -37,6 +37,7 @@
 #define RAW_CONTEXT_TO_COLOR 4
 #define MAX_DATA_BUF 4096
 #define MAX_DESCRIPTORS 8192
+#define MAX_CLIENTS (MAX_DESCRIPTORS - 32)
 
 #ifdef DEBUG
 //#define log_debug(fmt, ...) syslog(LOG_DEBUG, fmt, __VA_ARGS__)
@@ -293,6 +294,7 @@ static void adj_pollfds(struct pollfd **ufds, int *nfds)
 
 static int process_events(struct pollfd **ufds, int *nfds)
 {
+	static int last_accept_err;
 	int ii = 0;
 	int ret = 0;
 
@@ -304,7 +306,17 @@ static int process_events(struct pollfd **ufds, int *nfds)
 			if (connfd == sockfd) {
 				/* Probably received a connection */
 				if ((connfd = accept(sockfd, NULL, NULL)) < 0) {
-					syslog(LOG_ERR, "accept() failed: %m");
+					if (errno != last_accept_err) {
+						syslog(LOG_ERR,
+						       "accept() failed: %m");
+						last_accept_err = errno;
+					}
+					continue;
+				}
+				last_accept_err = 0;
+
+				if (*nfds > MAX_CLIENTS) {
+					close(connfd);
 					continue;
 				}
 
-- 
2.54.0

