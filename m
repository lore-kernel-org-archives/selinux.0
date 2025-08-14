Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D992857F8
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212110; cv=none; b=MBLP+ia0/t8FEmcGuBY55TE37cmJdZd/s5P5y1WPRIA58T2CFBr1GTnaNuLQSibq82Vo233yQGalssaDAR3AZC4s7yUQFAzE16naRdvqi+GmlRJjvYhNgSwZB8jB5J5g6XO3V8U/cWLw4/Zfc0aWkZt8xPYvjvThnJjLER7aKXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212110; c=relaxed/simple;
	bh=fdl7CzqY59D2dLsC4jc8NY8hiLlk4gTFAqpYUh2VbuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLY3R9np+HcZ7Sf2cKt7j+TAdROUBpd3ox7Pda3THQCRpFhmqScDfPKZ5ruqozraxwH1W3Jz8qiU55jG9nmKsLF1CL72NUk7ZBY1v4migL0gGflpUtOkY++ZLfL/KEAo5s/uUIRfOuD66xTNkAEqPK0Kesme8OoGc5RobVR0HuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CJNU5390; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CJNU5390"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b109a95f09so11109201cf.1
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212108; x=1755816908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oxe9YEWGmig4Lx2hQHLyZ4lS+p5Qn9z0718KHQhmI2s=;
        b=CJNU5390rHlHQeqZ9K7q7msBe5y9hERyoh652gRWYh9SzcWT0BHVAI35BQsi41LCo9
         MIgcpaREnJG7XQ7NA+hfscgzXB/Ih1cOcxOVq9o0bcJ/Ii2QK4YuYy+O0O135pHWldmo
         Y/xM/XPmsTglhUKAf0HNn9A7MTeeaPODJLP8ZX7ZzpPXelMIsXVaZLzrKzubyuYOyAlH
         ivmLnBftxTulJT/6mKx724Fh9ZptcwV+DlXZYPYEAYuR0fZXv0ae1tnyEdMQRRm/HeWz
         KFT5OOcJdRUuIlRe5PUtNHzy7pEUe4meBJAMk8/vmd5cVxC0cqdl8nHr3dqS0DEStsE5
         mt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212108; x=1755816908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oxe9YEWGmig4Lx2hQHLyZ4lS+p5Qn9z0718KHQhmI2s=;
        b=mQiYCWxW8MMy6obpXwNMSRvJ66j2k0D838SEv00zQba8BCimwHtx2RHs6EFSjaVDST
         2A581SUulu/qC8crR9c3fVT1RR/StAm00tfiexKsXHH6XSUF8CUtRMSJle4NE3hzIUqO
         SBbZ0/3eqC3b6CiK386jCdTckOzgVohEPJ2Bh2ik7FFq/ZovOzAt0JpxGkZPfSZtzOBt
         M+msjpjmfH+LcBT1L/ztGMM60LG2fIxZOggtkC18K+chO/RHoLuREOmkSQz2lgctj5dH
         UmyfP8P69hP5uftz+ocIV5ECkTxhCwr1jAfLVH3bLi/yA4FxoRZrb5yL4VcK8Dvt0+yd
         Eppw==
X-Forwarded-Encrypted: i=1; AJvYcCXD28m1B111ccE+jGxE4IGSTZbDxA13PtPcQzb84HaEsvXvYBzkSUYO+MXy3digv+KNzk1aiwe8@vger.kernel.org
X-Gm-Message-State: AOJu0YztjC84NlFrbBAMLZyV9LcqPQiocgun+zt391R9UL6i63MZeS3P
	gHXSl9lbvhMtW1+B1hIGUx9FnD7cUv6V/uKAufA+nkVnFxEReBKuuY+XyyYXDgsvEw==
