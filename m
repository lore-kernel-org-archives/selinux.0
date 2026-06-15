Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427FF40F8F6
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542740; cv=pass; b=OVRFlSvcV3S+0KXDme7oaciIC07dCcS0IFKzjIvyVxsZAHIADhCFQDaksO3aa+Y4xQTRSKnlpr76T2grV5G0kDNG615i1PF4nhCIxjmVRR7Iq9718QNQW2NUMNo0T82GSzX9XtlA7PkMVrjyPoeZeAF5/Xk/qAC4V7e518qHVjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542740; c=relaxed/simple;
	bh=Fm4Qy4yEu+EsIfgEbUX22HFehcvKQeFuEWpQ52OySnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKUjCZcLBeVNaGR/DsFYZa80DCavvjASS5ywSFqUJt9fMA9jFfWTxSJe6fERjXetRBa3LxoKD5RoF7ASyu2SGcNhkiawsiiqM0+5DJ2UJ0SA8XKy+s6ByQ/V8Ml0+iO5sHzRlBdo/NXEddyZoiA6fjt6XC8IKP/T8LXIQB6duGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+k7Cgcr; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+k7Cgcr"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36da151a152so2548519a91.1
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 09:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781542739; cv=none;
        d=google.com; s=arc-20240605;
        b=SWjYN8GW5gPT7oQ+VF2c1c46lL0LsoKZAkh1uAvxbyePvgytuGPwg+Pp/5JjiZ+ZQf
         QmIk+IPIiBFahMC9/ziGcul17L/hI4FJB5RGgPJpgntQDWYnDHHUK9J6qTURWGQuEIiO
         OGVmDT46QUaa1Ivl63gx2smo7dIzes+FsszgARtAsXzAoLcwjdA2wjfDgl1KUb//kcH0
         1T/s1aZy3nXLHYRRRbZkzZER5B0UdRPXgCCj1RxyQYgwFSSZ6CXntFRPwtubckg5NTNa
         kGUkDAJ/aKDcn229dmDra07pPpdUPmnoFo9gIIbQXdmfqRHypOqDRvUwhnuyOUPaCBxD
         mY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kfOE/6rx4vEsc8/YRr9czL30YalHkCRMyUQWHlyFJOI=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=c6AqpeXHnz8IzuN2uiji+I5Z5yArzBDKF53lLTs6pejP0hU108zNJR+uWnf+DfYXe0
         q40uQUewpprWzGnhno0iQ3CI7wWeCeh9+yvkK1HELAu1SWAi3wtc9WGMYJZaRohsxKHi
         9nksWcGl1SBvGFLIl/tn58hjmFxec9aNyr9gRpSRbpzR5qWooOaGYfQ54PRLJiD9KUh0
         qBLw4tz7T4Z2agVLj7yaKsakb+n0lzrU7l9K2j9xaIyi+5gp1SWcfWg6BaiGNsiHLN+b
         OYfLR4nz5Xq/TJRY5nuY9khFJu1JRK7YEvPJGaqf3+E93cAPC1gUtEZq03YwFXAwLcJq
         1+MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542739; x=1782147539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfOE/6rx4vEsc8/YRr9czL30YalHkCRMyUQWHlyFJOI=;
        b=r+k7Cgcrk8B7mR2B+4+/SwlWB8gisWRbA1iHE0dtv3evwoSGwkLqkb/e04x1UXMtI5
         4YtuaIvUSZI/dndyhA+qp/7U4Sq6n5F3vz4gzC3uZGwzJ718Yr2oKdEEWo7WccZvnUU6
         MbGYJF2TV8BnO0Z7x4swex6uPB/OWCqg3eCXmNL4mGnIK98CUN58WziZ5irnL0FdFoe0
         VmAT3Zpz62KKqkPLhXAbphEo2QjsFJFvvKndKVGP1RXiEmQtsjvFKc37jrzPAD6b7R5e
         bESkkdRoT1jd7Vrqifhx4DOai6scQSH+N9CUfzMHCZbphh3+YJOjSKdf4leViqWlad8C
         5fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542739; x=1782147539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kfOE/6rx4vEsc8/YRr9czL30YalHkCRMyUQWHlyFJOI=;
        b=KTpha7PKHWn5mAVd/dNRyv0+ExD/htUVlrfixG1md1W6BQNMCxdqZxpKkExrbfui4n
         XGmVuUGRqV0aV25oELKY21U+F8neCEiOwumSXr2J4bxoAQBZEvpvdgs1dfupLfWNp64p
         pzp5RemE0H5yGNw3xBcMuKFIjDdR0D8DrjvpyfcAMJcEQk2zWrRcFnI1PFc2eMcZTVzP
         SncP6DHKuHb7Ia20K3nHJWGJcFscG8Cdxx6lYnto8ylnn5m+581KdJors6R7QsqzmDex
         aEWllU04nMLKuwH7F5BfvmaniM7oYCQmn8U7+CrdTRlmavxV8UrReMRCZqzCEYcj/mjw
         oeUA==
