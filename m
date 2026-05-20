Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B136A376
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297740; cv=pass; b=IvXIcT5GUyL6ynKv9cWU2CUTFckldUBj8UV7q+q5R10Ody+Rpw+IWrnDw3HedlbwFnR36EgZZD2Gk3GOBp/KzyQbWfzjJsv/l2fOOp9ISp1mdYnR4kkq59ZvQSsbNvAwV7Wyo8YZTDLXiqRrmuEFovMiiVRm1DxJQ7TRdUXpGPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297740; c=relaxed/simple;
	bh=C43nW7okAgy6kOJVfY7Y/iTaiAUxLfdPJ5NCEKkegio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keY4BiaqJ0IrZXXcGYSgS1bj6IxyFowSh8KtuckziYDAcDOOcKad6psjrv8b8DVMckrZKM8sZaPzF0b4TQszNQ0GPujMoIoz9fMKanz7wZpJAATIn46Bue/jCbV1TvVyJrn6ISUjMUfRhHa6aUxV8T0WuQnpKwTU5uZpS51QJog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKjtafOD; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKjtafOD"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82faf871346so4044298b3a.0
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 10:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779297739; cv=none;
        d=google.com; s=arc-20240605;
        b=Sxcnr5qDIfYw4iHWRU+pw8RhXB9EaGT06yZatBQMeKdXMrX3ZKzwsPypJnWA3SrEyf
         +ZArHW5DT5IQIvyMgDFiqOQSUITOT6+uh7L5+95qzKBDhYXFKzdCf/ok+5RE8hQWA0rB
         BEP1a67sdtfNGxsk1hTzjI14BTuCf4D56ZLD4FESGZ5tBR8bcpDNQOJ95jgC8EyXald5
         H/ZNyyj4G6UVuV3/3ngGTGY+CDxEJgoR+lgUByMmK3KhrPJVftC75SDKh25akkO69RxP
         goQIwo13i/54qfQVhIeoyhsBz3i18kZey31/O9oZ0jL0Lo4d3ZOIjCDOxLxh77bTG0ba
         FAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sw5MQOJzVFYQ+Ka2DQZ8dp+HxM2y5uQi5qKmmTEnI6Y=;
        fh=zsSbkEwSh7brMl8sL/6IC3gI3Z2cNOEbDrjKJ7MfXIU=;
        b=geTwJnPcAlLpxYMM/IAr8R50Cw9cWSPIp6sTUd0HyEHYyRAnztkiCKpI+WRILl7ZWL
         soHQK4KN37EaClkHzVLVzJl35bmvmJdUuC+NwdW2xqHJqjan9TKvFq8I2EXTLzvB5/1m
         GyAlqhm+ziQ2HI7z6IpiXVvjr9o4B3VjWwZTVKFxswamYOrj+7ncVc2TRD3zR8l/w6Fj
         D4pGuVHlMTFUHKjw66SrxC80xhT3tu/hi7XWol9a08PUWMpwDiqD5ueYCJhtFGjyeFX/
         EZnibzAWgVUUjOqOr12l79dZE359RRuXlh0LuivXawlSq7ruTJq0hl0Rg/BEFC3U7emv
         cpxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779297739; x=1779902539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw5MQOJzVFYQ+Ka2DQZ8dp+HxM2y5uQi5qKmmTEnI6Y=;
        b=EKjtafODmfIg5zkgzdvmHnUNdCxZxoy/r+46hJJNfTto402gUX5ssOyurhZ0NTipnk
         Zn8llnIf0KqdiVnn2mQ7PN1NIKSFdkPiGxfGhUFhxej5Zq7tpbdAyzo147fy5P3ORzzK
         UanGSXzmdoJUM8sZ5A1nDfWhqAg9GaKLzZ9TT8IwemEcCAIBvHCuv7Hgdl+dkV8ZG8eK
         020MKTn+cUCJyFCyohx25dLyAG8JaJqkBCv7SLlHZ4KKB5+gxuCDunyz8aY9vu92yaqF
         k7EbmCM6MUV3cjNDTuI9HMi9/dXKQ/XR6v7ZSSL8x3eIrQ7St2E6H8K05YnSAq4Navgf
         +EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297739; x=1779902539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sw5MQOJzVFYQ+Ka2DQZ8dp+HxM2y5uQi5qKmmTEnI6Y=;
        b=WCgG03X68dnU1PG1Eqh7qdXpxw+2AgD9WO+3V3B1YmuvmZYc/K15bS58Se5zJdHYCR
         KNA8AeTQiYj8KpqzJD06wdcfombAeecZqhMbQev/7YIJsXbUFnrBE4u70KpBHDPqSZ5G
         CpuZtXld96M/1DlXl2teCbVUQYR+HXvJkFGs5ORaxudY+ASIIgEuaccy34b1sh7e3qcJ
         4ueu3aDd8wTOXJ0DS8RD911KrowjuZ+S0bqQXyTcVomeCIRBkIKtS0Sd6mlrhRga5quo
         a2hwihQWmXVRt9X4fBFOm0cxEPjADm2oUMwWqhp4uuOfgG7ClvsjD/cd6Golzsd4l25i
         HWzA==
