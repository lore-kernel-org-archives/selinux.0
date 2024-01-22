Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6EC3D3A1
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931719; cv=none; b=tRq57h7UTSEHUgPZI2qgtnrFfgwiML1O4HrS3Yt+xdUofOysDilFmb46Wn22DngLhseKx8IEyFhUXjJRFcvsskjVo5ee65XAxWvrBIWGEd1FuO8LCLwIDlxnSwGyCEkCasDO3moNeMinqnEX0iggqNdlML/u0O1HmPuTJLXzyns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931719; c=relaxed/simple;
	bh=oCJvL2U+bu9zhgNpzHuPXAe/N3txLcmFdWSTtiCHGns=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKJZFmFi78E2S0bSxneAyaEtzVSbtdPtaOSFsbhECIjw5mDi2rnn1zzGAp7rsuQWEprnk9MjX1L0N5eVJJp4K4jjb1H9s0TUnUK0HV2cK8yfUdd8Uaheieok8oE3isgptYDvV0JVLscKNzWq8oXzgcI1X2bNTULNU7dQrhvddr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CTKW3XRk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CTKW3XRk"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2f0cb62068so323346866b.2
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931716; x=1706536516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQw979VThehWy7Og1Ex+Kqpg1t5kLXcbs8ICBU71R+s=;
        b=CTKW3XRkheQgzS00P69E3QNHxiaZmqb8cCtSLVp0k1d+zvnLyE/OqmgUmRXqjAzNh5
         RJoS1MQNUVrDb54iQHxduK77pS1eTSF5M5cRrqFlbl75cjPKm06cJ61GEd6kuzq2UQ9u
         kka1f2OLAJrmTJZhMmBUisp39XZ0Aci8AYpuUSvhi2pjf0QwjVIR2Wx55QLuAW4e37l7
         FucZQ9Uw+QYxinKEqchtT3O3qHar1DJ+yEtIzxNG3LaiIMHp5hcx4S7zz2toYIbyY5lI
         HOMZDqe3v7g/21qk0Gn50ZOlDDQPsTVlqAMCkc7NyKapZtS+PCgLFaF/ikoKhjX2MzLp
         ySTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931716; x=1706536516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQw979VThehWy7Og1Ex+Kqpg1t5kLXcbs8ICBU71R+s=;
        b=lYyc6Y+RFdQ9rObaUSfjLm8SU7X9cL97v2i7ZqBUkibVYWoakSOIoV0KcpIvuNL4LH
         5wO2Bf5ydLPjl0x/YZboEq/ntFPEdS3HHzmqqNbcZ7lvLoMbf1MKnZYfG5HPr5xr6Dd1
         358BE96/0wor0NSYM5PuMpP0FqeclMSBeqshGv4TYosL9Cb2YYu8SkHUZKe67c8++cP0
         6Npn6H4kG0wWLmx/KgrxAFSspaOqteJ1ziDYlf5LKTDiw0v5edE/yZQpsW7s8/eBxcZQ
         ISOBTHAZx8qOXPSkK0oY7bokkjkIAgPH4q+whqp2OZU6giXxYBb/1PHDwQHLCBK8O2Xl
         /2zg==
X-Gm-Message-State: AOJu0YwC6sT3PVefY+NKUodjRqUd+3NAH676FQVANxue9Aghv5FQQ2tY
	QBBpFtIFVMdV1jRCx03Y2bHA+x0B4FF8/bkRSTxQeRx7LWiK6rNCa/CTm1t9
X-Google-Smtp-Source: AGHT+IEzDqR0nFitZby0zjhiby2iuS2sdgHCOBMknOhmsAKOag2ETISe1O0s9/Qv9PDNaUq3c0j2TA==
X-Received: by 2002:a17:906:af79:b0:a2d:9c0e:ead5 with SMTP id os25-20020a170906af7900b00a2d9c0eead5mr1087274ejb.117.1705931715766;
        Mon, 22 Jan 2024 05:55:15 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:15 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 04/15] checkpolicy: free ebitmap on error
Date: Mon, 22 Jan 2024 14:54:56 +0100
Message-ID: <20240122135507.63506-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index db7e9d0e..053156df 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2544,6 +2544,8 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
 	int add = 1, ret = 0;
 	int suppress = 0;
 
+	ebitmap_init(&tclasses);
+
 	avrule = (avrule_t *) malloc(sizeof(avrule_t));
 	if (!avrule) {
 		yyerror("memory error");
@@ -2607,7 +2609,6 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
 		}
 	}
 
-	ebitmap_init(&tclasses);
 	ret = read_classes(&tclasses);
 	if (ret)
 		goto out;
@@ -2693,8 +2694,6 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
 		free(id);
 	}
 
-	ebitmap_destroy(&tclasses);
-
 	avrule->perms = perms;
 	*rule = avrule;
 
@@ -2703,6 +2702,9 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
 		avrule_destroy(avrule);
 		free(avrule);
 	}
+
+	ebitmap_destroy(&tclasses);
+
 	return ret;
 
 }
-- 
2.43.0

