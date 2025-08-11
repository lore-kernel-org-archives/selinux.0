Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742AD2E4260
	for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950675; cv=none; b=d0roYKYKykVlHWmOiWYSkQgdK5XZBgTOTftCEP+brsNCc1UvLbanxWPjX1zxTImvxvrgeqOG0eqwVofyOgT2O1phCwjti5c0nMp4cr15paQ2yzjkAJIhJXQcfyUbNbZ4j7nF/LDIlR2raW1ECD4W7cExTHIC4+OQSm98p57TDzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950675; c=relaxed/simple;
	bh=rbtZ68rLyf/7ZKQToLJks77uOoN6Q6hQrn9YW8pG4Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Z1xO3PdSfxZSXhtGFKXjU1juVPcxRUhQI0Cw68Rheh0Yx9gtlkXnJAoqvAmJmkPoTe2Ui8JLDYNcx45dkcrEixJeplMjOUDgTxwTg0zMEmuxkuEYnLiu1p9KIjnb4biThAqNUAhkogJD6siIDoZVo8tGHyqYnPSFX7hEIAn+nMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aIyuiBRn; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aIyuiBRn"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b427094abdeso4512506a12.3
        for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950673; x=1755555473; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr8Dgv5YLH10p9lnbjf8C+c16YUM4Owvp7k7WH6jxBk=;
        b=aIyuiBRnvsSNqNF6dgtyznsnIJ4KGXHt1Z6kucx+r0eCMF+S0CHuL46jpTbAd5yOBB
         q3nKHxVPDMNo5G5YPZPXQaL8797gbQxhcpO02YBQ6fvckTwdDoDLNFSvuipimTCaMofY
         Qd9t5UKgTg3Kb6c+nL+QJfNuBUw/NzXSk0WD2Bg9TEe3ueJ2cdp4xteABgnfUg474Mfz
         9BVvErcpC2yZ7CcpW4dTqNI651GQSkjtqxA9J9TdfzVVVm/fyLZJdrfrJMWQEpuXAr9j
         y8UAQsfqqZrw3wviMOlQ6hQQNEdpxbO9c2zbRamDACXgNIgQiQq7A2kQiMSgpi2RMX0P
         DU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950673; x=1755555473;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tr8Dgv5YLH10p9lnbjf8C+c16YUM4Owvp7k7WH6jxBk=;
        b=XHU7R4oHcRH7ArfQl1Buo7SUuFvbpHNuwxrdf8871je9CoSOxyr00blV6XflHcCWKa
         EnkERHqzlUbZhaqkzIgGqPx1/aHAHRer8WXy9virFvys/Tmv6IzceLDk57a9OBd+lX7z
         +S4vieurL7818ENMABkveVFhfMW8Dx4K6XnJufGtLq1Mia1BHEzsk007IRelc+kK92G2
         5YJnQ4r0MSLDlWeH5MfptX65Ovs2aq12sQKPgmKefQ9XsHZHLnw6DOu1RjqLj17T3TLJ
         mt9lfHEdneEjq6fKfRjSo7gTskPEBXQTlqLAowNmf5ld0zrBawKFf+Wl/W8mynxkgGst
         vW9g==
X-Forwarded-Encrypted: i=1; AJvYcCV2agHNREgPjRQBbS4raPpet/p3/lUQBNUWH7ozyr1HzvTge8tMxsRIMsHr59GrhLsebvUYwWJw@vger.kernel.org
X-Gm-Message-State: AOJu0YyclS+ZMhBIMb4Esw8EVZOJbxlNznMLUQ51r5sqYgaCTA1MLsKE
	rZibx+yPytGxSAy/ZNYAIH0Cyw3lMHHUoM3uF62+rwyNzZtZJqp8OqJiNBwfIy3DnrWANf4MUzb
	XZuhPW4Ngwo/T+8lZAkPnvgiDjQHNSy6Hb9g10dCi
X-Gm-Gg: ASbGncvr6IpmQkw4yYGtbRjOeFJWPM36u2qSktfqT5NI2ahirDNbG2XWPMA8dNXtZeq
	5YP7MB0LBFtt8Md3TXb38o7XgIs1NQznj/63QGhSk8U6DlE+uctyXmOAsitd4qYTCT5HNHpCpoD
	jl6q/T46tc3H/r4a8WJYOrj0NbPWLVIJI9acuWiin75nMkM+Kziqb32GM+5/dL83t23SSOSXXio
	BMGbeR3hcZpo5dY1w==
X-Google-Smtp-Source: AGHT+IEXRfx801PfOc4EG4/BrKtFhf09Jw3cL0NkScavSktACkVTr1aoBoFPmzLZhaTnzALRjHvMK62Cc4teT2kOY/E=
X-Received: by 2002:a17:90b:1b41:b0:31f:2ef4:bc04 with SMTP id
 98e67ed59e1d1-321c0a69369mr1367593a91.14.1754950673350; Mon, 11 Aug 2025
 15:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729091044.95411-1-tianjia.zhang@linux.alibaba.com> <f68d69329455b0cd7e69233547a78a8a@paul-moore.com>
In-Reply-To: <f68d69329455b0cd7e69233547a78a8a@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:17:42 -0400
X-Gm-Features: Ac12FXwwv0PJMWmilt3xi132701iQODCFuMOZDvkyW8Rh7xatTBAbHnfX0_-1i0
Message-ID: <CAHC9VhTVNPfEbtqNxLQ3Z+RBt-1gPX-9XnMk72GhJEjA68_iYw@mail.gmail.com>
Subject: Re: [PATCH] selinux: use a consistent method to get full socket from skb
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 5:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Jul 29, 2025 Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:
> >
> > In order to maintain code consistency and readability,
> > skb_to_full_sk() is used to get full socket from skb.
> >
> > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/hooks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Merged into selinux/dev-staging with plans to move it to selinux/dev
> once the merge window closes.

Now merged into selinux/dev, thanks!

--=20
paul-moore.com
