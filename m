Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28911214A67
	for <selinux@vger.kernel.org>; Tue,  4 Feb 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738685958; cv=none; b=kILV1mmInFpCOvm+1xNvtH2z307ExYdGOI4Y+bgIB2RHeBMgg8utbqsQnafnoMwooUM8FkijmKnZoONVQixAlD54NJoEWy+lNEYl6vT1PE1VG805R1r7Hr7E8+6xYSz0JeMTFMQX0lRa2T93+352UVYwW/I5gN+bRYkJM2V5fcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738685958; c=relaxed/simple;
	bh=74T0US/o9kjlBij28lGopeWdzH++KQNYK++WmLFe1uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtAE9OvLp03Wb6v8iXDp9daG1UWJVrhBWUoB0q4UQvtXxgYXtEAK2J4xBxWr/6tq/avq4zlbYhr9YSvLWcPe4eeNA9KIHg9diYd2yZq2zJvlFVU9tI2yJVlOjRvIliqqd2LibT3qZoPMld+L8SeIUEU1Eh/wMFUG8HSjm0WfM2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBfvGKOj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBfvGKOj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738685956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74T0US/o9kjlBij28lGopeWdzH++KQNYK++WmLFe1uQ=;
	b=hBfvGKOj4+sD4yHywTNvxaWAUMKA3iijSy5BmNs2nYXRCW0cmWxfSV2wscMYiDVtsZmWLK
	IxBxfOuf90ikSDlp/cnQfnVa27uwNTdRBAudRz2VkKrsod7CfJIq8JWcncg/vPA0lHxHyA
	NDtQq9bw1aWJiyHaLwLQ7GkmVdAcHIg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-yU5jZyQ2O0OTeU_IwY13zw-1; Tue, 04 Feb 2025 11:19:12 -0500
X-MC-Unique: yU5jZyQ2O0OTeU_IwY13zw-1
X-Mimecast-MFC-AGG-ID: yU5jZyQ2O0OTeU_IwY13zw
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f9c78739f5so1283184a91.1
        for <selinux@vger.kernel.org>; Tue, 04 Feb 2025 08:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738685951; x=1739290751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74T0US/o9kjlBij28lGopeWdzH++KQNYK++WmLFe1uQ=;
        b=fGOyZIcpw0VkyRUcHO2s/gJhNNNnrhTB6RL3FCkITPrIWtxl3coHT5Wk6E2iwTuwfv
         Z7BmAfLF/njLfwmX0I81vVZtozx07Fs1vsQ1X62nFlqiKz/eeYW1dGxmIirGCztpEshW
         qmR5e58eJUExVoGNMeIUQIyQEB5B6ZT4IZQSq/L5Gjw1QA0rnr1LhWSzW41uifVhZ5Lh
         v4HQOxy3AjAxgwLL0o6nppvxl0jEaNWIqkTCkx18G44JYcIjJzT8v7MLreYhZgyGuuUf
         prcgjdocsXIt3VeXe3eesb/26+oelF4BVlcYfQrGJ/mRx1ipYw2kl/+E0DW6/Z82Ir+S
         ILjw==
X-Forwarded-Encrypted: i=1; AJvYcCVtWb1g3WhAk/aOpG+tpZXLgMBUbx5NkuhB6s6eX1mdsptJeajS2RdGJgUWSs4oKD/ZSIoQki76@vger.kernel.org
X-Gm-Message-State: AOJu0YwnCxVVz0VOOK6RMMdPQYK2m/wEZgaGUaEut6LqhQ1QOO7PINlC
	DiHOV9fzpWvaKZQJyw+2bq5E4p+kCAqTxh9FE7ZD3kza3MOoeY0C4CLqhVJuLE48s/kZ5vahCln
	Cry+AZ1kRvRjqHwuEsDXI6QXwLhgTtVwFO36kzuXTuiyMZ9pu9gLg79gSXO7CqMJiUqW5gJIK7n
	Z8lCJsduMlLBK9VJhROFoNHojEydLMnQ==
X-Gm-Gg: ASbGncsbRk7jCLIc5zoZCr/atv4ASyUgQ2nvB6BizueRNIjvclN/EBIYw3rwCu0DNET
	/IgQnNMWWeZ9lyOA1/pXVj17oOMIKTJAS3/GVCxaScygVb8nmsjgMrRYW91WRGQ==
