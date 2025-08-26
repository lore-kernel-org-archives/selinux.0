Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A4211C;
	Tue, 26 Aug 2025 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238942; cv=none; b=UYJ4Nb+qIQYR6PjQM8nfGVWdOav0sr/bK+BPu3sNAWwxM78snrDpfo6uwz3J2+savC60IWWFg3rzLXO74WYVrtJt6P8TlWE191pitW11hkrItx7BgwoJkBMAKMaoLwXE+j0woRzlMZEXRNHwoQ3yRspK7MN959FyAIi/qDUh9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238942; c=relaxed/simple;
	bh=dqJIgmBq3mpr1Hj6QcdqFxmKLNiTO5FZlbH/9RPgvGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZvylwsxXqga9P6Kv4Wqh/gkCaKbbyfwjTpssbTCPsEWTmHxowdX4NIOMU3AZN02Gr18yoilwASdduLEgdN8pqWqcftJqjlXa7nBkmw59FVY9gUR43liMjuYHWcDJrVvWOQEr5QYnWi6WYbAYog/XsexIDZoYKtEy9bqXa3nwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzvGTmAq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzvGTmAq"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3254abaf13dso2556394a91.2;
        Tue, 26 Aug 2025 13:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756238940; x=1756843740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aISX8qmlYPTfKyY9nd/pgZvE2T4wrpRDpwoB+MUeuqI=;
        b=dzvGTmAqL0V3fPXIcyY7I+b5p/slStEQ8WHdunUKBoNhSYxRgDYwmu5fygeh/GFX5E
         DQwpHifP9QFPsbLf9wk50vKe9deUQf1IQEGe6A/j1EL2lcPbsRp4T+6HDGIr7qZ8sAYj
         vaIE0kPDSiPW+PdLrzudc2DCXQO19vXK+yomEEh59QHrwU0rqF0DMoYULOIDj/HXmYFF
         WIvKDbhwkBNyrnD4DJW+K5VSjkZQkCX9ajlAhOMR2gf6JXPJXsSva//EcM0H6iVuf0ZG
         DqZL0BtkoakPOgryM/h/PB2FbXEi5da5r4NnKMBSGmxSwPbwFPoPdwUZkRidvgD3JW72
         Zj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756238940; x=1756843740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aISX8qmlYPTfKyY9nd/pgZvE2T4wrpRDpwoB+MUeuqI=;
        b=mIcX0jk6okYw2QXWD1l4lf+vAY+RtZcITKRUiiX6QtALRhEgbL/wvIFpSOinGq8UVR
         Tw4HE+rjD1BmaZPlqorOBWhx4FoRGDpLlg9eFbJgwo818nTR4mkFSoe3pWDub6313YzO
         fAUWr/59QSZQXj/+DZfUyny4UopfYHzZfHseN09GGnPLrtPCrNmHV6n6yoyDQ94p0kuq
         0Uwpk+ueUUmQhvDhcY5AkGE4zWqMB7+v0W91N/X1ArWGh15wzTFOsQwgZLDDw6ldh1LG
         eHeqUuTs5AFFEOyhryqWWKOXZpEUyhAxx7kY/IgpMFZ4z+Bi5qYvVd5rQwIJmVoxEOrq
         QHXA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Ia99EqgETwAVU7xz1ws/5ACNuHuOA/10/ujWfAGlHlL599E2PQCFGn58gPtZpgD/nHCpz/9v1w==@vger.kernel.org, AJvYcCVOaudpGQy5RsjelugMqwZpndkofDYU7WMEll5q3BldmNfr7Kn+U8iJcs+ziC84KYV1Ix3p+aDNNcT8DBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJCMkNdmvU/Kn/BRoB/MNpOPrhmbuvnvM8sTW9mtPFOrT53q7
	lDqqPmdGuid4nxXOAv/IIcBblDrZK6j0Qp9e2GG1gz9KDC9zIOMZrprrX3HJwDAhi0mlltZkA9G
	RJdgvW2dR0L41i0OwTZZCZOuoh4pCg+Q=
X-Gm-Gg: ASbGnctyR8Tx000QB8tv+EExZP5Cw5uGn4ZuXcboTMLgTcrYZ/PnECnXJswPElVtvPd
	61mih8e/XM+anEJQxBRRwxHEtgY/L7OHC9QPKySppTcE06L4QnR1y98t/9aDBq2XPXVYSsAOPm1
	ieQwZKqKBB2TGqk3jTVzp8qfpJWNQgOO2iDEGi41nY2i/AM3HBHbdRjcAEzFYAy8BxAVEP6SdHW
	gSY4iI=
