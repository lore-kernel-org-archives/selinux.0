Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792513960;
	b=XSLSioUgQBVRRUhA02wxnKWIw8xrvgkndw/MiKcfBf1l/M7LaFFZT6ryDoBAfC+XhGZ+
	 Q66ePabHKWeM6+Yrb2XBGfNKCwAvXU5S/NBS4WGreUk6IeiYqGQ8s2p4al9HDp/mDAvfQ
	 rQBngjaE7F8y64VkOKhcbQcaN6HlfUOcfmy3pXk3N1/L6ZwSIHA9XvFnd9W2d1o+cgu84
	 Ho+QOuAg34cJf00Ey0bCHk97hJz8lkQtk50LCQmnOn/xWLl0tvi02otiEUwuTF/kTMa+G
	 THNNuqa3H3XsDV3yWBBcgLJYjsZZp0M/SL7KLzV5Didz4phmatEJSckG3+fjaG5YOHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=G3+I11Rk8CZWBB8q0PAynxRo9XlrajbuPJYbSbNeLKY=;
	b=A1luSU1TE7Zs3kBuMA3u47kVRtWteArTT4G+di3eK4h6WFsTVjmclrHRtw85NwgXUP71
	 HSoL/I9V7hRQEgSxkFPfONWs4Htf+jRfQ6kvaAys4LW9WW0ZCSXnRBXXOovgGvI6RQ8Yx
	 tLIyIP4iQaImlErbFBCqZBDZex5L8Wisx4C79l6ZCtsnuNjPk8OrDZEP0xzCfidOQTUMb
	 6hVUSduNzgLkQuvvtPpgjsRqex/mDPXGlb06zxQigO+z9BtJjfjlgcbsdOg/nBUfCTYEw
	 FSIy4k8mWeRFmcwy1d2I/ntzuXbjED474+yIx52fQrlYukhVxDTZIUFFyzA5yywmjAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ODAY8TYl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8A606A31E
	for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 16:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA8A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ODAY8TYl
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8fe8e343fso18608005ad.2
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 09:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792513959; cv=none;
        d=google.com; s=arc-20260327;
        b=QR6leoNuJ8BGDYy9SAkRyN0ycke03XIIW9UyvTx9JR/AANVKaujLFwNIqSyXRVqlV+
         9r28hAiNsp/t3PG3BrK+KMOyUf9gMrfNTiLW/wbi+QEU44ypcN5uX8Yo6c6QwbpTWC8J
         cfKv1PI4TA28n+xnmfqLTCQjUOCAPtf6UBCi3euU2hWXM713AFMvu9shhenXc+XPficv
         Uh3uOCxdxitdqiO15PslGxfKU14m2UgsYUwUciHZHIP9t5yUIJgWcN2YTlAVQxRa7zDN
         LfVv3Mk6ulJHYnEv7mNZX4bjrHO6ypd9cXVtpUvyRqr32w+Y/ZVbddIl6BroEe91LIem
         2VTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G3+I11Rk8CZWBB8q0PAynxRo9XlrajbuPJYbSbNeLKY=;
        fh=XS/3AmYyT3c2Ir1roFQQzwA9Kc6dJUdJrz+iM5TkmXI=;
        b=Wk7iJtyS/MC37bwyj/6WykfxfVULNO3UO5Vk4c4vay4DcwjnqSdw6/au8jj2CeHU1c
         oV6GLec2yTTdSShRcFwJNQOUkKkj69aWo+DN5Gjt8/4O6u1Fd3XMhkj2JF18sEniK2dr
         PCI/UQRF8mPF3t7NTNiqvAaJe61IgxbUvp6wqzPwmWeFNQz3d5RG+NrGOscobxn9NkdD
         9kXV+Z14BkXpBuR1MuszGrtGmfq9DN6eG2pu/tCJFxaIJEyU2zFuMRCVgJEEefd5iDGp
         FLfjcNWgToDq4GLX9KGWL0swprgVGfH16PUerE2L6CI94GddRfSfW+0dhH22oHar6ZRc
         o10Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792513959; x=1793118759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G3+I11Rk8CZWBB8q0PAynxRo9XlrajbuPJYbSbNeLKY=;
        b=ODAY8TYlt+U3kjWllqbSOy5DUOv2yWOdXtdXrXecvMKqdXSHgIaWGkFn01bFfv07GH
         C2sSROxQhmQJ716sM0RXSQjhK+Ef+WWcvPFMlOdsQMfPIetuxN3Uwm1KhOH2Xbu58i2y
         h4Y6l4TDtfHVRwSURJB5RjrOLdXjAN8eqK89n9IGZhgU4qci+R9NG/dUfLSPfvQgcDjI
         /5ENpONI5mNL+sgfLIWMxdZ92OS4JC2FqdI2ksIDOk37OjDOhuff3kBC8zPA/z67346u
         HhQO/S+ATiz67XwQB5OLCm2UnC1umosbWmtrV4zFHUGsk84YHlKKDqzegjq/ME/SEc3J
         LcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792513959; x=1793118759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G3+I11Rk8CZWBB8q0PAynxRo9XlrajbuPJYbSbNeLKY=;
        b=I7ehjL+p8bJ56eww0Kq2UsVL8t+YQTa9ub7DF3WUrdlcTHETxfC8FoilPP+N5kt+k0
         iFmhj+pWbS25JXobworXZm37mNrBf82KPFpehalzApGXoKpcfmz2ISSClyXRlmumCU7a
         lTgAnt6wzRw+44ncPGdVfwCFeDyFgn5ul4qupAxWum8mAqYMr0hXN0JfDs0LyeLcplUq
         UdUTkl7LF9+RJgAD0zz2Y2DzBr0FnS7aMKI2Lhh+xqFOJAX5E1tqGYLBJISo7xbIofoA
         CVpF2/tVjFOnSRUG4wvJEyk2xitDoMeCM2U7A5PVo2Ge1sr7531EYSk+b/Fksz90IPA9
         5v1g==
