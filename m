Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F419ABD8
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305201; cv=none; b=W1oBZraT8iY7M4O75w3Vprdpaz1t4MSUYsjNV0okmQgogd8HuO5cDZhYBi6faY7sJLoyUq5O6uHlF6z+l18cFj6jLYGFXpKUvb9mh4JCq5fvNSLcHTGVxX17g7EA9RlUKumQKGrMabA0+fqktU9d+IeCap8PPs83gAR1qVPSNkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305201; c=relaxed/simple;
	bh=x66hmIGILhwKaBIsLRM+S0y66E+k9BuE/weApjH/UBI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=TAklSb4hN2CUn9a653YTtVfev/JWyQTRWfJr6xyYMRGmfPe3FSgovfczYIepjV2NPk0Yk8zk+Nko0G+iyJQbWSMy0pFr9dgKG8RHjWvHdG9nF1V08yY9EIXghr7YXiXXAh2IIWerbbvkufj5JvqBDvspgms5eQ9NXU/wnSSmBmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FHc5WS79; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FHc5WS79"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46788c32a69so24249091cf.2
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 18:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305199; x=1736909999; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTMN0fZnjdwbZaPCb5FrQLxLApwEte1/54lx0D/jILQ=;
        b=FHc5WS7963UaXZcl8SqpWIKPU2rdYvVNgybFRint8zoSWSmZV9V0X2jBPlAS8dqMls
         4ybZroqJ1q6yez49MSdNqM4IgV8T+NoLOS3jjtDPS4Am7PZ3ARWKZbuU3ID+/mxTF1fQ
         YCgH9VEAweM03j3sToS9UN/vm07bzXmrTX4S68JnTreetAHL8BUH3alVAKsP3JPux6Mk
         qDOJgQAycaSrLmjybERubJuz5l2EQ8tDrwjg3G4RWs3XO05lJZmnMcHX4QQUdONKJBTz
         90YDT3nAb+9fJmTlrpxOzaVTKJ0f2B2BhpaMGUia/PMNHkP1cgmWbBBrrkipanWf7NBl
         fUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305199; x=1736909999;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nTMN0fZnjdwbZaPCb5FrQLxLApwEte1/54lx0D/jILQ=;
        b=eyVyUbuU34eJCsyHaGmDKYBriaoQEz7E6uuwnRQLTP4VYVp68pEUCp09348ZWp0u9d
         dOq9Rqp26JGDipSPDkCBdEiDLRd4cW7/WNva6Hzsv9oxv/vHXhmujV9ZoD5OsWzgSkZR
         Bc8fg8V9P1W7OE6IikBr+/BuxOkPo7KD8kge55FAPRHiLDDLwVXE2CgxRtZZlmyqivOk
         DSG6c5HHSnSC1VGs1umC7QXY81tIhk+uSl327v0DIDhwDBxn6fTeNHmf7EIEh6lzkDmm
         f3lY1e2i5aVfMrsg2BylS7LUodqWllK9nky5vYmCzXtu6muwAlx7fbKRMhowwKxWHY1Y
         eO6A==
X-Forwarded-Encrypted: i=1; AJvYcCVYtMcr9hMrTkzWnJR6icICTG3WDVb1bzP0A8oO0qKTyj/P6xHYMYveyedEUzq9CAN9cZy4HCfV@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZWSOd0U3lDHv0wILAM6APImioXQU9fTfL+pxHjv//X71Idov
	vx4fYtVdVbsBnWsrBWXWNca+9MO3pPpzFpq3pOHITXooYph6NGpCAG8Akp7P6A==
X-Gm-Gg: ASbGnctSI4aGBEjl7Iq9hKodNmHzNwBN1g9XLGvhXjtH+axKFbPam3wJFyJ1WzAzADj
	rHRBOFW1Fq1Up7p7UmzBa0gQZ6nLhK2KWrac3YKvrBQqndD3hCBvzheUNfEi9+c+NciHRk7ivlB
	z0ALiGbJsRbtzx7rdh4c+Y7qC3Bg1HqOyxcrcPyQry/O2xgH5NI1cKZ+0eGKA1y5nyd5M0JIoDG
	/7ZXgAVCWEJjGkmk5LODpiIiBnkERw7skzp8ejcuTCvXXjb3JI=
X-Google-Smtp-Source: AGHT+IEk9o+lqCx9JhOO2ZsHFc/qXlWJ0wAp87lFv1hIl4E+FwexInYRHy3Gb8LgewH65wTTxnEBVA==
X-Received: by 2002:a05:622a:6082:b0:46c:726a:178c with SMTP id d75a77b69052e-46c726a18d8mr10961201cf.11.1736305199031;
        Tue, 07 Jan 2025 18:59:59 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6892ddsm191617051cf.29.2025.01.07.18.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:59:58 -0800 (PST)
Date: Tue, 07 Jan 2025 21:59:58 -0500
Message-ID: <0a1328b83f79fab79ded9e333240c6bd@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250107_1610/pstg-lib:20250107_1603/pstg-pwork:20250107_1610
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Casey Schaufler <casey@schaufler-ca.com>, Canfeng Guo <guocanfeng@uniontech.com>, John Johansen <john.johansen@canonical.com>, GUO Zihua <guozihua@huawei.com>
Subject: Re: [PATCH RFC v2 4/22] selinux: rework match_ipv6_addrmask()
References: <20241216164055.96267-4-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-4-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Constify parameters, add size hints, and simplify control flow.
> 
> According to godbolt the same assembly is generated.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/services.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