X-Google-Smtp-Source: AGHT+IGid88VV+Kr5wHPV5keIr+GWDP7AIXf2F942AueLphuI1otN/rKKjw47NVWYTfJxpiDs5lqs0wqAUWsC7SvhWg=
X-Received: by 2002:a17:90a:c886:b0:327:6de3:24b6 with SMTP id
 98e67ed59e1d1-3276de32df7mr316552a91.8.1756238940407; Tue, 26 Aug 2025
 13:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824130106.35366-1-mittalyugansh1@gmail.com> <20250826172330.44006-1-mittalyugansh1@gmail.com>
In-Reply-To: <20250826172330.44006-1-mittalyugansh1@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 Aug 2025 16:08:49 -0400
X-Gm-Features: Ac12FXx6CxAbdRv2H5agsSD8l8DXHb_XOuskN5WLLuQnENqwpHUtBvrXy0Nwfoo
Message-ID: <CAEjxPJ4KA+8iijcN0CrgquuXhzJ1e1CaeEaSdaj6_5gfZWeOYg@mail.gmail.com>
Subject: Re: [PATCH v2] [V2] selinux: restore sleepable revalidation; keep
 fast no-sleep check
To: Yugansh Mittal <mittalyugansh1@gmail.com>
Cc: paul@paul-moore.com, selinux@vger.kernel.org, omosnace@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 1:24=E2=80=AFPM Yugansh Mittal <mittalyugansh1@gmai=
l.com> wrote:
>
> The prior change made __inode_security_revalidate() always return

The prior change wasn't accepted so we wouldn't normally reference it
in a patch description,
just in a changelog that would go after the diffstat and not be
included into the commit message.

> -ECHILD when the inode label appears invalid, avoiding the potential
> sleep in inode_doinit_with_dentry(). However, not all callers can
> propagate -ECHILD; only RCU path walk reliably can. This caused
> cases where the inode could be left with a stale/unlabeled context.
>
> Fix by:

No need to fix that which is not broken.

>   * Keeping an RCU-safe, non-blocking validity check fast path.
>   * Returning -ECHILD only when may_sleep =3D=3D false.
>   * When may_sleep =3D=3D true, performing the blocking revalidation via
>     inode_doinit_with_dentry() as before.
>
> This preserves non-sleeping behavior in atomic/RCU contexts while
> maintaining correct reload semantics elsewhere.
>
> Signed-off-by: Yugansh Mittal <mittalyugansh1@gmail.com>

It is unclear what problem you are trying to solve with the current
code, but your current patch doesn't compile alone (seems to have a
dependency on some other patch you haven't posted anywhere I can see).
Also doesn't pass muster with the ./scripts/checkpatch.pl script.
See https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started
for tips on how to get started with SELinux development and to prepare
patches that will be acceptable.

> ---
>  security/selinux/hooks.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c95a5874b..170ae6d65 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -279,20 +279,34 @@ static int __inode_security_revalidate(struct inode=
 *inode,
>                                        struct dentry *dentry,
>                                        bool may_sleep)
>  {
> +       struct inode_security_struct *isec;
> +
>         if (!selinux_initialized())
>                 return 0;
>
> -       if (may_sleep)
> -               might_sleep();
> -       else
> -               return -ECHILD;
> +       /* Fast, non-blocking validity check first */
> +       rcu_read_lock();

Why do we need rcu_read_lock() here? We don't take it elsewhere that
we access isec.

> +       isec =3D selinux_inode(inode);
> +       if (likely(isec && !is_label_invalid(isec))) {

isec cannot be NULL for an inode when SELinux is enabled, so no need
to test for it.
is_label_invalid() is not defined in this patch and no other patch
from you appears to have been posted.

> +               rcu_read_unlock();
> +               return 0;   /* valid and no sleeping done */
> +       }
> +       rcu_read_unlock();
>
>         /*
> -        * Check to ensure that an inode's SELinux state is valid and try
> -        * reloading the inode security label if necessary.  This will fa=
il if
> -        * @dentry is NULL and no dentry for this inode can be found; in =
that
> -        * case, continue using the old label.
> -        */
> +       * Label looks invalid. If we can't sleep, signal caller that a
> +       * retry in a sleepable context is required. Only contexts like
> +       * RCU path walk are expected to propagate -ECHILD.
> +       */
> +       if (!may_sleep)
> +       return -ECHILD;

Indentation problem, checkpatch.pl would have caught it.

> +
> +       /*
> +       * Sleepable context: reload the label. This may block.
> +       * If @dentry is NULL and no dentry can be found we'll continue
> +       * using the old label, consistent with prior behavior.
> +       */
> +       might_sleep();
>         inode_doinit_with_dentry(inode, dentry);
>         return 0;
>  }

What makes your patch better than the code that was in place before it?
Have you compared the resulting assembly and/or run any benchmarks?

> --
> 2.43.0
>
