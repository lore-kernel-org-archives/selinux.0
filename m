Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E022157F
	for <selinux@vger.kernel.org>; Tue,  9 Sep 2025 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453597; cv=none; b=mVYlC6h9xgCzzG3Ll4iJz381PMC2rEP666rk2hx2aQYasKt9PTuD1/8FBrf37rUSvPtuUH1RYeyaRD37F2MJ+YVc/XTD4+NjEzSoHopWkWuwG5XWvQXsAtgG8R5wQAi6x2vt+5c4IPA5VXlcXSno3fKnPTreka4+Pcrar0iHLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453597; c=relaxed/simple;
	bh=AFqkDPxCV2dkTCfqd556isZVIGNAWATevSXO04uOddc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpf8MX2YMtCzsewm9674WRe8ludV5brLCCdKUyv53A1wTPJJXMWd9YUSOEiJB3z/woc3EyAIHqKZoFM6P4rTaZOr00b9LS1wm9agsuzKZjGIdw61pgG1dQaF6gajfzLA6btFmpwtBri1J7bhQMptsYEVNqLr7ihLNgv8bGSUdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RHWfBWWx; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RHWfBWWx"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4c738ee2fbso4831662a12.3
        for <selinux@vger.kernel.org>; Tue, 09 Sep 2025 14:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757453593; x=1758058393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RlRKmKYmNbwLMJ9ul6Y0tMfWepJe70yo4pyBWisz3s=;
        b=RHWfBWWxUPXpz48G/vKAbttbiDVFN2Af+f1tjP6/VhD6rMl2vt5r++FpeOk33giYtU
         93AFGYIEsCAwrpD41lkN/TWmTUcvWVniOCl6FfiAOLKt0e/+363XAVk8iSE3fqKfDsbV
         n5wLkvQixkP/Ba6mzf1WVfSO15kwSpCxjKC+xZVT/FFe1hgaleWJZs/DHT/Xi1BwHW3L
         yuF0nIg4UpzM28HgaeIrzdm6HY2iFJ0m//qmMQEXWhXx2KxvdTKIlo3ySBmiAzOE4IR4
         a1NnXiJqAxVAS5aw5abCd07lxh//YvgfLd3r9Ij9msN1FyvmUfZO/MHItuNinN0eIJ0Z
         Jbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453593; x=1758058393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RlRKmKYmNbwLMJ9ul6Y0tMfWepJe70yo4pyBWisz3s=;
        b=mpkex9UtZLixvwN+9OZMtY4ZVHPyeajsQ3EpwJ+tJO19mtyeZY3Mj+5dypDVnNfYzV
         NfJ2Gx4YcUa/exggRaVlFX4qe7Gnu3WscD5OCZgV3cCvYc21U/mQvxNkSKCqzRHH3b6W
         BMYmix5xt57y3bd/zCsPXkBIETW9Q7cgrtdnZ4omdanE+3muDjM6q4WhGQWnjlVQRWlS
         s1nAzIsEk7lOD+r1BuYPaBmDVIUgB+BoFOw1NXez0ww0ZrXg8Vzjc1IkJKXy3P/PwgoB
         dp3bRU/V16QoN0NshZZIdmuf1424euY1m6BHoAIZc8Oi0MSs2LnvTpV3pU+27pfCJpPB
         q2oQ==
X-Gm-Message-State: AOJu0YwjVeVy1dmPo6/wPR6opeVMd2Gy71Xn4d+qa9FjkrlYeTCybol9
	rJYZB0KInMLHviSe/Z6eM8Pm7ei2oOEc2twKweVD/Y6RxX0WYwFTODc2zmnXcOOU2hred46H0sq
	epOLZ6ny/hpmjmSn8J9ctk2i+3kbmzylyRoeZD0Ukg5l5YOMPYUs=
X-Gm-Gg: ASbGncuLy0VOGLdNrjy3kgncSvoqueaxvtW56wIepWmhwezFraD51qxWBroSiubb0vK
	FWgJHIMeXl8VA+XP1Zh481bkpfZaQN2j+o0Wg4wFS6Iq3jU60+KBDVRZwsSoS2XcFkGcSAdA77a
	FsI0AZBaKyKEVd36BDk0j0SGQ3USR/zbzc+pJ+vwi+9598eNJ0PFwf1yaPWFYRESuwJFgnVVUDY
	Drgz0ySz4enJC3mMQ==
X-Google-Smtp-Source: AGHT+IEEKzdnhseqUlhhsGkzUHsPiuLe3oenwgE9ZHtqfAEP2qAYIPgyYuOPnuZ2tjAl1cLtWNtxDmRiGPQ76VUTDFs=
X-Received: by 2002:a17:902:cec7:b0:249:3781:38f0 with SMTP id
 d9443c01a7336-2516ef54ce1mr216409145ad.12.1757453593196; Tue, 09 Sep 2025
 14:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com>
In-Reply-To: <20250909213020.343501-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Sep 2025 17:33:00 -0400
X-Gm-Features: Ac12FXyINjeBWeyUKquxHWM3OVkrbprFFgsn3bIsl_Re-FlzkC4zrSohxezBEJ4
Message-ID: <CAHC9VhR+5+B4Kx0zxFvZaiTM8Uw55fdA5d63+D7PV7Bj3tKPdw@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: selinux@vger.kernel.org
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> A prior commit, see the 'Fixes:' tag below, added support for a new
> object class, memfd_file.  As part of that change, support for the
> new object class was added to selinux_bprm_creds_for_exec() to
> facilitate execution of memfd_file objects using fexecvc(2), or
> similar.  This patch adjusts some of the sanity checking added in that
> commit to avoid a "silent denial" in the case of a kernel bug as well
> as return -EACCES instead of -EPERM so that we can more easily
> distinguish between a permission denial and a fault in the code.
>
> Fixes: 084f547bd8e3 ("memfd,selinux: call security_inode_init_security_an=
on()")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

FYI, as of right now this is untested, but a test kernel is building
as I write this ...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b2ad83353c17..2b685f9dd61d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2320,8 +2320,9 @@ static int selinux_bprm_creds_for_exec(struct linux=
_binprm *bprm)
>         new_tsec =3D selinux_cred(bprm->cred);
>         isec =3D inode_security(inode);
>
> -       if (isec->sclass !=3D SECCLASS_FILE && isec->sclass !=3D SECCLASS=
_MEMFD_FILE)
> -               return -EPERM;
> +       if (WARN_ON(isec->sclass !=3D SECCLASS_FILE &&
> +                   isec->sclass !=3D SECCLASS_MEMFD_FILE))
> +               return -EACCES;
>
>         /* Default to the current task SID. */
>         new_tsec->sid =3D old_tsec->sid;
> --
> 2.51.0

--=20
paul-moore.com
