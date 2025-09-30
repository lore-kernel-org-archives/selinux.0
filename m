Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DAC1D5AC6
	for <selinux@vger.kernel.org>; Tue, 30 Sep 2025 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222358; cv=none; b=sdtgqIDvyXpP7B6S2lC0G+ixenUOKBY6xOY9W25OCrL5YgVo0bT7SGx/LSIfUUejwVUIVSLGJNyslnKwVsOeYEz1YhONP1oTTfgEV+gMYBcvNymdUNGmbf2Ck5jFJqJjT1XJljn6KiIJViBkYeksfRJSNY/eLTsZmLFxAD2jCg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222358; c=relaxed/simple;
	bh=JTuwS6lyNQ2NH3bt2CiXlmH+iz+rcvvGNLtB72NP0tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5a1k5SoNVCKZOohN64SU824FigJWTeBX8O6XieXNHCDohkY3cxauyd0YJ1gFYnMNx5LomytW3UBS7dhpTTcejlUe2CGZYj75spM312IOdy6/ljm0zxA+sT3KWAFvUgFsH10jcBukZQMn8uJgFkCu4/GdvniLsubVyw5X6LpPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eR3IrvFF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eR3IrvFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759222355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTuwS6lyNQ2NH3bt2CiXlmH+iz+rcvvGNLtB72NP0tA=;
	b=eR3IrvFFHD9O4cTGQo9b69gqXGAbOmsL6tOZdTIWFcHAG5bSKririB9VOkb7rgyFgeLqKQ
	fkv/CXBNMiqAvMS2G3CxYleoW7w4AnqpLKRvWoA0AvDBkeJMqrwtzCyC9LUr9gC8lwqfc7
	2PsDtESJRbQb7rahdZSw3wTn/4hc1N4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-nUkbAsBRNTKVyDwWja9N6w-1; Tue, 30 Sep 2025 04:52:33 -0400
X-MC-Unique: nUkbAsBRNTKVyDwWja9N6w-1
X-Mimecast-MFC-AGG-ID: nUkbAsBRNTKVyDwWja9N6w_1759222352
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b552f91033cso7067613a12.1
        for <selinux@vger.kernel.org>; Tue, 30 Sep 2025 01:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222352; x=1759827152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTuwS6lyNQ2NH3bt2CiXlmH+iz+rcvvGNLtB72NP0tA=;
        b=a/Zd2OmKtDs/uXwOW82knPxbGf5HbhFdIUgqfYlXbL+TRQDRqfkOyE/Oxd/6e6PdSO
         kxhpR4QRiX796bfTBnW3APNlvgYCYd4epawqvyW5246ECIMrkO4jsn3f4EVWcmgwrsRS
         H9bzJvTliFFRgjTrIcgVZw+2e0Lf3kXWVH7XNlcya3CBKqhb0IUV7Gb9Np5wJh2fJocV
         Ea6OuhW08H1Wuu7pirCgOoFkCVUEgBNOJGJqI9W5n1BvdJgLg+el3Mqas5KDN1c7jGiJ
         gKFfwww+yyP9F3QSc49sYyQHcnb3ixJwLxYryEA5WuYne2ZqlmVCFocMBXvG3mZAQrEV
         HqAg==
X-Forwarded-Encrypted: i=1; AJvYcCWQdfHmdQx39V4hbRumF8AoJMTBzFIHjVyEaxl33QP6/CIrKWAAZxar6F4o5ynf46cNY56uUdJZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwwzWo3jFY2DZCht6bIX+P8xJthGR4nZxweWZ86F1L3j3Fw4Tqc
	Lpw0Yz2bsEaIZ1YeNvOXhVa2+CpwMrekB9FLupq870d25cN6lqEeKQkS+w98rTODmeLSM3DIFfz
	7ah1PG487BrRdSlV/3aV1pvqC7IBMIkFol93JBkVvs77jE1tpsRM7KWY4FmyzpRi0XmFynO8hUp
	UU3ltP2x0BPdn8toYrNlpOPF9ZwqQhm9cBvQ==
X-Gm-Gg: ASbGncs3v1iCNbk3j365zAapoWag083gCjrJxk2eUEC6AzL5tBWx2o93LAGIPCkWpHg
	3LYJssOLlwLZ4TvdY7Tbm68IXGjkNDtiupvuJCIuZJsU//7aDSrM23wqu6w8hiet/lwkcd4LCwb
	5be0putIxSvKMOTYcEt2eLmfjsPY5a2wJQ3Y4OhTivrFNARVEXaR3dpNDC9Po=
X-Received: by 2002:a17:90b:582f:b0:32e:749d:fcb6 with SMTP id 98e67ed59e1d1-3342a26b3acmr25760444a91.12.1759222352249;
        Tue, 30 Sep 2025 01:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmscK+i7RFrN0CpAKrc1yALsiTwlJr6EZXdy2Sc9MceZgvsmMHKtoShS3IOoybtOS8SJH+YFwU6kveJAq+vgY=
X-Received: by 2002:a17:90b:582f:b0:32e:749d:fcb6 with SMTP id
 98e67ed59e1d1-3342a26b3acmr25760426a91.12.1759222351956; Tue, 30 Sep 2025
 01:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402153526.ua7jdw7xtgda6qo2@jmarcin-t14s-01> <DD1MUDR1JIP1.VWEIIPWFBN8C@gmail.com>
In-Reply-To: <DD1MUDR1JIP1.VWEIIPWFBN8C@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 30 Sep 2025 10:52:21 +0200
X-Gm-Features: AS18NWDMHOWNgaKQLqN1QovrqXuyKXIfnYV9ZirGKDhLrJfa65_mWliAhlpLMQM
Message-ID: <CAFqZXNuEP=hPc-HuZVNme=b=qXPzLnm6xTzpREs-Whh_oi9q1A@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: add prefix/suffix matching to filename type transitions
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: juraj@jurajmarcin.com, paul@paul-moore.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 7:30=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Hi Juraj,
>
> Are you still working on this patch? If not, would anyone have any
> reservations if I pick up work on it?

Hi Rahul,

Juraj was working on this as an intern in our SELinux team at Red Hat,
but he has since moved to another team. We were planning to pick up
the work at some point, but so far there hasn't been a good
opportunity for it... That said, feel free to take a stab at it - I
would be happy to see it move forward no matter who does it :)

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