X-Gm-Gg: ASbGncviFHME2gLC+52+FlTdkRtRBfBGZqYx/ObieI8hDccACPG8+fMvjZ1ifQeJHeh
	aFOp1AGLMKlnsTINvzoe8/BVLAPUPEM1cEL9twPGQjpLmDVVg0xel+VWZSoknfzm0hypCr0RvpY
	9321s8Bu76TAUM/VjpWBR2/DiLBa6H5RKPB7I3cJU1PT1a5mbE4lU+tX5GrayH9q+Wppzeb2kgv
	yW5RE00E3TpqUXBwPZvKN1rOjg+4YapkuxuOCmcC77SIJeWb83rs+VyayWiPZF9hd2hwoAEVL5v
	VhSErtfZUz/BJyH5+mERUcAvO6mfCm+cfETYyEro+GFbf9EdhLecPlPnseGIiTs3kKkWudQY0rC
	gNEgzrI33ZKfDp/XkGnvTe+Q+73wic7TpVVK9xTo82zFkHwF7llwqGdXF9TyWf82eEGnZzCCNbm
	SNKw==
X-Google-Smtp-Source: AGHT+IG4cuhWSAP2h+Qyau+cGWtn54Cvnt6cc0Dk6EYYnulcoYcagXhlg8oEvE0PduHFsEToMbkDQw==
X-Received: by 2002:a05:622a:4c0c:b0:4ab:3c02:c449 with SMTP id d75a77b69052e-4b10c5213a6mr74481871cf.17.1755212107784;
        Thu, 14 Aug 2025 15:55:07 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b32b1dcsm44910785a.11.2025.08.14.15.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:55:06 -0700 (PDT)
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
Subject: [PATCH v3 34/34] lsm: add a LSM_STARTED_ALL notification event
Date: Thu, 14 Aug 2025 18:50:43 -0400
Message-ID: <20250814225159.275901-70-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=paul@paul-moore.com; h=from:subject; bh=fdl7CzqY59D2dLsC4jc8NY8hiLlk4gTFAqpYUh2VbuE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmj7rGty3eNbiLBayPaBS0jB5uAjUcq3lXHPV bH9KTnAfjaJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o+wAKCRDqIPLalzeJ c7jQD/49TAYBsfxYR13eJLmK2MD1NehvnHrPVZB8DDt27MYzR8T2nBeDVO/4RYDQyzQ9kIMal/w H0KCfERXDU/1eUTshg5DP86iddygWpypciU4+rV2wQDNH7vGdBYvDLj1BH0mAd4EZdV3izIx4sT /8/m7i/jmBtN6bpURG37jI3lXWYwgERkoSexmJ2s60VxK1TgOl7rK9Owx3ZS6Kweq9AylnU6rHP dsJjDXkU9Xo74VVYKis1LdOUIcm4jwgdfqs7b9IfUoMaExWlAHcNh7W5fOOoQfbckVLiYEIs9wN Kc25nncwqTC+kPpQlG64ygxjcD0TMBOMJgbllqfBDqGAAjnhr6y+7YoYirSOT51EDxF6X1VMPvr rGM1aajS2q1UMG/aBPxKV2opGhqe5Lwkitydf0swuE1cmItM4IwgOHcy9QC+K1nCpaFxZVjJ0wA CMGD60bnYXO0DBtfForehRfKBfigOk6LftnaqpIn+7Ug/hoW3lPIMMLaJY3aa97vNJNyT92ry8k zAd7+CwgEQr/5i1aMtRCwK96Cg0leQhwo7Y9x5s0NkTX1mrTOVo0JDWRQ1mJByBlGcgcjXayx1y 9v4/OPCMPy1XQFZFPaWq2yXl8afCOm8AKPQm8+lq06HnU0uYYzknEKWQH3A/WqYFDkx35gjNzI0 8elFjuAmXDUb2Kw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add a new LSM notifier event, LSM_STARTED_ALL, which is fired once at
boot when all of the LSMs have been started.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 1 +
 security/lsm_init.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8560c50edd2e..c13f0a849024 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,7 @@ struct timezone;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
+	LSM_STARTED_ALL,
 };
 
 struct dm_verity_digest {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 2bd705836df8..af4046c5c581 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -556,6 +556,7 @@ static int __init security_initcall_late(void)
 
 	rc = lsm_initcall(late);
 	lsm_pr_dbg("all enabled LSMs fully activated\n");
+	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
 
 	return rc;
 }
-- 
2.50.1

