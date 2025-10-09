Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543124DD09
	for <selinux@vger.kernel.org>; Thu,  9 Oct 2025 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760036018; cv=none; b=UMGk6uG9Z3ca0QaDjo+e3tggCjuyGYlthhcbkoKfFKMZXP8/n1D9jvUc+CizWVurWjTFELeMy2CVzuMIobc12m4ztf+++vjDytinIHJ4CkcBlHHpPC+15MkVfdxKE1BXrbucoBPjWojPfGgCw+Hv9Irzc10GfLHDMeB6/cD5ndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760036018; c=relaxed/simple;
	bh=1ac/fLFPsYRuSpEkij40k5Zmt1ThI8YAweN99K6QAss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5Is6dAI/u8X3QTovbdlUCQVbAJJmCYHvQpYbB0jiN7sXw4+S13Xy2MWvZeUIJaIk0MKBHsaluuem0+2gMau5q56CnwLSTh5sx/rzZdYUz+HGul6Y4QKa3DvvuS5iHKO7JC3TRL3vejDwuBYHS9jALwbw+YNcRnPVgu0t7HTQ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdN63dL5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdN63dL5"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33082aed31dso1438588a91.3
        for <selinux@vger.kernel.org>; Thu, 09 Oct 2025 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760036015; x=1760640815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1Uzp5iLkP5Bv1fIK+1rV8CxjLbvYcFDDKRV4JvrlmM=;
        b=QdN63dL5wPR0n/taPwv6oeKB/ueChxEfKvcz40tSBsgCljMJM0rR+/jxWX7mN0Ygbp
         Y/FPUkFD0K1zBzk94PAG6RderRkAi7iQ3Tcb/11j4m6tP+hkzIBFEdibDKEmJy61C/Fm
         xdatRxXMp79ahOMDpc9syoqlFYRR3UHLXsSTl7DTbiYLUFWdAobkOj1zz7Qd8l68LZET
         4eoyqi9Zxz56lKVoHe9NLpYhtqjCcjfMGJ22buKmK/ZbIN5OsFhYjQmSrLzFzte4d02Y
         ibgRvuVhS9ZKOtJldFa6jICte/nE8EUk2EKCrjuiRExC5iC0rzaQxda5gkdfoMjQxkwa
         goZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760036015; x=1760640815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1Uzp5iLkP5Bv1fIK+1rV8CxjLbvYcFDDKRV4JvrlmM=;
        b=v2XGmwWJVhQqd+6ef5cNJy8SueOg3uBTGIBxFMsxGvBSXwsSvXPsO0MR5m+tr7o7Vw
         tZo744c98MYB/Qi9MYSyx3xUtEBObwU0ARI7sw/VwrEH0LQfn52RamZWoV2fi2Avwfna
         ki3eqBlT1u8gCGpYd12EFiRPZ//507S5id0yLuUqMyzlolvfMH0bl6xzOl9p7GZMakYV
         oD1I+633wKVAmEUZ+WHivKorgrs1KEBRjtGTey3flxYu2DLZvwCJK4FCM93jxQYpX3cq
         dSZ5PGClFmRlE/wVHex/CJSVKF8BWnMgUzAruLszViogJL8P1nNdn4lFobMTYnt9KFZE
         z3Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVuGL8gPbh0BbzDRhBxu1rJBxvE/DfIxkXO//toPRmJHftKtvXxF9rTsvLbucQ50d3o9ygm7UsJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwdIp+Xu9DNSxMsFDD256BTBCE3asquAbBx+OtsrpEqKdUGgmkl
	v5Hx92U9f6z0qU1dAwehTY6qf8SCPVjCKcz4vSoqodw5COWwdE7oCk1DugQHqJBmWJQC6NJqB/2
	KYy22D9taL9ETKuqbu011HrbTRaV8qf4=
X-Gm-Gg: ASbGnct7SDDJGWvXois9HTM/htH36r75VdKrHrs5NmP/9WlR3LI2IE+X9waze3Qbul5
	EAFw6bhWO0m+B+cJnQLKkr+vB17Vh9cxYBg0Z2yrohS+zrsaAe9HDEtpb/VfpdSABuTyf++GNjk
	YAM/rZ8jKG24vQJCl30N0cjnPuv0Zp41TG8YQeJK8Yyf38zzoqnF7eeD39YuOHxVK6FjGssHRfr
	2PTz0gRpEYLt4TLw4iaz6GwRepipPc=
X-Google-Smtp-Source: AGHT+IEr6xYml/4oPWWPBOYMdsJawHFJTDIUl5AA78sk0QeeIlMy3jRJkuZ6KGVkF1uxh5CG/9S2tm6wzcvo7HYhJS4=
X-Received: by 2002:a17:90b:1648:b0:32d:f352:f764 with SMTP id
 98e67ed59e1d1-33b51105d58mr10655063a91.2.1760036015068; Thu, 09 Oct 2025
 11:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001215643.31465-1-casey@schaufler-ca.com> <20251001215643.31465-3-casey@schaufler-ca.com>
In-Reply-To: <20251001215643.31465-3-casey@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Oct 2025 14:53:24 -0400
X-Gm-Features: AS18NWD9a_Fk68Lh5JrlS0gUk6gyIQxpz3GgsrNopdIM_qVpZUajo16zBkCmCyY
Message-ID: <CAEjxPJ48PiZ5ZOZbZjka5YeiBxaWFsCufoGcY_jEztM+wtEUCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] LSM: Allow reservation of netlabel
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:56=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> Allow LSMs to request exclusive access to the netlabel facility.
> Provide mechanism for LSMs to determine if they have access to
> netlabel. Update the current users of netlabel, SELinux and Smack,
> to use and respect the exclusive use of netlabel.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---

> diff --git a/security/security.c b/security/security.c
> index e59e3d403de6..9eca10844b56 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -289,6 +289,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blo=
b_sizes *needed)
>                 else
>                         blob_sizes.lbs_secmark =3D true;
>         }
> +       if (needed->lbs_netlabel) {
> +               if (blob_sizes.lbs_netlabel)
> +                       needed->lbs_netlabel =3D false;
> +               else
> +                       blob_sizes.lbs_netlabel =3D true;
> +

Same principle here - if a LSM wants to use netlabel, it may want to
guarantee that it truly has exclusive access to it no matter what the
LSM order is.
