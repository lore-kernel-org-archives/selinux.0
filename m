Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C63D0C9
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931721; cv=none; b=giSHUPmLmn9S2hNp1HB/rJAbGLvYbITmf4N4z03cSt32MBN8wgmYuGexumYECM5q19GR4BSfTSxxkAa2NRi54pik7IW7MrBLb3rKStS6FJ+Jab5W1cD4O935KkELauILf9SpeRvZGaX/74RBTEHGHledJ96r+aG+Fcjtn1hHKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931721; c=relaxed/simple;
	bh=/NFSIIY14o/GxFP5gSNDLyd6TFAvNnvIU/dN3107N0U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qsr4TCDebqyVyPaKMEDocCyX96H0dyXM5tZlsBrp4T0u/ynwL3Z0Z36Wpa/fCNPE0XwmWe31hmqC9gkqifI7iqdt7eJ4ykW5fdlhn5bPKNGV5QJnPC3fa+JZO//hHltqZxSCDqa+cX0ktz4eED1LxBsaS/tf/RRo1bXvm6zdW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=B+wI710P; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="B+wI710P"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a30995f564aso8108766b.3
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931718; x=1706536518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeGZXdMIc3uC2VkXwulCTeQkSS7PCa0YqjZs59DxYPw=;
        b=B+wI710P42EQsMTzOmIQTCTt/NFTXDd2wiyln3Vu2OeNkEJiRvkfkIbQjhT/Y6E3FR
         gjie8gf2WHsADVB1mlf1cqDWlUM+eQk2Mikfzutr7r6zuGx4SgGWkfwph0K+JWs+jsfk
         dSw/3szRssXQo7b+uG2ojze4+k1iofG91ams4515lLyw3B8GiZFS11g8MBNCieAi/a3V
         Auo8/2ryOYxCosWz+XwCil7pZVlAUIwSoZF6aKapLmgtnnanPiD0UIRJQiIR0LnKS199
         0uOXqZnCbIJzeqqzaiGbPMqqaXBAdo/DFp6rWORFRzPz2oWtCZg0mPemXCEjElSRmva7
         dlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931718; x=1706536518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeGZXdMIc3uC2VkXwulCTeQkSS7PCa0YqjZs59DxYPw=;
        b=PqboZRB/EJJJXiBmRRYVVEsD8+WMdOMSZkAP0xCkZSYLUd3TLj8br4DIHYJF7kMgVQ
         /keTbH44Jk05StnwNV3FRkbt/yZVxYk+y0itDmDBtY4EAdzha9Iw8Fy0WDAhAY/FXFA3
         dmjzTJsHfgTsx887+SPZlmUUfSse6l0/+WYFjRsKxbBDkoNbtmnrIin7L++3BibwhDRg
         C6wKoWx1ZXp3pAcua4R6J8WG6t1vhlTbDwH7VI8+Eiz069dU8007gPfnwayHb0fS76GE
         89lR0icYYriVp5uLOmQQN3SyTHSDsrGjAt3SfOJ4PByjIIzNMDGNMv6miQkOI/W424k5
         +saA==
X-Gm-Message-State: AOJu0YzxsMFoIDIDWhvlCP32j+Iro9EXjSmaZetDH164XMTaNvYb/VQ9
	NOzQBQdf2ffwqJ/dNTVPjHlvvycsGEsIxSLYR3EvcZ1LnQcyzvl4uGwwqJKt
X-Google-Smtp-Source: AGHT+IFH+PE+dUtJgZONnV17V8R+VJr0hc6GwnqgsTPwqVIclsi5Wp7gGfJRp4kQNhgKaMwAfKd1MQ==
X-Received: by 2002:a17:906:c812:b0:a2e:d377:a9d3 with SMTP id cx18-20020a170906c81200b00a2ed377a9d3mr1955379ejb.59.1705931717958;
        Mon, 22 Jan 2024 05:55:17 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:17 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 08/15] checkpolicy: bail out on invalid role
Date: Mon, 22 Jan 2024 14:55:00 +0100
Message-ID: <20240122135507.63506-8-cgzones@googlemail.com>
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

Return early on invalid roles in user definition.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 97582630..44236797 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4244,7 +4244,7 @@ int define_user(void)
 
 	while ((id = queue_remove(id_queue))) {
 		if (set_user_roles(&usrdatum->roles, id))
-			continue;
+			return -1;
 	}
 
 	if (mlspol) {
-- 
2.43.0

