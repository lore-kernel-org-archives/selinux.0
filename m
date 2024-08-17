Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9E154BE0
	for <selinux@vger.kernel.org>; Sat, 17 Aug 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912004; cv=none; b=JzKIQV22+2O7Hu4EGe0DRn1PQcwhRRrGJNut/2U/Vq0TlSumMscO4mDDSyh5sFTnTldGCfXKNhwjv+S7oWFSU0zqdFNUPKYRJpeMigmxDT/iHYp8mpOZbYGzyx/JSzKsVBIM/ufs5C8YG7wBCqVeiBKHHFwcS8ZHNN12uQLsEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912004; c=relaxed/simple;
	bh=9dkMY8jFzFQfn6EKGYFPV4tiA60zbFODArOLJ5YzeIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbV+smICeRpt9gCWNS3PMN+t1IZAsBohaI1acNeKf5VOlKBvAk7WLmkpEZg/NBz6ycg9InUu7vbef1CwfO1VBxKW3kPUOniM/dG2KNPFXm+7XDS4DvyUL6+keHpH+PrGU7xvilN+UYr8KZuMUeYfiqgMWxmw79+DMdfKmUnwplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wb8Qxq0Q; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wb8Qxq0Q"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so6509235e87.0
        for <selinux@vger.kernel.org>; Sat, 17 Aug 2024 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723912001; x=1724516801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=Wb8Qxq0Q6QlvbrL4LYHVdGcdP1ReqQ6RM71H9fGG7sYMu2jIALrtu4opf2UmjB/bDW
         EttNaZssMQoiZ5rBDaPL3jPPV56ajuJx59Z98XGZWo/EZ8HZEjBVvp1SZxOwQcJnm5HH
         bUJgmTz4wZmxQT05vumNN2OOUSwr6LKhmtKYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723912001; x=1724516801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=ULrbgV2V+lpjRUtH29IYOztlYoH5jMraNXFTHdNJoUEN3ROsL7uZsMFUVpooQoMbQS
         o9wbLsk2mX7EBPLiivU1bm9zNyS5J7Jr89eWrCw8iFK3NCl/TE2dwZ0gI90kGEvM+S60
         mOCQA/UVXTCFcUV4/JsQWMTb3NH/cpxerLfqCe8yreTEd6SMZ0fp2oeXQO54PR7Fn3WU
         cUSHk8t/4o0ELWcCRwQacyemx8qr8fap9IQEu8LeDyeiNQOjRopsez6aLXreicnus8wi
         hcdKraI+4z9f0PGF6Ei1qL+eTZmobwZf6lfuziN6KUNM6rDU3Dj8IkZGc3oUQHvhVGZW
         0DcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6iEATrwgjTnGx9PlhVSLEf9x0Bpu1bRq9hPpbmaLHf/+bk7wkrL+C+vA9c8ttoKvaJBZ70lTZMW5RKmPDUQoVtATP4aHqYQ==
X-Gm-Message-State: AOJu0YywZZLXY8V6zm8hkC2CO2C2Gvhlis92oFlgEtspEkKxEwAXYrB7
	SG8L3GZL1Z6JB9BEgALR+C3Qp38JbMJuP8BIyFgjOyYRnZD+5ZQOwSu3LVV+9aT/X236SBnRunn
	k8XQWMA==
X-Google-Smtp-Source: AGHT+IGz2roxT0qlmwajzuYHQxbNwR/5S2c9SHEL73svLgOCagL1KOgcvlshWL58BGvLDcUdQniBMA==
X-Received: by 2002:a05:6512:118e:b0:52c:76ac:329b with SMTP id 2adb3069b0e04-5331c6bdaeemr4838571e87.35.1723912000372;
        Sat, 17 Aug 2024 09:26:40 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d3adsm413786566b.218.2024.08.17.09.26.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2024 09:26:39 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bed92f638fso502190a12.2
        for <selinux@vger.kernel.org>; Sat, 17 Aug 2024 09:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdD9yiwwqCs99vOFsEAuOlEdB/VvIJ4JRGj7XptVcQGAUsC+GIrwR5/BsUKZOF7ooiBuAErHm4iT9O7+qlEkK63kiiI0c+9w==
X-Received: by 2002:a05:6402:278b:b0:5a1:b6d8:b561 with SMTP id
 4fb4d7f45d1cf-5beca527ec4mr6027442a12.9.1723911998605; Sat, 17 Aug 2024
 09:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817025624.13157-1-laoar.shao@gmail.com> <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
In-Reply-To: <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 17 Aug 2024 09:26:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
To: Alejandro Colomar <alx@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, justinstitt@google.com, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Aug 2024 at 01:48, Alejandro Colomar <alx@kernel.org> wrote:
>
> I would compact the above to:
>
>         len = strlen(s);
>         buf = kmalloc_track_caller(len + 1, gfp);
>         if (buf)
>                 strcpy(mempcpy(buf, s, len), "");

No, we're not doing this kind of horror.

If _FORTIFY_SOURCE has problems with a simple "memcpy and add NUL",
then _FORTIFY_SOURCE needs to be fixed.

We don't replace a "buf[len] = 0" with strcpy(,""). Yes, compilers may
simplify it, but dammit, it's an unreadable incomprehensible mess to
humans, and humans still matter a LOT more.

                Linus
