Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098E1714BC
	for <selinux@vger.kernel.org>; Tue, 27 Aug 2024 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798550; cv=none; b=dPnBhvIaRnopb+VUDMdof0wnoRLFcZ2gsOmvdRqEJCdJuTJZTOfNhmWTjZfhO8Ekn/kMVUu4BjxZuOKt9sxVd8/cf9avAMmtg3wHuXspJsIftBwrmKplDE0CQhnURZG4wDKCdoFdbniiOsDK8W+cKo45rJWQUdhA4ln1fd+fXAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798550; c=relaxed/simple;
	bh=Yghv/J+0rx+0gWvgW2CWRgzdsbD3sXmcYuohmaK8VWg=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=ku1Y/BJwOhB0qa+W3i8WfBwmQSc2EVMuEOpd3IhlfvJ5z7NTydI/mkeotMMcRmPYYvYZKWcXkxWAtCkcYWG7NPr/fn6ocTNCoVU4ccs5iBWhqDeydu++i+swOLUcWUKO/eNhDeA1+LHrmNhoUYEizfSihne6Uj1yHB6z9fM+9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EuydRWYV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EuydRWYV"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a7d91354ceso161851885a.1
        for <selinux@vger.kernel.org>; Tue, 27 Aug 2024 15:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724798547; x=1725403347; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zU+cCOEVzUYpPZSGjHMMQGOipQ4KAc/qVm/ssmWSnac=;
        b=EuydRWYV/VXUsqR61kR5HksqHWrbSo2jRYa6KG8rBl9pgcfB/oXQ0gRKm4qqCaRe3l
         awptF08QI7YPvPXsF6UnJYYjJLE+2kvvoZEkub45J5d/13XZcHQ2mHRmpqlEbzTelojp
         uYDel76o/jq/cibOAjAM6xHtgqJk4YlFMcjcAFzfIQdEqBhRe9HRVodoGY8s6g1l9W1A
         vc0iP5ojoH4CG2bIqXO4AGIgiQegGtRaNVwAXLMntzbdPMqnD1rWWBplcL5Dd4xX/x5G
         ONvZ0Ylgu4p6I79w5A189XiOfnE/kzufkl0KVmccPpjo3aNbkMIG8r31E53QVJIbFgrO
         9onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724798547; x=1725403347;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zU+cCOEVzUYpPZSGjHMMQGOipQ4KAc/qVm/ssmWSnac=;
        b=SU12SBpkAVQKkKAd3mEkRFTbOILNNcA+U9m/tXkge78MDHozsqVVI06257eaFQ3tbE
         iPHjpgXc4aaO+/5GaS0BiYapcddV5XVWMukN0BJhdj2D2ySIGnSepgN/iZrnvQ50fz/P
         UnhEXUm8fe6KLrB92Xoiu7cE+a0/NpXVwbMSd9y3ED/I4UXHjVB/kIfc3V2R8HMc6rJe
         hZPQJwSw8zefzv8DyG7Rvht3g3LXVAKFbtA833ezn9I3GPLVaxUTeFJ+sYimrCDJgFqc
         yanVtI+g4z4vphOPYK/l5nRa5XgoXxBRqvyDsH9vKaKAZoz8YPwd+cAGvHn9f6ca9ZAi
         SZlg==
X-Forwarded-Encrypted: i=1; AJvYcCXPAJZWNeGDgIn36cX8ps6OFDevJgN6ANsP7L26UcA/U/a3+MK8q0x/dVAFur+TSKbzDV3z6Zx4@vger.kernel.org
X-Gm-Message-State: AOJu0YzeY24W0QVOf7qmHPlDe7yUxU2c3qqzZ2csrqxpw1sgYkvPMUEW
	Hfd9SS6X7nBI6T6rYCVyYRgfmVLeoYVTLEARwCjs05zRbl6wlryPHAonzmgn3A==
X-Google-Smtp-Source: AGHT+IEP+UB0SudkYHpofycuDOH+1agCmjIsIWITIP2WnCvZhfTZDLP3nnwC+IONklLZyP4mOnVHnQ==
X-Received: by 2002:a05:620a:4154:b0:79f:15ca:b782 with SMTP id af79cd13be357-7a68971e374mr1742483285a.35.1724798547036;
        Tue, 27 Aug 2024 15:42:27 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3181a2sm589824685a.2.2024.08.27.15.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 15:42:26 -0700 (PDT)
Date: Tue, 27 Aug 2024 18:42:26 -0400
Message-ID: <e3ff5574d4eda35e6b525bf21ea58394@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: ericsu@linux.microsoft.com, selinux@vger.kernel.org
Cc: Eric Suen <ericsu@linux.microsoft.com>
Subject: Re: [PATCH] selinux: replace kmem_cache_create() with KMEM_CACHE()
References: <20240827174003.52690-1-ericsu@linux.microsoft.com>
In-Reply-To: <20240827174003.52690-1-ericsu@linux.microsoft.com>

On Aug 27, 2024 ericsu@linux.microsoft.com wrote:
> 
> Based on guidance in include/linux/slab.h, replace kmem_cache_create()
> with KMEM_CACHE() for sources under security/selinux, to simply creation
> of SLAB caches.
> 
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> ---
>  security/selinux/avc.c        | 16 ++++------------
>  security/selinux/ss/avtab.c   |  7 ++-----
>  security/selinux/ss/ebitmap.c |  4 +---
>  security/selinux/ss/hashtab.c |  4 +---
>  4 files changed, 8 insertions(+), 23 deletions(-)

Looks good to me, merged into selinux/dev, thanks Eric!

--
paul-moore.com
