Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1893CE4A6
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837717; cv=pass; b=OSYqBWWzyw1KYLtYEiFj3h5CEqxtkVLqvL9UMW1xHeacByVrqI2wPthzJexis/g892ZbuO3cGLm8qHozUJO2Vz0MnX0+o+hb0yx34Io5TKvHh/sLf9NnuqqsFPrCvrnVWaPCMNGq9/bJFp3OgchBIigG2kpxMsjB/EhUMcRPMzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837717; c=relaxed/simple;
	bh=BG52CzZJianw9o9g2uCeIbNA1rTnp9yxhYo1fsob0fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nYzH228i+quU/Uzr4Km7jp1cz0NQuSgEmtHNuK26W47RbF8vLcGZ162WrSK9RYbmp8dy8TZ57xYAGg1ubuUXZoIMvVCwm1bpsS0pyNlm/u655LxeZOanpejGue6Hqul1zxefQtHyuk2BhqY4xQy8FfZeSm8hRRk27R//HUBOC24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzv0KVH5; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzv0KVH5"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c7efdb7d8so11681394d50.3
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 16:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779837715; cv=none;
        d=google.com; s=arc-20240605;
        b=UGRjgl85Zo4/6GRWPd4MwiMdjeSu1ii2kOPhbpA1wiCniW5a2+jkVLx8/OblEN2DRw
         R9yUhRl7IWJQo4r9pZl3afRGks5VAw/sYCJzDERXhGg+8UdOJsDuiTmNWAlTEJ2lGchO
         hPXyeqesxsHElJQ7NkVd0d0I6fQiUoQNHSv7K0GsNAxx8TMIQUjIM8ML5aar/RM1ikjC
         IaLFkqZQO1KPTxAibIpF2+2czuxk/FkGbNIacSFSmdLvbX31DZeZQPJJIFyGx03niWUl
         gs2RYoFp/xkqW6/KJnFYjvih7NDxILOVg3sDcmdki/98jWzbK8lqNlToyrAutlQdItPg
         J3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IawsDaq+jT4smAWsX5Q60cfohWJ4yueT6RiGk7iaP4U=;
        fh=3qmRDsaUNOy74jWOx3Rs3PjUDVycykje/yVNGpEcUS0=;
        b=LealjziHkRLrPvh+QneZMKp9xhSJqqEQBwtLRFIUfUsByquhzQLCv1XsUGj3cCG7Fe
         KSeo+5RJbMst0Ak6EQqtyiaH+jQf45VOZEW3Ufr9CVzQ2o9nAfrwJ2zC8Hv8mKFfQ0/0
         62OMjq5NyRSO2/lK4BNSLwP2Lo/OaG1aWE3MRU6oOeLs1Ikd0Nrp/6VTrSTSg8cnKPbe
         ars8T9Bm45CsvEHdP90hWhwDnrbiJalo66NgzdltyarpMT8wxhqEhx+q9cvJei1fnvtk
         QsTNqIdQ1UbplHqGIaa0ZRD66dWhbjAUXYIUkhCUsg5rXTFne/jTuEaQnl5qn+oRVhqD
         Pheg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779837715; x=1780442515; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IawsDaq+jT4smAWsX5Q60cfohWJ4yueT6RiGk7iaP4U=;
        b=Jzv0KVH5eKwV18JpLE5WXz89uxLXuX91c1AlqI0vVVaB8DRiC79GO4oR0+fn7uCfNf
         na5Ksqm2EpPAlKZOeuv4i9qUe6jPZREW/x6cK76zkEPqfMPBmgSgAstLxwdPvnPM4Awu
         JT3DSjcyhZHRrEKA1nekX2YH6ll9r/kCuh1eHFeq/7JRSVRw9DEtIVm3aFSrBffKOn9w
         mFmimsKrROcbCr5lXPThSny1DjOeNE+tRWzUxkkCGEN+OIu83w2Gu7Qcv1FfoBrOmE9J
         Fo8CZVGZTDuaos+mRgDLw2387Q8pawKvL0XWfXTic7CMAn3TXvD4n+KnYp8HThK6xH+N
         ti4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779837715; x=1780442515;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IawsDaq+jT4smAWsX5Q60cfohWJ4yueT6RiGk7iaP4U=;
        b=BAY9yOFre992QBJO/5PO8zGl9lifXxOWlUhfRCfpjeVj6INlwgLYMwklwKGulMG2+P
         eupA1IWb996C9htKf6QpNoyQPoktCvUGThOq1CsB25JZ6lqJYryqstcyqWm0NpTdvK2Y
         j4Sgr1MaVpKSkGEH4ohFyoem9NmZ/iff4eaxYR/oMjiDBx2Rm2ZECHsQNpGWTxEwnkP/
         e0S59yEl2ONdu/6luDioop+pNjJQA63Ra5l/1224aN6O/AW/ngKCztTpmCbbrTiAEaja
         /SmjQ8e+uU6vr40FmV/UukBTX0miCWVvleW2aluEcOL0iDA78JoXnlA2+JY9s8OJNwHg
         peKA==
