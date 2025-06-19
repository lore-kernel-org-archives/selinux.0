Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B66F21FF3B
	for <selinux@vger.kernel.org>; Thu, 19 Jun 2025 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750368299; cv=none; b=TH8JJ66dVgVz3fu8J3ko0AwfTIRWLezE9emvPkrvf2fXIeOkcfnBE2AzbbWnP/OpKzLYGvNPpWh85Mf/JjhUoEJOuMSLs0M8R5q1t3yChVlxUB9TJKRH8pNXcOE3vIFSfXkDB/JkEpbt1R5p6Ylrd420wccADEUDlcpEJACSYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750368299; c=relaxed/simple;
	bh=z//LwiVtRs6AC4JPZRiu3+IGY8nJaB0pxdC4y3o00l8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=E/PEVYQFycv5/V/XZPM6zj/JYdiis9NtuXtSozlFuOj6eLCFgw7o3TPil/neVwaT3Dp/8QDuXYL5sKHdqKpYWaDjvND7WmU6qA01ac2IHkByhib8monh6W2MstK/6n3g6SZGN+Pmh1j2mg0ptTFyVWOUqkmk5wFsmv4LIEgZeQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nabnu1IR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nabnu1IR"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so12396056d6.1
        for <selinux@vger.kernel.org>; Thu, 19 Jun 2025 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750368297; x=1750973097; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUy1QgZz130ReVsfFqR/tESg8IrFsMkryxS0CVlucMA=;
        b=Nabnu1IRPvNBwd6zLXIh5poKUl7DbZm2qpo08tHiMtpKrjh6cGwI03tCPyIG3ZnqD0
         w80odoZfEnPpXHCpvnwaI+vaOScp2UE71bU8lGnt1v4VTWYOnE5/QmTRo26u+hPxn40F
         J8bg6m7Rt1Nm/sq3zWC0NCdRtN8xlZ/yg91KFAbMLwvhYKzvKzyZjrAh2F6qp82FPjrx
         mwjnUp8N8l2mbu7gQOk/OhB0VH2pLSNwANrrPUcbj7QrO3p+3ehO3NwmIlQrzeRL91hz
         HTQ4Ucjre7ArN+EZqgFvVWhRwbdmHkQmKLihl6qDSwwMCknUkFaB6oSOa5fLvhJmOUId
         Id2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750368297; x=1750973097;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tUy1QgZz130ReVsfFqR/tESg8IrFsMkryxS0CVlucMA=;
        b=OR+KkqAsjGCKVjRVgGs4d6lWw5sQcDzA1J4TUnJX+Rt2bIYnT+9KLbR2D7BfPUoYXx
         rERA402v+m4wJo0avcni+UoRpob86NewOkVeNUUFssPdfgiqKKUR68Zy4jO/4ap1WWFp
         tMfQTvEw4eSijORPzKJNSPTORItx0g/0IbJp9te6WBG1Vg9s+CNeEsmZTGsvZ16RkB+Z
         nrbEtQs+msZHsH6FPUs2vpxMUE+Lr+73e7htdVkg5OkalF3QBspXn2UFv32paReEus/i
         fTWr5lIo5fElHbhd7ZLqaDnBaitP2P+2o5e1e0Yq9Bvums5GzC1Iof63+4pPluNRUmmd
         nV0w==
X-Gm-Message-State: AOJu0YwIrCw2FobVlVWlsQIVvRVnAMxaUvnpaL0x2PKjwdGf/VAXXWTH
	ypb+fNhVBh/w9EcLE2Z61sfZLevsORPE05YdzGgKo+mIMYvxMfFnyH6uzq493YjP22lmY+fzpdd
	24XY=
X-Gm-Gg: ASbGnctsFySOU7w1y+T+v07Gceq3mO6N045kos33KUrrWi/RrdoNu2PgqWsPzLoVwgo
	mH1fOYX6UsbKeo+SNHvmTr/EDbwKG+BkmVf9ltux+DxQj52mJwfmg67bg83BzISEK2llyAV7TV2
	4/t4xogXV6ifqUOSyfjeS8DuviscU0Sl33NXetLyeNb1vKfA7CJFUhJqpF5BWuKEPrMVBoCvmrN
	8fKpXF9ZC5iE74VP5emjxzLu5Ux611WI9lFde26d8Jxazu48g5CYL8IqoN/LUNulSchmC8NJILQ
	/u5bpOzO5PwFM8WFZx6JlMsM4Eyc3igKHPY+SpBcFwgNTjBPuR86hqlJva7JYnzjkhxU0XhjxXQ
	lqDMTN9FB38Xa/2fyy6Ew/vLOUpl/wrM=
X-Google-Smtp-Source: AGHT+IH8a5Xw51d7QmjndJY6MIY2z3saeog5gZgWnkGlub1aelX/sEPl3COOX6leySTGlkPGgLwrhg==
X-Received: by 2002:a05:6214:cc1:b0:6f8:997d:fc84 with SMTP id 6a1803df08f44-6fd0a4ceea2mr13603136d6.19.1750368297395;
        Thu, 19 Jun 2025 14:24:57 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fd093de9b9sm4493326d6.1.2025.06.19.14.24.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 14:24:57 -0700 (PDT)
Date: Thu, 19 Jun 2025 17:24:56 -0400
Message-ID: <de574241d5ea2ccaf7795e5e0d1ef6b2@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250619_1608/pstg-lib:20250618_2237/pstg-pwork:20250619_1608
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: add __GFP_NOWARN to hashtab_init() allocations
References: <20250618161732.140904-2-paul@paul-moore.com>
In-Reply-To: <20250618161732.140904-2-paul@paul-moore.com>

On Jun 18, 2025 Paul Moore <paul@paul-moore.com> wrote:
> 
> As reported by syzbot, hashtab_init() can be affected by abnormally
> large policy loads which would cause the kernel's allocator to emit
> a warning in some configurations.  Since the SELinux hashtab_init()
> code handles the case where the allocation fails, due to a large
> request or some other reason, we can safely add the __GFP_NOWARN flag
> to squelch these abnormally large allocation warnings.
> 
> Reported-by: syzbot+bc2c99c2929c3d219fb3@syzkaller.appspotmail.com
> Tested-by: syzbot+bc2c99c2929c3d219fb3@syzkaller.appspotmail.com
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ss/hashtab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Merged into selinux/dev, thanks me.

--
paul-moore.com
