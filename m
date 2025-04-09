Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533EB27BF81
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224822; cv=none; b=m58Abae1eYCbg+1K05hZsu3FpxhodDZBmEQdNXJqjilReXpGAiMyu7fPd62oEtjz/36+HvFoSnuZGrFlw30Dx8FKihdEdMvA5MjhhyI9iK53sIH7DRto39RnmCJnRZudhjsFWQe95vR/F4aJgX+0NuTuWsBv82NWzlx06Ms02AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224822; c=relaxed/simple;
	bh=fcwkPm6l4+RHA9bcjsLXtGXDqmHsJQ/TI+/6NbM7lsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNBCijRu+xpY/7uaalOQ1I9KfWIbT41TO6wQiJmmAR4hdVGiNnZhTukrAzNVijD5MZXGv5z4JEqtYpZBos0Pt9iPhPsSVwYsMoEfJjh9yhDO9+TtHutdZV+0Tye27tfFmZJtdWxC1MFa6Ez4Un/FNLBbrWmseGKS9IXN/r6bu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZV6xoXJI; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZV6xoXJI"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso78608146d6.2
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 11:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224819; x=1744829619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxPKniuzPeJsq2MGKkGone5ImmkHqpzxLLYbUnfQegY=;
        b=ZV6xoXJIqlc85r5WPe65ZPVxZAOW4cAOdlRS4yHE+wVOXOi/UOL0ZlWf9OU8BuMSZM
         zVtwMYBxQjwgI8CsuoTCBOhQBiusk1vFW8R3wWlTdZ0hdEDc5oNWw1zwHBlVITaFF+Ob
         lQVN1oY3Hc/YaYMQ43cigQUGESt8QNHWbAGImrT69p+gzTzRcYF8HF1+BvW7uWdGsH0G
         QEGRzyH37olkh+r3eEH9ntncCsVkEcoD/sDKFzaFSmc321aLY+IdtQeJmDSMe8a1VEJ/
         n60UXmM9Z4y+vEbP8rpVaeuStQImjZleV5Ih2EgHJJ/2cfAt64jQ2B/tQXdN68vOcl9S
         EqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224819; x=1744829619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxPKniuzPeJsq2MGKkGone5ImmkHqpzxLLYbUnfQegY=;
        b=l6HYme3yiZlcd82Vl+Tl8eMfhLOxZoYsKokEnAnelG9FDTjm8FEryfjcHZcTetktAw
         itTpAvvj6amxuUUf82xXvg1CMYHpy/B4zZEjSHigMHU4zP1dtbchhPZ7TBnd6Tek0j+F
         709Nu/vYwhP0TtMqmT0bm3BwMpJpJNOIwvnyU/hQBPpIuKG1tfrjThg1uBru/tQQg7MR
         Lfk39pisvDc+5ZzIv1Ln8q4etvZpES1QrSu8jdKUbUj27rdxWMdM7APTKk/LXyRCo6HL
         9zE9tn/c4oYUD/U7eRvmQbQQUscCAoi5DN9yQrZ84LKUGV+Fbc/1Wf46HM7QmFFEkt9M
         0L2g==
X-Forwarded-Encrypted: i=1; AJvYcCW0H1J5mld75ptgnm9/D1fFaBeqdMcMFJ6H3rYiEwVX/zByyaJt/GDKDXzXLjGG+q8U7WNz93DK@vger.kernel.org
X-Gm-Message-State: AOJu0YzvYBhqlpLRfXbpB+AcndJYedAYN48qBjpf/QIF9KpjJfCx/eS2
	O/SHi1Jar5OBgE8ZqmStiSZeLjLVnu0kNNag3+baSYuceiYUaRh4B0yS0D/fMA==
X-Gm-Gg: ASbGnctbBhPvBUlnWHYaD11XUBISf0M6aEOeieq7sPscRI8r/eN2zBDK4Os2auMmmX/
	e2rdoyTG8yON1RNSTZ0ALS7OO2YYpsqiqsXifYX/Z9f6zVPlSBwS6X2idfZ1F6mkZar7UKEsfvk
	p8nGyVtQeNPwawNEdodFsiy+23yRybiXCKddCJud5OUNt/2HMYDuBho8yXWiA6vWhXc/Q4Is+E/
	5VVRMJnnK2h8gZ4C7Anx0rGf8EXQncu/COwXcHoqe4Sl8FEeFECyG6QplGLrsfoQh9Qejm9xGQz
	6AEMwbqf1/4nNBYGeqN4X+Is0qZoXeYk+8xUCF8EOD/IUcvKR3DzF8O6SomjuSwR9Q1af1B96VO
	N6BKQr7o3DQ==
X-Google-Smtp-Source: AGHT+IFIR3NCeybYkanzOUbrcon5hthEoKzgmw9eaRlfGizZ1TDGKtjpdGzHi+gzX0HsB4fZD6CADw==
X-Received: by 2002:a05:6214:2468:b0:6d8:9ead:c665 with SMTP id 6a1803df08f44-6f0e5c12010mr394756d6.27.1744224819219;
        Wed, 09 Apr 2025 11:53:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de970befsm10638566d6.27.2025.04.09.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:38 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 10/29] lsm: cleanup the LSM blob size code
