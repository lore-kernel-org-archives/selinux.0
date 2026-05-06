Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED13F7A84
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071805; cv=pass; b=k+TbcA53JWJE6+FVASgT+O8FcuY/Tlxr8VFqnF6bI1e+D7KzEi1GM0k7xsI1g1ODn3FI7sCuZ9G+zF1ltFEWMc5Ara8Ot8keOm4aPpPmn+pLhsD8Y+hoFzSC5dCLqMokv4+t1GoiS1uoNxMj4BX09qUVE1DUg7X4O5jWieq1UMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071805; c=relaxed/simple;
	bh=4AXe+Vy14raXMDQB8msJ5nyebWme2yeBGC1/Jrnytv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+3gKVYXAfmBLwJYbneooW1gf71GYp2SphfGZvVi5rL16FI65fkObyN8LNDblBJ8QdeHJSd2F7R0okX/eenUNqeD9X35zzwzBx8bDZwDH/cII68YGfXCSuAmB5gX65gM/SMBu+/Uldy0uHYVD/FkXqtYT5/imanbMQJ4Vj3G2ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp1Neua2; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp1Neua2"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a2ee65171so66875567b3.2
        for <selinux@vger.kernel.org>; Wed, 06 May 2026 05:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778071803; cv=none;
        d=google.com; s=arc-20240605;
        b=ExbJ51VVi3Ur0sKXfS/IVPIgcXrkFgzZQumietDkcynaoVDWGWPurMN4fDhltCgO36
         zPCcqZXUs3xvIk98bNyVvkGC8BVmviiZ94QESCPfNmTfoB0vR1VijTPr+S9FIHbPffS3
         LPQEf0WIICe6w2htTf9DvqNz3DiKQFpLXRotmlGA2nNd01SqWm20jgNA99y1aiZd19zK
         WTSSXmDH/4+m18UqlA8VGkLYCIyKLJODNrSEZQy23iHqDvRH98tMJSxpkxHJyXHrYRr7
         ZZP7+p8tjJUjG7PH78dm92MmbLZx47Dc0JiHB0f4rBdI7N3DuDnqVugoba6ljpWA2Sdg
         p44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4AXe+Vy14raXMDQB8msJ5nyebWme2yeBGC1/Jrnytv4=;
        fh=+eaiFcK9nT2T4l31go7QxAUHZ7muzcTbslKqXdPXi48=;
        b=QASfnH0d1ZTVZk5CUa4D27e+7I1ey080ax3mRl/hUYpMMjbviUxg1u2zkEH6Ou4dNs
         eya3Pe2Lnzv0ar+Q4PXB/eG3JerSGROY0F3+BT0sd3Xh8+AuAet1U49Vlm24gLZZnyvT
         eMLWLmh9vtdrbgEQUYzTvUbWYO0gICCF2uYFGjK+01It0gKY/swPOZ/nxZffi4ix9AL2
         q/33roCVqBB3tYcsAGbXgQoG49L37Cfik82eM32RfOyAfEI1GHNvmoNsV7498PMHxdzl
         8qn0tPk+7nafji9xkj/gOtt318UyswH6IMzoLKdm2iwdH9P6VQsaBgjoNX1vW6sLqc1f
         rzEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778071803; x=1778676603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AXe+Vy14raXMDQB8msJ5nyebWme2yeBGC1/Jrnytv4=;
        b=Mp1Neua2OqvPhD42bVHRc1DpSnnJbtavn3QWAr5/fcNJ8JvaSy5rAcu4+zdCNRJQ22
         icX5MPhgN5D/00w5RmL9Jt+mKXfPeTR9z12m0Qvb1rIb76xYyRc5IR5J3TzVb94vLso0
         2KAdEVOSjZqMVQ6N5mqp70lId29ivWanYk+sL8QeZKERGftwFu7Ss7O9Nl9KX26pmzla
         vnZdIgYWcraTRKneX5ABZ1lCAd+aYBQrFu09qRLjcVAGVrguKJvzkvLHO/bmCdX2xzp9
         ujPdno5HqkBtLGQNfzxf9xsSKKC74Ja24tN7fdM0jpDPBTMAzXo1GyS48EY6Qn7eMW/S
         Pg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071803; x=1778676603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4AXe+Vy14raXMDQB8msJ5nyebWme2yeBGC1/Jrnytv4=;
        b=tVU86y6DezEXEczT35KkHTcfo6kIPTFkuD9kekiPW/vP1/+HnWpVaQOVv6TGWyJpab
         2oWIaFNatgOx428sjYAtY19fEcVXN8nRo/+lUh9Piu9v5sL9rGcfuRITr/tDENT9rnUl
         NM6aRyygIfZtTdCaMtc7pKfNFgWs6JXChRpt+iAnZ56w7M1ZGn3JWYFCcedpMkWVr1wp
         XjTmRlHHAJqbgXocWhYQpQBpvJhWzErEfwhxCF5OjmwBYDKgBe5T4kN70IbTp2siMYcp
         VP25t3AzmcO0O3UqTDbxsTl+P5jqr9acmcX4LPb1VUB3qOMtAuvnV2YaSgEuJudesolE
         Aa7w==
X-Gm-Message-State: AOJu0YwVopIahhl+ZnID+zSs1j8AWhyJUVg78gJ07EpdPg3RfLNpbdJv
	5mEUXklr2iVipYvDDoYRWF7BM8Nhh6cx41gl8v2VuQeWGZ/zlXZSXDMuirDz49hrhqzm7jjPHTJ
	wQJ+VnKr+oI1OUPYbxbWBNJw5tKoPdFU=
X-Gm-Gg: AeBDievL80CAfnIfBDkBEjGq9+z/CNH91jhpE9WqryQdGzSXmu1tLJD4WSp/JFfJLWh
	ItTNZUEdk7/CQGOrGSux2w+J7uy+Hl3oW2GRnws67BkSW+gNcYDl0vktZP6IAx/yslYhMNx13cp
	dcX6U7BRZhic3QEQftgUSw0mjrN6qBctPLvKV5yq1FJG1Tx53AyaePT7YFn+XjYfARfMtxECcua
	zRFPl+L/D1eRu+VHUngi0G3ATdyQj1gzdGM29A25HBXhkiEmBMLPiTcjFRhF5HzVGq5S/wToDJV
	CxUVhtMkb/I4q5hQ3w==
X-Received: by 2002:a05:690c:d94:b0:7b0:4bc1:d700 with SMTP id
 00721157ae682-7bdf5ec8733mr37029457b3.36.1778071803303; Wed, 06 May 2026
 05:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505185017.18428-1-stephen.smalley.work@gmail.com> <afpIWa5ezvPiFpIv@14-5A-FC-31-E8-67>
In-Reply-To: <afpIWa5ezvPiFpIv@14-5A-FC-31-E8-67>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 6 May 2026 08:49:50 -0400
X-Gm-Features: AVHnY4JV1Bo7wwK2nEx7XdJ36r7KM98ddxIBIXCJJ6TBHDE1bbCNVSDJEhK8qBk
Message-ID: <CAEjxPJ7N+W_=FMr10sZv7SwOnw_9wt1GjGGKaX2d6mQwnni9CA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: restorecon: revisit pinning files to avoid
 TOCTOU issues
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com, paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 3:43=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.f=
i> wrote:
>
> On Tue, May 05, 2026 at 02:50:17PM -0400, Stephen Smalley wrote:
> > +static int have_proc;
>
> Just a minor suggestion, I would prefer 'bool' here.

I'll fix that in v3 but already was too far into v2 to make it there.
