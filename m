Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B54193073;
	Thu, 23 Jan 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661892; cv=none; b=VKmZtwXSeP1+yirAQzZ5cKmc0VrrBYTfBr1Jxk8/BkVEDyUR1N01Vzn1xIVDXNc0Y+78DQF/Qm6M158VJJUh8YK0OLOYDb3OowcJ8eo4X0kq6m637MmlA8UOv2j1QgZ1ohWVFJiJMuc8dj4EpFXSVoL5DC9nTA0aZNvGgbUB4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661892; c=relaxed/simple;
	bh=09NJFRZVtnjNBvT8LoZIOLEZIQckHcsixMq3S1vs2bo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VQa1IFR602Dy9Zgyzs55cp7TvxZRCS7unEK/sy8F5sMk2dKHQmmjoOCCOBp7aTGIioYci4VVw+t84tblJByvKeze185CQKsz9GwuzsUrOA26+DhaZdVCqtQZeVuHVG0GTjmoBTgvnbwpsEmuoGiXbcjW72iSEQNjpuAVxS1L0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY5LhLhO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY5LhLhO"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21649a7bcdcso23501515ad.1;
        Thu, 23 Jan 2025 11:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737661890; x=1738266690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRMq2NTJwd0sl2TQB83kfnPB1ugnuL8mghta1vIGy1I=;
        b=VY5LhLhO3H18ODoRP7as5ZgVRLe8WSHFI1xCevDpUAHUsjZ37ncYKChICp1cc4Grig
         UmtK2+HnOAymprFTJjZclx1pU2PwSAN4nSj8HRus/mfOFerlaZlLgVE2YGbeP4dEQSR+
         qh5IGYASAYfj5P1cyAhbAR++4o/fJuO8prI2Nfa3i365M6AI3FKPb9j/EdiTGC56rWMR
         Z9UFMzWzOUiiUznWYk0FDuzd+A91Efv6xy2FE1QKLQyfJhggzKlZnYDpyK5OonIZYgX4
         7ux9lUVN3c2tlUz9aJnYmejmgc83wAZoIV7r6oRS19iBaQKJu5TJuiPk+7r9xsidDgew
         8JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661890; x=1738266690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRMq2NTJwd0sl2TQB83kfnPB1ugnuL8mghta1vIGy1I=;
        b=Wsezy3PeLrnX0sVvo1+uoEmyVc7Qs4x+573fuy/whxAPwxl93xM5rfUika607BdXkk
         r2VmYfRgwpehtssOTqjguPfCgaxCv/3AjhPnyao6W+bzsqjwWNqs9n7fzV2gorMfdky3
         6Aqn3kDltl9O228K7Y4b0yA9AklouIt0ncq4ZgtJ355/iMSfO+Q6cSqXqfKsmy0H05z8
         nvc5q9lvARdc+NNiBZqrGgfvsyS3mWvimKkMYpOtKTEpJnD5HuePR2S4KUx2IoGUqReP
         oMA83C6ALQnlzk5abkGVMSFcnj4ezTuGeDS/xZ02mD4Bh+FqhtLMpMgydWzIrUrQ6DHS
         cDzg==
X-Forwarded-Encrypted: i=1; AJvYcCX9pATEl+yg0cjEoBgxKYCxzsyyNeL7N1xpIO0QauTg/c9Cj7RbrtLwUOfr68dR9rtbhuST1WWwfYZFHJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHYGVlt1oGfccB9ZyKBcRH6i+kYpSfyJkDttWafZFH5W0ILy/m
	YbXLrHQSO0SGwTwTTmzgVBmy8qB1GPjGg+IC6TkA6UYd6rKUstpC
X-Gm-Gg: ASbGncvYxqgSKdZsbtoGh1z/f+MJMXWGfK/kmRIZwG7AYYD/B5vM/4haq5+bMVlyvYF
	nGN9vrNmN52NX8mBiYJCOumBy5SMu8uWpafDKCKqOhZqLk061KI7AqpVXIwkeqThlF1LnrYW2Er
	mBPN6t8NoBExLi+gkwoKlsNVyOCRtCXD/zFTYSQZeNh/Tbsn8Zx7WgfmUQvJ451TOjZONagW1uh
	Tox9jADaQpy4mwMqhWUeIWcMYy6V0MPuGwD39Z0wUbrnIQsAgVXOCgcHa1azaQFW8iSL/agxwj1
	mA==
X-Google-Smtp-Source: AGHT+IGj1rIMTFelHIGc6LLlYv/zOLI9Z7umk/qq25pYL8h2JGeSzVJIfIaMD++pgkGUIyVFSd5BOg==
X-Received: by 2002:a17:903:41c4:b0:216:2259:a4bd with SMTP id d9443c01a7336-21c3562a640mr368121525ad.52.1737661889340;
        Thu, 23 Jan 2025 11:51:29 -0800 (PST)
Received: from localhost.localdomain ([122.174.87.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21da414151fsm2730875ad.121.2025.01.23.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:51:28 -0800 (PST)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: zohar@linux.ibm.com,
	paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>
Subject: [PATCH] selinux: fix spelling error
Date: Fri, 24 Jan 2025 01:20:41 +0530
Message-Id: <20250123195039.2793-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

Fix spelling error in selinux module comments that were identified
using the codespell tool.
No functional changes - documentation only.

Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
Original discussion:
https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gmail.com

This patch set is split into individual patches for each LSM
to facilitate easier review by respective maintainers. 

 security/selinux/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 1f2680bcc43a..4b4837a20225 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -936,7 +936,7 @@ static void avc_flush(void)
 
 		spin_lock_irqsave(lock, flag);
 		/*
-		 * With preemptable RCU, the outer spinlock does not
+		 * With preemptible RCU, the outer spinlock does not
 		 * prevent RCU grace periods from ending.
 		 */
 		rcu_read_lock();
-- 
2.39.5