Date: Wed,  9 Apr 2025 14:49:55 -0400
Message-ID: <20250409185019.238841-41-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4763; i=paul@paul-moore.com; h=from:subject; bh=fcwkPm6l4+RHA9bcjsLXtGXDqmHsJQ/TI+/6NbM7lsU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sGm5ehreHkrFdt3cc2O4D3ChMptSPmhQWe9j a8tVG3+3ryJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBpgAKCRDqIPLalzeJ cyEXEACh3QYKJTL8c02bX1SpOHevSxfKVTorFYqxJSHLoIUVdt/y0KPitqt0qztltUDWoDaOxOj UArQ/ZMFDt7yZ8+dFTRlxXADs4vSeixDGkVU0/C8mIme02378Gb7h31Szlk4mK1PYg7ytgRDZG4 cIv2tMKqZ8yvTsi1rt/rR61LxQH+ZjnEvV6HW1YPucvwmZ6tCRo8yNGoczTD6HF0KgPcWscIiuz UKDh7GwnQ3/rZhsN/hoOF3HRqynx22VDLqFy6MPledKNULUdk5kEUfh1ajgCkt155P/wAEyYwZ2 gYVV75DTdfqGiSFYutUI7eHlLDTlllM3/Q5KOUrv2sot195sewIvjlf+JSLzWICOJNm3CDZFFc7 N2pEXK2j78XZmRaHEG34KbEbYOGJsr5ttsKyt4eRRej9z/goqJ9jPD8vBHLFPyhi0UKA+y038IY TKMML/2aYqt9j4lkc9ubHeX+T6yrva5/Y4/3JiuJTxCznm1Ydg4y2maPXrzCXNrKCNUOsUpmtR6 Uf7rUCr5pUWnsPrwd1TQ3/ajgqRk53vGif39n5vaW+idhEPN6Uq3QZB3VgMeVMYerokC062F7KU tNz8Ybtm5GQ5TtmlY2Nq75J5yb++fTK5A3wwR2+IDOEzMWaermy34YuUc7GO+hsqhCILUYhjVBx BB5fKjiQf2IAilg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Convert the lsm_blob_size fields to unsigned integers as there is no
current need for them to be negative, change "lsm_set_blob_size()" to
"lsm_blob_size_update()" to better reflect reality, and perform some
other minor cleanups to the associated code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 28 +++++++++++-----------
 security/lsm_init.c       | 50 +++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index bc477fb20d02..a7ecb0791a0f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -102,20 +102,20 @@ struct security_hook_list {
  * Security blob size or offset data.
  */
 struct lsm_blob_sizes {
-	int lbs_cred;
-	int lbs_file;
-	int lbs_ib;
-	int lbs_inode;
-	int lbs_sock;
-	int lbs_superblock;
-	int lbs_ipc;
-	int lbs_key;
-	int lbs_msg_msg;
-	int lbs_perf_event;
-	int lbs_task;
-	int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
-	int lbs_tun_dev;
-	int lbs_bdev;
+	unsigned int lbs_cred;
+	unsigned int lbs_file;
+	unsigned int lbs_ib;
+	unsigned int lbs_inode;
+	unsigned int lbs_sock;
+	unsigned int lbs_superblock;
+	unsigned int lbs_ipc;
+	unsigned int lbs_key;
+	unsigned int lbs_msg_msg;
+	unsigned int lbs_perf_event;
+	unsigned int lbs_task;
+	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
+	unsigned int lbs_tun_dev;
+	unsigned int lbs_bdev;
 };
 
 /*
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 7f2bc8c22ce9..9bb4b4fc9888 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -148,16 +148,22 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
-static void __init lsm_set_blob_size(int *need, int *lbs)
+/**
+ * lsm_blob_size_update - Update the LSM blob size and offset information
+ * @sz_req: the requested additional blob size
+ * @sz_cur: the existing blob size
+ */
+static void __init lsm_blob_size_update(unsigned int *sz_req,
+					unsigned int *sz_cur)
 {
-	int offset;
+	unsigned int offset;
 
-	if (*need <= 0)
+	if (*sz_req == 0)
 		return;
 
-	offset = ALIGN(*lbs, sizeof(void *));
-	*lbs = offset + *need;
-	*need = offset;
+	offset = ALIGN(*sz_cur, sizeof(void *));
+	*sz_cur = offset + *sz_req;
+	*sz_req = offset;
 }
 
 /**
@@ -186,24 +192,26 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
 
 	/* Register the LSM blob sizes. */
 	blobs = lsm->blobs;
-	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
-	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
-	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
+	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
+	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
 	/* inode blob gets an rcu_head in addition to LSM blobs. */
 	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
-	lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
-	lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
-	lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
-	lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-	lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_event);
-	lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
-	lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superblock);
-	lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
-	lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
-	lsm_set_blob_size(&blobs->lbs_xattr_count,
-			  &blob_sizes.lbs_xattr_count);
-	lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
+	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
+	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_blob_size_update(&blobs->lbs_perf_event,
+			     &blob_sizes.lbs_perf_event);
+	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
+	lsm_blob_size_update(&blobs->lbs_superblock,
+			     &blob_sizes.lbs_superblock);
+	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
+	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
+	lsm_blob_size_update(&blobs->lbs_xattr_count,
+			     &blob_sizes.lbs_xattr_count);
+	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
 }
 
 /* Initialize a given LSM, if it is enabled. */
-- 
2.49.0

