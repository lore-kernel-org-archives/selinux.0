Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E619ADA4
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213361; cv=none; b=rTg0xwnxf6kA3QZhVz8ynOFW9uzQ7CsukLH5SILRoYCs0hLBs49PGha2jzuSy3k3QmLdj+SIC3rjQl2RuzjN3tiRgLlXzoCyRwfmrRaeHsgIhObdpiGDPfK0ditJyBNmY2DlJpq+qIDLsPBIzbvn8ClTKbvBh1rVbmbmIS1yGWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213361; c=relaxed/simple;
	bh=h8f/pdVag6GVHrzfd3fw/D3IFDcFbbXzTWynMyL11Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juILBAp90WAb8yiyGAhesURAMZ6kMfqx06TrET9Guyl0+CBK+5SSRX9TfRsQpGDIh8n4nzgMX7V9llLJ6LIU3zDRxvEkyFchXKrUbsbB/Xp7RWFye2GF7BOoTfwgveYob8ycmd3iv7qCCv5yCrUIofpOWzsuHFoZYBe+GSjxaco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEGJeK6O; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEGJeK6O"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e5d50b0dbso247529785a.1
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784213359; x=1784818159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JBg2kiE65bDsl+G9fhU85MzeW0hGAKxWih5WmBzxM0k=;
        b=HEGJeK6O6YqjQ9ePQhiRYpeG63grUPPG/C/NN/ONA/bVOrAJdWx9kppPlQItFTmyLy
         BvR+STaGLkdldxyJG02nH+svpJ15V0/CL8Z8QQk5UDR1BegZw/y+PPLt/DLormmPLjz/
         vKCEymiWv0qUstFSS1z53dDaRAL547sJXlqQ46YXclNApn7F3vk1ywKFZ5F1W284ZqVK
         JiisQhdTZYs+JleY4EUXpqbLJLEUqbuXaI4UXVRFe9p8gHmHnFtjpyyISTkWpP5WBGCk
         iquOfT2bMlKwZofTIoAKni0ULwppHo7J6dPTbAtmtLoOG+74whFhYxIonQwkKw/Zeukq
         m4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213359; x=1784818159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JBg2kiE65bDsl+G9fhU85MzeW0hGAKxWih5WmBzxM0k=;
        b=JiHSw32W0EocwCkbhNxvT3LkZec+pHFP8mpxG9SlYyy0L7p6SkJC+aed2PHg1jRlZI
         boEu7qkEd69sWHWUxCH7QRWpXwYJqWZ/gLkjXGf3CXiexhOnQh1LW3zFU8yuX/v27eu3
         URYBClcDktFHUe8nZCdeKilbMf7hWCUppjkyoVVgpyuBVl1npGeNDJsM5SUbWx1ShqK7
         hyae6jrcrlLQGRioPl/otbCVMSdpmDD9GvS7e3cWROd4ykv/rrW1676LeMxHbB4LbUxk
         QjePstBSnXG/68jpIne0ehWMGKA6/nqMQBoSVp+fzZpzPhI5NoFfnoeY7oDWvEUf50oq
         f84w==
X-Gm-Message-State: AOJu0YxM1LFVLMHMHirtx5U54iQ8DkCFY0vICGjXqJVelcWhqgU81WZQ
	/08nTZ4VQnynWsxQDdYVGTWqy4CxSYoGPYyHlzLSZ8YuvLVmJbPjKa0lH9fkZQ==
X-Gm-Gg: AfdE7cl/g3tr+szvsmSbsoJ0QGKBUd5Z5nQ0StyGd+0o9z2gk/n8ag7C+Nvb7CCufj0
	Y9KYeKIC8XwRetenbkt/jTSzInx+hRYJo7KA4LYExdQS45ZkSNmLfxosLfrpJ6eVSuIsC4OxuRU
	li47PdRWkA7j3QnrxIYC8awibIr3+R++uIMQWLKxXnh4UUlg5ZJ8uCZCJBMHeAQs4c/7YpFouay
	gUO/2JWz7HGy6sTFOTbc5G6VTLdyv2z0W3dizyRt2AuyAXPwI/ll+KX4AjBtDf2pH0wFRTNytfx
	+ekF2zBcTwbW5WdCsA1GhrZCQ/kDMn+KZYwEMr2qRfxiEYvXkYIFfXJiMsy5zuJpC0b2418jUVn
	VB6k1S9IYw9ZQ/jX4tRp6W24UOQwDPvILqXRGOMApn2HnpqG6JC27cv7dql/epe3V2v6HsWo78/
	xKJuI7mKih/CwhUcBzvniFJgW/ZKqgJZNfQWJA4YAb8zRYXr8Ject8iEs0SqxwIwYBgGgtCBbe3
	8AZGg==
X-Received: by 2002:a05:620a:a185:10b0:930:a26a:fb2a with SMTP id af79cd13be357-930a26b04bamr343448285a.2.1784213359258;
        Thu, 16 Jul 2026 07:49:19 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4b38dsm2163336685a.10.2026.07.16.07.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:49:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] semodule-utils/semodule_package: report the output filename on write errors
Date: Thu, 16 Jul 2026 10:49:05 -0400
Message-ID: <20260716144905.8874-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error message reported argv[1] for the output filename, but this
may be incorrect depending on option ordering. Use outfile instead.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 semodule-utils/semodule_package/semodule_package.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/semodule-utils/semodule_package/semodule_package.c b/semodule-utils/semodule_package/semodule_package.c
index fa50a80a..c2bc49fd 100644
--- a/semodule-utils/semodule_package/semodule_package.c
+++ b/semodule-utils/semodule_package/semodule_package.c
@@ -285,7 +285,7 @@ int main(int argc, char **argv)
 	if (sepol_module_package_write(pkg, out)) {
 		fprintf(stderr,
 			"%s:  Error while writing module package to %s\n",
-			argv[0], argv[1]);
+			argv[0], outfile);
 		goto failure;
 	}
 
-- 
2.55.0