X-Gm-Message-State: AFq9FYKH+0z0fRehoxhz8wla8EcwVtHQhK4hWzKXJ/5O97CiAr6/MVXi
	pq0I2iM50rsjUjI3Q84GkdU/ia5aohAJFlNGfeYOqLPIbCNBRT4h3AzokRVyhr7XVY1vnWUxMc9
	SXjJ/bzvNHBYF1bmuPYE0MO4ebwXNxbm48RZEXnGzM3mTAGDmGa8PXg==
X-Gm-Gg: AYBFou04pCaTywe2NYFt3CpTjsX47BSh0yTTKSL5jdk5rAeOAgpMFxTGDX7qoWQ0iIX
	kYWJzq/HGX6tWi1JiT994o64CwwCw7/s0RBmupnnggDRPrHTqDDWB4bHMMsH/6zo9JZOVXPyuWy
	ZD78T96zIvQWydAw6+8VckAcmCPiUpAnYQ2sXBPoUmGAaND9fuHQ0prHG5RBU9UaiOmIMczqgeM
	xBz5QmlT/BP9kJJVMf8TLK+FfLOgb+GM/fSfa57mYMbgVrjokSFZ1TzooHm7N/aEQPQ2/1dHM1z
	OXeHbSZGJc5U7w7X+MxtteQ+uY0SPVvlygxwZ45S/3qZzqiQtSbXTWfjWWTPAeyv5K/unX9Vyl1
	kk430IQuE3M0=
X-Received: by 2002:a17:902:f652:b0:2e8:c331:fc30 with SMTP id
 d9443c01a7336-2e9a6d26448mr88340485ad.69.1792513959219; Tue, 20 Oct 2026
 09:32:39 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAEjxPJ4nHQEt1ApaA9Qbt9Y1WQpN1y5PM=Z8mECKhdJL5dYYJQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4nHQEt1ApaA9Qbt9Y1WQpN1y5PM=Z8mECKhdJL5dYYJQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Oct 2026 12:32:27 -0400
X-Gm-Features: AclHuK-hx2GrIpAVpZvlykrULkojxvJZ6nI2JJNNf2g5O2xA_ebaIQikRC1loSs
Message-ID: <CAHC9VhRjtXYeFAhZn-NCV0T_5Gp2J6gt77WnjD48rJs-2XYyDQ@mail.gmail.com>
Subject: Re: Updated SELinux / SE for Android tutorial available
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 8:54=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> An updated SELinux / SE for Android tutorial is available and linked
> from https://selinuxproject.github.io/ in Google Slides, OpenDocument,
> PDF, and PowerPoint formats. Note that several slides have notes in
> the Notes section that provide important context for interpreting the
> slide.
>
> The content except for the agency logos is public domain and can be
> freely reused with or without attribution.
>
> Corrections and suggestions for improvement are welcome.

Thanks Stephen!

--=20
paul-moore.com
