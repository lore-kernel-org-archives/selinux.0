Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B23FD139
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805260; cv=pass; b=t+hnlryww+s2Z2F188gMiiBy0ECXCmsizeAlS4CgV8syX7IUA+d/JmesWCj5qFMiX59PVZ7sWFvjrBJ5LSRo1oaZNLVZIO9N8htVFxkUGr/UyCnI2l/ILfIsncelAvJPRNNjxWaaqddPEfpdL1x6RxA/Ybg0d+ns1pe+zNNnHkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805260; c=relaxed/simple;
	bh=rGarESh6foTaRj4HlDn9/zfjy+ZXCI45PyaBTMp1LmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMCJWKkb3Janivd+wjju88qajDxj6IleuOAMEjUBAJE7eo9vRThLGc9tawZ77thyohxnR8lW9w+gDHX2nwPV5L7qjbTxvuXAPvFhVd/MdiZdB5El2AfhEJVjsthGuXnvYnXI4YPjbUGdvltTjHWuz0OwvakJcQN+nRjNJZzpO9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgMQsv4N; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgMQsv4N"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-837dfccd950so4958886b3a.0
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 07:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805259; cv=none;
        d=google.com; s=arc-20240605;
        b=kDQYft/dysovAu5HW7vNi09Qi8qVDVfHp6WDCc3EQddTLINwxAq0KZ/uMX92/gu2R0
         VhQ9k2xDOZui8EIX5SWMDN+An9bqz2sivd+ARHesSeppFblomrnk3f51fQtrdgnKNB4F
         4jTnHI4gN/kiZREAUbyD2X9heV9/yYACflxgxsO5AluGCh4sW6jTANgraUqXU6wRhd81
         8ESef0jQoDxQIxpRox9P99M/sMRpjKJT12u0ClUO4T8lfxamQZyM72gZee9PGvkyfgjB
         TUP7t5ufThaAaI72vRXw3m8WJv/wUhciwOKf1/2sH3jgGANouEFBjjWw1wgbDT7BY5gq
         GDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CyfxBmE530e3wWYkMTHWPydSStB8SfVKsfRtoYIhnJU=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=lmD2RxqIzru3uYgvUxfddljumGVUcJD0wrsBz2rKD+C+y2ip0wRmXSTOEW8Aqmwvyg
         /EOMHF93mOJGoZLAQhnS25MKMGwohYvj8yw/Y1nI2CTDveCtmM8OUwQ306zzSTi4Sgzc
         7vLKAbrJD/AwVfQRRfvR4jsjLx7nOPKUqq5DUtTgJhoYwZwL3+EBtopSKE0IGtnHhRZF
         aJfJN1UOzXoygfbXFFDxlsVmidb078e8sDBSL05zXiZjpvh5hIWHFHsuX2OGDWPr3feZ
         lI/L1lbtGxMZgeUZdOgslSgWC8k226rPi/yz9NhMHYSrCICCUQqYH1coZNjQHzH/CTyv
         uDBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805259; x=1780410059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyfxBmE530e3wWYkMTHWPydSStB8SfVKsfRtoYIhnJU=;
        b=ZgMQsv4NWpssz57Fj3VQiUCzbp9haqe7NsFKV4KdnZ/K1LLtdzE3ChJ/b6iWxD1A2s
         zrfxjgsQiW9ZEsa5b7AjwbdBFM546PjyFiRU7IgQrpFmIj4ZDnY4Z6iE5tFpjHUVazAa
         dhnyPuIpfc3RQsGdNih5vdekbtiyjAH8CX5Vo9cumOueBtiDhD4pJxF6a/hhSdlJUywJ
         beUoL3LeTNSejCXi8Zyw1XaOqYeNAHuK4rOq0IwP2POv25b5TPJRqVcEaXBRn6lZjBQe
         Jg+lOYaVmNc52y+xB/dNurfxGDytG/+SFVdi/7dVFxcgGQbvoVhIyQKfXHo4s4s1rJKM
         sUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805259; x=1780410059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CyfxBmE530e3wWYkMTHWPydSStB8SfVKsfRtoYIhnJU=;
        b=iMwdYyT8KY4vUGcTOitsxETcmuwUjHwHa7v/wv1TsOAvNufbRz1/8ZOeLxOE27hpPG
         xSYtSZb04XJ4qNRgR1MA70VIdBi9GYC3qKbiBAaUVrmsxv2Ib6Jpm8Sj/1K32xDUowYn
         OQaim7ZYKTP3Itkf82kwzX5iz8EYwfnGUFd8FrvA6Yp3CTCJNyADcNoq5biZjZ3xSyVf
         8CfhhZLWi2+UTZdsNC+zkqTjTUDEizo0mk7kgmNUn4wa5euw73aMHWssV/zacAYVjObW
         KmKgRadmcsQnKX/o27pPx/S38L7o7EgrZyUfDDBYk2gMkfjj23MCSOK6hQyl9P35s5pH
         Hkjw==
