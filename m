Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5D843DA39
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577786; cv=none; b=drYpWx9hE9IYh+fhMtSDrKpMTI+ILMjZo2PpzR/x0ywWhiSQWBdxmGtQ9NqSLlxeSMxZPePq9aO7mFoTug/wiEivTkp6FNze6VlNs5k8Wc7FtXm2P679avjDK3HKi+rrQJEc4GF5PhqwIXAFo5gEAYrKeJw2kD6E6AF+xsgryWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577786; c=relaxed/simple;
	bh=Ro82NtyT6kvCrve/2E0yit84bq4/g0lb4NSmavx/SDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLHovwiXKMzpg5fHbV9yv0HXhtk6doALyDlbvmVPotfb2oQQrSKClPgsHzjoXU8h9pmGnHTlxyrnbe2hkAX23wJO09pD6/iemaeFMB/B+NAVYV8NIrYPXxIh8tCZ1xtwsJUSgxK8MEJOBhFjoM1CLkMoU3h9GkR9SoUKVkEtOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAJ0/xOS; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAJ0/xOS"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91550f68089so72132585a.2
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577781; x=1781182581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mr0OClP8hFrXUynWLlBTK0Gpvx5cz7m0c0JrWYexTl0=;
        b=TAJ0/xOSU4KUtpz3tsp9+YhnONx1jsakFH77292o1MUfh1f5FlZdNT2uyXbGREKAcr
         Ga1ZbWHA2+gH10vUjNqx6nJfm/X2W3RPq7Ds6a1CESK1RHtynVhEoYHTNLEYcCEGASfQ
         rEmqq113vUsKHqXGM18H89LvqudCQUiOM2avAwgWG6sgG3oMITwaneMehl42LjglabuD
         fvYtfmd1tsBtmt1U/h5jnNFz9mXG3ykyPolHh+e9H62h3x/4D17ElSFwsTArf4uVCk9r
         hxaS/h3l11pNxM/mU5ls6ETAv1F9f6Bs5T+qtVWGCdTIbIdcBukXJzXqH4mYWlUDHXr6
         zUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577781; x=1781182581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mr0OClP8hFrXUynWLlBTK0Gpvx5cz7m0c0JrWYexTl0=;
        b=BWLgTGvvctrWauC6WVlw3ylDXhQ3oXL4IJ/mbWvamCyHiv7pTBn/XfVv/PUE1h+DHb
         ZBLR+8Nm6Alt0G0zi3NqNdtsFFEYvgEmm/xdjh8+EOTOJsECQsC+A12Tn1tZliFyx5bM
         nluc43U9UBXayi1wxDYazgFmQPnLhjrZSYNstmtWIpDaYZnRPk1YA4pjyDr4dJxhJkPM
         qne0STlZGXwRiDoIbgpRnYPZfUPqPa+BegTkdteYSy17jKZ7GhoZ86t8Aw1h4iHVmjOf
         dx+gev24lKddN3SRe7jjBL2HAPnuS0QueV6nVx/u58uEJY5KyappDuSvyNgyqGgVIlmc
         G8pQ==
X-Gm-Message-State: AOJu0Yx5O0PghtNP3E/z4BeQLYnZ9uG9Uwkcun9RBCJ7s2EHgEwH8WLk
	PcDEXiwNkRQ2V/LIhFIN/3HXTD1/AMD6C60VOtX03HuyVch/opupQud9KxPymw==
X-Gm-Gg: Acq92OExH8PMO0Dx5CO85VmQV1hUKh0Wk7jO8/T6ETzXrttD3qghA2oTUUHNydExZJ1
	C6hlgwYPhKLPhRBt5tah4tZ1Vq28ikquUueoj0p38C27XPn0CLQcQnRIDJIgO4czR1foi1DijLZ
	wW50K03eNeky4b4KGzmRYDmAIaNoSzyppVMo4DaEbOWRvrlHOi7nRIGlTzaXRW2tVaJPVTV7Xk1
	Zrxf4ll0mi4ie839HSh/XlwgNcE8Fq/GXQhcz5EWtJpXDWYGnPUk5sJyYMBALBwCkIuVA+nqFwO
	a24cEGLcjaUAEJlaKi8a2kXP6Zzyt+J0YW/TtMFB2K8bYmr9mtaC6tJJaSBkywA/9wjsJ5rwLcc
	nnPqfsL6toY7w2KjUoNHuSTU2Yi2P2WxILSLIT6Pjfl1PgQjRes9RGsGP3ZnNj8OepmlmM16EyB
	9IXlhX6HmbL40v1k1NSxTF/a6wHtXgYIIBgZyTDDxXInPSlK2SvphJJGrTY41IuGizRPCnHZ5JX
	0Mjn1pDD6d2IIM+kKJQnpT1jYFoSMSEzCLDSA==
X-Received: by 2002:a05:620a:1d01:b0:915:a6b7:4c94 with SMTP id af79cd13be357-915a6b750bdmr53627585a.6.1780577781513;
        Thu, 04 Jun 2026 05:56:21 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a243041sm598297785a.18.2026.06.04.05.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:56:21 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 5/6] mcstrans: set receive timeout on accepted client sockets
Date: Thu,  4 Jun 2026 08:55:56 -0400
Message-ID: <20260604125557.255554-5-stephen.smalley.work@gmail.com>
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

Otherwise we can end up blocking forever in service_request() on the
second readv() call (header with no body). libselinux always sends the
entire request in a single call so a short timeout is sufficient for
legitimate users.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstransd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index 8786c492..2d07b3af 100644
--- a/mcstrans/src/mcstransd.c
+++ b/mcstrans/src/mcstransd.c
@@ -13,6 +13,7 @@
 #include <sys/resource.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
+#include <sys/time.h>
 #include <sys/types.h>
 #include <sys/uio.h>
 #include <sys/un.h>
@@ -304,6 +305,9 @@ static int process_events(struct pollfd **ufds, int *nfds)
 
 		if (revents & (POLLIN | POLLPRI)) {
 			if (connfd == sockfd) {
+				struct timeval tv = { .tv_sec = 5,
+						      tv.tv_usec = 0 };
+
 				/* Probably received a connection */
 				if ((connfd = accept(sockfd, NULL, NULL)) < 0) {
 					if (errno != last_accept_err) {
@@ -320,6 +324,14 @@ static int process_events(struct pollfd **ufds, int *nfds)
 					continue;
 				}
 
+				if (setsockopt(connfd, SOL_SOCKET, SO_RCVTIMEO,
+					       &tv, sizeof(tv)) < 0) {
+					syslog(LOG_ERR,
+					       "setsockopt(SO_RCVTIMEO) failed: %m");
+					close(connfd);
+					continue;
+				}
+
 				if (add_pollfd(ufds, nfds, connfd)) {
 					syslog(LOG_ERR,
 					       "Failed to add fd (%d) to poll list\n",
-- 
2.54.0

