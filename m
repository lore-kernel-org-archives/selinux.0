Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5562FE314
	for <selinux@vger.kernel.org>; Thu, 10 Jul 2025 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179335; cv=none; b=VPOuHWu3yPJCmQhrHBXaVAWtdmXUK4mKWafAgQ5CpP2LUg7ie8t8mM2Vw3ak/XhGe2nOaCv+cGyWm2ORzSNIL+pP0Z7voYFKkIdpUdvqeKAnUauhkI5kMCdu+vBk4fQTnhP9kpcO8SiqzIPdiLhMb2dR31Gxf5SIr3lmEuVLrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179335; c=relaxed/simple;
	bh=/wOsEIcfjn3J6qSvekjUGQIyYcHYIdn+iVCQ8+kOFiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEKTGxkWpGu/poS9IuiLuZ2v/dZqhJkEm9vrVKkBvmvpP1FEUyz13Cff8BmYzi1r4nhn+JgNUgypcCRnQ7hLde7YLmHFoiBaAAVIjzgjbAkIVL+fhKYiUPgSjcR0yN+yRpIjsZnWFxfj6fL0sK0Ak/ymEYcZah4hsnN5/LjBxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UmrQqrJZ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UmrQqrJZ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70f147b5a52so10958067b3.3
        for <selinux@vger.kernel.org>; Thu, 10 Jul 2025 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752179333; x=1752784133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xY4Bipga27Fg20OgpPWdWhIIHs7akt1FQhLv+fxqvQ=;
        b=UmrQqrJZI0XidQvQ3/1Z+UFYiyOPlLBJ2ynm2La8yX5XsDQ297j/v9JiXGb3LF0PTN
         walCqlX7v3ivGXi/kvsc4jNnw2Fz4D8jqIu65ep/q2TdRZIFohGj/YTJpPvakGRLkeNb
         Z05P89yMV7sLqcujvp1d83G2EH3c1Kuw0UYO5gavJQawfydWbjQzZu7YCZdMrIPcJVbM
         zG7Thiz5FxV21vxNt+lmnFQFI2Cj9Xt+A/hBPjTqwS2yCkV4FEjl1NtJbSMAdDOIOIx4
         5fGJbvST5lutZuuhm81+cT0mDf9iQc+F/jUL4Eo+7/uYE1Sy5qY7YMvg6MJFTKE3bqO5
         RY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179333; x=1752784133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xY4Bipga27Fg20OgpPWdWhIIHs7akt1FQhLv+fxqvQ=;
        b=eWqZ25hY2OlCcZy0C4CjDTZRM8Rnb/6rSj8JAyxMF6bIxLKt5frhoTiQS26tk/kOlJ
         OdrVq/RTWxThYAs1lMBkghTTr8i/C9qjLoYwaeLxMGPffJjpsJv3v7PJK6JGq6bEHcHr
         eB19HJISAe4fmX32KmyVSaw2+y045JBdKzMsaY6uvWUOVohyJna/GbPBtfSJc13S6KCQ
         2wGlsTyzHFOc3NUnW4ejVmCCtJVPie1/ES9whBGdwYNuD8XbtekT9VHUZ75/MbSPltZc
         qvN2koGrQTNr93kxu1YDwz9LLwDVhcVRh1HEtP6bWjA64XyQejhPc77x0EWALrol/0GT
         PcTg==
X-Gm-Message-State: AOJu0YwAobO15+pcIiaHM9FTsXxeqAInGOljPB5XgZ2G16T+iuY6F9DE
	/SY06FTHS+uobnH89f3wVeIOkVtSOdkHmEe1ttK4WPUmDNI+8W+qMfInS76D9antPyRfIIzA9fe
	iySqNNhXO6lFwIFZcuBw7qwpLIBeuAsU/XpU2k5x8
X-Gm-Gg: ASbGncuIkALiiwoAvVTOSJ1Lb3EnYMsQHtgH3Aiqy0tnNZe6DXpjiOI6QCBs/RMzMaq
	O1NAMHFASlovgUX4G8K8SQzohj924L/EoV9eQPiudffBRF4LIKrDdKAmxJTb1NSKH879J3Iac58
	jyES7HVr9FOOSzXnUbbXd3+IrhLVGatnCCKNOybn3qN5c=
X-Google-Smtp-Source: AGHT+IFWABu0KWjC6/bF/AhMUd9GAjVvZ7VTl8bUWarv08izcwlp0tLlCNi/opmy0gRAqlH2uF/+eFNT7904b6gmlBs=
X-Received: by 2002:a05:690c:61c3:b0:70f:83af:7dab with SMTP id
 00721157ae682-717d5b80b60mr16673097b3.4.1752179332591; Thu, 10 Jul 2025
 13:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708210748.8782-1-paul@paul-moore.com> <CAFqZXNvDNAtukRPhKFiQmN+koHOevx75qGCK0uE5nWX+afTPqw@mail.gmail.com>
 <CAHC9VhT=BG_3H=JAuJzcWKABM+eHBZYRHjVoeomRnH0OHkR28A@mail.gmail.com> <CAFqZXNvxvZO9tOCpxshOLkQy=ogka=ow=njeb9By3MP44HjXWA@mail.gmail.com>
In-Reply-To: <CAFqZXNvxvZO9tOCpxshOLkQy=ogka=ow=njeb9By3MP44HjXWA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Jul 2025 16:28:41 -0400
X-Gm-Features: Ac12FXzarCk8StlPssI2sJTYtj5NjwC-lJoRxdYsuMBeEzAc-iUdF3zY63QaXiw
Message-ID: <CAHC9VhQgjkiiiFvYFAOKhNG2FeKEn_S7YphxSZpy5gG6qvV+Mg@mail.gmail.com>
Subject: Re: [PATCH] policy/test_secretmem.te: add anon_inode perms required
 in Linux v6.16-rc5
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 6:05=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Wed, Jul 9, 2025 at 6:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Wed, Jul 9, 2025 at 3:35=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat=
.com> wrote:
> > >
> > > I'm going to merge the patch with the extra permission dropped, since
> > > it's a minor change. I'm also going to add a Suggested-by for good
> > > measure, as Shivank originally drafted the patch. Thank you for takin=
g
> > > time to formalize and test it!
> >
> > A more careful reading of the other thread would have shown that
> > Shivank and I arrived at the same/similar patch independently; the
> > Suggested-by: tag in this case is wrong.  If it was the case that
> > Shivank drafted the patch, you should have contacted him about adding
> > a Signed-off-by: tag since he would have been the original author.
>
> Apologies, I must have read past that part :/ You're right, I messed
> it up... I guess it's not worth a force push to the main branch, but
> let me know if you'd prefer that.

The important part is the DCO sign-off, and that's correct, so I'd say
just leave it as-is and take this as a lesson for next time.

--=20
paul-moore.com
