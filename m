Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D933D6FA
	for <selinux@vger.kernel.org>; Fri,  5 Dec 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953398; cv=none; b=axCLtJqFcaJPW3mdRaLVXz64ijwctInoi5P90U1/lSSSm11YvHXvIfkGRffj0NSuWCNtVUvkfclIJsXwZ/qJ6oDsSnhf2E7f6RfRagw3GBeuqTd5RNceW63CGzrruU/NQsWonTK0r2DXt3VD6j2ZKfH0E/yEZ7tSl4FDhPZhcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953398; c=relaxed/simple;
	bh=S44aWYDgH/L//m5SJH8feoTD7x5AMZ2hYNyqwCckyWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cedL2nDwslEZy9zwANHbpPFYbvo0YhOfPXGl/xh5OCj6R/T6PT3GAr0zIPa/YPwqDeaNTviU7HVZm1PTAOZKXxchWZzJm8MqdjCSW0BcIdivtNlFmxLmGGtoMWwdUMbqYp88+cja1rFg2rbjGb7oWlWPbou4vRUeb9OjoeKjyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AE7wy9OA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AE7wy9OA"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343684a06b2so2336111a91.1
        for <selinux@vger.kernel.org>; Fri, 05 Dec 2025 08:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1764953389; x=1765558189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFta1eTe061x4aiEFe5juzgftswqmH5K8rJIx5K4PRg=;
        b=AE7wy9OAbs4QrmVIBK++VC2379+yCH7XzbBJu9O6jInGQlBTsI6LBCRFAh8GzUC7t/
         RBO1r0lIx6g1eT7wJbf+8pylREjgHGDLIavvuuAb7Q8MI4d3RDa04eXi/pIWD9T4Ul46
         QUiryhP4HoXJHgvLtjxlYxSqAa4TrkWSPuSoPCFC36x3IeHybuGUgo0GY2AfX2fxKQRg
         NCgHygCuxhCnEyZodLfQM6QqYWxNJTlhNIST8daII+RhBGJHZEJKLBtX40VxSpwMCiRz
         SQp3n014Is2TP1CLA3xEQKF009ZPH8IXCIfgACu/eDWLyu0McIxvrE8I1JyxQLx1fB3d
         7BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764953389; x=1765558189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mFta1eTe061x4aiEFe5juzgftswqmH5K8rJIx5K4PRg=;
        b=UUaB2OKCLueDuAnfcMmuVm/YBLN5INgWjB1Un2J5rJrtgVcODKw1MsHdfneK5c+vXF
         BqCw0zpt4TwA1v4IPxQGXazD9BdL0+uROLYcadhgSJ2y1K+SE34YtuyQMwmhkK6vupmk
         hVGbWyeJNTI+mQJu+xrGsZeUCnWE53BQRK4uQRk4grJH6EnupLoJe1lc/mpLQGXJQjmn
         edHQGVqMwTx4bDwh2EV8NwYooMuxd3F1H+rJ8D6CuNhpfCwxaQFIR6hdRBR/uJo+H4MG
         ENtT8JNKfZAJDFwDb77B/pGKeVN6SccYthFODoBtzfASvULUJq1wD8xZ6Urx0bi3KZrJ
         Ek0A==
X-Forwarded-Encrypted: i=1; AJvYcCVwzFzVMCDEoJ11FQW9Aya3/LR9/6HqIuB8lGRsui1onobEgAzR9Rixxm9T+gxGsSDXR4zeiw44@vger.kernel.org
X-Gm-Message-State: AOJu0YytUl0A6FcRSiB9DE0DlJ0P83gu1g5HCz6MUCjTnNeZGRGxD3t3
	ec1wvk1WxlIGwteN7Ez+xxiF1nx9aUG7U2hRlcvEWTzx9eDrQtTdyzML1CfXUDOWAcuORUIXMDu
	kqop9f8IKoBCEOTA8p1MFBUKLd6+Q9yYIHPX79jIW
X-Gm-Gg: ASbGncsKFdx91UwJDgh/J8YcJOXlbnWTGx/JIhIeSy3Sbpi9wcAgTH5gB/RDFzcPOTV
	TlSB4bj51K9FEFb/K7sDd3xq4aJpQ1IZQXX+FWOi0kq9i+uqhTFbGY4Y4jsPq9nX6R0VvCoA/rf
	5uLMoLei8zUQpUiQEkMCe5czsjRTpPXldNo1HxqYdZTEl8ltU2SJGRZeTnqtlyVCQ+OrDk/hAdO
	8sfgXphfqpTS1i881FRAINCafEmZidxnT8FLbHKBS9jpZf68fXeAN/sQTWsy13r599OZMs=
X-Google-Smtp-Source: AGHT+IFlgcm08Zi3P6+2oJVUXwfdUw7sv3b82zhNSHjaEBOQwXrzMMtqEuxbJwYy1uEuAcGXQwXxrAFNrkMjorAMSZ4=
X-Received: by 2002:a17:90b:6c5:b0:349:1597:5938 with SMTP id
 98e67ed59e1d1-349159759cbmr9821798a91.23.1764953389394; Fri, 05 Dec 2025
 08:49:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-tortur-amtieren-1273b2eef469@brauner> <CAFqZXNvMxoTk1MQq96r=QQGjLqWwLrbdUVJ+nkSD3dzB2yTEYA@mail.gmail.com>
In-Reply-To: <CAFqZXNvMxoTk1MQq96r=QQGjLqWwLrbdUVJ+nkSD3dzB2yTEYA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Dec 2025 11:49:37 -0500
X-Gm-Features: AWmQ_bnDRXn8-Q-vXQyXQXeKQ75yPkmrhCwaLV1ifzTgMIqsDQEG5-wcwGbDB3s
Message-ID: <CAHC9VhTh9mmSFf0m7Hd7A59Q8cXN5j_rfTGP7_A_ic=1M283Dw@mail.gmail.com>
Subject: Re: [PATCH] ovl: pass original credentials, not mounter credentials
 during create
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, selinux@vger.kernel.org, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 8:57=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
> On Fri, Dec 5, 2025 at 1:11=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> >
> > When creating new files the security layer expects the original
> > credentials to be passed. When cleaning up the code this was accidently
> > changed to pass the mounter's credentials by relying on current->cred
> > which is already overriden at this point. Pass the original credentials
> > directly.
> >
> > Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Reported-by: Paul Moore <paul@paul-moore.com>
> > Fixes: e566bff96322 ("ovl: port ovl_create_or_link() to new ovl_overrid=
e_creator_creds")
> > Link: https://lore.kernel.org/CAFqZXNvL1ciLXMhHrnoyBmQu1PAApH41LkSWEhrc=
vzAAbFij8Q@mail.gmail.com
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
>
> Fixes the issue according to my testing.
>
> Tested-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks everyone.  For the SELinux crowd, I've added this patch to the
kernel-secnext builds/packages, but as the Rawhide kernel broke
yesterday (unpackaged files) it may be a day or so before you see a
new kernel package.

--=20
paul-moore.com
