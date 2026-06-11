Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9877E363C6A
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173476; cv=pass; b=oYdKwCenz+YZebWhC5B0YUzCTp5QBaU6PdlhbQLsFDSQ2jyEhgOyG9McevJgnU/36TbJ00qtmcqy8L2ru7iieFpHSrssWjaqgkgcZucB8xSdSQy6p3yQdr8YRZMrZW7ggOFMPcOBax47/d6K8PP66hZvT7Z92AwcOgVrv7v+b34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173476; c=relaxed/simple;
	bh=EvfpDVi+MWP/Yl+nCamsRxBlTOPe42gk2ioFWkDI87c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QO6kuf9WwfRJuyz5tno9sNwq6q2oHo2MMoe6cnt1m2mhXv7/VYvVqI6i4aJsGi75NeREbe7fKoA7cb7x6q2QxjmuDDo7GkItZR3EX9n5t/TSIA3MYx3UNa8fq1Wcr24PKi3kohlNhQ+LmNspZYmPLTgLx2QO21y9Y6vm0QHy7Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsK5Zsaj; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsK5Zsaj"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa61503fdaso730307e87.0
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 03:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781173473; cv=none;
        d=google.com; s=arc-20240605;
        b=CLNKGJgaCTS+4YHgK4JQgrw5Q9mfXAYQ4SaMDUZsI98nCKYdCooa8dMC2ae8HQ5f4h
         Q6mNBrF5ql+jn6LkTStzOqzjukZ+naN3NgyjBkpEe7B0cZ/olRKsB6qJvg3cu7xg3TAg
         jMXTyRedg4qkAYfBcDsbvAjx2aTOZBWIEt7fPIzKZJUn2Ovfl9Bhx5n3yJ7wJ3XCgAMy
         6T7x90LTwmXpBjRQGHvkYC2YI2pPYzXjamquDayR6hG3UJ2yE+whKoihao/QXthCi6VB
         WBYFxtOCn127KTSg6QHW0v/t7ehnm5yH8ogxrwuSlvoGj5uAZTrFr3JpuIkPugGVbcfy
         Ljew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=odqGdOtLagfQVos05LnrG47yQzIpR7cm2wVlbT4YDX0=;
        fh=PvVq3dmv8yvnCRJYSTWWanBfOaJzW2R+gufroGOSnBQ=;
        b=EA+DU25baf0xgW9UfPlpuCy7XXQWTYq8VDtBS9aGM7Wi7/8HGnjV8Pq/WQgapUkrfY
         KP+M7ZQgksFhZgv+mhQwGkooP4PZ6dTFo53zhY876HmcpYGQRsPe88zSSXrOUjRMread
         ww69dwUDJ+lwsAxQorzIKfvil17mgu092MBdUKBBejfJoC+Z/Tpu+SpaWPcxNxn85qxh
         /wfaNn2Do8RyaHC+OYNCYfkVOnJrJsJcStl/ZdAQdF2693yaDc+roeXSVd8lcsCvDP41
         pZuhhqZdd66Q9i+JedM8NknIC+FWnjIvgTBPIt7ylxIUOmmE5fFOVFQAbnm4p+WXdCWr
         lN4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781173473; x=1781778273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odqGdOtLagfQVos05LnrG47yQzIpR7cm2wVlbT4YDX0=;
        b=OsK5ZsajC2p+NDN7Y+aHr+w26AuavGnJlmbWZ1YjOJQkPapMO5Rancmxl4//QvSKjC
         cKur+WxdGvqxm13eAUvKDbVMjwfV1gn+tLajC0+iptTzm4OG0RXnAKyA3C00l/+8WHqA
         dIBR3u+Z7rT3dMdO5QYhbSJWvc5gQWtNhP3ywWdnwYTV6CfGdoSQ5n5ftKd2fnwqXIW/
         L+net06MFGxxCANtW13zX1INB+v6frSQpjklLbI+BzaNaDYwLQc+wm4nMDUd1IDSgnMd
         9RYe9TO10KskYfJth14D6nZ/Bne6R0NGiYOvW3lP0VIjlaSZD5gx5jCUezHJq9i9TcVP
         /BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173473; x=1781778273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=odqGdOtLagfQVos05LnrG47yQzIpR7cm2wVlbT4YDX0=;
        b=afuRgIHYfRoiVq3LCD20b1x/8DxUZ5Ex12m/20/6S+N06RP4eyP3zhkzMNr24PX5+K
         0rl1pLMuK2Yqdope8Zs1btGmY/fwVayhQkzrAcqq6h0eC5j31djhF0YHPwwIVfjONYbo
         ncs3LKLCO/j3gRkigZt7GWQ68I988X0hz6OCX8WS6jSQ1DGuh5lEpi7JS3aVt6fzkbLj
         zYjwis/2qY5HrKd4PMDc9xVRdmS3MoJA0v/MUqTbEhkRddhaqX1sR4uYvkJwRPWrAmiE
         AfodhEa5nTb0+2ILJth17e4UlqpoRH5ntNHKHEXdWx4rQWZ4hasw+aRgwrl4ug/b2Sx7
         8AHA==
