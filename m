Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2FF158DD1
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463633; cv=none; b=vC2r4odBw67qBOqFnX06S810mvDYMxc57le/BdNy3CvfRJ+BMyc7oEGtZ94rw7TpwKtJEjnFeZYB3Dok4wM4INNDjviTmO+oI77M0Ma6ZwEZ1MdE+wiwj7JDmVV/Mid5jS5gGXu2rV5Yxu4ytGBsF/X3/LV7w8DLQCNLYgsWm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463633; c=relaxed/simple;
	bh=U14wLxXzX42eXPSprN8XSSNvrXqHOCD6YY/tjV7vsIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlXiWhzzj6X0wJG0ZkxGRLO0nx0kFSbE22IsdcKoREB86vkPoJ0LDHCyUfKByzzNjtAW8KjM8ZT9YGQTjLOZSWCo2xyT8gcB91tuP/ofikoBB4cgDOcJRYwFSNlsWLVETPFR/rO+rWUEDKPOF5Vh+UIt1lVVJpifjfCUtV8uWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Anon7c55; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Anon7c55"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85b9f2de38eso1116290241.2
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 11:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734463631; x=1735068431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA362baD9Vq5CpTdclzvmjPkviVm3vQdsLvDT9X6Htw=;
        b=Anon7c552JEWVRsULtqghV0+noS92zIwj0qeLy3ylbZ3rPGuFVmNVxZyPcJtKV/QB5
         PHyOccHKXr29lWd07b3Ai7SytiOuq8XXTKbUZ9rFHSgh74ZAXb+KoHxeSAZLde/WYqZJ
         PAPtELGSedn61ClwIZfOqLH6sC6wvN7i/gLGqHGmz/hl53saI4feuBE0MX0a1/X4qTdL
         v/fR5WyBJBriTqcSeHLfSwfJNNf9iqscUp/FG+kMCauCqg6KeLSdmkow594FhGIp3Qmq
         MuTTMRpJZzbhmYq2xQ7uS11MUTFDbYVvcnj/syIwCoLEbm5yktL2z+8Jj02UtDI5GhzH
         c7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734463631; x=1735068431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oA362baD9Vq5CpTdclzvmjPkviVm3vQdsLvDT9X6Htw=;
        b=SvFzrL+1Q+hxiOlmZgBy0EgRyuzF+R8T6UqdlGgBLgmmBvkc4j7bPaFeCcG4LUaf4Z
         CZytDKq/4jL5nwqPcsdNZKKNOqPZno8amcDQGpkQdfAAZqfdLBD0X6WFBqGNyjDAnh4D
         XwDG7ydJQFULPgF5CHmGl6zpX+nuabiD3VLPo/BviFFp5QVxhT1y2zMsh2pgSIfUWD70
         e5kYn2klgOi77mjl88jxim+IKn10SfeWR3w0vKCoGrUPyuFftLA3F1fbTM2+ZhO8ofz7
         i6hW/8hyCm6Rw/2UpkOExKNX2xjXGJlFTqZLDZwAI1z8JAFphc6GQsOFgbfPistGPOBb
         ry4w==
X-Gm-Message-State: AOJu0Yw5vTt90mHg754UBpsBQXmHoDQ25YYq1Y7oS/Zx8kJYF8qfpInc
	lbhbExSiAlj/F6chXUFYpNPnIdyGU3phpmlcu0usF+Etzpn0pId0TKvD4c93GpR6xPUsg9GkAYQ
	Ox8CiYPYh8b+7h//JQG6YCZRtUlEk5ViM
X-Gm-Gg: ASbGncskS81AftYvW9hvoajKxK6K0Qxzab4ITkfW6fC5l7u4BDmuG/MEdhyjazhdB93
	VH8BgYrXchCaARYcp0PZsUNqUzZuGf/LZ2//diQ==
X-Google-Smtp-Source: AGHT+IFxjn0bnBIvPj2rnMiIfm70ipTHhKwfdJg2YJZvYHEFGC9XWAoaKzluJ1I2AamKvR7nKqZFzKdbs28GAGupfdU=
X-Received: by 2002:a05:6102:32ce:b0:4af:de39:c55 with SMTP id
 ada2fe7eead31-4b2ae87469cmr47424137.27.1734463630771; Tue, 17 Dec 2024
 11:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212185416.2187747-1-vmojzis@redhat.com>
In-Reply-To: <20241212185416.2187747-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 17 Dec 2024 14:27:00 -0500
Message-ID: <CAP+JOzQ=pzzFmtCQRTP+3YqFsVjwwV9t3r2uGFF40o58cetzaA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: Mute error messages from selinux_restorecon
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 1:58=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> Mute error messages produced by selinux_restorecon when rebuilding the
> policy store to avoid error messages in containers, image mode, etc.
>
> Fixes:
>  #podman build --security-opt=3Dlabel=3Ddisable --cap-add=3Dall --device =
/dev/fuse -t quay.io/jlebon/fedora-bootc:tier-x . --build-arg MANIFEST=3Dfe=
dora-tier-x.yaml --from quay.io/fedora/fedora:rawhide
> ...
> Could not set context for /etc/selinux/targeted/tmp/modules/100/rtas/lang=
_ext:  Operation not supported
> Could not set context for /etc/selinux/targeted/tmp/modules/100/rtas:  Op=
eration not supported
> Could not set context for /etc/selinux/targeted/tmp/modules/100/rtkit/cil=
:  Operation not supported
> Could not set context for /etc/selinux/targeted/tmp/modules/100/rtkit/hll=
:  Operation not supported
> ...
>
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2326348
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> I feel like this is probably not the best solution, so feel free to
> suggest a better way.

I feel that it is fine in this case. It is limited and there is
already a comment saying that we can ignore errors here.
Thanks,
Jim

> The logs are all the more annoying because there is so many at once and
> they clog up the logs and terminals so I am wonering about removing
> the ERR after a failed fchown as well.
>
>  libsemanage/src/semanage_store.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index e44efc16..2ca2e900 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -3000,15 +3000,29 @@ int semanage_nc_sort(semanage_handle_t * sh, cons=
t char *buf, size_t buf_len,
>         return 0;
>  }
>
> +/* log_callback muting all logs */
> +static int __attribute__ ((format(printf, 2, 3)))
> +log_callback_mute(__attribute__((unused)) int type, __attribute__((unuse=
d)) const char *fmt, ...)
> +{
> +       return 0;
> +}
> +
>  /* Make sure the file context and ownership of files in the policy
>   * store does not change */
>  void semanage_setfiles(semanage_handle_t * sh, const char *path){
>         struct stat sb;
>         int fd;
> +       union selinux_callback cb_orig =3D selinux_get_callback(SELINUX_C=
B_LOG);
> +       union selinux_callback cb =3D { .func_log =3D log_callback_mute }=
;
> +
> +       /* Mute all logs */
> +       selinux_set_callback(SELINUX_CB_LOG, cb);
> +
>         /* Fix the user and role portions of the context, ignore errors
>          * since this is not a critical operation */
>         selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | SE=
LINUX_RESTORECON_IGNORE_NOENTRY);
> -
> +       /* restore log_logging */
> +       selinux_set_callback(SELINUX_CB_LOG, cb_orig);
>         /* Make sure "path" is owned by root */
>         if ((geteuid() !=3D 0 || getegid() !=3D 0) &&
>             ((fd =3D open(path, O_RDONLY | O_CLOEXEC)) !=3D -1)){
> --
> 2.47.0
>
>
