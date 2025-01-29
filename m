Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED54191F84;
	Wed, 29 Jan 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159978; cv=none; b=AD29T0UurXHuxbMdRMtjtt84ShuWXsH6IiJ6RkYT8SNDDtOoFQjSEosLKMFYhzeoOaxjPQuBUSQOM/Cmo6h8K98gJs36GJO1InoKE074BtE0ndudVw0Y2QvOCQ6BkPSX0M+hJiCUqE8WoQ6hbE792l+l+fXILCNWYYH+gLDoRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159978; c=relaxed/simple;
	bh=O4lNDCz6kT9xbeqIv1IjkcASwMTjjglNG2A/rVC7KXE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EV1WQIC2D/8+M7mA+MdzC4eo0x5hIPZkQL2HKV+pQNQAqK9yeJUPRTszKesLfm/Xxog5zfJKVSzLVveqFY5w47/QQAiaV4XqIKV1BdGbnAK/PLrkGTl3MmwNy9NPNXvslOv1y8LptEd4fxjpsIPTE1LvLB3TECPC+Pdn0OvkfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdQpeuv2; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdQpeuv2"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e1b11859a7so36935836d6.1;
        Wed, 29 Jan 2025 06:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738159976; x=1738764776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek8eJCXUCCmExLQLQk58UyQSg8MbUlPNZk5icxwHmmI=;
        b=UdQpeuv29dL5nNTouQ/4eqqmX9f6MbFlUd9eOPPjIGZ2cFtQV4PKBExDXyz7XMBH2v
         TNq4/WXy+uMr7ytugS+PeSz16GdSJidSjtz+l8YGvECSOIaoTWRrqY5KkuMnZcX/wOE7
         1zyQg8dBfSELMU4XLSJm+9JD8OmxPzOA68+rCs0N6JA9W+Zwhri/fHhgzOMqLCU49vva
         3JwSlfYg3e4OHR9zr4K/LtWPf4REGN4S3cuW8eR6qXMWR/9VkfuQqFHoo94UkyChRrLf
         GqxUQNc7jkVQJNVHS56SaEOlLDoebHOEPj8UqkS4t/DHCOwONF9HPWB5Gw6iDI4hArUl
         QbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738159976; x=1738764776;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ek8eJCXUCCmExLQLQk58UyQSg8MbUlPNZk5icxwHmmI=;
        b=GfZi9xorpQ4u0V9mm+qv5CUVpuR4H894VcZxvQDyi3QCmFYwz3AK5qUWe2xs9AF03X
         OYzCVje3wfJCU9pELfAY6xp/323gdGdBa5RzythOtP2ZUlCO4mJwwtPRMyVN93SccMbk
         rbzvfhM5VlW5ufOlTdYWf5otLhuj1VA1J1X2DQ7zM1cWHSAhCwcS1248npyUi5E7XVa2
         VOflqnTvB9zclcnV46hM8AadNFmVAGXiAf+nLCsMGmr1sCqqJIPejXCiaxlgddPts6gI
         EN4PgX4m5+HX3999/gbysFGabgEMcW2D8WbujPdir0cAY3J9564M8F53Mp4waLh/J1QE
         NPqg==
X-Forwarded-Encrypted: i=1; AJvYcCV7PCDPg6XSziO7EsW3sd58bqISBAwvz3ngnhtbMuuW6Bp+DU6xuRBLBFVndwahFbskAc7nL3kZ39G8ps9pJRRnE8ZmEyg=@vger.kernel.org, AJvYcCWP3/9yYyCzuy/eZMAHvYqQeh0DWplLfwYvUsNtsuhbeNeCZ949IO9pTO5MbjETU308uKX1NUvP8g==@vger.kernel.org, AJvYcCX5caw+wirfk9ziSMusHai1HpMz4jYH9RnPuWlm2MXOEWpbpIM49VGmE2VzkMN2KAczoelEghXx@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYMAvfmcGL48yqulLlF5Nr7QCsgmxIdFPW4wn5BoofU+o9dpQ
	SnGRuDehAjUEy5nmV9el1k2F2A+0UfJ0XCaplGtp1usmNsm9uUN6
X-Gm-Gg: ASbGncuK/+1HMaYxvU8ulVgKe6LHXCms7h9lqTeg5RRv2t8YeZ+kAJGUJDoCHhMDafq
	iXBjYntBQW0CVigbVWxUfs4O9pR7RbS98PAq3L4aX1Dv2OonsjDvxFEb7rKiq8yyztOqSDEQTbx
	pWnWxhFp/8gnRqXzIa8YpY/W6VaSsggvctBUdZqy/pXCuIY7J3HWZza1e3nA9Y3Cii7IRaRlLWr
	6L+5srfAPix9qEBbF1gTaqMi4arrtVuZTvRJXBj1NDxWwkAxubeSpp2d1DPKPMJrNACduth46ki
	RcPpZ+Rx7TbDYbUZpbw/XTZZbTkLohrpiaRfGjheUD+8HDEMiPSAimWk7cQZSH4=