X-Received: by 2002:a17:90b:2884:b0:2f9:9c3a:ed3 with SMTP id 98e67ed59e1d1-2f9ba73e992mr5850929a91.16.1738685951012;
        Tue, 04 Feb 2025 08:19:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3tNzqy+EU7XvxQi+cg7fICk2NlmjtW/FLHsyarEoa9g32uMgqKoDLiZihP/6mbIUzBrFaPLZ4sIHN3Vf+DyA=
X-Received: by 2002:a17:90b:2884:b0:2f9:9c3a:ed3 with SMTP id
 98e67ed59e1d1-2f9ba73e992mr5850904a91.16.1738685950735; Tue, 04 Feb 2025
 08:19:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru> <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
 <6798f1fb5e1ba_987d9294dc@willemb.c.googlers.com.notmuch> <c4413e16-d04f-4370-8edc-e4db21cc25f6@yandex.ru>
 <67996154e30ce_d9324294c4@willemb.c.googlers.com.notmuch> <8b81a534-9c30-4123-bd7d-bf3a9d89dfcb@yandex.ru>
 <679a376739b99_132e08294f3@willemb.c.googlers.com.notmuch>
 <04879909-72e5-4ab6-8c28-5d3cb551feb5@yandex.ru> <679bace3a753f_1d35f32942d@willemb.c.googlers.com.notmuch>
 <CAHC9VhS-uSaVmy65oA8p6tCzMZxMsuzdmxO-vf7L0p44ZKO=_A@mail.gmail.com>
In-Reply-To: <CAHC9VhS-uSaVmy65oA8p6tCzMZxMsuzdmxO-vf7L0p44ZKO=_A@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 4 Feb 2025 17:18:58 +0100
X-Gm-Features: AWEUYZmXehgyVPBBQTLARAnAWlLsy16wrENGnIjpxFiM8a4vwAAtZ0X_3p-nmQw
Message-ID: <CAFqZXNtq7SZSu_JyY5yaiOQy89c=5jG+vqdg3_RSUWm4JNN00w@mail.gmail.com>
Subject: Re: Possible mistake in commit 3ca459eaba1b ("tun: fix group
 permission check")
To: Paul Moore <paul@paul-moore.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, stsp <stsp2@yandex.ru>, 
	Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 1:30=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Thu, Jan 30, 2025 at 11:48=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > stsp wrote:
> > > 29.01.2025 17:12, Willem de Bruijn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > > stsp wrote:
> > > >> 29.01.2025 01:59, Willem de Bruijn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > >>> stsp wrote:
> > > >>>> By doing that you indeed avoid
> > > >>>> the problem of "completely
> > > >>>> inaccessible tap". However, that
> > > >>>> breaks my setup, as I really
> > > >>>> intended to provide tap to the
> > > >>>> owner and the unrelated group.
> > > >>>> This is because, eg when setting
> > > >>>> a CI job, you can add the needed
> > > >>>> user to the needed group, but
> > > >>>> you also need to re-login, which
> > > >>>> is not always possible. :(
> > > >>> Could you leave tun->owner unset?
> > > >> That's exactly the problem: when
> > > >> the user is not in the needed group,
> > > >> then you need to unset _both_.
> > > >> Unsetting only owner is not enough.
> > > >> Adding the user to the group is not
> > > >> enough because then you need to
> > > >> re-login (bad for CI jobs).
> > > > At some point we can question whether the issue is with the setup,
> > > > rather than the kernel mechanism.
> > > >
> > > > Why does your setup have an initial user that lacks the group
> > > > permissions of the later processes, and a tun instance that has bot=
h
> > > > owner and group constraints set?
> > > >
> > > > Can this be fixed in userspace, rather than allow this odd case in =
the
> > > > kernel. Is it baked deeply into common containerization tools, say?
> > >
> > > No-no, its not a real or unfixible
> > > problem. At the end, I can just
> > > drop both group and user ownership
> > > of the TAP, and simply not to care.
> >
> > In that case the safest course of action is to revert the patch.
> >
> > It relaxes some access control restrictions that other users may have
> > come to depend on.
> >
> > Say, someone expects that no process can use the device until it
> > adds the user to one of the groups.
> >
> > It's farfetched, but in cases of access control, err on the side of
> > caution. Especially retroactively.
>
> If a revert is the best path forward for v6.14, do you think it would
> be possible to get this fixed this week, or do you expect it to take
> longer?

Willem has already posted patches on netdev [1][2] (thanks!), so I
expect it will be fixed soon.

[1] https://lore.kernel.org/netdev/20250204161015.739430-1-willemdebruijn.k=
ernel@gmail.com/
[2] https://lore.kernel.org/netdev/20250203150615.96810-1-willemdebruijn.ke=
rnel@gmail.com/

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

