Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C9544C68
	for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169045; cv=none; b=CrQbxS7QDmzj3a+WDuOJx8+KPNvwUAzne1d/Ch5NayebtbHEqOoiCL4LKu5afrycsHD9xDvCWdvIF0sCOHN5NPixoBrCDeDxWS5mWcAZ0whdHbj+3fmqk7To841vVOMAAfLgxlz1m0gJPSH5eGdhIk8w9mqIqowzkHphfxwR0cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169045; c=relaxed/simple;
	bh=WHwUIAOhmod7DA7pi3lXEavucN0NclfVxFHWbfcZXz0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBs2y5xJM+9CEFb0UU0ChGlcMeMFcgCCh0Ih5yjatZ6Teq7pwOUSi/tL1YLjnhp1dX5FmlG9YThcc8uPjko3FsVMNDS5ZWEsJFFRAXQa+zql334v7PgfrZNPTBrQbtksgS6OzKbDoQkpcy5BGYC3mn/7E1WHr8I0X4BF7rji/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fYdO5j3j; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fYdO5j3j"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513a06ef9b6so2353610e87.2
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710169042; x=1710773842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wINX5Kq21cNkSQQzKKoh47mlcuLKgswKSygSKstGDCM=;
        b=fYdO5j3jD+3dGEy00GHHn04ZFahFzqZw+P+YrF3/O6vQT0UK+roCSGOVSnro7mRzmn
         RgBXeNjeCXpgtDdIKAi6r5YoN4e8wDuykUmgh1wsYfHjIjRIZXEpA14xqmY0s+3+MXxO
         0IpWFhptxCiu8VlqvyLn4hEd7Dm1UNYf2GYKDFqoRwiCCdNUf967CdIuRxdewmgvg6sZ
         bqRmup9iv+D7jSbTIyRSGp95i+AmsV9F34tzpQUGQc3dvboe5iqGQC1cLpRxwM8b2mJI
         E8wwxaEi1kHolol3LQLLM3uw+ArnAWAMh24AqBmarODDZbVOFCLdjTLkO6d2EngCY55/
         3cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710169042; x=1710773842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wINX5Kq21cNkSQQzKKoh47mlcuLKgswKSygSKstGDCM=;
        b=WgpoZI1dpWMbPEmbpt3eDoSKixTSuWy/r0Mfkrd+qfUlB9q9+qau95Mkexdpe+OhNS
         NR84Yr76m9J7tA8ZKKHOwkFpP+HoGWPMIauQLCNDlibS9vp+wAbqAUTcUmlWst7EsNnp
         5aQ7ciaQB9CSw9lFncW9mQMlBCbVC2/K4m3H4FdkRu380JUD4knKkhvugmQr4XUBI/A3
         ghnEN5ACyHpWgh4bAdUaqYJmQID81MMe4nMueCsgbwsOPUQZPzFIiyVnotZzl8xuVkkD
         fLgEU42DbhTN1f6K7iiFfq2nDTU67YM9w94FmJGAQRhLbrvfZKHj/pn8BUQU1VkwD8x7
         SzCw==
X-Gm-Message-State: AOJu0YyAumGp7Sn5T3y38JfmMjmi89kZNrxWsICyjFJZ98x9m/IFfV0G
	5+xskt0TQF8MuMLBm1HlzM5SMQQl3P7wPsL+7wdTn3Ic35IvP6W1p2PTsk5IdO4=
X-Google-Smtp-Source: AGHT+IGAOfdjZG6vEIzzoVa71w81htR6yKGsDgdT9UamkkRR3Nc76eVGx6WWqlNoftgS0DgrTL4B1w==
X-Received: by 2002:a05:6512:281e:b0:512:fe1f:d3c1 with SMTP id cf30-20020a056512281e00b00512fe1fd3c1mr6162556lfb.58.1710169041685;
        Mon, 11 Mar 2024 07:57:21 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-112-075-004.95.112.pool.telefonica.de. [95.112.75.4])
        by smtp.gmail.com with ESMTPSA id r24-20020a170906549800b00a45a62e0ed0sm2945240ejo.98.2024.03.11.07.57.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:57:21 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 4/5] libsepol: reject MLS support in pre-MLS policies
Date: Mon, 11 Mar 2024 15:57:05 +0100
Message-ID: <20240311145706.34885-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311145706.34885-1-cgzones@googlemail.com>
References: <20240311145706.34885-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If MLS support is enabled check the policy version supports MLS.

Reported-by: oss-fuzz (issue #67322)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 6e46f426..e987d8da 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1554,11 +1554,15 @@ static int validate_properties(sepol_handle_t *handle, const policydb_t *p)
 	case POLICY_KERN:
 		if (p->policyvers < POLICYDB_VERSION_MIN || p->policyvers > POLICYDB_VERSION_MAX)
 			goto bad;
+		if (p->mls && p->policyvers < POLICYDB_VERSION_MLS)
+			goto bad;
 		break;
 	case POLICY_BASE:
 	case POLICY_MOD:
 		if (p->policyvers < MOD_POLICYDB_VERSION_MIN || p->policyvers > MOD_POLICYDB_VERSION_MAX)
 			goto bad;
+		if (p->mls && p->policyvers < MOD_POLICYDB_VERSION_MLS)
+			goto bad;
 		break;
 	default:
 		goto bad;
-- 
2.43.0

