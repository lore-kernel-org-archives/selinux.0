Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF393135A63
	for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744471967; cv=none; b=lShbnXjPcNNpwq1X0O+29O6BIYi3//EP9Id/KsmG7QdzGvUewjn29pLJ8aRtY3E3TrfUta9ibg/fiGj+5MkjUNhySJbj2kvY5kALY75iVKOM18nBedZtoFTPixQ6DvinCFYlIhgfEz6rjnRrdPfLousnrlvRvQj6e3BS/VB/WRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744471967; c=relaxed/simple;
	bh=wcyO6/2e8L7XolfvrDQkcLdY1Z+7DTGHq2oFq/VJNS8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jxE+Y9UmatGZ/hJENaOvLJCCvSu5MJFQd8oBwGa/ANboKxZvAUrNjtgjLmCMjW2qwvXQ9tFRE4LoN3uJHTKJBhJs79OutCjplBt+tQssH3uOo53PxypTVT0UDhqZgyzCdLoZasfUfd2fBhqQlFSBbZiv4N/NSGrXusXi1ipOMyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YOCVtEEN; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YOCVtEEN"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e904f53151so25889276d6.3
        for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744471964; x=1745076764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7tPbgPWlC2eGpdlWQu65JfLjSe4sp0gap9Iwb/cNdt0=;
        b=YOCVtEENyayVOpCa9NjWTn6tW1nqV0sw4xaamqWEl4RiYBHkJEtKxVownudJ/JtPh+
         +aIHQMpFpdIyRDYXD6LbIPWsrrKfIIs0wMj5754MdWFmvc2MCKSdBu6VlPEZXlN7RagH
         y4Xuu2C+l7lKDzp3DZP7Y2sI86C7VM2DiCUuyZfJtdDW9IceOFuZAlpHxDqHEh2iEAAE
         vkhcWEbXfg43KUAscP3bKCT25PlLfTPaz5KOZGbgnwuO2eaJtN9lyQXe0pPeI9zVbEoJ
         1PL8Rx/1czS9/3B/+d1mmLj/tk6Ti7Rcx42QW0SfI6sQqQDjR/hOeC/G3+xxZQ3dZ/VQ
         ihqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744471964; x=1745076764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tPbgPWlC2eGpdlWQu65JfLjSe4sp0gap9Iwb/cNdt0=;
        b=xUKdEari9qm6vW/eJT9SWDP82q3YvdolNImF8rhS/XSe3VDJjzad7jpgScJnQMAgf/
         QaAJs6PS+3ufahRjJuDkVtF9i9DlcsPMYkdDqg8NRv7keBePQefyAh//fBMvOHQ6afyG
         TYcr1fkvMOotbouci+BYNFjbEbAwdfd9iTEoFCMnZWj96ogcUNGA2zKyngkdQaGKYu7F
         3eBVAr08k0mnktHusoq7jQ7wyfU4pZLOGcOvBlffDrM5It/ua2S4r+RnkQFfPjnbM9E7
         YUWGJR18LhdZkAWa+NL3hkSKWlZcpmcTblXBABgHRsNLrn/nKzmNzg7i13spu75kAXki
         o3sw==
X-Gm-Message-State: AOJu0YzrBEU93zkH++3LsljlqPmlGmT82UE1JF8f/BkjCeS7FX/Zc+hu
	4dLnSMSGBIihA1xfJCNRNGOSNw6lcLfsaXekEZEYbjuGipqRi1wf6h5V7d1T3u0pUphk2tNFqd7
	fJw==
X-Gm-Gg: ASbGnctD/jpqdNUq2175j6L5cBTg7mq+Mf6kn8dG7LrCQ+Bd05+Up4F3k5vpvSmaN9V
	FtGrVONbxZICj8ihyfMFhpDMAuaPC4YeyIgif8AXho3WkGLW4YyqAKu6Znc+W+3qAP6kJpbclh7
	jpPN4ITpW0QMFLyL0LtG1xSwrfCgPg6siRijAwiddn77LiFZ5r3+lSstlDajO1H9Huu+HyS1P0/
	bqTLvU3CGW5ur1G51h8DeRac4nclABNfnb6YxwT2kMjpcVAq35NKrZel9W+I2sF5+CjpH6t5NCF
	FYOb2+eL3VokgJI38PhMiIvkSKd7pJcRO5exlPEDaVPwr8mnK6Xm+bm17VMRlLTkb3B+vPWeMrv
	0JgtXM9sQBw==
X-Google-Smtp-Source: AGHT+IFYKjr8ef1IKisHHCp9OYUmtD9UIlCcGSRR7ZBaV/tm/AWaZp40A0i8It4PS3q1Qy+oyD3+Yw==
X-Received: by 2002:a05:6214:19ed:b0:6e6:6505:ceb2 with SMTP id 6a1803df08f44-6f23f13a68bmr121867286d6.36.1744471963936;
        Sat, 12 Apr 2025 08:32:43 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de9735f9sm51271956d6.46.2025.04.12.08.32.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 08:32:43 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: remove a duplicated include
Date: Sat, 12 Apr 2025 11:32:35 -0400
Message-ID: <20250412153234.23169-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=727; i=paul@paul-moore.com; h=from:subject; bh=wcyO6/2e8L7XolfvrDQkcLdY1Z+7DTGHq2oFq/VJNS8=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn+oeStMbQ1RoX7VkMGHNnYCjfU48st+UJvvoQI ONEgR5rMK6JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/qHkgAKCRDqIPLalzeJ cwFcEACk0XpHHxveqdEKLF/nq1Is9RRnoLVTJEWDIO7Xf7LbnrQaF2xt3EbCYQNfPFQ+D1TsDsD te7zH/R/uAtBO7H7Cs5nL7w9p/Mtpv1wSGIO98+srixHe5+BAUVciNw4tfSxAQYycth5P4JLBZk plOvmUtUPNfpuiUCmpX3Rbv6YCktjMhGQWX1IYevfRvunK4GzCtaHjm2pm7H6wlgPaIPVzMWOvS SvXK/TJk/9lu4DchSxuquuFfQYaLJR2emT+wYq8f7I1u4Mr6mNQK6QM76agjYhbQA8r8kOVa4K+ dpKUkVe8vAUttEuT0hdDr3Mo9uzRlfrPdMedx0hyckC1MExtt9BVr+O+RlhrSj3CFk/RwBl6fLA 8V+2o5OqvA3p0MY6bSzN4h/4HTWyh5S3DOpPaw8cVw4vZ4OqtKHesJ/6WMcK8YJHv/d6z1/OAZH /Pa+8U7KYYwiL1zOV8MRARMa7IRy6p5qEAUcJlZwW+hz1q10iH3IPEn4YWbPfgfFCZA0O409NTz OePwsAHOqblS/UVZ2pl25eGPwS2aPSfUwVX9eXsUXxbFD+d7sCypFTZXsWA5QJ8qW0B891oXU8V P+M72OyAHq12qp/MtAA1O9upi4wbUPwWCNXkFcPGJXsH09T+bA2+gNksqYYlNVs6IxtFmDaNA9T aVV9VAJcPi2BpzQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The "linux/parser.h" header was included twice, we only need it once.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504121945.Q0GDD0sG-lkp@intel.com/
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/services.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 5309bb885576..7becf3808818 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -49,7 +49,6 @@
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
 #include <linux/lsm_hooks.h>
-#include <linux/parser.h>
 #include <net/netlabel.h>
 
 #include "flask.h"
-- 
2.49.0

