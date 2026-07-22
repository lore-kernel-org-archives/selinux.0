Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD583AFB0C
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744022; cv=none; b=hSNRBWjk7Pl+vBKzUYDXYWkCzinHkF/SN97QguEeuODr7Mv2yQaA8raUdw2chY5ouC/ryqeortPSwnPlHmB6e1PyFPA7OytA5asrmCKxIJmUXHAe9ZFWr2A6j1gWDS5fa6Jwe1EqexFutCd+5YeWwlINCVq3KJeBaKnx7F3O/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744022; c=relaxed/simple;
	bh=m3bvMov3E84fJ885oXC+HhKUrCHVJLja0afwruffShE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5ekbcjovRMX4QWHhZFAC0nzaI0GiZ+1v4oXsF7eXC5M2rLCdO7W7KgNWtaAhNdJvzzwKH2fio5nvYnx0Cbcxo5DvA6v3RDx0Jw8+0wEhj8mt0Qiwnd/dHTsIlNzFGcGgwIYmHlM7mC1Ly/suYb0pf21CjwoikJpjJoflX2OYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9RXOdWA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9RXOdWA"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c2a818fc4so108814511cf.2
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784744020; x=1785348820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=92+UHldOdPbU8p7vnSXGMT7VGGd4IQTuPHry1nsyO/c=;
        b=Y9RXOdWAHfjjFOU0rURUoJnSK7B1cKKM5FR8j4svFmFDZ5V++U/v3auqWjT5Zo45Ud
         owNm5lMdjzN2G6U1N5OgTwdPl7ZLBwUPKbOAIp4N+HrJZbqh3E8YEpouh/RtAOrA2Sd3
         ERbDQNO2echKAhotLvsqXoGNid4unzZby7ooBDBaT7QYmGe86TLCEbzK0dbyhX7wiyJv
         bCZgU72RdFwHDEaHfu6Rlo2pa3kHlgeCg9MbJSISUt7weE8yz8SSv83ehevdTPuHHd/U
         YZZAPfcuMou16zYHk3h2nfrxJHd2iyykQHWwPYTiaJE66CMI4cRh/Ak2kcPn5e4PeKRW
         9bRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784744020; x=1785348820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92+UHldOdPbU8p7vnSXGMT7VGGd4IQTuPHry1nsyO/c=;
        b=OX5MM7hj99U66hhxDAEKa0DrysWjVGYMNwMIJVnxoG5TAMqyLRZogDUFnX24Ki2NZ7
         vVVrgO5PP+mCK+NLkCWtzwam3DDgtsXFgy5xBUucdcGaqe57O/bZXabJoLuB90lLtv+t
         bGO6eofeUOIhfCoa1K1AvXQs4ozf48qWFJdxPy4ydf9I1IqhtLuLkTgEYbuKZ21INf2U
         5X81Fd4wIt3WFzj1HMn/rH3O0X1BTatB5PSbd69IjfzmpdZA2cUU4acXVucAsXZYhSbT
         PYn/ed36qpxc4cjvJTCYgEF7mvx+K6oTvIJh+OZASOY3nvMOA2fXauM1A0DrGy+ziflI
         Gnxw==
X-Gm-Message-State: AOJu0YzR+PlEc1BmKAz5nbDqIsaa+dk4T8Q4tptR72Jk6zpZnTLwunpg
	gYYUejCs9Z7YdoD5Mc3bJPxeFj1m226dSunJG1qt/cspF78XLbHPugU4+zE+Ow==
X-Gm-Gg: AR+sD11UVdvHtw4HnF5wJaYH0gR++oMpu/8tta8vQRvuvYc4y8C/Jq9Rw5VTW4nZpe8
	1eTXqJO2AcC/OUKlXx85XQ+v7e1/FHkqW23LJc0MNjHq2l69huvjmIqZaFF40nzMIOYsj28XeeG
	YqD2fel8uys20PZ4BHZMS7ZTuvGc2Z+GYfe+fYvLeZ3ZFnj3wHJSyKq9PKZ0c6scOCzEvJ1aKCm
	bn1KrHG+TfRqncxOV2skVW9jkGSCp39skHQLlTvBqgJr+q6N5xL0ggH+M/YL7KMgy/3OqyjapY1
	Pwff5vM9kGzZpnpxqX09KvtkRMnD7kMMr1AspoSy3yxLBu4qNiMTXuTAsnvK5L7yOkq69OJbate
	YCRCHFjL5ILzXxLB41+crS+rxpWb9zSQy+y8inqSkcxWria2hI3Uio4PU9uoJZWx+EjeljY5M5+
	LOD4+Llr43R5Ex49ROV9mfTa8T
X-Received: by 2002:ac8:5f0d:0:b0:51b:f8b3:3d4a with SMTP id d75a77b69052e-5213daa2112mr258081171cf.50.1784744019910;
        Wed, 22 Jul 2026 11:13:39 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa27cfcsm26147206d6.44.2026.07.22.11.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:13:39 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Check for embedded NUL when reading from policy file
Date: Wed, 22 Jul 2026 14:13:25 -0400
Message-ID: <20260722181325.107755-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that data read from a policy file does not have an
embedded NUL to protect against maliciously crafted polcies.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/services.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index e8f0e622..3e8bd38b 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1799,6 +1799,12 @@ int str_read(char **strp, struct policy_file *fp, size_t len)
 	if (rc)
 		return rc;
 
+	/* Check for an embedded NUL character */
+	if (memchr(str, '\0', len)) {
+		errno = EINVAL;
+		return -1;
+	}
+
 	str[len] = '\0';
 	return 0;
 }
-- 
2.55.0

