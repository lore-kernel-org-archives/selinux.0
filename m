Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6738945A
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779133862; cv=pass; b=Og8mE1lCwoWOf+uWAbczz790Cr5GkH4zbI9Cxt4Mn3kANks29gedABtUI8bFdi7yccFBXW9ppWqijWXMNi0AK0c4IvrKnh7c2wmdS0ZWH3FaJcqcZ+MKAdeOTR70ibNoSIUzNLDAx/LxBIEMHQhCbgXBX0+vJ9O/iFcy2bTSgzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779133862; c=relaxed/simple;
	bh=h+oztDPDav2rFJ44SOivjviPkgs/WpAqybSUtMqKhKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhNaFKTYLroYin6NIC7Dt4cF0RlbVMk5yCoy5O7FU2gy6/IEClfUMWdN2PuX1MxDobya+GX/upbFH4j8NLKy/3p2yo9rXHT/JHktM8t6TUARQ2b83GURb72tOP5+CMCYupxelLhbTtwcfAjE/EdN9bdGlpHA7R6+YMkNJC3bozY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgk3E60R; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgk3E60R"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-369576666d5so1229090a91.0
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779133861; cv=none;
        d=google.com; s=arc-20240605;
        b=JA8ueqFo35/3RmeHw2+GkHcz+vrF9QWHwqQ7RcZYynQ0F6OrbtalWOYriqgIyOOk3w
         tcvSv5q7wOvhG+oILXN4zy/DKx3+Xxnl2OFnbBWZbcDL8AOmYhZ0a9GU7ra7aV/5X67B
         L6fArT6f34gSHvmoKxKtBOWvWQsw7A+HfWtCzZmRNvm60bXFvJ11gWVgrVbupAJz/+Pq
         HjVtmNE7gj2AXWvl9pyjK6cbl/xcdGEiwYWHlmJZj8/5ohGWyZTX3cI+4lNGs1iUqTcx
         8n1yiQW8cjI6ol6FOv5KtuTSy6qkla36H9Xx0NmNrcEMbWQBEBxDs6SYz+Lh+SXJlNnW
         ZwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BKHRC1RDENTB2FQ2txKqyeFXgavhn1lu4zpM3elzhB8=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=QkqCEd57zD60/0voiHxQi98M3B1P5C357s4jsAxBpEko7gDNz7KfHvC9RuQZ9/89Dn
         baPCD5/jyuZlpEOovrxTCLbeDNkXJDAMh3e6W9oEa/azW9K9aDTP8FpAqZsx9xUVzxcs
         /0D0/pYWT+1sEMqoLxL4n44eyQsfUM7BBnCVhxpzsz6H5Xk2k4cTSbksVxJct5hzCWND
         4E8jrj16CVUILRuCI1M78/k0XHZTozkng67vNhpDeTnE7Mw5dvVGkJyk2XO9iu0yTBGi
         T6YfQ78R+f58xHQQIDLpTnPAIQdiU500kRrYebZvxEWFNefTWkwdzg93Ej4pXT1L2k1+
         MFbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779133861; x=1779738661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKHRC1RDENTB2FQ2txKqyeFXgavhn1lu4zpM3elzhB8=;
        b=sgk3E60RuVWL5DzU8m9o9Kx4TIk7T+mgpNXdtPqQaAa82Cg2LO6sij+z6AJLiP7IdS
         3y9ievgbev56Ajf6W45wtGKVXRFfIqNEUo7EhR7pA1CFWe3by6QXJcmwlolcLsrz/8or
         t6fFmlOK0T9axVAJfhFYQXrUY2W9xFA3Ja2PmkoedOUnnyduL2jyYW0n4L8TFStaAhpw
         tC634T9MRnlW4leElUmCMDTRasYwqv/CcDwNfj5XeB88og2c9TnrF0d5X2TCDppq1NU6
         j8Dl+A8382/Web6qK51alohtJSPwMgdABE8kL32IyQXdmj+uIXofL5eYoVW1vG40FF4o
         iBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779133861; x=1779738661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BKHRC1RDENTB2FQ2txKqyeFXgavhn1lu4zpM3elzhB8=;
        b=cl5O0pJxD8yUsuz0s0/onzUFfmcDjmg5PdsjpvpRcwQ5J0dnu/a8lumC8yj1BEZ4/a
         EsDC6196oOYgz63GOxCeKWkXLxOnjbJlp1oczeUY0f84dpY3EpcL8dgL1RcvruYGGnYm
         n5Kitt+0820pnoEcqtshsvz/Wlz24YYe+AWewD+mLOdKNxPfPXaYu368i5GQ4oX9WnQA
         CWesaSQ6dY7Mlqn4sRybUwuFjYqomNEdnJZqOKgXvWPz9CkmdLbxm/ABRONuTCaE8Xwk
         D+HIFaCsH5AAWTn2ex8uDc26ZhAqtG2mkonfMOdLQmTeDm0/H1WSsMcdasU6AwEFyWnK
         lXxQ==
X-Gm-Message-State: AOJu0YzayHtm7sFClcYdYRumlbsWpTDtnMDE3Okq7huotNEg22Qd140Q
	SmwZNilzO/JXdkMkR7PxvntkaF8QuxcReiZwS29UMPpNHWdh1Nsr9g810QBRQxocxo0aZxvhKb+
	1UbAG2DPDUNZAqUgaOhqM8V3K+MRO9pKOiw==
X-Gm-Gg: Acq92OG7xQ8UUG0mOH5iJCfisWOTDlpc8Cvw21VS7VPFWHY6jaQthRnBozFLeSQohnh
	x2T0mi8eLikB2iyTsRnStxKStoMhAm+pgZKFX9lFu+7gpLvLg1JrqHRS4tB0jkuodclsYgg8eZP
	BHlMqZ7kgf+4LoJWBlx3zokUTQuoCIDRjkqSZ3WbwAbkJ5uw7MWY2AObmx4Fj10Lfh67VjMTG+P
	vJIhu4rEt1ETMh+6mWLEY8y5dd6kjrFR3P6AZ6MrtNaYPf20z/zTag7XlyooMCNYirl8R1llqMB
	qhrAh94=
X-Received: by 2002:a17:90b:134b:b0:368:78da:803 with SMTP id
 98e67ed59e1d1-36951a01748mr15770279a91.12.1779133860754; Mon, 18 May 2026
 12:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518124656.353403-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260518124656.353403-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 15:50:49 -0400
X-Gm-Features: AVHnY4JefKmzUo5tgUiHQbGCYRtqG26BF7M6so9HXQIf3C1vuiL_OqvvrutXriA
Message-ID: <CAEjxPJ4=qfwCpW+4PgKB6ndPTT=b8eA=MhHsnYCtPKhcx0UxFw@mail.gmail.com>
Subject: Re: [PATCH v2] sandbox/seunshare: rewrite to pin directories before use
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 8:49=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> To fully eliminate TOCTOU issues in seunshare, we need to pin the
> directories and pass them via /proc/self/fd/N to mount(2).
> This is complicated further by the unsharing of the mount namespace
> in the child process and the need to remount in order to apply
> nosuid/nodev/noexec flags. Do the best we can with the legacy
> mount(2) API for compatibility on old kernels and revisit if/when
> we make kernels with the new mount API the minimum required for
> SELinux userspace.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 restores the new file mode for the O_CREAT openat() call in
> seunshare_mount_file().
>
>  sandbox/seunshare.c | 406 ++++++++++++++++++++++++++------------------
>  1 file changed, 241 insertions(+), 165 deletions(-)

Merged.
