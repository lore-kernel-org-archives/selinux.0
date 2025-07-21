Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C97245033
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140248; cv=none; b=B9BWGHO7cxqz2M2doBSFFaRcH1dIHWg6mOp5ZIQ99HSJmZphpXvSnIF3ZupRiJLwW8vWaHUF1lck0yocAX4NS7m1u08P7yB7AELAtTAzkqlTiUTBzi8O/Q+zFp2lUMl+XAyRDPUg3PDVl1EstBLftkEcU9pRP30HWuuy1iOfVZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140248; c=relaxed/simple;
	bh=rdBPCXy4+zMMahAP+JfAAcpjXp+SK/yo0e3ExJHaW6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b74mbqkv7x5IihdX5efw/khik8qRbDSmJu25o76LY+f3ONukhVy3zj+9AWW88IDnN/6xlKxw34hMffhdZvx2/IzlpUaqF3fUW6T+3ek3dxUnht1hbSrgw0IT+GcT0GTq/MeDXmw0JSE5F0nKFGNyI5k37qJX1uTPfHCqCI+VRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UdAlQkmm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UdAlQkmm"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e34607e575so851395085a.2
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140245; x=1753745045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr+5XluOiiRdnmU0yLT3prhxmj6Bm+YlSZyG9UsMSgw=;
        b=UdAlQkmmn4uTGuwRe/hUpxzNCxgwW+P7aIY0uAJInL3jQNrWsxDdSC1Ir8Uo++wzhx
         SLczswux54kZzhHCi4bBQUBEVFDjzUp85CJt3qU9WqTZkXKiRMYYogXLrIOZ92v2Qw+W
         xoaob7neAVreHobJIv2ot40W24XgdR3sjXjio4AbFKj/SSKPotLPIk5ACOXuQF8/A/TH
         otQaXkeqqXeL3oiMJ4QnAlCoWH4lZX1BAHnpjWccH6UBieVzc4has9/4odv49dlCTgyt
         0R23kO7k2jS/DECwpWpHXBVrGjzmtI1L/B6XIRp4SkWbE9I7dWxuJ/DxNSlRK+NcS6bh
         NjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140245; x=1753745045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cr+5XluOiiRdnmU0yLT3prhxmj6Bm+YlSZyG9UsMSgw=;
        b=w0+xviS5XGSCYL65phDlsXPFtisado6lvW48E8bsDYETMBicQ4VXWjpi+Y8Dem+csY
         lPdIbWiLLMCoqHTN1uPCYv9Xl+DZjeCoafvSXAh4yuCMgp+l+l8b5whHUSxFz2f8TMKG
         66HjMn6cFfJobLBRcWmhu9PuMi2TRuh39dINWNw622/p16pMxQjCz6vGQqyJE1+ALa0s
         k6BeCpXauNnNDhbQ4ZvkNnbp/WlbTJ+fZP5lxOWtXJqDdMIGR9W6GQCw+h7JnqEIxi+K
         qN8KT4zDvz5cqZd0OfltQthyR6nEFgeP3GM3/sjw+du9Wa0foEc+vaXbEm3LKE4t0tQy
         x0sA==
X-Forwarded-Encrypted: i=1; AJvYcCXTZPjOfAkI1HJADquopbV38B93oOF9B/T0gZZvfLF5uQK7FP/4BggwXhPeIItM6ZKq+ZD3Nth8@vger.kernel.org
X-Gm-Message-State: AOJu0YwynnDYGK3kE+PEi2gx8p41rHy9Sh9SnPBnNzrAQp5UP65+nYTu
	8P/Gsb+1/63dFXbzT6T/25ZwGvuJLPSTyLUDDdjeSlaWc9xYz/sX04b5TPpOECmR7A==
X-Gm-Gg: ASbGnctc0ATRZWgCC3X70TWm4VAVpNKlXjiASIWsusRrVceu9WbgyI7Y73dUl5YEPDt
	SBESvu4ou2IFUyO3n+W8h2yoXz7COn/ACfvdYs7gVFvbR71zb3Wq66X+wYNFlW+LKqSfBpDZrW/
	7fZhLIxsmQQsio7dyC1poThjFrHsPZBu9HeBRAMHeLD9fEzLySBQtkbf7z/uzTf6bZ5qxdEgK+j
	qClQ03u0TbzLnAunBDRthC4+G/ypWCMQefJUofdtxklb130ee/XqaaVPECHVtc5qUmmdGC+6xNf
	RIxd9sN/mUbMCWj2gENk1krFmBV4GT7BlwHQCgz9seeJVJTR08/N7813v/PKSExpe3wSGXpSp0W
	UqjhljAjjR4zc3eQFzwEI/Ju6DMKKcQZGSoqpZVP2eJmQc8KszG9MzJaj2QuXC9gDvCs=
