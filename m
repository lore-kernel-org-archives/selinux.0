Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5E303A16
	for <selinux@vger.kernel.org>; Tue, 30 Sep 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247310; cv=none; b=UPoUQTcjQLckJL3zJ4rVtO+VT1wXGDK+1RoLueBnw+mKDW47kHhEsL3r/kJ17NOuQwnLp9W9e1onBC9c8y5gdlfA6M9pkkHgz+1yEH/jBAPBykgSqlo1obMEbIxeMo5/Uubmwh1EYTY/JFW3iYzXbJcIm9cQLrSYAVHObdR8m2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247310; c=relaxed/simple;
	bh=5dk+SBRw24GnWlhj/fQ5DeJlOcYn8lBKeo22Opld+4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Io5jh613GJ8prlB6KpnFc0UsMu/wL2zrM0QEHAaKVNYaesWFD57yQcVARha+h3jnvmCQF9rJmqnWESSnvl6tpLaB5IgXkg5RhDxN1z4b8VG0OV+HOKKzcMUqjUKjhx5ZwpRU6SqXaxUeuZcW0sGKbCJakX8ACeXAvTbZ6dkJnIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WZfrcBfM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WZfrcBfM"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3da3b34950so461972166b.3
        for <selinux@vger.kernel.org>; Tue, 30 Sep 2025 08:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759247306; x=1759852106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BBG0QiSMVhr1SLCtRL7FqkE9Hmi4p6uP4U2GxU0hK9c=;
        b=WZfrcBfMs74gZSaxTIAIjQGx7r/uQVg4Aj79uF1mzjCNMKII7emQFYLA4fHh3/WYks
         Tec9YVhNqipnlqFtMEB9rYM/PWILxieIFFKRIStLpWo3IVEhgsvLN/MQyuhgAKPgBker
         UG49cB9lui80OeUYLHF/YYxXmvKZfJ/fcyKKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759247306; x=1759852106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBG0QiSMVhr1SLCtRL7FqkE9Hmi4p6uP4U2GxU0hK9c=;
        b=wpFthWorwZnQouMQqEOYiOlEZXT9QHnm2cojDI7POiZAOJfX9Zwzf3h73N1X6T8PGW
         k8jxlwkTvaeowJBKlNmMbCZk0a+w6ncc7oHNrBDoW6zXYm57ttrSQWp+tux9ehP1Q4Lo
         nQEJkTWAUHaKoNOgel2h+5BArP8pbo4tH57uanosjLQY5cbaPncdKCfxhVW72MYH/jI2
         7Q11tNnruoDTBw7D6/sDBIu4csHFRetYYdY3+Vtd/yT1IzOJOwaJy+OJqszPzGMNRHWJ
         fBLGiSRekNJp2GLGuM+3tAelQUH4wOsGGFCRcpMvpY8QtE5UrdG6sWzecB1URai5qzDO
         4XTw==
X-Gm-Message-State: AOJu0Yx3XnRUYDpSNmWXYHuamMRHnBCAVpucsR7LrOKGRBlFhooNk5eZ
	4BXaBhF1hCT95pv6b+LOyYYKJo9vq2Nku1WrHj6y8iQeuK06Yh6tysYbj92xc/5ZnnoZBPw8Oi0
	z6+Pdb68P4Q==
X-Gm-Gg: ASbGncvBgC0cA8/eVHxnpdHTN/WoECy9oXX/MGf0z06TCeWgMODlFd0kSw8bLtStPQs
	y0WVpCAB5jcFE3rupUx2nssMs0PmY/ahc9+p35KlhJLroQBovoSaD/ur9abuf2F6PLVfJVDs4mh
	UhOL83a5eYnyxdQuDhq2Y6NPqKVay+8zDSMcNyMv3eGKQc2upcqNtoaZx3DNwSvqQxbPdDr7zcK
	RjX71A48B8Z+a8tEu/Ctq530xbjgRLDMSeApvsnBomc5GDPEIiruoORuVJyKtuDNaIVOJsUjI0q
	wIbS5zm1Esbo8HLbaidRrp9weeYh3i7qldtlpI1blcvP6Qzv0zkZaeMCLtMCxAeAdoKGjZu9IwI
	o4hBQbzrnvFKR36AQPENQ6zKKXUE+JHTjpsZv1A/mysxzVMqtgTYZANNIQpDRsvbuhorLy3qh5c
	c3bLzJ8tV2VVtBaFr9ofWc
X-Google-Smtp-Source: AGHT+IGVbv/nhSSYBsIbzOHHBWtk00I0X9hkHZb0A7/+kgZmtqJWsrxmTTKYo/gpirh/cnwareilOQ==
X-Received: by 2002:a17:907:1c12:b0:aff:16eb:8b09 with SMTP id a640c23a62f3a-b46e2626954mr15143766b.5.1759247305916;
        Tue, 30 Sep 2025 08:48:25 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b432788d967sm188348966b.66.2025.09.30.08.48.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 08:48:25 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-636688550c0so1690851a12.2
        for <selinux@vger.kernel.org>; Tue, 30 Sep 2025 08:48:24 -0700 (PDT)
X-Received: by 2002:a17:907:da1:b0:b2d:9286:506d with SMTP id
 a640c23a62f3a-b46e612bed0mr11449766b.38.1759247304449; Tue, 30 Sep 2025
 08:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com>
In-Reply-To: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Sep 2025 08:48:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfeAjTNomdTU3gx308O+k5+3STqwBMSqrM7=D8CyEydQ@mail.gmail.com>
X-Gm-Features: AS18NWDnegEfxl0-IfjBztjUvXWxvekoliLaNtqKY6s9U9XtFR6zj4hxzgx-h1A
Message-ID: <CAHk-=wgfeAjTNomdTU3gx308O+k5+3STqwBMSqrM7=D8CyEydQ@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250926
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 20:07, Paul Moore <paul@paul-moore.com> wrote:
>
> - Remove our use of get_zeroed_page() in sel_read_bool()
>
>   Update sel_read_bool() to use a four byte stack buffer instead of a
>   memory page fetched via get_zeroed_page(), and fix a memory in the
>   process.
>
>   Needless to say we should have done this a long time ago, but it was
>   in a very old chunk of code that "just worked" and I don't think
>   anyone had taken a real look at it in many years.

Lol.

... and when I looked at this, I went "scnprintf for a 4-byte buffer?"

It uses

        len = scnprintf(buffer, sizeof(buffer), "%d %d", ..

and I went "printing two numbers and just four bytes" before I noticed
that they are just booleans and so 'len' always is just 3.

It literally could have done

        char buffer[] = { '0' + !a, ' ', '0' + !!b, 0 };

instead, and I guess a compiler could do that transformation in a perfect world.

But this isn't exactly performance-crticial, so nobody cares.

                Linus
