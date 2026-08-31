Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E337DAC2
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205284; cv=pass; b=IwbQYcuH83PO8Vn7bqU9sPPJqDMmA0QRbC39yD1y7yZAdo7HDWrRvtD4QTbcW0oh2eWO6M8H6C1l6pNOK/fUnPjk6GoP9qsX8jw1S+bFCFoSg5NJzk6NWW863j08zFAZNM6O3a6zoQ5CnupQgV4xJEKi8GpXfKLUPArZgfl1p/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205284; c=relaxed/simple;
	bh=Kjoup4KDdutAD/AolEW3YIQKVgoqUEz1cobB2RPiE6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3+4ZzRoO6Ij/beRBsMqErGcMzgbv7RZjD61htsZrsSfC1ODjsPx4YKObsvTEpcYKnau7l/HyfWIP3kql336JMyYpdhbbWB/76nJrN5BgqXLD/4EAWtUQhVXAhwmE5RnUQrExB8MkUx4VQiS6WGvCXZ4QgLGN03Xft3ZP7VSJc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PytMdQNm; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PytMdQNm"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso75961b3a.1
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 12:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788205281; cv=none;
        d=google.com; s=arc-20260327;
        b=F+5BnzUqb3U3Dk+gunDrsoQFeHdeldVyYKjq4qQrsb7aSuDz3xWJibaAp3jFsW16qD
         VvY3K35KOSnowlDQSu3DcC9c7kJx8fRoUALJ+nkg8wb5Gsar+9kTDZ1PqP/b/W79Z8x4
         CAz1PvhSNfQRx1iiKrr9tIqfVstT1bInHWRacqTgzN7WwDkr1pS9vTkNKkDCH80GuGxW
         wyGDoAenxhqkAx/i2YzLy8aOcRm4U+R4N4P4xfp12/KXoNZe9CcKEWQMEJcs8XDxSHwX
         So3OKBX8UZbAIIKWe1DR0TZ1R3uW6k/vbmI1j5mhJCpg0Tf8GjUi3JjMDV/YMj1g3P4L
         0qeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zoqoJxqU45eZFqkD0UaDO7HxA0/VF3RGvncekHzDg20=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=V5zb5+wbkT850GxGJGMztaTLDSM+ggGSULvIg7G6K4siDsk08ul9iuwvi9Y1iL89pR
         EteWaF4QHCnbL8FygnX1nYhj+Uk9mA+5b23zlDEMUXdPVtqDRm23CaJrWPm49EtqDBVu
         BrAMVDRCV0rneHuMxz1RLyWBqn6mtar9VzpovwKhSwofb9uZkyXHR8qrm/9aAF1zreL6
         /IgDLjYRy1ILw0NnbX+7VA5C4N0GvuoQ0W58ZDe6HUM7UE5X8jImPOb0oBJ0GEZM4LAL
         46pbIEz7Vol2V5dgp6qMMhqFKicPiBwqNjzOu72Jyaq+GKLwfp/iirL4F6pSeCqx1k+H
         YUDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788205281; x=1788810081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zoqoJxqU45eZFqkD0UaDO7HxA0/VF3RGvncekHzDg20=;
        b=PytMdQNmUmsfTp0zVLAAIszIzFxEOCu/9gL4s02FB9hfdxqFSr7ja7+NkDgT8GO90I
         OLpdjHanIOwn4+jhlBfWvMEKY/fx+qKRakL3LZ3SPQ9pLNftMX2QOJClPjIg58puzW0j
         7lAZI4zFtg8MCXhfENSf7RH1JyzPmCpMFQuDHqfRQP45VWw18Rppy7VJG+dJ2eKz0PZX
         W1Pi0umvQNn8k/+fdJP0M2LFyhExr6T9fTcxsO5FE6sp2lw3uBweSO9WTzVY9pvjWW3+
         YNb45rSAAjy07u3MlPp0EDKNmRNDV0jv//m9wk3HOyCDKq/85pMiAOk1N6KUqqWVB0Wh
         NeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788205281; x=1788810081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zoqoJxqU45eZFqkD0UaDO7HxA0/VF3RGvncekHzDg20=;
        b=JcenD8xpTjBoRogNDdeS4wjY15+H19ft/32Vuud93O/Ldla9p/Na9Guw35RuNKIsuG
         6qkT2+/E9/C/4LcVZeV/Lpx6gqDbR/Stu3pIWYw5DCCn+LHegPOyhp2KliEz/IohoKQL
         jvGPAiRYnYG/fJK7kR4k8hf0mldiHe7vXCSuAj2CnPs+iq+FAToz2c3/pGDlek5t1TW/
         wT5hr70pcQA4+quU8r5TNkrlBGXXr4zu4AigLPIac0gJV/GXgAW1SD7NBaIfEj861JOE
         uO35iBnM+y1kVcjTAJ4q1+6Ah2SicgEV5OUPdjdBWKYdcgxYT46/JYER8PDjCCYWnlY0
         KwIg==
