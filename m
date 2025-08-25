Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0496BFCE;
	Mon, 25 Aug 2025 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126047; cv=none; b=YZar41SzlE3wsBPZITNOCDfITDXj0WHplRvwu+YqxnkvmrLWSOBdbi0iGVrn6f/ZUUf46g4QRVNoI1QxHiDNnVQwD6yzaPAb0y/SKYxAy1vJulqaYKcUvb+hYYZ5ZwSV9WbtZPko1TlOFLXieKuoG7RvhJNZ+CZPLbEoodo4jSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126047; c=relaxed/simple;
	bh=0gdFNx6GXTjA5oLRilWZiyfEvwBHxFr5q6NQWUJX7lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDs0PdjvKjMXxZvF+oxvID0RRnw31PtY/VqqOPdBSWA59QGHzUmi32EKajSAg58It3kZcM+v/IQ3kTORSSo4MRFbP5Yh2qV9D6b3UexR1jBtm8ZUokdv+2XpxBmFx+gviEHRWZ3vZzOvb8cGebD2dYUf84qgapN9yAym/UyxmEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B04b0TZN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B04b0TZN"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so3794947b3a.0;
        Mon, 25 Aug 2025 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756126045; x=1756730845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pB42h8KhdCu+rKcl6R+qSx9ydRtdSuvsQ7gp0cs6PM=;
        b=B04b0TZNpIjXThagXzvp+82oBaAZqRHjInmz5A9+6A2oTE+KwaQlNidUq5TLS9Z6na
         MzWllDgEshDdf7XBIIacNv/TUpeK5tfs4EZUtGfYoLpbRYL3eL5laRLRJL1d42ukLYBp
         salXvo7Z6lQBRxfKasFx/ToBwP0N2YKsOu9179J2ERjEHZ/gY3rBGOWs9eP56D0HCeOe
         8rKilT3ermcAsxAJRmY67gaI11HvxaehKZexOOkrG49ZRtv+3dhvzeLOXO/boQ2V0fKC
         cxSzfA4fZJubo4p6knBHjll0GhwRC06hd0hEPMByqHkhantq4BC2Y8KpWOG8QdsAB0QF
         yiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756126045; x=1756730845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pB42h8KhdCu+rKcl6R+qSx9ydRtdSuvsQ7gp0cs6PM=;
        b=PIUdaZ9PQAw4g877R/HCntryxteep4hl0fDq6pMJH61qtMnbNpXDonTnkbi6aprdoq
         0koii7PXl7nf4fHRVISkf5JC/9D9DsATDjf/VBQTQ8GTYhiPBGAi+1eT5YmaSCRmPLL4
         69j85J4d4vI3BHXvBMVstj5fAtkArWAMU0AotBzIeJpMA841uP6bVyWXCObaeqKc+PxH
         JwI25Ld43QY3aTlsuCSdQMl+RmKwW8IHb6WXPBbDZZtwGumfAQLqr/ZPZgZcwpnLz+1S
         nNj0s6ZW6e3fQsFUBtSuxfClMulgkn9cQuY0kCh1x7H1Czh6bWIFoonhBjp+yBakJaGR
         KZcA==
X-Forwarded-Encrypted: i=1; AJvYcCUOxp1T9eHTSQPUEjVQu+whW2CZoNfEG9BrwKZ3Icp/xn8QSmO+2nVjApqa1rY9d0Ua/rbLKTJ40RMaTIQ=@vger.kernel.org, AJvYcCVc3ZFm535gXQhAGKESs67S+yyIkC32jZKqkoJzUY3wwvqNdapqNjumMMsK9/qjjVBSSPY4f58kTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL4jdL9BNQLz99fjnlP2MHYv/gZ92FXp6DB8EYF4Hom5B30kGv
	0E17eARGUoUCc517v7a7jWwKUGo9iGuapDgLJnmiHkEIvz8F3MvBiKz6TjpoPzwbDR5u6tkvVHS
	hqDtwssXve0QEQHLrRZgo36ToYNEvuzI=
