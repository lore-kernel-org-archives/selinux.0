Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4190027B4FA
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522687; cv=none; b=fPDWMEAK6f6NpFZito0oxCi53rgxoKs3U6d1oSwvR0DDmpI02OpY8ilIw2DjjWAdM/CO/NyaUblo0izytBSR6NfEXvl2ZWUdnHBCMkr/5obvOTCn5DqoqgBWDbHlKqnz35vs1CiThvneeOcoJzVoychjim0MTeKBVI7gMPH4QRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522687; c=relaxed/simple;
	bh=HO+yFygP+gfnE8vYnDVGthKQSrWG3KBwTnxPTHvYEjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLpUUffZ9+IUL4jWhCcJ8to1kxlniGUbvQjNyhZVgXl7v9VYsvWHSmRxU7jaqxcpdRM2llCyDZOgJZfVIYcbEiMifGdIrXl8tlVcITLTP88qSl7ddGPFv935rFDQZIXctjkyCGn/4ml4V2CflWGbM/qVE+1Daps6cZDWYpR9Vkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0e7d24t; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0e7d24t"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24b21006804so78432755ad.3
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757522685; x=1758127485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO+yFygP+gfnE8vYnDVGthKQSrWG3KBwTnxPTHvYEjI=;
        b=G0e7d24tNuLR0IfykXbaE+0GFmm9zfqN5nXut+SOk6xT+NqfTo7ZeSF4tRMfKnv/yv
         sQpYzag5WkIOZybODNxCTdoQBYFLvQZT6hn8LFCDAZmV9E3XY3HWb+83Hkot0RuPDJyP
         gTZcgy7jJP30AAdM8yTBfWOc/cL/f4NYhD3VZlM8pIHbF5FxrO+2VLlj3c09kYrlikKZ
         ukSqnuVYS5JRpC2z+PxMnS/eo+518LFb2qRKKAOn9S+mrrTbuPA8QHfSlK06y78AIrlj
         iGeHeYpTlElFyc9m2N6TxmfN081u8U2B3OM3xoi8+d1Q43lEZOc23NemS1fpDBPt2XG2
         WPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522685; x=1758127485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO+yFygP+gfnE8vYnDVGthKQSrWG3KBwTnxPTHvYEjI=;
        b=f90bPNR/aWi3BsbFrLILTjoUd6UPmA2Bbd5f08Fe7XvKVyC3Qw9D0bon6hpxXUs2H4
         iw+3/CHrkU8K2fIL4PM2rZgqJdgnvofLYZoLyZd0pREs0bn5aVsmnRfVB67h0fnMsPD1
         HHsyZZL3c29ob73k0M+4HRC3uUAZpGhe2Zj3gL0KmDFwsrIHOoyqEucxJWGrlsspCdpG
         /9ZcnsXVC6hKSkTCBVoo6NTKBBK82IOHjh52PNbOB3sURkNyxPbZaWWAJisNMl5LCqqB
         1lUtlkHXDrT7AJ6/uFZebJKXpw0hDjUATzpgMl82MT1KcUi0QbORAOo9ptM3tHMdCmSG
         9Jzg==
X-Forwarded-Encrypted: i=1; AJvYcCXReZfv3mB3EQMkm8ULggo7K8pLtoBfcJe/gD+bhll0RerNFUoNNFpAB9iasMjVvTUfh++1qYT9@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBvOww1RkEpIulDvJT18vuSPBF3eszVPfDyh/1NTR/hLbFGu2
	LnJJeQT+9aLvH8gR/3qiGtNz26uIVD7lqT7vJue/UxCjC9iH5RS9dak//u73z8QqFn3EIt/RNYy
	wwWZ7m4e3GQsLtL4mj1R9ntCOUsyFc9E=
X-Gm-Gg: ASbGncsizAzTsyraW3nOeD8K5L9e9SLA4gHxIlS10wnE0LoThLSXl62OlZ26eIwPCjK
	rmyognN4RsIc1rocyMUbycPb4lP4DoqjKeE06/df9uO8kb6NyGSnty2jt1LmMC7YREmaAiJWGc7
	DUkXEaxkeFdfK++eL9PrJmcV8BtyAI5fcftMKJoFRAp3AZGaiy91mtN3YMN4UuzMuDn9SM7CT9C
	LXFt4Dro5bN+OQ0Jg==
X-Google-Smtp-Source: AGHT+IHY1xD7+JRivAYEsI7VLxD1MsXmLP0UGbaNvbQSc2IpX1EkwpWezgvvG3JT42EjEq7KqNX6a9IyGj2+WFlDPHA=
X-Received: by 2002:a17:903:234a:b0:251:493c:43e3 with SMTP id
 d9443c01a7336-2517330a5f2mr275480755ad.31.1757522685530; Wed, 10 Sep 2025
 09:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902055026.617170-1-tweek@google.com> <CAEjxPJ6HmLe5c-iosTvfDYy5EVz8xNRq0=A-jDKTKXvCNWMypA@mail.gmail.com>
 <CAEjxPJ61HCx3xz5HQwVKD+-9ctOL9WjuQ1mXu435eg9k+JRsTg@mail.gmail.com>
In-Reply-To: <CAEjxPJ61HCx3xz5HQwVKD+-9ctOL9WjuQ1mXu435eg9k+JRsTg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 12:44:34 -0400
X-Gm-Features: Ac12FXxeSNJipmVTsBeTqYkKmRUCPXFoU7q_FmIS05lOUUHwGMc6D-AljigtYvs
Message-ID: <CAEjxPJ5qJBpK+gioHBWcju3KdrSStZ9RAWL9XVuguQ90DSvYAg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: add memfd_class capability
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:35=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 10, 2025 at 10:20=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Sep 2, 2025 at 1:50=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> > >
> > > memfd_class was declared upstream in [1]. Add it to the list of known
> > > capabilities.
> > >
> > > [1] https://lore.kernel.org/selinux/20250826031824.1227551-1-tweek@go=
ogle.com/
> > >
> > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Will re-base on merge.
>
> Thanks, now merged - note that the policy capability number changed
> due to the previous merge of the functionfs_seclabel polcap.

With apologies, this has now been reverted due to the kernel revert.
Happy to re-base on top when/if the kernel patch lands.
