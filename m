Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759593BE162
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362804; cv=none; b=aOpKY2CUhvHEQ65Bsoa7UTZtsCQ7EJG5dIETwBDyouI4vC6ghLxeNyChWrtJdUVvD17nDICw3K/UF7WBF/vMYFRGXzYywvEiGlqhYXCiGlcD4hdEiDnaPMZ480xeYYR8DNXoaK1DmXLyptdMZ0l9+kYMoB9whxONA63ACjUvb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362804; c=relaxed/simple;
	bh=2rrUFID41YP8NNpGLU7WvBFtW/Yw9N9W70b0LTBz/gE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=u289uVLYSoek7yhemcRa7go6TURd27uc/hnFYLrD0sCdTfm2xoZjnSTmroOEmMz/n/TvE2YwsULDyOn4FcrDq1MR4DAy7Je5yRENasGAk2Lvy5BsFOjo8MO191YMH3nCtow53gGC6t+yFH/M6LsBqZ4gFQrLU+hYXYdcG/5LS+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f7f8NawA; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f7f8NawA"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910c9ff1fso138319285a.2
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790362801; x=1790967601; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hpWJXzKOiV7tQrfFKTC2SYKP+mdoaiE/LfAu+sMZ/dE=;
        b=f7f8NawAS/kCCo1h3oOj5KI42+KWHstDeEuvNDlJXCCuvZj5mjSRAH9/v5FF2aIg5r
         rwWG2vfUtg/cyNr6Q9Hi8rPXgYQUKllMgEPPCtxm/T1UUMdw2P+stzDgmkjBfvCQV0/S
         V2mc6hgrMCM3qbCaB9FoNYDHk6ZLYD+wQM1cJ/jH+EWb8voTdUQT+IfNBVO8XSJTwfyt
         qdDjtShvz3JqNvYOwpDZhLR4L4ig55qIvvc+tYQzxam5D2GLWgC9oGWUlXtaTN8RuSMY
         WOFyGs2PCo359RHBMCFYazN3ajfsAHH6ikjJrdPFnfHYHNfob2b2cNPPNAZ6Atd3b1hF
         94Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362801; x=1790967601;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hpWJXzKOiV7tQrfFKTC2SYKP+mdoaiE/LfAu+sMZ/dE=;
        b=jqARzC0amREJ3sqrs2J/nCR3TKvKFNvn66cntMxX5/NwAtoNlcq8p95G08Xu3Cyibt
         Fe3Hi4mCi3FQiDyhcy7ykgIbM+vAPjUgm9397SZN7fhoQcfyODEpJpbcUvVxf/HOSSy4
         cdFW0PpdndzGq28aHKbJHh3IPdFumJ1gjLeAB0brhEJOleK3xjnMvA9ynWz1KgrT8yh6
         tN19sZl62k2ipcZ/Bo5DcgPvbkG+VwgAKtUxcsgXnLVIFMpnuHevVlrF4rs3jcvKCoRn
         diCkxTpTOEI9hkwWCw87srHoN03IJKToL9L+Wo0v/5wEL7+GqDYKDVbmqeG7BqEamv6u
         iI2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwk+iE0p8hzCJHJyw+A0VyTP1t1FWp/ycJwocxX05zcKG9xjHX0ToD+pShtCGBab2HuuGuuvUgv@vger.kernel.org
X-Gm-Message-State: AFuF++mRCyPUQ0gvTcNRU+lIE3VKwbYv8Q5wOmHoctEZkp5Uzu7tPtsm
	Zpbau4TkkIep7ayTMAMpKvqhPKECojI2cTvT0o4gewyfHVUb4C4xqFUUFf9YlrSuc2c31bcvaBK
	2rsBYpQ==
X-Gm-Gg: AYBFou1LAzm+nC/h8xAlu6IAchLMf3vtE11Y2/pZPdP/INs+EZznRYvoZhCzfduRJuB
	oC9SLyC9ufi0JRTDf9JjiFQ9oCpRT4ntbabOR7jxiROTcSDApqaSrOrX/+QRb/sQE4aO7NqWBIf
	gcgQ2fPutsPlwZbwu3oqPF5KsNyPzHFamoJslGBh8NJxFbZWSCdejU+8/MfVLZb+NGGqUiTzdEU
	qlCqR/q8qWWfFFQmcql0XxPbeF/yM4nWpu4sowCUIWA5NiPgFNKCpcs5UhIcOpkQuenN4rVJopf
	29S4AOWTOcGLfkSCSu1ebM505WyUzucpcYuTE/hNc4l+tgFvxA3ZMCU+j+OEiWlSJkZ54Ahb1g5
	eLrnp/IqlZa2EcpXp4nUL5buCuvdkuER4ClZo44TH15DgjMsPnkerxC+AXZy38ECFFcPzzJxAur
	ZrOLMweIbiIhloX2A8B3IBhR9pEOvV8IIlOHsEigcrXAdb+WI0yMxjbCm5FZCewn8TkpTfyor/a
	Wpj6Xk/6iuo5vkHdpl+ixUUloatcNKMKa31S6aZg+ysllhkEXBaqcIxHdJciHD5PdjBjM3398g=
X-Received: by 2002:a05:620a:4107:b0:939:feee:630 with SMTP id af79cd13be357-93c43cd7b38mr627469385a.30.1790362801103;
        Fri, 25 Sep 2026 12:00:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c4499c06csm246728385a.46.2026.09.25.11.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:59:59 -0700 (PDT)
Date: Fri, 25 Sep 2026 14:59:59 -0400
Message-ID: <290d5eb8ce5b1c81c971703773f88212@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260924_1657/pstg-lib:20260924_1656/pstg-pwork:20260924_1657
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnacek@gmail.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] selinux: fix data race on AVC latest_notif
References: <20260923101323.2996793-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260923101323.2996793-1-cgoettsche@seltendoof.de>

On Sep 23, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> avc_policy_seqno() reads latest_notif without holding notif_lock, while
> avc_latest_notif_update() can update it under that lock. KCSAN reports
> these concurrent accesses during policy boolean updates and permission
> checks.
> 
> Use READ_ONCE() for the lockless read and WRITE_ONCE() for the update.
> The spinlock continues to serialize the comparison and update against
> other writers. Reads made while holding notif_lock cannot race with a
> writer and can remain plain accesses.
> 
> This marks both sides of the intentional concurrent access and constrains
> compiler transformations, without suppressing checking with data_race().
> 
> Fixes: 788e7dd4c22e ("SELinux: Improve read/write performance")
> Reported-by: syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a7f7cb0737bd91aa698c
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> Changes in v2:
> - mark the write as well
> - drop data_race()
> - i am not that familiar with the kernel concurrency model, so an AI
>   claimed an RCU read-side critical section would not exclude an
>   in-place update of this scalar
> v1: https://lore.kernel.org/all/20260202134822.67476-1-cgoettsche@seltendoof.de/T/
>  security/selinux/avc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Merged into selinux/stable-7.3 with a stable tag, I'll send this up to
Linus early next week after it has had some time in linux-next.

Thanks!

--
paul-moore.com