X-Gm-Message-State: AOJu0YyqmrQI4D2N9BUUEj6GSTCuE81HTcK0YGWRDnUAGWtASQKrMJL7
	c2Jx1nb19oSOQD6dRhwKOvLM8J+Jht1pzJ4yHtrM76w1HqnsewbBJ9VIUPqq96PSuST3tgPHxzJ
	sxbWxUSZA4QCn6xCO5DXKocG1hk8TcgHijKLi
X-Gm-Gg: Acq92OHrmKECT2nQ/4sq0RGuDlwZkKObKULmBXgCcD5UaqQ+77H56hZLGZW3npLZNG8
	VSEA0wSu8laCextHN9zY/hyeZk/kn/pDfkCSllq+cLgyYJzodrSoQTAbrj60eRiLB5/XZ4WvAZp
	j1lzoO1fALOQnwRmbk17hTeimtAhR8PvDhYLuDQ2gE53maT55jujeiRlnjAI2bTHHJ2vaemX7LZ
	4G0bKkkJOONTg5bl6xs10q0tCgU9Pe61FnQfXL4FaEKZ03LVcHVC21K6DXh3j+/4juJJnHyJ/cT
	lkJnHrNPaKsEiWFG0rc=
X-Received: by 2002:ac2:5685:0:b0:5a4:175a:f821 with SMTP id
 2adb3069b0e04-5ad2860a8b6mr480036e87.17.1781173472390; Thu, 11 Jun 2026
 03:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhcyzmaCLaRmK2anDfThnhy3M_EFRgpk7Aajd+uctvYr27WZg@mail.gmail.com>
 <CAHC9VhSf-ph9D63=J-AemOZfvb9HXLFguCRFWkU4y1DvDsKr9w@mail.gmail.com>
 <CAAhcyzmUS0QkOL9_HReHD76fNTknPpJUui67-mLW-Dx_BPFzZQ@mail.gmail.com>
 <CAHC9VhQbfSV6gt5QncQKmgjbyNCWb5TP1WsheER+JLaV3oqoMw@mail.gmail.com>
 <CAAhcyzmHqJwcWqSZ+Crv=+z1fHvT3n-XJomO=iqB07wRO33SfA@mail.gmail.com> <CAHC9VhQHe2AvKOSqFC9FzAR45CjExPVNM7+F8j69mzALB10kSA@mail.gmail.com>
In-Reply-To: <CAHC9VhQHe2AvKOSqFC9FzAR45CjExPVNM7+F8j69mzALB10kSA@mail.gmail.com>
From: muneendra kumar <muneendra737@gmail.com>
Date: Thu, 11 Jun 2026 15:53:01 +0530
X-Gm-Features: AVVi8CdTpVS4RUpkNBcW-tWJU-CGPXVmjLpbAA3VfsMX5SedvW2lxLWdt16qiCk
Message-ID: <CAAhcyzk8JmDMtjzAzO0R_Pd9A6027NT1ZCdRqFjFiwkYwu-iAQ@mail.gmail.com>
Subject: Re: [REGRESSION] LSM/VFS: startup latency spike during rapid library
 lookups (ENOENT) on x86_64 between 6.6 and 6.18
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

I will work on narrowing the gap between v6.6 and v6.12 as you suggested.

Regarding the static call conversion, I agree it should generally
improve performance. However, I have a quick question: could
performance be negatively affected specifically in failure cases?
We=E2=80=99ve observed that the degradation scales linearly with the densit=
y
of path resolution failures (ENOENT) encountered by the dynamic linker
(ld.so) during its library search fallback loops.

Best regards,

Muneendra Kumar M
Will post

On Wed, Jun 10, 2026 at 8:15=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jun 10, 2026 at 2:23=E2=80=AFAM muneendra kumar <muneendra737@gma=
il.com> wrote:
> >
> > Hi Paul,
> > >>There have been many changes between Linux v6.6 and v6.18, not to
> > >>mention any patches Intel may have included in their LTS trees.
> > >>Unfortunately it doesn't appear that Intel releases an LTS tree for
> > >>each upstream Linux kernel.
> >
> > I agree that the broad version gap makes it difficult to pinpoint.
> > Following your suggestion, we have tested additional releases and
> > observed the following:
> >
> > 1. v6.6.78: No performance impact.
> > 2. v6.12.76: Performance impact observed.
> > 3. v6.18.33: Performance impact observed.
> >
> > Since the regression is present in v6.12, we continue to suspect that
> > the latency amplification is
> > an unintended side effect of commit 417c5643cd67 ("lsm: replace
> > indirect LSM hook calls with static calls"), as noted in my initial
> > analysis.
> > Please let me know if my initial analysis seems incorrect or if there
> > are other areas I should investigate.
>
> My original comments still stand, you need to narrow the gap between
> v6.6 and v6.12.  If you are comfortable building a Linux kernel you
> can follow the steps at the link below to bisect the regression down
> to the offending commit:
>
> https://docs.kernel.org/admin-guide/bug-bisect.html
>
> ... if you are unable or uncomfortable building a Linux kernel for
> testing you may want to follow up with whoever provides your kernel
> package to see if they can offer support.  To be honest, the static
> call conversion should have improved performance and as far as I have
> seen thus far that appears to be the case.  While it is always
> possible that commit is the root cause in your case, I remain
> skeptical.
>
> Good luck.
>
> --
> paul-moore.com
