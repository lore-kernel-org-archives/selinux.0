Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3D62777FC;
	Wed, 13 Aug 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099827; cv=none; b=Th27lrXIH9lsYprByQnTkmxGQm0Mh8NgmdVoOKk7LPzVxVdF2aqwiDIs6UY8hv8g34PDSmjID2luUeEIQxUpUOb+qH5udO7FC7w0K50jxXL0rqosw8c4mHIPqC2KkHIDgCsJoKWqpjDRqgvEqpDYJhO8ob9QEX0+pzvdaHTgKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099827; c=relaxed/simple;
	bh=Yu2TGz0V7huH3B+dopXezRr84noOuCa0qaA8uSjwg3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYi/38q40dpDBGpmPXtC7qjlwjH9ZOXAG3uc/P+XMxm/rJazCOZZxKKSuiir02jC5709GFWD7kyhKUmw0zaCpWQ6nDdQtmZt7ZZUw+TRZwNVSGrY0WUlp/nQHNTBsMyBAQOWsNvNgifXUOwmuExLRUuM8+jXXlzU+EMX0AGmNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2hSx1rA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2hSx1rA"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso26942b3a.3;
        Wed, 13 Aug 2025 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099825; x=1755704625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLJY9WChfSG8Mbw42w6HBv80pOousbyrGLdvMJa51U0=;
        b=F2hSx1rAQkm72Yk4mP/GIq+1hmbR7FnghdWGLkrp6Z4hKF1TnYuWDaQXnOuj7DPlUn
         cCo6dh0UscFFfJFkGfFzY3u0tOpLOs8QkTVFK70Bds4B5yxTWL2cAOdCLtwXuPTEt30D
         2gKjCtcw7D2lmP3Y6JzNkLzL28aAdQ3CVfWrK2YlBrgXCIhr4/ScgfnXFHhJkXgJc3se
         1/icTVMFWGWUs0ZtvyMmg/ZLTjmrmPBX5kZ6ITEttxO2SZz9/Fwl+1GtLAtXMVE2x0NM
         IiHpj73Bvnc6d1HDmYyhkySFoHvvkdvPGVuqwciZeRZyM1PhCoHX+2lxo/xWqSyYxwsm
         UnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099825; x=1755704625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLJY9WChfSG8Mbw42w6HBv80pOousbyrGLdvMJa51U0=;
        b=sNIgOWMmd8zuigY9PKCFjY0CMGGIIpg/L4QWHcpCeRwyNhYQsZiXSUqAKniEC2RKkh
         MNSKkXmfw+GCmQnZhVsfb2lBk/5D6ndaefWNyVynZj6ZvjkQ7oBBWTHGRsNr7GdtHek5
         GFWsC7sOZf8x1Ipg8qtPCf0ELYfrSNgX0uN0mjIL1JJsIYNPVewcPw7f8sNlfyaMZgK0
         QtP/ZUoPkqT+MFcobOsaDYQXIUx/p5Xo1evbVIbeEqJCKDyd7yxICObemsyPejAp/qX8
         +7yUwGNeoBLJkWLynyCvz++fH1cz7wsrO+9jis/yY6S37fCwNqLYb7UhFkQMUP63AfJ/
         0KGA==
X-Forwarded-Encrypted: i=1; AJvYcCVJB3Y8N/e1L+2V188lUn5oWkbPXTPVb3/tU2/Fv9Ce8NKvaezzKOm9eh4GkYj1xgL+SttfnwIrRucD9mk=@vger.kernel.org, AJvYcCVMkbUIHGldRKChtR6JQtSCV12dbpyHF5mU7kLSpa8EE7Ohv829QcRD9sl2xzXPH8lo35g9KYsHUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgAn8k+4zB/uZWRgE3OuWDs0wIyYpAIR/ureVkUJ8pfe8DCm98
	kmT8AXgiSVnsspgHQqrsR6cGzExfmezQhx2Ky6SOVJkFyHEgyw5J87mUlNj6uYxTEyzGWKrAKYH
	U8OnT2EVURuQRPiCKYOkvlYuhwlpNcwGhHQ==
X-Gm-Gg: ASbGncsXbrN+dDysvztyxR9xVdEubE3NaKFeHixshXjf6Qekvp0FYgwIwdv3fEZLfIZ
	TApBy8RErptlKCEEPm2Wsav9fp0lhuTGlhFDZjDl5XThJK+Swv2NwcQ9Wo5/hKOD+nmEDuBHSFO
	quOJ/NIoFX/zPn0s5uITSxL7fXvZNXgreP7XFHadHJx8nRoQnRc/Q/9XHRajb5FOZXMA9hfbYSQ
	/ZbmHE=
X-Google-Smtp-Source: AGHT+IF0tYy6+sdAda4bu4ePagsub7dBCKp7O9diUO7ecnaT2ixsWT94QXnnnmjcNqd3yM6qh1F2eCUhYa4CQOAkBws=
X-Received: by 2002:a17:903:1b08:b0:234:a139:11fb with SMTP id
 d9443c01a7336-2430d1f8072mr41150655ad.27.1755099824625; Wed, 13 Aug 2025
 08:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813100053.1291961-1-dsterba@suse.com>
In-Reply-To: <20250813100053.1291961-1-dsterba@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 13 Aug 2025 11:43:31 -0400
X-Gm-Features: Ac12FXwGxLoVhTfBgkQj0xCO3LwjKiT_AVVp6j0dFtjbt_4ekDZCkBAOcErN92Q
Message-ID: <CAEjxPJ75Nwb2AGbT2uDe1WACjxiL5hcg0q+WHfu1T3YFN2_UAg@mail.gmail.com>
Subject: Re: [PATCH] docs: Remove remainders of reiserfs
To: David Sterba <dsterba@suse.com>
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:04=E2=80=AFAM David Sterba <dsterba@suse.com> wro=
te:
>
> Reiserfs has been removed in 6.13, there are still some mentions in the
> documentation about it and the tools. Remove those that don't seem
> relevant anymore but keep references to reiserfs' r5 hash used by some
> code.
>
> There's one change in a script scripts/selinux/install_policy.sh but it
> does not seem to be relevant either.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---

> diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_=
policy.sh
> index db40237e60ce7e..77368a73f11171 100755
> --- a/scripts/selinux/install_policy.sh
> +++ b/scripts/selinux/install_policy.sh
> @@ -74,7 +74,7 @@ cd /etc/selinux/dummy/contexts/files
>  $SF -F file_contexts /
>
>  mounts=3D`cat /proc/$$/mounts | \
> -       grep -E "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" |=
 \
> +       grep -E "ext[234]|jfs|xfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
>         awk '{ print $2 '}`
>  $SF -F file_contexts $mounts
>

Just commenting on the selinux part, this entire list of filesystem
types could likely be removed and replaced by just running "fixfiles
relabel" instead, which on modern kernels (>=3D 2.6.30) will check for
the "seclabel" option in /proc/self/mounts entries to determine which
filesystems support security labeling.
