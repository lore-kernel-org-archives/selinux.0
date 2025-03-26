Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9641E835A
	for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000661; cv=none; b=NNFYaREnWfj8zW75WPaYZWUtv/8EipLXcmDCw29rlPVU58iT95tslFxlzhX0P9k6ALUM1PyxCejh3nSWAWskF+zwK3hqmubht68VO6peB5vv6aYJYCBFWt/bnf4WhRDYkTCuj9EjBRlYN8FjBG+ZoGfB7YYESr0yuo/iPIxbI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000661; c=relaxed/simple;
	bh=9+Wn4o4ZfYJnddu7wbT6vlJ4Zo7wtpFNww/i7dKFarQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhrWdRJVsqwFjCLtP9tgbr9GOTsL8o1gjmqeD6bKsk8RIbLbKrm7yUhDaOM4oaHKXqgE6DxFdznldMXDL1U+N5EMmOWurQI1ep+o7r3U9LuyjwvfSjEmHZYhjaU4AC96GZK5vDWXjN7UAaBHtsABXEwWHvDwoohaZyOC5/7+1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FBC4+J9T; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FBC4+J9T"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e461015fbd4so5160333276.2
        for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743000658; x=1743605458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TryVD5CFfRquqiR5s54SHld1/iLLK9/M4gETsJY9Nk8=;
        b=FBC4+J9TkwdRmbz0JgNv0uMP5iCC4kRGQLw8UgJ+DnDn/H1Z47dYNbJXhsK5Py4TqE
         w2wHc+uJKE4K5Kf/8kFmdaztrVEQRdExq41pQ9tmUBiwPah0aB7FX2eF77m3d2bkUBv0
         ncdNYRJfEhL7X5haNMA6hUedxoaggM/2szY7+nLn4kNFaCeQUnWtzfNVpVKgQ8YUlDBj
         aAV9Pjee3DGCUq40ywSittvxVuppoCiA7dr0X4vd1f2K9NYG3IZXQ83auywIAcQnUXlv
         zhlOIoD7R0mgueLOnekOaNXnwU8xtFYVFXNW/Ffp3Y3SVlOkMaAIN/coiL4OCGGNGvrE
         rxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743000658; x=1743605458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TryVD5CFfRquqiR5s54SHld1/iLLK9/M4gETsJY9Nk8=;
        b=STaaM+9QSNq3zZOa4qy2whZRB0XWRljjK64OzNKju2emEST/xiaKlY+h8MFyhY1vNb
         Hm3gkIq+6W8Nq6zvgPUGn9SehM5uf2LD+Y1/6PD8/ViEzDG5sTwpsr7V2kT3vB72+8P4
         lbutQGMI29+46wDDDGf1kOeFqIBhugQhcFgZ+Xfmi4DZPFhBa6LWmpO0RXld8y0hRev6
         k9ru/QMXKgLB6qy2E/WsvJAZD3Ilsnt5zuaR7N8LdTDUip8dX7Bq7uY1VIBWH7UTlkkn
         bJ2nk/h6sPRrtRvsrFTI8m6IOyJ0rnmsQqmHFAuiL1PwfqqDwEdzSWF1bPJJwxpCs8Fh
         gN8g==
X-Forwarded-Encrypted: i=1; AJvYcCXkCAd6xgP9ssZcML5+063aANpZZWumHMGajLQLPDpkZCN9prNguO6orjMXFC8y3JQO2h69XM6O@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwlAGfirLlBcldwpTgtQIx+TxxfFmVTUuRqQvywxSNtFTkR2I
	asLUntTCNNQZ6Wjf3NETUW4Og6Z2wy0s2ZCiwdbTBknPK1EAAzlWpL2FgZ8VHXSjVgkZDseSTTb
	lakGP/dnAISPvlsh+U4jhQ3FXRIKly64fJFAr
X-Gm-Gg: ASbGncufWVbJz5LeJWo+xm/aUFjes/1md1o/FDcuNUV/fwD1OryCqgzn9cAxDQIDH5U
	RRMdNVvDGpBZl8W7FqxnI2YWGOLsIYvH2hxseqN+nm7hEPExDwXFtn6kK1rWE/+5QKHDAxwlVr5
	DXlE/BBYp2XKN9pyAPcwqwxi0HBA==
X-Google-Smtp-Source: AGHT+IFcPaBFchl6GGXsFrbA3a18D06/oSA6/keB9qsRXz06Jix3SOEcuau74uHQbJqSgkjYgJHwTzGjP8JA6S9LCdk=
X-Received: by 2002:a05:6902:1b0a:b0:e66:8fa5:622e with SMTP id
 3f1490d57ef6-e66a4d29f57mr27836094276.5.1743000658423; Wed, 26 Mar 2025
 07:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326103819.93387-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250326103819.93387-1-cgoettsche@seltendoof.de>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Mar 2025 10:50:47 -0400
X-Gm-Features: AQ5f1JrV3Av0wV5o_U_aKmUG8HQHcRrvdTic1WTTG_JyJ2opcOPJaHy12pmnt2I
Message-ID: <CAHC9VhRUzr2XpfP5XJpXLxEhYoFvtee8OgEwvib1x7+H7B68Qg@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: rename io_uring permission to match syscall
To: cgzones@googlemail.com
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Jens Axboe <axboe@kernel.dk>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 6:38=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Commit c6ad9fdbd44b ("io_uring,lsm,selinux: add LSM hooks for
> io_uring_setup()") introduced the LSM hook `uring_allowed` and
> implemented it in SELinux via a new `io_uring` class permission
> `allowed`.  Rename the permission to `setup` since most permission verbs
> are named after the corresponding syscall ...

Some permissions are named after a syscall, but there are also a
number that are not.  I believe "allowed" is the right choice here as
it better reflects the intent of the permission.

As an aside, the original draft of this patch was sent to the lists
back in late December and the final revision was merged in early
February before going up to Linus a few days ago.  While I maintain
that "allowed" is the better choice, the proper time to raise your
concerns would have been during the past few months, not now.

> ... in this case
> io_uring_setup(2), and avoid confusing policy rules with an allow
> keyword and an allowed permission.
>
> Fixes: c6ad9fdbd44b ("io_uring,lsm,selinux: add LSM hooks for io_uring_se=
tup()")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> Note: this patch targets torvalds/master
> ---
>  security/selinux/hooks.c            | 2 +-
>  security/selinux/include/classmap.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7150c953fec3..bcc66dea8bdc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7188,7 +7188,7 @@ static int selinux_uring_allowed(void)
>  {
>         u32 sid =3D current_sid();
>
> -       return avc_has_perm(sid, sid, SECCLASS_IO_URING, IO_URING__ALLOWE=
D,
> +       return avc_has_perm(sid, sid, SECCLASS_IO_URING, IO_URING__SETUP,
>                             NULL);
>  }
>  #endif /* CONFIG_IO_URING */
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 04a9b480885e..49fb584f2056 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -179,7 +179,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
>         { "perf_event",
>           { "open", "cpu", "kernel", "tracepoint", "read", "write", NULL =
} },
>         { "anon_inode", { COMMON_FILE_PERMS, NULL } },
> -       { "io_uring", { "override_creds", "sqpoll", "cmd", "allowed", NUL=
L } },
> +       { "io_uring", { "override_creds", "sqpoll", "cmd", "setup", NULL =
} },
>         { "user_namespace", { "create", NULL } },
>         /* last one */ { NULL, {} }
>  };
> --
> 2.49.0

--=20
paul-moore.com