X-Gm-Gg: ASbGnctjIeO9bX6HYiYrT0xAah/x4DOSlnaakLl1KNFxLtJs3MLAJcQ+ksGSon+7mUG
	Y4xwKf0vlV/s3nHzwBi/pvPuuf218TttNu8hXVu13wHyl/IIykK0Xx1czPEHJidG+VyjP7FCiSs
	3U8J/m97ZsY6tnqbtTAECF8tjdVEm/XmE/V26uFgFnAXsJAY3baCpYfHOh5a72wH9gYeysvfa/4
	WNBRVE=
X-Google-Smtp-Source: AGHT+IHK4G55vrT0z/Vc9/EMd1Xem4OzHkqt4YcrDG6lt8qqXtwp8frm3zJhvIQ3rDj7SzFcOYWWfEi0n/Kk8cuc56g=
X-Received: by 2002:a05:6a20:6a26:b0:243:78a:8296 with SMTP id
 adf61e73a8af0-24340e06888mr16844987637.47.1756126045319; Mon, 25 Aug 2025
 05:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824130106.35366-1-mittalyugansh1@gmail.com>
In-Reply-To: <20250824130106.35366-1-mittalyugansh1@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 25 Aug 2025 08:47:12 -0400
X-Gm-Features: Ac12FXyPz3TVvLbv55vx5OvxIWKPlrlzVuYOuRUEj4dKsNis_Ik6IjZqj7xVw4M
Message-ID: <CAEjxPJ6xCZLotyjfF-SBKbxFUur4=0bFbUpSZgbOkF_BMaAd4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: make __inode_security_revalidate non-sleeping
To: Yugansh Mittal <mittalyugansh1@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 9:01=E2=80=AFAM Yugansh Mittal <mittalyugansh1@gmai=
l.com> wrote:
>
> Replace the blocking revalidation logic in __inode_security_revalidate()
> with a fast, RCU-safe check of the inode security struct.
>
> Previously, the function could invoke inode_doinit_with_dentry() when
> may_sleep was true, which might block. With this change we always avoid
> sleeping and return -ECHILD if the inode label is invalid, forcing the
> caller to retry in a sleepable context.

If you look at the callers of __inode_security_revalidate(), you will
see that not all are capable of propagating -ECHILD to their callers
and forcing a retry; IIRC this is only truly possible during rcu path
walk. Hence, this change will produce situations where the inode may
be left with a stale or unlabeled context.
Your patch was marked as 2/2 but I did not see a 1/2 patch.

>
> This ensures that __inode_security_revalidate() can safely run in
> non-sleepable contexts while preserving correct retry semantics.
>
> Signed-off-by: Yugansh Mittal <mittalyugansh1@gmail.com>
> ---
>  security/selinux/hooks.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c95a5874b..2bb94794e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -282,19 +282,15 @@ static int __inode_security_revalidate(struct inode=
 *inode,
>         if (!selinux_initialized())
>                 return 0;
>
> -       if (may_sleep)
> -               might_sleep();
> -       else
> -               return -ECHILD;
> -
> -       /*
> -        * Check to ensure that an inode's SELinux state is valid and try
> -        * reloading the inode security label if necessary.  This will fa=
il if
> -        * @dentry is NULL and no dentry for this inode can be found; in =
that
> -        * case, continue using the old label.
> -        */
> -       inode_doinit_with_dentry(inode, dentry);
> -       return 0;
> +       rcu_read_lock();
> +        isec =3D selinux_inode(inode);
> +        if (unlikely(!isec || is_label_invalid(isec))) {
> +                rcu_read_unlock();
> +                return -ECHILD;  /* force caller to handle reload elsewh=
ere */
> +        }
> +        rcu_read_unlock();
> +
> +       return 0; /* valid and no sleeping done */
>  }
>
>  static struct inode_security_struct *inode_security_novalidate(struct in=
ode *inode)
> --
> 2.43.0
>