X-Google-Smtp-Source: AGHT+IFVSDYJ5VMngE/uoZVT+AczkFSwpn/OWJjKkh8cFG9+qC0IfsSA7DfJwIMSZRUZfOWM6Ej3OQ==
X-Received: by 2002:a05:6214:1c46:b0:6d8:b401:44a6 with SMTP id 6a1803df08f44-6e243c7e0f2mr50612156d6.43.1738159976023;
        Wed, 29 Jan 2025 06:12:56 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2058c304dsm55900026d6.110.2025.01.29.06.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:12:55 -0800 (PST)
Date: Wed, 29 Jan 2025 09:12:55 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: stsp <stsp2@yandex.ru>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 network dev <netdev@vger.kernel.org>, 
 Linux Security Module list <linux-security-module@vger.kernel.org>, 
 SElinux list <selinux@vger.kernel.org>
Message-ID: <679a376739b99_132e08294f3@willemb.c.googlers.com.notmuch>
In-Reply-To: <8b81a534-9c30-4123-bd7d-bf3a9d89dfcb@yandex.ru>
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
 <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
 <6798f1fb5e1ba_987d9294dc@willemb.c.googlers.com.notmuch>
 <c4413e16-d04f-4370-8edc-e4db21cc25f6@yandex.ru>
 <67996154e30ce_d9324294c4@willemb.c.googlers.com.notmuch>
 <8b81a534-9c30-4123-bd7d-bf3a9d89dfcb@yandex.ru>
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

stsp wrote:
> 29.01.2025 01:59, Willem de Bruijn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > stsp wrote:
> >> By doing that you indeed avoid
> >> the problem of "completely
> >> inaccessible tap". However, that
> >> breaks my setup, as I really
> >> intended to provide tap to the
> >> owner and the unrelated group.
> >> This is because, eg when setting
> >> a CI job, you can add the needed
> >> user to the needed group, but
> >> you also need to re-login, which
> >> is not always possible. :(
> > Could you leave tun->owner unset?
> =

> That's exactly the problem: when
> the user is not in the needed group,
> then you need to unset _both_.
> Unsetting only owner is not enough.
> Adding the user to the group is not
> enough because then you need to
> re-login (bad for CI jobs).

At some point we can question whether the issue is with the setup,
rather than the kernel mechanism.

Why does your setup have an initial user that lacks the group
permissions of the later processes, and a tun instance that has both
owner and group constraints set?

Can this be fixed in userspace, rather than allow this odd case in the
kernel. Is it baked deeply into common containerization tools, say?
 =

> I actually tried to address the
> supplementary groups problem:
> https://lore.kernel.org/lkml/20241108204102.1752206-1-stsp2@yandex.ru/T=
/
> but nothing came out, so I have
> to walk around multiple projects,
> talking them into a new semantics
> and representing the problems
> like this one. If people instead
> concentrate on solving the inability
> to change the supplementary group
> list, nothing like this would ever
> happen. :)
> =

> >> Also completely ignoring group
> >> when the user is set, is somewhat
> >> questionable. At the very least,
> >> perhaps then you need to explicitly
> >> clear the group when the user
> >> is set, to avoid the confusion.
> >> Having "either user or group"
> >> sounds like a sensible semantic,
> >> but its a different semantic.
> > True. I think that would have satisfied the intent of adding the
> > group check at the time, and would have avoided this situation.
> >
> > But we indeed cannot retroactively restrict allowed behavior.
> > As that will break users.
> >
> > Conversely, it might be that an existing user out there depends on
> > the prior behavior that only a process that matches both user and
> > group can use the device. Which might be reason for reverting the
> > patch entirely.
> But this is not an option too, let
> me remind the previous situation:
> 1. If the user is in the group, then
>  =C2=A0=C2=A0 the group doesn't have any effect
>  =C2=A0=C2=A0 at all.
> 2. if the user is not in the group -
>  =C2=A0=C2=A0 no one can access the device.
> =

> "either-or" semantic is a direct fix
> to that, as it represents case 1 and
> fixes case 2. My semantic covers the
> real-world situation of inability to
> change the group list, but it needs
> further tweaking and discussing.
> Applying "either-or" may be feasible,
> but the complete revert looks like
> returning to a quite broken state.
> =



