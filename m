Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70D3B95F6
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784143407; cv=none; b=bU/RVj1O0UdJiqcqpEw/CFeiAjh0OrdZ12tAb6Xgk7wEXNPz14bYsbAMD8EnAE7aUSN9Mz+xBQD/jvl+xmZHK2XW/UOtBIT2/f/l8GZeCxtEQVg/9q6VAuoGCbel+EO8TDY7ozN/MrhrFZObGWO3ZQPNn8iepSZZVL46QOG+NEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784143407; c=relaxed/simple;
	bh=JNI/QqxkUGHTSvouUAVAqyXZ+hos547oE8XtR+UQvCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKgAt37UO/0awFEb7ImojszLrkfRF+jEhiEMKGFz0irQMOzZXNWjgZV65vZiyP7+5Cg9XN6FDyIFEK+745zbJa+GGg/38ncodzF5V3szpwgl3XUoDNG2Hw1iGQNGbwYux7gR8qH86fdt7R2+x8lbEHArpejnTMPKcogOn0CkmDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD2YFDt+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD2YFDt+"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c167c58f2so41500171cf.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 12:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784143403; x=1784748203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HGTd8eHpTYH37nGtn3zYpH0cVR2Ymj7sxuv7HLd5+A0=;
        b=OD2YFDt+/zb17YODHq5KhFIsM/OdQdgODfBAQCErfULBwAPNxvsv5jfZUPbHhPdSQ/
         ahBK1DlTFHEQcpA1LmSrWpVIExwKDiUqSxlnALAzsMHXMHT/WvDXzFPFhptdQE4sWJyh
         CgIkVhsCxm7LUqp6UskNTI9r49EhHmV7gzUQkriaX/wu6067GXtTD/+VgxU5kBh6NUoN
         ktQaF3tPvFs+Rv6VdY/xZj0LJdkZ5WggtWpEySjMs+D1JGb/UVho+E/YsQbl96MIiQcl
         O7N2Rz2jzMYzXNmwn27ZP7w+3WBtGT5HC0YdcAMHEvleA0JAeN+MNmipfC3W97sLx/Fa
         kgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784143403; x=1784748203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HGTd8eHpTYH37nGtn3zYpH0cVR2Ymj7sxuv7HLd5+A0=;
        b=RroiVxR3kOTq0tsakDNTHNV0Dt71ktj3JipXgEORwJkpgS2Z5BnP7uAGeNW5h2YxcD
         wIY40g1rjCGqZExoqcvGSHGG5siqHlsp6NStkApFnGRO5pgGTOoO8rQI7ICU7Ox85aZS
         nzo1ftVtg2Pgpfc+yqb6SaCaUyXHVBotVaG9EF1xjkYYkoLjhlYSwbfB2drwgyZlHPn9
         5/GWmaWL2Aiz+Ne9swDdbaOtmBaQMrJos7+H22ODC9l2sDRMe4x4UyZ27cASifssU94V
         9E5yMBbf+MhDGjAENWwG4BqagtnMc1Z6l/BNIBuTPlB5sBx4PyXerGEWo+293etC/ZtO
         hnKA==
X-Gm-Message-State: AOJu0YxUrSdVku9l8kdMB+zndCJ4S/vEwAqyiDsfxW95eWzAcnFOYEML
	asplkVxnH61yd1OejMngx9vHqEgQEDZ6NAwHRQ9rXb5BkGDmcyCJRqay2I7EKA==
X-Gm-Gg: AfdE7clC3O52SArUtC0t0xUuVgQEce3nbWTftW25rW93lGCsrgQivUGv/NmeYbN8N9k
	nd6AzRQg1pDa80hU0lG0iwMFEo9yMCOUYplq5vdwA4+r5tLNZqHU80EAtJE6uv5N7cx6WnnYVv8
	XXlQHq5pXeBWpJ8TEh66KL6icpbBlj4g3DN96LIoz/W7EjsE/VSH4S6a0wWCZ/AZ5dsEX414z1Y
	SL7ygbZcG5wGJ7mM3JXQydXVI8ioNs4FbxtbVyhiP1VD2JDRCPYrVJ/PyITiZs3XHmLjAFLf1w1
	n1YnSV48PQVtZ1Sm2zemSl78dY7BBqJmai3fjBmOGQyDFIs6YbfCqo4NJSlQSvQIjn9EbvLOxkw
	kvekKVKfDouyFZ6hGDY4n7PSdPheXD7xidrMEH5uDNrgHDpA/XjGTjFt7S/ibNDaKb9x53i19Zv
	w/iOc0mXpR3v7yHnUNBlQtFRnV3RfJJ3RvDdf1dkerqeOpManV3BW6xLLSdbsatMr2dFly1NykN
	qstJKQqrEVsovlC
X-Received: by 2002:ac8:59d2:0:b0:51c:1fa1:80d3 with SMTP id d75a77b69052e-51e42453c3amr76831831cf.49.1784143403186;
        Wed, 15 Jul 2026 12:23:23 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf671e2sm139601481cf.25.2026.07.15.12.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:23:22 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: direct_api: clamp write length in ERR_CHLD_STDERR()
Date: Wed, 15 Jul 2026 15:23:09 -0400
Message-ID: <20260715192309.46442-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snprintf() returns the number of bytes it would have written on
truncation, which can exceed the buffer size, and can potentially
return < 0 on other error conditions. Clamp the write length to the
buffer size less the terminator and only write if snprintf() actually
wrote bytes to the buffer.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index b87b87e7..6c84b23c 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -618,11 +618,19 @@ static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len,
 				  "libsemanage.semanage_pipe_data: ",          \
 				  strlen("libsemanage.semanage_pipe_data: ")); \
 		n = snprintf(buf, sizeof(buf), __VA_ARGS__);                   \
-		(void)!write_full(err_fd[PIPE_WRITE], buf, n);                 \
+		if (n > 0) {                                                   \
+			if ((size_t)n >= sizeof(buf))                          \
+				n = sizeof(buf) - 1;                           \
+			(void)!write_full(err_fd[PIPE_WRITE], buf, (size_t)n); \
+		}                                                              \
 		if (errsv) {                                                   \
 			errno = errsv;                                         \
 			n = snprintf(buf, sizeof(buf), " (%m).");              \
-			(void)!write_full(err_fd[PIPE_WRITE], buf, n);         \
+			if (n > 0) {                                           \
+				if ((size_t)n >= sizeof(buf))                  \
+					n = sizeof(buf) - 1;                   \
+				(void)!write_full(err_fd[PIPE_WRITE], buf, n); \
+			}                                                      \
 		}                                                              \
 		(void)!write_full(err_fd[PIPE_WRITE], "\n", strlen("\n"));     \
 		(void)!fsync(err_fd[PIPE_WRITE]);                              \
-- 
2.55.0

