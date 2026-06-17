Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD03EBF20
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697304; cv=none; b=Uek77XCKGwp30sfFPvMp4UIB/YAmJGSKfojeCYHFXlPg5OdP2i5tjBoQZAQq2IfEy09ZGl+22XT7YBh8mTb9WDilxVHHi0ptaUfS7e5kxaUG9SRLJWdu/dZ2lTNhZ0Zi2V7ds5g+XXBfIMxQwfNw6TAM5DSrlKz3APMOFlOBB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697304; c=relaxed/simple;
	bh=mv8ykqF0mqU1tvvIiC41TlZ25RAXE0n36/mXsAGuwq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8iczhVNoAwftqRvVaPise47N5YaHo7JQM2mm7pLx/cSyq8D2fRsDtKUVXsR6a6NmIDaR4yoRqeIpvYatoZqZ3k3AN32UY7akKjxd/ppSn2Q6JKmYCmyCxpao/y8NOzDa6PEEkMO9wSxkyLWb66SYOvrraQXtlcehB5Qvx+t0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hd/8CNdv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hd/8CNdv"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69532288224so2144691a12.0
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 04:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1781697301; x=1782302101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RMazHyxAaWShCblmA4ypYbvu76XmyiurG8invBtAkKM=;
        b=hd/8CNdv7EHMw1EUOPKRwgbrtWJlXCU3Z0EC0pieamuD1E3x7z/v61vuHY76JX4k3Z
         DH1KDAiUTgolsDZaOyRrzGM1IdBcxcr1GtwmCTyi+eKBSMl46QqaO66k7rTA6Iy89hwF
         1dpgs0bEvp9IcrrwHpR445B5xzAjJO3B5B73g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697301; x=1782302101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMazHyxAaWShCblmA4ypYbvu76XmyiurG8invBtAkKM=;
        b=nhs5U3E3t43uG5TGTSMFDRB/F3EN+yAlk9jGiGDhQrvL6/fAiFDgSjLhMRpgF9Nu4q
         B+AtERYd1NW7VkqWVTf3WBVn18FChaWITK7rs3XfutxpIuGZgXulwlICCoHqIXx7509G
         uShB3Km2M9z01w55cfZtGRnxbjs/OO8lJg8KTH5y3W9vTQ7wMb9pI6cjpk22tRuzKlsQ
         BNNJCGEnS27pUVskr7c/YBsJqnQcOiryuLL1f07MvG6VmOgW2auF3PCV0Rnr6i5hM8Pa
         1EZHB/V/Jn3ibibgUSMXVgQdfgSI8TmO2F/Eb9jUBL04FtiVhEb3aVwexwsuhh+75XE0
         XFgA==
X-Gm-Message-State: AOJu0YyUXJqH3HUk3EcGOkx2nVpZev3CcH+n/cp0xVc1OilIovdsoMNF
	3QlPMw6o9MoyKEsHxOlaKO1qxW1pN62slJJC4yj7p3jj6xSBMRNuTAOhf2kD5DA9YAeWovOgst1
	Oc6VSlCl7ig==
X-Gm-Gg: AfdE7ck537SNKUGOUGo3LKLfpzgqDVp672y/k7R3MQXr3zQQcJ8Khg5FvcI2uO8KVBs
	GQxc93BPTWt9m7RxOamVn2uUkiIdUzEeUZyZCllTJ3J+VucVat1TIkIGHHdRPRALUumsp7knrCR
	7PPDIvr+UWHj88WKTYvJRcjZ5Ae9gPyDx08CEYEN3L2ICZe8zhxq7f9W3W8seYS0YK6CHGS7qWu
	tssWEgqSY6R2zfHnCPzZXfh13UUqK1zzxyhZ1qplc5mw/Uh3j4SVoMXf+GgEVOVhvYdRDtZF6YM
	SpiCF883dXqFRa2ca0VoHqnEx087FbaivA07z4yKTFZe4mPUw+8zmvRlRNbWP78f4E1lim/8qO+
	t/dBvFFgNkjf+05Iyu0fojeMEnhPQtpL1+91TCw9/guQ4nBV4W10t6UBgaqwuwkL3pLTevXBu8R
	RGFQ2Ij/rtQXauLSNg3+WM76lQXAcWGrCxMmeq7vsXEBrfogA9702E2qYXX6SJXw==
X-Received: by 2002:a05:6402:5254:b0:691:af08:a9fd with SMTP id 4fb4d7f45d1cf-6954769c65amr2034020a12.11.1781697300919;
        Wed, 17 Jun 2026 04:55:00 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937938ab02sm6173384a12.17.2026.06.17.04.55.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 04:55:00 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bec2ddee9bbso1124741566b.3
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 04:55:00 -0700 (PDT)
X-Received: by 2002:a17:907:75d1:b0:bf1:b3cf:3db with SMTP id
 a640c23a62f3a-c05d1f42003mr125365766b.7.1781697299891; Wed, 17 Jun 2026
 04:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <577e6fb29cf0b9c335748aa5fa026275@paul-moore.com>
In-Reply-To: <577e6fb29cf0b9c335748aa5fa026275@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jun 2026 12:54:44 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjBF1ZXNRRqnA+KDFzqxZaXPgmDc8=Ly3+RdxUXWuve9Q@mail.gmail.com>
X-Gm-Features: AVVi8CdvOdxJvH7A_0DHzsgSpHGK2ub8f7SzoeDFn_m4WAIuYfwVRS5xnQfNhAg
Message-ID: <CAHk-=wjBF1ZXNRRqnA+KDFzqxZaXPgmDc8=Ly3+RdxUXWuve9Q@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20260615
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jun 2026 at 03:55, Paul Moore <paul@paul-moore.com> wrote:
>
> - Avoid nontransitive comparisons comparisons in our sorting code
>
> Done to prevent unexpected sorting results due to overflow.  Qualys
> documented a similar issue with glibc:
> https://www.qualys.com/2024/01/30/qsort.txt

So this is clearly worth fixing in the selinux code regardless, but
did anybody check whether our sorting routines in lib/sort.c actually
have any overflow issues with non-transitive comparison functions?

Strange sort order may be confusing but tends to be largely harmless
(the confusion might then obviously cause other issues)

 The whole "confuses the sort function enough to result in bad
accesses" might be worth fixing in lib/sort.c if somebody looked into
it...

                 Linus
