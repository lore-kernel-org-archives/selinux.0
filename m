Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25EBA32;
	Thu,  6 Feb 2025 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738811091; cv=none; b=fHpFLfJx+rumQra6XxGONL07blJoe+oGIPVX7O+PX7QO/PyEaZNYq+LWFAnUEjsDeLXK/LoJwWq2ELaWWgrXQEQSHtkEvEQj6RriEjichtJ88WX5uX+xEKi01zDfvx7bGncZ9jc+wM0w51qcCCEvSDKkhd4LlXJi/yYtNFN6/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738811091; c=relaxed/simple;
	bh=oXp18l47nlla4/efBUQIMlXG2GCCVSQbGjwXCaJpre8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Q/z2UYIWO3t+bKRdHjU8cusTG280IOdKkDIrSstVwSvlu9N08NhkpF1Et1Yb3vWKPBa+qbnpHhF9At5vcpxAtJnTxbWNrAG3ktsQlJj6Wri739QdjftJgIF1PRdMCpsuirZkgNbgZ2OUurKr1ChnT9NfS7O477upMvv59cIrjcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LglbChjW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LglbChjW"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4679eacf2c5so5273221cf.0;
        Wed, 05 Feb 2025 19:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738811088; x=1739415888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXp18l47nlla4/efBUQIMlXG2GCCVSQbGjwXCaJpre8=;
        b=LglbChjWFitKkzuYvP6flHg1m15YdfyvidaVVhoecbAjEm6pg1G2l1nKMd0hC02B/l
         2xjA9loawYkiHe7d0stmx1gAlycMrQse6MYIZj+BLbhnhWy7EtGfha5kkB2dhM1c0ybr
         1d6fc99G2wXSIwr07Td0SqJWYmx1/F6oBUb5VhNR1KiGpGToP+k1B5jHGA3ZcpaJ4Z5G
         UEZgAEBSVciI0pm1xn2NOxQEZnPIOzPwZWTNdSLs380L+kUcr/G5gHsCrxEewBslQ8aq
         OC0utUcmmB8ZaT2qmD4quMrZ2yz2B34PZjaCMeWDAWM71YA55cSq83H3yiU2ufGPmXEN
         oCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738811088; x=1739415888;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oXp18l47nlla4/efBUQIMlXG2GCCVSQbGjwXCaJpre8=;
        b=Pi4CBmR7gYrFM7y/XkocM+ckcFA3QAsZ3K6yOmXrY4KmNHbNvr/yBgmtHTnvClZCkn
         UMy+PKskUQKQo5sTOWBIknyhyKCuzRhskFM/FYsIr4xYcwyTj03dCXXOXH7pLMeMlyWK
         DuxUJ6x7Hwurd1q4hzOcHTfjIIFX7nxz2bFM5YGOV5Oep6IkQx1cJUZbRHjjpdpuqtUt
         eqz8DJSHSIB8NZ/OogdwlG7Evn977t1vKVOdQXW3sc2WYXoLpQ3zFRz4Ffhprjxp5568
         T1qAqsguUWctN+tlIGR0q+DhvM9OaXikmw61QwM2ae9dOyDtDlvlTnOcoWTsHSnqB6ow
         7WmA==
X-Forwarded-Encrypted: i=1; AJvYcCWTqhDHWf6/yGwoRCrrDt3sOTv5Sp6uypwoEfPP0okM7SWZ0MP6H9eb2IgQLClyBM7X9g6l36oqkPe7YJ0BHOOxIPVQIr0=@vger.kernel.org, AJvYcCWa2uOgjzs8UBhnjGvvejXk99jPmT2PiHA9MrEtjzTvz8rf+c2l4kJpueZGoXfZchYW1OV7ebKN@vger.kernel.org, AJvYcCXfMCMXcV+HE8nY7n/Y/Jmv80jJsf47nQrgh6P8tOHNftvWs1RipcUs0BO5L0tEqbvsekhz51zj4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeG3N/2XlB+7XMHqSGS986LV5HmqVF8iLIJhs5XKTDcOCOCn1v
	UOFSf0cY38HGONg40MEV/aMPO6bKs+MM+lw8jPwu8vS/FTOobQ3y