X-Google-Smtp-Source: AGHT+IH2/awtgbdd9HS8F8qdKLvqQLxCU+tNuju4p23IFiYiJXPedSeAn1ufJcSLiXNam+ak1ZbEJg==
X-Received: by 2002:a05:620a:4623:b0:7d3:9260:6dc7 with SMTP id af79cd13be357-7e356a24654mr2055990985a.6.1753140245593;
        Mon, 21 Jul 2025 16:24:05 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356c649cbsm480552585a.75.2025.07.21.16.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:05 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v2 06/34] lsm: integrate lsm_early_cred() and lsm_early_task() into caller
Date: Mon, 21 Jul 2025 19:21:09 -0400
Message-ID: <20250721232142.77224-42-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881; i=paul@paul-moore.com; h=from:subject; bh=rdBPCXy4+zMMahAP+JfAAcpjXp+SK/yo0e3ExJHaW6Y=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsufmFIlee/a09i1WUsF6musLpbaGAIzsUhLh bf7XqM30TKJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LnwAKCRDqIPLalzeJ c/LSEACInaP2nWSEqMsoqyI+RYT4mS1nDgi2/sUYsDAxrqW8kwPeDLig8a+c20/0YzPUnEo8BG+ 8y1jyITSKzE57ahgHD05zJbi8s1Vu72lyGxQ7FdDNL4hqYt5eHcJfiSrXh0SHIz6DBQRmv3lv9x r5dcu9OyggScOlbgLu4Ms+Ofk31sZFB5Of9GPWnpzQw89j6S/x1kjYwockWptx4lMlW+XUXQoPN EbskUvFG/UiuF6q4Hbhrtd/fjqn8AGQnuo0dXjrFkkSg+hq5+qOUcbo32zqR6jEeeLFWwt1UfCo 0qy3eaGjibr/LTSv+7s+UUT/az4ytlY/JgOQOj+pYnKbZatt3UyTkpokZw54dYN1E4F792RWSyW wSaB2PX+NAW4lKVUIJKNmEYX/tDhN+DchBU10olu/DBN/k+fQLE9W+PEEHmKJ44TTCXcGFjjjeH HjLEdZfTh587IQSEGlPsfelkkMD/or0EMAsxQqqrmXEhDoWFoS2I3K/5IvHovn2BOrcJT+m3wC3 qd/glUGSa8AOnkxPcV1JiDXmHBq4B78oUkRM00Ee/7B/8rqfvNGz27NkXyZi15J9A2W+yy0H0yX nrkPE7gf6LBV5GUEdSe7a/A4RBQA2BAEwV9ex1rOkeFqT1E3XLfH8Ni9pZ672ceJOz8SaigQ0v9 BYtGtcWcm7AE3nA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

With only one caller of lsm_early_cred() and lsm_early_task(), insert
the functions' code directly into the caller and ger rid of the two
functions.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index d20c6df55e7d..7e736c20458a 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -288,34 +288,6 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-/**
- * lsm_early_cred - during initialization allocate a composite cred blob
- * @cred: the cred that needs a blob
- *
- * Allocate the cred blob for all the modules
- */
-static void __init lsm_early_cred(struct cred *cred)
-{
-	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
-
-	if (rc)
-		panic("%s: Early cred alloc failed.\n", __func__);
-}
-
-/**
- * lsm_early_task - during initialization allocate a composite task blob
- * @task: the task that needs a blob
- *
- * Allocate the task blob for all the modules
- */
-static void __init lsm_early_task(struct task_struct *task)
-{
-	int rc = lsm_task_alloc(task);
-
-	if (rc)
-		panic("%s: Early task alloc failed.\n", __func__);
-}
-
 static void __init ordered_lsm_init(void)
 {
 	unsigned int first = 0;
@@ -376,8 +348,11 @@ static void __init ordered_lsm_init(void)
 						    blob_sizes.lbs_inode, 0,
 						    SLAB_PANIC, NULL);
 
-	lsm_early_cred((struct cred *) current->cred);
-	lsm_early_task(current);
+	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
+		panic("%s: early cred alloc failed.\n", __func__);
+	if (lsm_task_alloc(current))
+		panic("%s: early task alloc failed.\n", __func__);
+
 	lsm_order_for_each(lsm) {
 		initialize_lsm(*lsm);
 	}
-- 
2.50.1