X-Forwarded-Encrypted: i=1; AFNElJ8vVPgPIfNDJttJnh2mHcigPFl1Uk/KXJ5yTSQW9loAUOm6Gm4j/W28m46VMmbHpx69lFEQIIyA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dEswd16g0NCk2c1tRDYpEZSYs+/4bieFMuWdwcqPkKqArS3K
	DcUeIY0S0+9NI+HdMbXnH+8tNEVKlKyPdFd1bMgZP3N1jEwgzXJy6oddAzIuphMXleCr7dGBcDy
	HkHFE6Ls8/N8LvGh+14ioKRXObKYpk+Pg4RZj
X-Gm-Gg: Acq92OG06h//MSZUf3twxSGg0BoToZyyZY0wXP7pKUrdPHj6L1eVHSW7X3whSEnXbLY
	aA2VVNPMsYmCv1G5CkRZHRDYLw1Y+CdsqLbdfx0dSQUy2PJNvXr2v09VKb4IKoj0aQnBLUqUO/s
	12p2L0K+AncJ9BjGtRfkBBJ4bZpaUo0bwTzrpEmxQLwBc8dZeuca0AAZDZRgxEKC6v/3d8eFmEs
	eRVN1D+jssoG6W+lmts7XQrS+bkfPlp/gV0f8EmCs2x4kkdKCnyz7tRJYvCN0Vqc+A6yhFQDyx9
	8LpNwgvr1hrHmijvMw==
X-Received: by 2002:a05:690e:4090:b0:65d:4429:b6c6 with SMTP id
 956f58d0204a3-65ec98ee2b4mr20064856d50.39.1779837714727; Tue, 26 May 2026
 16:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
In-Reply-To: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 26 May 2026 18:21:43 -0500
X-Gm-Features: AVHnY4ItZov3xV5vdDhv9F5waH1j7N9kKMkPY-kOalQ87k149-SYhfMriDG0MVM
Message-ID: <CAFftDdqp8b5n21hdEP6w0-PK+CoG7mmQxgrnhpBLU7-1GZxniw@mail.gmail.com>
Subject: Re: security_task_prctl: why -ENOSYS
To: LSM <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 5:39=E2=80=AFPM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> Hello,
>
> I am trying to understand the motivation behind having
> security_task_prctl only continue if the return value is -ENOSYS. This
> seems to be very different from other LSM hooks I have investigated.
> For example, in other hooks, the value from SE Linux avc_has_perms is
> used directly. This essentially means that a 0 will cause the check to
> pass, and anything < 0 usually an error.
>
> In commit:
> ----
> commit d84f4f992cbd76e8f39c488cf0c5d123843923b1 ("CRED: Inaugurate COW
> credentials")
>
> (8) security_task_prctl() and cap_task_prctl().
>
>          security_task_prctl() has been modified to return -ENOSYS if it =
doesn't
>          want to handle a function, or otherwise return the return
> value directly
>          rather than through an argument.
>
>          Additionally, cap_task_prctl() now prepares a new set of
> credentials, even
>          if it doesn't end up using it.
> ----
>
> The check in kernel/sys.c is currently:
>         error =3D security_task_prctl(option, arg2, arg3, arg4, arg5);
>         if (error !=3D -ENOSYS)
>                 return error;
>
> Should this be something like, "error && error !=3D -ENOSYS"?
>
> I ask because I am looking to leverage this hook in SE Linux, and it's
> annoying to have to coerce all 0 returns to -ENOSYS.

Of course after hours of banging my head and one email sent, it's more clea=
r to
me now WHY. This hook isn't meant for making yes or no decisions on an oper=
ation
but rather to also handle special prctl flags for an LSM in question.

I guess with the said, do we want this interface to be used for both
a, let the lsm handle
this prctl flag directed to me, as well as a yes/no security decision
or do we want to split
this out into two hooks?

>
> Thanks,
> Bill
