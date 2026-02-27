Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE0B30DEDD
	for <selinux@vger.kernel.org>; Fri, 27 Feb 2026 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772234075; cv=pass; b=uiNuw4kvr9Gkm9JrRllBIxUrlx3MccolYRmY8CtBnesCtRtpDlyTmzOYYvuO1fvIZI/NzPLmy7vFGUOo1sarDNO3C4JMuUsMsRZNeihRiQK3IBn4awJZ25k/9JRsgffbNhbSpqw2s29fdOun89AnIrEVSKmqc0FsUh4WXDH8Vgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772234075; c=relaxed/simple;
	bh=J3b6vc+tOHAVCzK0au98UT//OGVL9k9k622Myb8Zz2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT6YGL+PMNRAYjIj9kubOFTFUbzDjReAIDJ36nszFzwDNxgXaqZ0qsbKUr+TNybaCzWtRM5pHJPQN8ngjd/4q4PIVmk+CnCHdaGIMtHS6v/tvtZjNiuLceenWowLjbxLBLo3IwNzLmrWinW9J9XLmud0NXijpuK6I+DvgtbAvr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDWXEEej; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDWXEEej"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5069a785ed2so66541cf.1
        for <selinux@vger.kernel.org>; Fri, 27 Feb 2026 15:14:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772234073; cv=none;
        d=google.com; s=arc-20240605;
        b=c+tEuCWJAPmF/U51MQ0K4xi7t5r/HJN+yBr2HcjQ4lS0WU+W33i9f6FiDkNdkEK0GI
         ZYBC1xP9gn0Rj9M081Xl3ltbgbOa0YHAK25MphhGwgDONTcsYiYidArEfsTXRMoXpx8G
         CA7e3nkdZYk+/33LIm8GSGQPUwk15TsKbNw+wFwHReJUgAS5Fl244FoHdumPC440hw26
         32GRcgh0Ji0QHI6YTVBO/GZfLXK78Y1bLq//dBeZVIUIwR+K5OdBYB+oV5U930UkGktL
         WDbQLFsBvxwBxzWFZr/8Nq50z4qVz+uerQgobHouvr5KKm3X+8AW3OMZIc2NsQf1f2a3
         QTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PHrjTZJ/ludJtcAtHqM2ccn7IPWxmV3xmjA1wISavJA=;
        fh=hjc5moZwdj9GHFs0UK+AHNfYsanlwAXaObgth06xWfs=;
        b=P3BZQP37kPqFxnEhO/E9z/G8p/SXV9tnMeTHhUcs6B84gd2Gn4iYZe/uwFS/MQ4kaM
         bOtOY+yECq9IFktA+vLdWiB2eRehSnegadVbV774EKn3ciqOe0u6vgxppaJcsW3VV+dz
         9dCT+OUya7P1zYxNP0rRruHNI9psi7DbprCFJLIo8MGdrt28jjIf4yvO89rx4EAOU/oI
         SZbMnFC4glRHvmhqOeJ/RuJ+NmfG1F1Tm/sD2fbddcxiwW41Ov836c7A3+rgwevEP5xL
         geGFKQ/WE+RiMt+OsZ0zy25sricx5KKQ+8vRpNqdDdrSAWYm/pVmM9ZPY6rfjzQeelwi
         Occg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772234073; x=1772838873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHrjTZJ/ludJtcAtHqM2ccn7IPWxmV3xmjA1wISavJA=;
        b=GDWXEEejVIsDx55vDy27p/EEaoligf/sw0MoQx+LgMZnjhVMGuHUejAL+CrNAZaXAl
         DKjITxB9KIKfZAaeUoUjdCZceCsj7Gy/Y2dRWiq79UoyIo/xgMVz7N+88evXIrW6Aikq
         QAGyhbd8h1W2ejJxBKwX594Nmo6nGnbtuGh7f1TDCne2kWoxav0vF2D15YAzyU1DSGvn
         QD/mpPqsGZ/DdRMOj6WoRR9/mEyC7Rc0lyRTmYADO0clfU4EXBgbJzPD/ExanUYScE9j
         9c78zGWxLqSKlIqhELkRf1bNisPl/KjmWfpxm3lQJmzZjS9UWHBEcTucSbTr35VeeT+y
         67ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772234073; x=1772838873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHrjTZJ/ludJtcAtHqM2ccn7IPWxmV3xmjA1wISavJA=;
        b=nJv480772ufRi0mbWKZsTLOajzxWyG+aRBYO78vH83bK8JIcGCqIdNDPzDWnSpRJj6
         vbgeMv3kT1toE34bYY6jCuJBGbda8Rqj09b3WRbq3I+yVGmikpCsVdSwrv8QkOwcRT5j
         yI35Zu/pwoUfbRN3iRCnt58rn9VprOsLkfKM6PhqbA0NksqNpm5LbDFMWNLkzUn7vFJq
         L0gl2B4RYSJskailJ32sLf5w6UW2CyMvyQiPp08wg1467Piv8ylqxOOpwt2FXCPkyhi0
         9DlK4HQmodtOznacpu7ZDVp3RhoK3FHC6GxsXFKbAIEP4PzMea8TaWUgajuwZJss8QbS
         UreQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnCnUU/YDO03Cnuz3auEwU9cuDNVZ/dc+Bw2Z0HlWfDHF2qrjmgz9hhBghXTYO6ROynOjPiRfb@vger.kernel.org
