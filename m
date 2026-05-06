Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9079417A309
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778110992; cv=none; b=pozk/FPDMC0Gx4iDGoYVi8sv/oDWFVh727XZcmToUnb1LCZku58dA5IPs7cHnwd320HX4cU2uBcLST96xC/Eap3wZDXAP5GubYN2jZFveKvj/BkR7Mwt41uhwH9lESh3JGdCcbTAm9YhM0nm6ahMeNYENvyc6Rn6uX5eIxhuBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778110992; c=relaxed/simple;
	bh=oZeuB7KL3zxAy0hmmydSyNOyTpvCA0EJ5yCTrgACFiw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Vhjg3Tz3tXmIrOKZvrH+C0HqCagdEezudbkyFjnWoG5TYkYoqJsIfYhFsiY6KDd9lr/H+oqJaVGdbw7OQOcNrmkpyfcEwpXz9DYSDXolc8dShPQt9WFYdgkPEAK26n4iTi3HK2UqXkhWDOkKck3DqaJUjGKFR4NtCFHyZCB8wjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ton4jxpI; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ton4jxpI"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b6ea7716bfso2664846d6.0
        for <selinux@vger.kernel.org>; Wed, 06 May 2026 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778110990; x=1778715790; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcoKkFtwd0iz1211ZD1T22G5ji+Vy50EaZ+dpwZh4m8=;
        b=Ton4jxpIAnalznL68qUYp56abwnTSeBgk2RF+7LrgmYFwmDnSJU0iAxsfi2Uj7TDj/
         bVFG1+2mlmsXU5r7PVcX6qAD12qU8XhfyaaBhux5qGNgTmRlOzJoswpc1GNjx6yrd2M3
         objXM7BsgVLx5dPt3LvPLJn9LzYNN9cOym4ug3Kq3OiTieBNhimP9DD4cWqwr2khAnha
         pSkHs1niEXlQmKwKmqJp9drwC5VEs+ETVr8Gb8jGkMBChspCBmVTTWmQbjTMy548Y4np
         HS/iCyNBHElh375o4o3bwRnsJMqs8QeSM1H8bIo0beq9V6EF+g9LE1TFTcXjNMTtDrQj
         ssFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778110990; x=1778715790;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcoKkFtwd0iz1211ZD1T22G5ji+Vy50EaZ+dpwZh4m8=;
        b=YYjhXgU1tQZg/rSbb0XptN6V4nKHNZZfikT3xzvKYpfvZcMAh5qBJ5GivOBLHeWlYX
         /Hx64GyxjSYPMrwsSF9aBrz5kkzWCVeJlmqwuTHwE238qMz4mpyO8qw2exT4MCFv2sg6
         QZzy2BYaDUSw1ADvQIHYoYvyhw3qzRMOQ0B8PSB/pOV0/eCWrRg2Ey56pLzJUy4pldBV
         TWch9KhdFOJJle2EMTxHnX6lBZRAG1nneXjMo6vjiRAR8RSIj/JQXh5MgZqq1tGXKT51
         e/WZi6k5Q4+e0+Vd8kWo6Xkugos/VXoHDTE79WwtPjvYGNvokjfUorKu8JkisMnvdhTx
         u0Lg==
X-Forwarded-Encrypted: i=1; AFNElJ/aCxf9dQ/GHWen7XuwGxSlh98sCskHWLPAnhLMBLMJaGIpg9x7Pn7qqG/iAKL+LaF8Yx/OTbAV@vger.kernel.org
X-Gm-Message-State: AOJu0YwiGjVXAI+QH+nRtQj+c0+kWE2eqechaEuH4o2XUw3pi1OswT28
	6tOLuXTfh6y+v615EYNl5cKPzMVPQsOvTrCtN2BkRUh1dk5A69GXon9vntsekbKm3g==
X-Gm-Gg: AeBDiev2a5Z5V0PFm2NnwGp4ZH2xNY820D/eZ3yLh+ji603aziBvrqDUYGTnxDToP6m
	QbG0on3L+tKvmm8m6V5sGWW7jnMcMZ3YClOsrR2wtbZZZp4IBH9NAv5n/CicFdLT/EpX1Bo/a87
	pToUNDO8qzXBatLkFLWObjBNL1xU9YWjumKFveRU57kzFrg9bPb3Gw6pZYgvUv9okUyobUibtfG
	+88JQCGMJwmUHU7vsfqjNnzk6gq+YxXiBDySlXfAhi0A7thndGnUBdQDtWb7LlcdB8/n0dayyX1
	AOrd9yuErHwq5JLafdCO4Yu9wSzJd38R+GQWfVVYMTggu/g5SKQ4cm+S6F2QRT9p2I4vWsEURKD
	WBjvGy8DN3Wx4qTrmkZJI8CUvHFtYUEgE+zqNDer+GZz3+Qr3/l8Vz4P1v8FO8l74RseuPyT6Ka
	JlYRntCwaYmxXdbV7iocVHKPP8DtHQ0qdm0cFTiNRqYpmHb86TnZwoH07ixN1niali36u//7rEg
	OA+yts=
X-Received: by 2002:ad4:5d44:0:b0:8ac:b137:c4ec with SMTP id 6a1803df08f44-8bc42492c98mr79227136d6.5.1778110990521;
        Wed, 06 May 2026 16:43:10 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1d953sm216990586d6.3.2026.05.06.16.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 16:43:09 -0700 (PDT)
Date: Wed, 06 May 2026 19:43:09 -0400
Message-ID: <c374e00a48c66581f55b19e88e149bb1@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260506_1600/pstg-lib:20260506_1556/pstg-pwork:20260506_1600
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, Eric Suen <ericsu@linux.microsoft.com>, Canfeng Guo <guocanfeng@uniontech.com>
Subject: Re: [PATCH v3 7/14] selinux: check type attr map overflows
References: <20250511173055.406906-7-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-7-cgoettsche@seltendoof.de>

On May 11, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Validate that no types with an invalid too high ID are present in the
> attribute map.  Gaps are still not checked.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3: squash with previous patch ("selinux: introduce
>     ebitmap_highest_set_bit()")
> ---
>  security/selinux/ss/ebitmap.c  | 27 +++++++++++++++++++++++++++
>  security/selinux/ss/ebitmap.h  |  1 +
>  security/selinux/ss/policydb.c |  5 +++++
>  3 files changed, 33 insertions(+)

I changed the name to ebitmap_get_highest_set_bit(), but otherwise this
looks good to me, merged to selinux/dev, thanks.

--
paul-moore.com