X-Gm-Gg: ASbGncuFrZ44PLUy5V6ezNTFIzWaABdj5VTGplKlj1NntVYLkGv4ive8wmX0NS3mTzh
	qmG6CsWSAHmZz7MFWxyrQaFY0r1S118z3znTxCNXhRUC0B/Q0rXC0WxAmMnbtA1idjyLMgzNkXv
	jaE/Lo6tv0jEFqZZ/X++MRD5CUEbPtnk/vuW/jc94ow5fY0JY63Zw/hpX2PPx12lKj4lfVA8gvH
	kj72SP73oSnFLg4TTskqW7LbdARDsaodYusy+wFV7LwWs0Q58tTfTfZXDY/qS1fNbdGaw/W4NnR
	HDAbHjLyaJO4IGfq/vuxJusb5Gs4Ko5zi7DCvXMOBdbWP7cV8fyFqSQOr8SQSfg=
X-Google-Smtp-Source: AGHT+IF385RaF+e4LBZY/dU8q/qmiAATNu7nZk6sXtBuQ9brNJS69/yBpsY3C9G7pYbXCngtYh2gLw==
X-Received: by 2002:a05:622a:1488:b0:46d:faa2:b6f8 with SMTP id d75a77b69052e-470281970b1mr82138371cf.20.1738811087752;
        Wed, 05 Feb 2025 19:04:47 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492bb931sm1480711cf.40.2025.02.05.19.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 19:04:46 -0800 (PST)
Date: Wed, 05 Feb 2025 22:04:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paul Moore <paul@paul-moore.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 stsp <stsp2@yandex.ru>, 
 Willem de Bruijn <willemb@google.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 network dev <netdev@vger.kernel.org>, 
 Linux Security Module list <linux-security-module@vger.kernel.org>, 
 SElinux list <selinux@vger.kernel.org>
Message-ID: <67a426cdb29f1_199430294e5@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAHC9VhRF0bka4zY5y1uNYUGXNSSwz6cdta+c0NH_YDO0MxauRg@mail.gmail.com>
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
 <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
 <6798f1fb5e1ba_987d9294dc@willemb.c.googlers.com.notmuch>
 <c4413e16-d04f-4370-8edc-e4db21cc25f6@yandex.ru>
 <67996154e30ce_d9324294c4@willemb.c.googlers.com.notmuch>
 <8b81a534-9c30-4123-bd7d-bf3a9d89dfcb@yandex.ru>
 <679a376739b99_132e08294f3@willemb.c.googlers.com.notmuch>
 <04879909-72e5-4ab6-8c28-5d3cb551feb5@yandex.ru>
 <679bace3a753f_1d35f32942d@willemb.c.googlers.com.notmuch>
 <CAHC9VhS-uSaVmy65oA8p6tCzMZxMsuzdmxO-vf7L0p44ZKO=_A@mail.gmail.com>
 <CAFqZXNtq7SZSu_JyY5yaiOQy89c=5jG+vqdg3_RSUWm4JNN00w@mail.gmail.com>
 <CAHC9VhRF0bka4zY5y1uNYUGXNSSwz6cdta+c0NH_YDO0MxauRg@mail.gmail.com>
Subject: Re: Possible mistake in commit 3ca459eaba1b ("tun: fix group
 permission check")
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Moore wrote:
> On Tue, Feb 4, 2025 at 11:19=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > On Tue, Feb 4, 2025 at 1:30=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > >
> > > If a revert is the best path forward for v6.14, do you think it wou=
ld
> > > be possible to get this fixed this week, or do you expect it to tak=
e
> > > longer?
> >
> > Willem has already posted patches on netdev [1][2] (thanks!), so I
> > expect it will be fixed soon.

You just beated me as I wrote a response :)

> Great, thanks everyone!

The revert has now just been merged to net.
