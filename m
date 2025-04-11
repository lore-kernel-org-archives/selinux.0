Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312D28152A
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403379; cv=none; b=iVbLtlmPKw4yK4XV+9/+TVENBZ2tugMf+dY9J/UJBG4c08Y/gcDaA8k4aBp+DjtWwFk3z7s0TfquG5dY3mMaErosmWouyc1/hS/5d7MhwufRT45HSeKorKO0osvASVB9BOoKCA8DNvfd7KxaxJJqYr3EBCwpbgD+DstboUgZYbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403379; c=relaxed/simple;
	bh=PLl9qmt/fzbjwndzJldvUlU3AVSqPKp1HHLdDNYCu9s=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ma/AIL4Pkv2EjXUaTmQ5PzSpgKl4WN8+yhq9yjJ8znydrkywDDQxniShO1YvPmPVLBrRoaIciIuTxHcwLgiqEJ1yImINCthBVk6Jgztr092nk50N4ewxj0t9QXPivR0TNw5I5Prfeb//AUtPtcpS733JoLDwOtvXZVSkL11C6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PWk1Glzl; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PWk1Glzl"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c597760323so234348285a.3
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 13:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744403376; x=1745008176; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktRVy/kIheAqpbf8tUSC8ehC31QAJCePsk0t6WKxomI=;
        b=PWk1GlzlbAObnirKuJ7i+Y0A0IHBshXp3bAJMN+BXP+lWjDB3+W7AXLpxbgEeP3hMU
         3vE9TMrRrL7a4z0/8YAFHYS0FSJQB0AZhu4Huzfd3SWnuAxEcYsFbc4ke0jb33jog4Yc
         /6nwHJfVXClhVKHMEkxyV8cRk+zejfLaQV3jrsZfsrB3U5apoKT1eu6nDmmj8Unuztco
         wV+0NkXJsc3xI6Xy4Out51HLha1tNKeJBkCBuhHzl8TxAioKaum/QUgLy2Ch95Sle2kC
         IZ2vkzkRP/EALGjCZCcg0thlZ4xjcdHEDJc1aTD3G1HhrDf4cWLP9TksQSRx76Zgp0XI
         45fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744403376; x=1745008176;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ktRVy/kIheAqpbf8tUSC8ehC31QAJCePsk0t6WKxomI=;
        b=hoepj1E+ARbMsnnKjtvZK0NRksJ1z8Iei/aijei4rQ7e3tGIN3Pv3GGJZIyohDs0bW
         w6X1KWn3pIubuzAyTFwNBRo7BWNdjHbUuKBL0e1mFOxUqLTbCo/G9RFZi2IXvSWIVfJt
         SkNo0nb6uOkVlfhqp8Cp3ywj3mQzWk5vXOzNLb/bOZleWrLXjwRJ6HsjRnS+4RqhErjL
         KtoR3OUCVUXHVkC3607ryFyz+Hi/dMhDvzWngz/iWe1ShpJ0UWVcaJm0TgrVNSZ0Lh2S
         iOj7hKDu+mnIqvol7sJfY271H+LfABjcsoVQreOwv8oO9lhZIQpTvbyUBNDvAZw1aMNQ
         A6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3KOoVS9sIrz/aVOUO3/EggSRZgiqwmSlDoDvogemYwBcZ1B/aMMn4eIFHjSzoqbJVlSFo9j8R@vger.kernel.org
X-Gm-Message-State: AOJu0YwMGYXBsGPapw2l359nVndUQ28oA6jdnR+ObqKViARHhw3HML5b
	ICvRqno2XjVqvhW8oj8IsCwYqU1Cx9wZLInl+VpgeGbeR40cTqjMFyXyNK+m3g==
X-Gm-Gg: ASbGncsz5F1DF89Nb83fcf1sfaiLbLEJQA/3nH5nRLVFQG4Wd2+CMdcprjGZ9HD0c9p
	udMprOIps2zb1W+AcXbLZGejzvrojU7vwV2vnEuIOc2vldh1Fs5w+ukeDLI3ElAkBk8paDdVuqZ
	ZhRYsAW0uqyuyWljJeeep793WniicsjsqvvU5/7RcqpdKEY8Pa+DBuZ03HUxQ3j6okBIXn/z3No
	1btr+Cw52elelNJeM7Ngz4vx/qzgkgxNIHigpV0liSeK8ESkWwZl9O47CUt/r+AGRy2EisetYRe
	AmndgK8wk77zYL3OKP6gXziJaSH1XogikmkWSQhgpGfLhsHUit7rWwpNQQNKj1zpLlT+hYZn1nL
	TKydwx+E9z8NC2cJdo0F2
X-Google-Smtp-Source: AGHT+IHrI1EUrUVygltkuHfnRucDiC0qqict77jWL5RBb/PkRNG9F9tnOg0M8ZX6T5ukmsj9PaclnQ==
X-Received: by 2002:a05:620a:1792:b0:7c5:a55b:fa6c with SMTP id af79cd13be357-7c7af1f3a65mr569107785a.38.1744403376436;
        Fri, 11 Apr 2025 13:29:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a89514f7sm309302285a.25.2025.04.11.13.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:29:36 -0700 (PDT)
Date: Fri, 11 Apr 2025 16:29:35 -0400
Message-ID: <b2a47590f8fea264863d0cef0a9c426d@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250411_1406/pstg-lib:20250411_1552/pstg-pwork:20250411_1406
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/6] selinux: add likely hints for fast paths
References: <20250318083422.21489-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250318083422.21489-2-cgoettsche@seltendoof.de>

On Mar 18, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> In the network hashtable lookup code add likely() compiler hints in the
> fast path, like already done in sel_netif_sid().
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ibpkey.c  | 2 +-
>  security/selinux/netnode.c | 2 +-
>  security/selinux/netport.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
