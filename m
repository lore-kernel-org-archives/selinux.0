Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3582149C74
	for <selinux@vger.kernel.org>; Tue,  6 Aug 2024 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980637; cv=none; b=e0mOJuyMz3/NCCtcbXvEZrYP8pUNZn0IIIWXnFZg9nvkXprMZhZe0mnKeoO3WI6Do3GAXwhS/nmrG7DINdkbJU/klVjPTN3jL0DmC+XrffpqJ0A1Oy6SMDWsYETRgOMNj5n5NhVjWGUqEXAKZr9+8M5h6wH/9SMaef+1+f9o+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980637; c=relaxed/simple;
	bh=GDLt1yaxQHKbA3TwlKzhqHaV2yLftQnH2BtqSFI1wFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPdh2zYulZHVpfVz36EnOuLqT6Vp1tMKQsFpGiXaS6NbRourICdFtHyVTr8fvHbKG5eOCArqMHgxbthCW6HVMyr5rt/q6VQxIMdb+VEGW6fqF/ibT7NKFbh2MUmK2Ious2oeVr6vPETAZK2CD1TGip/auN5Dl/tes6RbP4ppcXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QlbflGPJ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QlbflGPJ"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e026a2238d8so1036599276.0
        for <selinux@vger.kernel.org>; Tue, 06 Aug 2024 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722980635; x=1723585435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDLt1yaxQHKbA3TwlKzhqHaV2yLftQnH2BtqSFI1wFc=;
        b=QlbflGPJ/18XkmuxJOk8Pps8XEINRiZuoCu9PA8ksYu3B4BEFfpE8VPQ9RoxrjDI6w
         ///wHc9wmuqBBVULgwkv7De6oudcAAQU221spFY0yzuxQ+WN4ItsKo7JIg8jyAVe4VVl
         wnqMnGfdcu10e21tj17cKsaAuq9NgKoJjD0WhTX558Coa1t4bn/RHFNQviMbiE7SAZ9F
         IcFef6ZPQrND42nqrpAuzN8lqBVEfw5E95YHmmwFwZk4f6a2bHaqLLSqy7b84XBzLqG/
         IQZlQGOfTwihtFnlW/wV2eqUuC2mJhV3fAoFDIlGXzSX64VEGuv84DUpW41kCWtwl1LF
         wZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722980635; x=1723585435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDLt1yaxQHKbA3TwlKzhqHaV2yLftQnH2BtqSFI1wFc=;
        b=I7YptcYywC6LrzjXjvaIESZsTAdNhzsxkoEvBSNPzsVwLcYO9W7AZCiyFKOuPXCKuq
         oDppNvMIoHZ7HVKF9kYu8GT/SQ4IUo4a80aMmTNaQ76dESRBY25dWgTkU2phjvIA2b53
         cfTXzD1LTYV8ayUittKChWAY27XVaUJprP8VEZIw+IvWPXlgvZJUZCTULSzoD1G7N3Qp
         fnIzPuNyFgRvmtG/d+1HIsdyfLu1q8B9BmwGuq5nd1zo5H6vrL6CQKTHNNNXb8rNRguM
         KcB3YMhopti8LJs3Ux4BiKSauRPflgubpeEScmq1Q1BO7QMCxPznaXexlNI3IyZ3wBWl
         PSyw==
X-Gm-Message-State: AOJu0YwmShCCWw4ihAqv0sInARelirW5Swm2xEzbMJnFJeAid8yCh8v6
	k0ov9nPZmsbIYm5SUF8Xw3hGjWUusICViOENLvkqfvvZmJ4nJ34aIAnaFqKZEcSpyYiDwxYquIl
	YY9tVFSTedx/2eT2fLg+8A4E8nF7BtJK3mL9emRYbxl6wJ8U=
X-Google-Smtp-Source: AGHT+IFdk6///BwAkELaLVDymYLehyF/iFxjtkc/6By2BF/4qrwpNsjqKIv18MbzIjbsHS3myBwblH4i1UaMuDoeCn4=
X-Received: by 2002:a05:6902:1105:b0:e0b:e3fd:c0e5 with SMTP id
 3f1490d57ef6-e0be3fdc87dmr15938851276.31.1722980634656; Tue, 06 Aug 2024
 14:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Aug 2024 17:43:44 -0400
Message-ID: <CAHC9VhTc0CqHfTtsNbgk9mEV1p51hpHrmRdC_M71rnY=SHHoDw@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 8:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Given the recent discussion of the SELinux namespaces patches, I
> re-based the working-selinuxns branch of my selinux-kernel fork on top
> of the dev branch. This required first reverting commit e67b79850fcc
> ("selinux: stop passing selinux_state pointers and their offspring")
> which I had created at Linus' request some time ago to avoid the
> extraneous overhead associated with passing those pointers when there
> could only be one selinux_state structure. Due to the number of
> changes, both substantive and coding style related, since the last
> re-base in 2020, there were numerous conflicts that required manual
> resolution. I also checked the coding style of each patch with Paul's
> scripts and fixed any issues introduced by the patches along the way.
>
> The rebase can be found at:
> https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns

Thanks Stephen!

[SIDE NOTE: hooks.c and security.c still need to the coding style
cleanups applied, I'm hopeful I'll be able to get to that during this
dev cycle]

--=20
paul-moore.com