X-Gm-Message-State: AFuF++nMiBxcNxzr6q3+724TaNpYaG0C+7EJ5d6j/WINmz78CxivdWiR
	Tu5z/Wc1Ndx+aArbvA3T+ZSyCSu2NGZj1BrL0otQSqnpnbZxgNgQGCQ00shJ4w/iUAOoTC9eFeg
	Yt5qdRVZohV2ATrVhw31N3MpfY7VP+QLOyfj/K7Jekd1/AIOojj1EMQ==
X-Gm-Gg: AR+sD13txPagfz25XqVaVjrb3uC9yGAXfYW9fT34J60/tpBlLHm2nHyAFFly8BPlSZ4
	h5p7zDPdqRWLmsSt/hNnlRxLZONK4H0XXeQJapUf4D7wgcaMSSgxX6rlT8AF+7Rwu6a2vhNMTEM
	ULfqWML+7g3HoixjnkbMZlZ8ZafiqHUJSO2U3Z5ipSg0N4cWXM6N0DlnG+2x4uxZUTQBDiJvjVH
	Q4rnjftXkCL19KTVE84QPafOSz/vII+0hdo/m4qOof2dOxU8q7JVYIjIDhYIYsZViVtLDt/q68S
	axeKKIcLrbVngKBCJj4aW2BsXspGTAMwT21sNy+8F6XLFA==
X-Received: by 2002:a05:6a00:7616:b0:857:4dea:e1dd with SMTP id
 d2e1a72fcca58-8574deaeb9dmr30050377b3a.14.1788205281432; Mon, 31 Aug 2026
 12:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827151126.107545-2-paul@paul-moore.com> <CAEjxPJ5HeZ1P1XLs=EoG_F427hWhUphebVthr+MhnKPR5aWNTQ@mail.gmail.com>
 <CAHC9VhTzeB_pVuu8hzbwbefw=Xz4DCg=t7WUTJXGtj-XP8sL4A@mail.gmail.com>
In-Reply-To: <CAHC9VhTzeB_pVuu8hzbwbefw=Xz4DCg=t7WUTJXGtj-XP8sL4A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 15:41:08 -0400
X-Gm-Features: AcwNN1UzoxEcCZnX3vC0x7LV3GToSTi8YWrnzqMT8VudwRODBfe_8JxkOynvZRo
Message-ID: <CAHC9VhSmfqFJwkjCx9UWL6yTFRdYQyqoRb4YVNvuMFkg4H4U0Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix BPF token permission checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Aug 27, 2026 at 12:23=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Aug 27, 2026 at 11:13=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > >
> > > Avoid multiple lookups of the bpffs creator SID using the token's fil=
e
> > > descriptor when the same information can be found via the resolved
> > > path/dentry (in selinux_bpf_token_create()) or the token itself (in
> > > selinux_bpf_map_create() and selinux_bpf_prog_load()).  Not only does
> > > this simplify the code, it avoids potential TOCTOU issues if the user
> > > changes the token file descriptor passed into the kernel.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 5473a722f782 ("selinux: add support for BPF token access contr=
ol")
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Thanks.
>
> Given that v7.3-rc1 is due in a few days I'm going to merge this into
> selinux/dev-staging for now and will move it to selinux/stable-7.3
> once v7.3-rc1 is released.

This is now in selinux/stable-7.3 and will be sent up to Linus later
this week assuming no problems are found in linux-next.

--=20
paul-moore.com