X-Gm-Message-State: AOJu0YwALrYrxmW0iexDvxXD8qMVmG3aYiAQkZDG5MkUSEhwjRwyarU0
	oLfE8fxN/Jtwq0OxPAy62PdjEoocvj8sqkKSoVtCNKUYF1oXgwAmiuiBujevRcjGcEuUHCB1nsJ
	iiCUXiEpvOs/QB+5ET3564C0vtXoWMqykeMCdeLZJ
X-Gm-Gg: ATEYQzz4WkI6tnKIDe+O7QQHzxGS5ltKNSsgKM9J/K94VkZIv0/afmStMfFvUiyI3XY
	CiijzmU88Wt/lQPw0u1YNK/15fEmcsDfrGShxE9VQwAareuFAo3ZYDdoHXX4wjYuJFUyS3WnjaZ
	cEI8zdBvUjoCL7hSbHH/eL+Zq8R5wzp7pNKdWw65L/5EswHyJ5Bs6wndaip5ufoJcp4qbPP++KA
	Jk9DKAMtnMnlm2HrQFRcRs1mJUFWAJsXlvI251EyRMFhi6bl8rTxe3n79EPPgAy6c32ZTdXp4kJ
	VYhrX0A=
X-Received: by 2002:ac8:5dd1:0:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-5075fe651d3mr2304671cf.8.1772234072872; Fri, 27 Feb 2026
 15:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com> <aaF_SAQj4WT8jRaO@krikkit>
In-Reply-To: <aaF_SAQj4WT8jRaO@krikkit>
From: Yan Yan <evitayan@google.com>
Date: Fri, 27 Feb 2026 15:14:21 -0800
X-Gm-Features: AaiRm50RfCsDRdNp9ozDLxsAZSi7IdFQviiBLjcP_FPn4UGRHCUZCPnuyQUOd4Y
Message-ID: <CADHa2dCF=Cq2SMYgjHcs71VedwYaDmUXPWnNbv=46+11Mz0otA@mail.gmail.com>
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 8/8] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chiachang Wang <chiachangwang@google.com>, devel@linux-ipsec.org, 
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	Nathan Harold <nharold@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Anything that we leave as implicit copy will have to be "forever"
implicitly copied with this new MIGRATE_STATE op -- unless we find a
way to pass a new "clear these properties" flag (probably via a list
of XFRMA_* attribute names)

That is true. I also have the concern that if all updatable attributes
follow the "omit-to-clear" pattern, we lose the extensibility. Thus
ideally we should switch to an "omit-to-inherit" model for some, if
not all, attributes to ensure that adding new SA properties doesn't
break backward compatibility.

On Fri, Feb 27, 2026 at 3:26=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-02-26, 17:44:51 -0800, Yan Yan via Devel wrote:
> > Hi Antony,
> >
> > May I request that we also support updating the XFRMA_SET_MARK as part
> > of the new XFRM_MSG_MIGRATE_STATE message?
> >
> > In Android, the primary use case for migration is switching the
> > underlying physical network for an IPsec tunnel (e.g. VPN, Wifi
> > calling). Currently, due to the limits of XFRM_MSG_MIGRATE, we are
> > forced to use a separate UPDSA call to update the set-mark. Supporting
> > XFRMA_SET_MARK within the migrate message would allow us to update the
> > addresses and the routing mark together in one atomic call.
> >
> > Regarding the logic, I believe the set-mark can follow the same
> > omit-to-clear pattern as XFRMA_ENCAP and XFRMA_OFFLOAD_DEV.
>
> I think this raises a wider question: clearly definining and
> documenting which attributes need to be explicitly provided
> ("omit-to-clear" as you write), and which will be implicitly copied.
>
> Currently it looks like we copy:
>  - all the crypto stuff (aalg/aead/etc)
>  - security context stuff
>  - coaddr
>  - replay/replay_esn
>  - pcpu_num, if_id, tfcpad
>  - dir
>  - mark
>  - extra_flags
>
> but not
>  - nat_keepalive_interval
>  - offload
>  - encap
>
> [gathered from a quick read of xfrm_state_clone_and_setup + the
> definition of xfrma_policy]
>
> Anything that we leave as implicit copy will have to be "forever"
> implicitly copied with this new MIGRATE_STATE op -- unless we find a
> way to pass a new "clear these properties" flag (probably via a list
> of XFRMA_* attribute names), but then we could also implement that
> with the existing MIGRATE code.
>
> --
> Sabrina



--
--
Best,
Yan
