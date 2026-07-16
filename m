Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF03769F0
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784230679; cv=none; b=lPIRep/Un5GBBamja9IDeS+Z7rVQOJXRqXba7m8Ape6tQ2hWbHulz3vwUSUHacSiXXCwAm2r6iWcp4tGpquuBc7/7g/Ke2/PzM7hEhg7r+cYMz6mpfAQhV4olMbF/D8KyiCiPvFNxHcZ4ScfoWZnCXz78mDUKeT1bR39Ze7IdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784230679; c=relaxed/simple;
	bh=9ReDq58OlH8vQezxN6D7pnTr/2cJWBJNHhl4ZW8tr4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naHHhg72OdGp+P2BZKCtqACZ5ggJhxc+NtmaCGmS15qIoaBrYq+1cnrtyTTNBL02SoaHGKiRck1hNXY6wRRswsdaDlPSeFocn8E6ehe7GUROWQRtqIPsebFNhdMs3HF7AVKbLPqX3Tzng++7IuHELPylLEkOO0AoXfX5GGr8OTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRmdlpjz; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRmdlpjz"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e65e18969so70566585a.1
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784230672; x=1784835472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OfXjDcCSgsGmklZ+4Kn4ovS8z76zYEUvp98j+YVZo0I=;
        b=qRmdlpjzuVxgRHKA+jdngDcklCnTyylYAQaFlIoXOkA5COaEM6rgXRR4eaA1UZC0H6
         A+1gNbzKwdYx+czIS/YUguRvbOZH/zWF2LpT9haCHFE1kVUSMqJ4t3ZBz0QqkYNaZ/rp
         UnhJjX3jRMk2GBD1L1zohP6htuH1nvfKckZSheRE78gH6mL1Gbllb2NN7u1gSESu+yDS
         0UJH0/IiD8EFPJOf88vYY2tyzZHUdsDDrx0OiOLVfVv4zRqNAYrZdiBpWur6a1A4KYuh
         qZo5zxJOxffDBR+jnAeHER56DGdbxW643q+cHjHkYd0FLfdp/UntTRLrt0JFpLmY4mO+
         7Qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784230672; x=1784835472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OfXjDcCSgsGmklZ+4Kn4ovS8z76zYEUvp98j+YVZo0I=;
        b=h3y2ax6KqSYNl+XQe9HjSJVHl9MEV/pPbWLNIu24uPqzDcQdbxtvYTGEvRb4CKhxrO
         b8L6HVxXGbnOvKAiML1UJ61e3R7lofjlZ0FSZq+IJfEKiReD4RD2QdwD/2JevixK6bxY
         hPrN8dXUXnBeCRcAR2VlC1TZqj8g8GrlQlyUEGygjOioQ8HgLF19amYN79v9FiTe03Lj
         gbK1YVEnkRIoPaYILyfPvpT69OMkhm/8pSXOsY36lb8nzNqmkBgabpLbAkZvMOSRBemh
         AF0guRuGotRqjXDbO/VfNUwYtnKh9kjMaSjhrDzJPSQrzkrdzF10EdEIYJuGyFOTfD+y
         Y7gA==
X-Gm-Message-State: AOJu0YxWm8GKHKd1gQT6e2uLVQxoeGffhfzBNDYlr6VWRNddMTAvi+Cv
	tyB8OEXJMdCZ32e/ALynzwvmxNFxwEfKrmtzY866iTQK40UMoO8TKCiAssg/+g==
X-Gm-Gg: AfdE7cljI9L15ExOzl/7C/WFdxRODoycwQH7UR2WCmzCTXKykMC0mX5IYfUlybPW+Xf
	jhEq0fKVuV9Mv6qmPk7es/u7B6zK3DAdCLZiwC+fT6iXM/DuxR8bn1RrTRRTB1aARIlp/P4GfgL
	JQcsvgAFut6hj2mPyIRAlOs2M8hI3AsSyf/3xpTEjSPLuP/haxMz3zkpf3j7SmYja1T9U8wwM+G
	5cWbXJpyQdQhaGtKRET7671bGnQlxmi+LdcyzePd6NnXORZvw4c9l365cWfZMr3PevPhxDcCvr9
	2RGWNLwQuKs1TMWd5ObWnH4OSGcR++tHJPL+mlx/w3HxoLnMrAmQhPqpHGAzAsXb+H6w8ky8uFV
	ZqoQxEvMUgZprVE5fmoKlys3z2QjB6Sh5mvGeugFSE9RGVwaSzoF1V16R7N53+3WIX226uP9GJ7
	HGWihv2ezn/tzYdDwr2mCWDWtEyd01DZEUW9fc0aAGJyfOv1yWSsFmUl2IlUnlZQD+SPv+qgCtK
	orLxSRaVyiTDP2q
X-Received: by 2002:a05:620a:2305:20b0:92e:d7c1:b1e1 with SMTP id af79cd13be357-930a5f39caemr320838585a.28.1784230671907;
        Thu, 16 Jul 2026 12:37:51 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b492ebsm1987760985a.9.2026.07.16.12.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:37:51 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/4] restorecond: switch terminate to sig_atomic_t for async-signal-safety
Date: Thu, 16 Jul 2026 15:37:34 -0400
Message-ID: <20260716193737.11366-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The terminate flag is written from a signal handler so switch it to
volatile sig_atomic_t for async-signal-safety.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/restorecond.c | 2 +-
 restorecond/restorecond.h | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
index b8ca4b21..0e973d83 100644
--- a/restorecond/restorecond.c
+++ b/restorecond/restorecond.c
@@ -73,7 +73,7 @@ struct restore_opts r_opts;
 #include <selinux/selinux.h>
 
 int debug_mode = 0;
-int terminate = 0;
+volatile sig_atomic_t terminate = 0;
 int master_wd = -1;
 int run_as_user = 0;
 int foreground_mode = 0;
diff --git a/restorecond/restorecond.h b/restorecond/restorecond.h
index 9fb5c5d5..7e209226 100644
--- a/restorecond/restorecond.h
+++ b/restorecond/restorecond.h
@@ -24,9 +24,11 @@
 #ifndef RESTORED_CONFIG_H
 #define RESTORED_CONFIG_H
 
+#include <signal.h>
+
 extern int debug_mode;
 extern const char *homedir;
-extern int terminate;
+extern volatile sig_atomic_t terminate;
 extern int master_wd;
 extern int run_as_user;
 
-- 
2.55.0