X-Gm-Message-State: AOJu0Ywx8cG/PPWaJSFMkXfX+1dP0oTaQ6HWKQ9fR0D9TJIjFe1selFs
	Hj24v/a3hlaSSNH6NzR7/t87dMFlE7IfO/H3HtWD1QsjzCZIncJtC60Ie35quaXseQYWKPr6zD9
	DFOVidkGaZiUbs2rkJ1Mzn1IP4FslZ/Rf11G/
X-Gm-Gg: Acq92OEyGbrrnp26PElwOpEQlLuLKYqgDMqXV2NlgqgnvqPc0JQegQA1q02OK6zPb5s
	3Wv0cRpkITT9iQJqKH/QLlLE0SYRFmLnfb40gvSU54pdU9qqixe5FvG8OzZyKHyqVjWGPqMNKRm
	l2jX90JQOd53b7+ohLUNTN2coPuGCsxVA00VZwB03PcVXDF/11dGt+gXv9ZEaY98Qe4tZyVkzSz
	R4Nzoi+GnNPd0SfMXt1x1qkcyjyQMZMmX15iNluS+TXGFm46nQJosUQpRRaEfz2ppN2Qn/YHSkY
	hsVbSHs=
X-Received: by 2002:a17:90b:5685:b0:36b:9798:4f6a with SMTP id
 98e67ed59e1d1-37c2bc86b05mr12538838a91.10.1781542738613; Mon, 15 Jun 2026
 09:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614162323.18730-1-kalevi@kolttonen.fi>
In-Reply-To: <20260614162323.18730-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 12:58:47 -0400
X-Gm-Features: AVVi8Cd59ZkHqcWfs_6uTNWv4EbPCTuKWZHWz1zW-NZye_GyWKbZCuDIXs_1ceA
Message-ID: <CAEjxPJ6C7ST4B6Xuq1dvE7Bx7EuZ1NVzh6yE7w0VRziXKHORiQ@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: use bool instead of int
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 12:23=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/newrole/newrole.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/=
newrole.c
> index 19271c2a..8f75706e 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -55,6 +55,7 @@
>  #error NAMESPACE_PRIV needs the USE_PAM option
>  #endif
>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h> /* for malloc(), realloc(), free() */
>  #include <pwd.h> /* for getpwuid() */
> @@ -390,11 +391,11 @@ static int authenticate_via_shadow_passwd(const cha=
r *uname)
>
>  /**
>   * This function checks to see if the shell is known in /etc/shells.
> - * If so, it returns 1. On error or illegal shell, it returns 0.
> + * If so, it returns true. On error or illegal shell, it returns false.
>   */
> -static int verify_shell(const char *shell_name)
> +static bool verify_shell(const char *shell_name)
>  {
> -       int found =3D 0;
> +       bool found =3D false;
>         const char *buf;
>
>         if (!(shell_name && shell_name[0]))
> @@ -407,7 +408,7 @@ static int verify_shell(const char *shell_name)
>
>                 /* check the shell skipping newline char */
>                 if (!strcmp(shell_name, buf)) {
> -                       found =3D 1;
> +                       found =3D true;
>                         break;
>                 }
>         }
> @@ -457,7 +458,7 @@ static int extract_pw_data(struct passwd *pw_copy)
>                 goto out_free;
>         }
>
> -       if (verify_shell(pw->pw_shell) =3D=3D 0) {
> +       if (!verify_shell(pw->pw_shell)) {
>                 fprintf(stderr, _("Error!  Shell is not valid.\n"));
>                 goto out_free;
>         }
> --
> 2.54.0
>
>
