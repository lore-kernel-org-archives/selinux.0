Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF343218DE
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513158; cv=none; b=GgV70ZL0QF1cYyfQKTbpQgraxGsk0WDMR13mGRTy2eYCKW8TvHUsUCfMXElnE+xiIwKjqQTj9lxie/unS/1/N37nRHxtIJtrbyeKWWbORxGRqGkdqL9bEPArs3cNouUoWP3X29JDUpiXqWjJukQzP607Yio4+xcC1F924pJ6dtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513158; c=relaxed/simple;
	bh=r1+lAihfO/8DitQLpUuvKF5IdQ6YkPNqEIpHdHdfEoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enR7DeVYdRMXt2GWFD4lmIUq+zs1cygLrPwSAugIkFHJztBen5lAFNC/9BLqtpRH7vO9Fi2hyUJQtrhMLtocV2XJ+5hIvTbl6E5vlz2Hlhli88Jd1vSqQ64rqgKcZ6CIYZCBKho/DErtr8405EOo21Zf4NGLNLv5Q9CJAbz58pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/e6A1tW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/e6A1tW"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7722c8d2694so5806251b3a.3
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513156; x=1758117956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzc0xFwAqgPEgoSqOz4JjQSEJXNOXhqu5r38l/IYUHM=;
        b=Q/e6A1tWl5xKgFv3ZqQMu5xhkRMGatMc1d69vKP0uZBP6XCRA7ZdOFl+t9vWTQeKHq
         8GrJqunnUzqIaBJVLiKgKpV/O0cu3cQdAg6WLywSaTRP2O2951ZXJwvoLM9R8+nZckZL
         mrpNpOfDukCHV2Q4q3HjeXP4dqJaWZTdrkr7wslnydohm2vLSECO3asZixdXlb/RAR2Y
         lR5815uNxJFKladu2S0ZZfHzUZVMQm8wLaKCe5LaGK5EZoOD8Qwl35s89Shw1715GyJb
         0X8Xlgrqj2xcm9rpqrKEhVdxchzy+3fRtLG1xbp5sPuq9gHEmIahAkaGNNOEMr7AiAjQ
         OACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513156; x=1758117956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzc0xFwAqgPEgoSqOz4JjQSEJXNOXhqu5r38l/IYUHM=;
        b=l7IMtYK+CoL2amnONKojIvmaGzCq0uw9f2MYF0YtBDZl/7l2DlCEN8OPxM6FeGXM9Z
         LDciHZgillEQMaWlu4qFnYqL9gN299jgZw/c5pboImDBGQZRyd0qsD8ggYTqZf3HIarb
         M+fH11jBVmVr9m4NvU+cKm5Jn52WjybNUn8vmX+0duEkJ4X21kGRny3bsWl3RtwdnMMV
         YtL6O/wvRXgdpn0bVUP3VRL04sDfdb7ocHvWSV1DzrXB5k1CXnPgs7ajAXRFAVTkrRKF
         x2JCR/QFGuTwfJ/fF1f+K6Wkg1RVGZr1ipXBB3ZIQG/ap16paYbCw78lQ2ZIOWVoZ0an
         MLjQ==
X-Gm-Message-State: AOJu0Yzir/xb72gkY29NpIUPk1G7xlCqd8LI0E3AjlpMCixBgtpY3EMM
	lGObUva0xRivwigeulanaA6RhBx6NKVamGVaGhS8tj6GVN/SxzJuYB12ztRaheKUVkiN+FD3pXn
	Yk4iCFveqjDY4+99fMqnFU6LlWVfJYeg=
X-Gm-Gg: ASbGncvKTheT6Jg/g/l0skkm102vWwrx8BRtbHF5k8BcBcXc68uZl8hxLBrwIJthgQp
	fHeAbdCwJ+kTtae3M+FeOLHRXqAYXOT7aqVNhwdVeIaIFjjEjiWpVy1uddZsn8mp3L0//368xv7
	QglrswIST3VAycmVt4ebd2m9cor6NB8hcBYoD/N8q+Z8106QhV7F+IozgZrCBvgFo/UCAqHruen
	pZWvGjxx08cItogQQ==
X-Google-Smtp-Source: AGHT+IFvWndJETIGzGa6Jd+IUkuNrOg4RB600K4IVTfGehZ2+P2hdXpEXa4IMnYoWfvjAqUK3CYw7kLZc2hEo4jPBoo=
X-Received: by 2002:a05:6a20:734a:b0:248:7a71:c27 with SMTP id
 adf61e73a8af0-2534557977cmr21790052637.56.1757513155717; Wed, 10 Sep 2025
 07:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com>
In-Reply-To: <20250909213020.343501-2-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 10:05:44 -0400
X-Gm-Features: Ac12FXx4TAKg2WbunLXIG4ctNLPtEDXWyIE8OybOtZvzha4IWCBBqrleA9F2C4E
Message-ID: <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
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

Technically, this doesn't make it easier to distinguish because we
usually return -EACCES from avc_has_perm() and friends, but return
-EPERM for capability denials and in certain other cases (not always
clear why, arguably a bug unless we were just replicating the error
number for some existing check that also returned -EPERM). My
suggestion to use -EACCES was because that is more consistent with how
we report denials outside of capability checks.
To actually test this, would need an updated libsepol patch that deals
with the fact that the policy capability number changed on merge, or
re-basing the original patch on top. Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

>
> Fixes: 084f547bd8e3 ("memfd,selinux: call security_inode_init_security_an=
on()")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
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
>