X-Gm-Message-State: AOJu0Yy+5vTY759jPkpcJgEuitBgUDlL6OA8FM0uolQO7MpldGREKm74
	pFcP8oEC6SmOOlFA7RfSITlxy6ahCYZjZ597PODcrc6j0Lx4Fyuh5hqYMG/ejOnJ9xvdz1QBMF1
	iC/p/rO1Q3OGhdAKg63nLN0S3fFBaO/5uTg==
X-Gm-Gg: Acq92OEKbBaKkUEGBeUsto2fBb9A7Ku7571wUIuxPz0CBBGTCH70dqg1UASJTJj9IwZ
	Nx5avGfu9sTNvqNMAiFbWp1jfduwm/6SXO3qIK+Ou91YaEHjwV5PvBsRW/154M/VQn+XSz+qEBI
	duoH26Wd1JkeRigLj4ksqnD51RiAHKAee2B/PsNh3aCeMCKCwJGziMNPPiruk4H0M7H6GK8NGDc
	lm11uINprbBZ0/gSFnyL5eSpApH6dHzLd4FiD6I6lPN/EhqDqhdNHMhWp2F8Lk+XFeg7AvxhuG2
	rme0dZ0=
X-Received: by 2002:a05:6a00:2d8c:b0:838:9e25:f128 with SMTP id
 d2e1a72fcca58-8415f32f29dmr18423924b3a.26.1779805258559; Tue, 26 May 2026
 07:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521134024.11581-1-stephen.smalley.work@gmail.com> <20260521134024.11581-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20260521134024.11581-3-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 10:20:47 -0400
X-Gm-Features: AVHnY4IWaf4HMgP24dLH0JqT4u-JyCwwgoO212ey_9ZQ0Q5N_hquj4KzE-yZcnQ
Message-ID: <CAEjxPJ7SRvDtH3_2-Ztg_jePK05dGcLP0VWuyg+89q=49bAyNA@mail.gmail.com>
Subject: Re: [PATCH 3/3] restorecond: create a separate io channel callback
 for stdin
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 9:40=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> restorecond registers a single io channel callback that handles
> both inotify events and stdin. This can erroneously end up
> trying to interpret stdin input as an inotify event. Create
> a separate callback for stdin.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

All three merged

> ---
>  restorecond/user.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/restorecond/user.c b/restorecond/user.c
> index 25e70ae1..3191829f 100644
> --- a/restorecond/user.c
> +++ b/restorecond/user.c
> @@ -169,6 +169,32 @@ io_channel_callback
>    return TRUE;
>  }
>
> +static gboolean
> +stdin_callback
> + (GIOChannel *source,
> +  GIOCondition condition,
> +  gpointer data __attribute__((__unused__)))
> +{
> +
> +  char buffer[256];
> +  gsize bytes_read;
> +
> +  if (condition & G_IO_IN) {
> +    /* Data is available. */
> +    while (g_io_channel_read_chars(source, buffer, sizeof (buffer),
> +                                   &bytes_read, NULL) =3D=3D G_IO_STATUS=
_NORMAL
> +           && bytes_read > 0)
> +           ;
> +    if (bytes_read =3D=3D 0)
> +           exit(0);
> +  }
> +
> +  if (condition & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
> +         exit(0);
> +
> +  return TRUE;
> +}
> +
>  int start(void) {
>  #ifdef HAVE_DBUS
>         GDBusConnection *bus;
> @@ -243,7 +269,7 @@ static int local_server(void) {
>         g_io_add_watch_full( in,
>                              G_PRIORITY_HIGH,
>                              G_IO_IN|G_IO_ERR|G_IO_HUP,
> -                            io_channel_callback, NULL, NULL);
> +                            stdin_callback, NULL, NULL);
>
>         return 0;
>  }
> --
> 2.54.0
>