X-Forwarded-Encrypted: i=1; AFNElJ9+LZyIWrXjSDIx6HYwc/86aewAhcUYQeafs9hlgFtHiTZidSGaJujFOeU0EsOz7TKFrPQ3snNX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fNhxoEp0ruI5swk65MXt/bPhHcWsWI06BsYApS0B+lit0X6A
	quZx5vmOcLzDH8HRTT1ta8UVyhwl2iCFNTwRzDXxENrEk9Ze4jvR4rDyJTG4NQ+5DGDxRVWDgIt
	lr2Rc/G1WgBuCgDpL+6xsHB+cE0ydlpK/SQ==
X-Gm-Gg: Acq92OGtMFEt0vI117tJXPoVkiZpFqfw59OTiGgDLsvlSzm/xY8ntS+qtyvk2vbB2Aw
	2cxXAAx4dtl0wr/RSs5lrZT7G5sYGVInudoll6SiXtLrHWyXk+jSWFg7gEipr51b4Yyqbo0K67N
	Qix3tbCYI86hpq4E4s5sE1DF6XBYZcKq1MzUX2QAN91i7V3Yn/v+Svf+yfDyxNYegI4yf9065uh
	Vq30rWahdGi6Myso7oWUYsoj6Ox8sSPladUJ6bLB1BvGpZYw8pMNKzRcI+2y+HV3QA0Kn+3z+Et
	6tyzFSfp97ztnGKaaRf8bySn64BR
X-Received: by 2002:a05:6a00:240e:b0:83e:d996:92fa with SMTP id
 d2e1a72fcca58-83f33b2d29bmr25685745b3a.11.1779297738607; Wed, 20 May 2026
 10:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507161633.15947-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ7ynbRQ0OAwFUj7RGH17WBpC9Ekwhkadu=wfq13XjAicw@mail.gmail.com>
 <19e462c5110.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com> <CAJ2a_DfJZzZUe7XoYM27gQSPgBsEnXkCL=GX70Nvys6XN7776A@mail.gmail.com>
In-Reply-To: <CAJ2a_DfJZzZUe7XoYM27gQSPgBsEnXkCL=GX70Nvys6XN7776A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 13:22:06 -0400
X-Gm-Features: AVHnY4KwmaY0WcxcDfbFha8y9jYBSdvcHALJRuh1B5RDLAuc8J1_psGoj6C7_Gs
Message-ID: <CAEjxPJ5ebd1jhQw6bh84qTc3fNOsmC+HFU_74KATJ4mwdRyaSA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: tighten type validation during policy load
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 1:12=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 20 May 2026 at 19:02, Paul Moore <paul@paul-moore.com> wrote:
> >
> >
> >
> > On May 20, 2026 11:45:57 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >
> > > On Thu, May 7, 2026 at 12:18=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > >>
> > >> Tighten type validation during policy load to improve robustness in
> > >> the face of ill-formed policies.
> > >>
> > >> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > Ping.
> >
> > Pong.
> >
> > Just a reminder that there are free things I dislike more than "ping"
> > nudges. If your patch hit the lore archive and is visible in patchwork,
> > it's on my list; if I haven't acted upon it yet it is simply because I'=
ve
> > been busy with other higher priority things.  Nudging patches like this
> > simply steals and wastes time that could be better spent elsewhere.
> >
> > There were a few of Christian's patches that weren't merged due to feed=
back
> > and other concerns, but I need to go back and see if it is preferable t=
o
> > fixup and merge those before looking at other patches.  Maybe this is g=
ood
> > regardless, we'll see.
>
> I'll try to address the comments and rebase *soon*. (Haven't found the ti=
me yet)

Likely helpful if you can clarify whether your patches add equivalent
validation; if so, I didn't see it.
