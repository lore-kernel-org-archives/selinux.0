Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DAE2641EE
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159333; cv=pass; b=Oo3TMmKmqTovyJ/huJQqAXud94WFSvq/oggUn35ZwXJ+BUs1Dyyyaui1DkPbHqemOsk+uE6a7WHtKKNnstEzTzUGpuz6fZPmy7qKxiO8cS5TaDjqmO68WJFCi1qB0usssUE8lERDgIQU6vbPcClvTRgUHfpZCgtFISqbmzrUE4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159333; c=relaxed/simple;
	bh=up3FlFM3niw8vSUx86jGjiDK6hebArADA2Mgamo7k/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIjz5Fjt93/HHAndCf/RkdRkTZe47CXjbkTO23oRX57Zmg+uO08GImQfIJTuLLGyyYW3oI5x98jH+JL6GlAXMMrzeAA26j4TwwgE9kU1uNlkm5Dcc6ol2T1Klw49nMQX4IBdBDLYuGCgymc4d8xo3b3tYKV1kyjyinUTUWSbLR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0C+chBJ; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0C+chBJ"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6aaf3f54dbeso1430720eaf.2
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 06:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785159331; cv=none;
        d=google.com; s=arc-20260327;
        b=eXMYyUXBYdn2sGF7ALOpA/0UXwHDPX6GKkXrCM+eJp9ByTHKSSBNkgNmr0xTpDe1ol
         /g6neCU5ozMJRKOERO9c3rXW0q7BI4p+xR+knwWDS5e1clUOvzDrrRk/We/LDD2RerSE
         ED+iBO+i0cuzUw9E0N8YPe0zOLyyX8/E4dchA3wpKB0kfjPwgZTjodBikKI1hrOCn8wd
         ChdOlYi1O5eqaN672ioE9aaNBTF1b0bhENBPnm4jf5OXQhOLiYteV9xXbX5sa44YLRTl
         2wIU4aYqULaWRxKOjouesYZQhXMVIale9RS1N8DNkZ7QiwlNbxNkZRq3p1JZHJdQJayA
         U8Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dX785e6wzIJbm75J8Uuls02O/XxfeJSJ7p5Q4URLETc=;
        fh=E51Jjr8Bz9WzQ+Ik80n9UcoRPIh3NakEhV8l9xr/qbM=;
        b=Bf4wq4lrA4ayVdt3/IeiAVw3ch8K2Qy/FoiWOv54EnM52k9jAPULBlsZo3V+a4klbZ
         Qb2kJF1ZmhdoKUys1xRg7qjGF5kEMgkvRr8SE4gRpXcDb7G+3d8E83PYj7iyVA4Y/EUD
         0yJBU7ReW5j6ckuPxcQk142GjM8/BetllNYasCf8cJzIdXtOt2LjM7UgaxAEOp6XX1a5
         40OXwWCD5077KZ4g+lUPHB25G69VHL/7Mq5xe3feZT5ESPhn/59o0Hjvlq8LdMUyTvEO
         RSezC1dYspA6Wi4NMOldDhybkqW/my5gagFjjLxauaGcK446xBfLx925VV2w7Chi6mvD
         sGNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785159331; x=1785764131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dX785e6wzIJbm75J8Uuls02O/XxfeJSJ7p5Q4URLETc=;
        b=J0C+chBJzF5KfCJh+M8wP+sS/J5y/+2usauJPWcPPfe7Y+/sIGVuTjYEJl/AmEZQZA
         3XysnGJqyegLCV3fO+Wk491J+XfXxndkAgkHkAgd7RrgQsO/Yga3bU9fEso1DUKP2PWX
         XefxnPZtu1CcrheXZKk6U71IHh0epHLL2qGUYc+1M3TkQoy8ZwRQ4qsGt9RKs50t4p5r
         z69WDNCqjBQ+7boudypmfk7ndj7p8lYTlnDMoEpCKqhq9JLnyuE9xILMd8UqQ+doj6NK
         ai8OtJAf3EjXf/fmBp+CM2gZmcEaBSp6ZjuPWV/1WvAVrbPfzxQWaJxLd/dLkXQ+0l+r
         3x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785159331; x=1785764131;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dX785e6wzIJbm75J8Uuls02O/XxfeJSJ7p5Q4URLETc=;
        b=Dt3OA/uFc7qyeLDYrTpZ7TfpiwnVXUg5lvxQu1QbCM+Ugj1/sLmq4OQ+XmF/ELvzyk
         bgP1q9M5hKRhpReYeZIocYn3Crxbyqyc+Aj7u6D4WKwQ+39+20M8GRa+DT9J08Db94yU
         HBEL1hzHyRPJOyxuC5q+qXErNQdM3CmMuPz7GeECqIMOb8ykO7Y8JiAeln1bUd/8ZrYo
         FCUrWXkKIZ5Bk5avTPBNbOpsRLB0fFMZ5wkD5LKXsydNGrKdBzXefHGjT1h6V6L9Vr8T
         /4vhnLJ2LGkvps7wsKAApGwYI1W4dIMgw1Yghadf2mJMJGHTjhRqW6GnTyxLbUiNmizb
         8fUw==
X-Gm-Message-State: AOJu0Yya8hi2zfRjVyEq1Szf427HfVcK/XNQ9CK7IsVAQpK76RwGdBve
	G5TlnoeaKCLY7Z3BEm27xaNDJLbZs5tli3t4iUHry9VaB/Ba5IP71iW7ztU6Ny/4vViV4EEfrpw
	MG1zBhUF8EM2ojjOOwRpKf4Wu/u4APEXBJw==
X-Gm-Gg: AR+sD10BFLnfp4BCkx69Mr++OqVwOYmGpJSokTpRg/aDcaA8x+Wz0oidjfdjclxcI1I
	P2qHsUXuJKYASScOQzCrG+2SVWeE7RcpxJ0BQ+GlAnyuQNUOKHz9yRMDP9fWmhGoiHFl/2oMlyt
	Agm4GLWrIx5M7wmXkXYX/S2ZUM5FOgEYvdSdGIimV7F6YL1WxDsdHvwGcu3ISwOTkgVUY4EKUJ3
	EoxBsF7K8Mrza+Yiz+37uM0f3D2e6P23gvIwuUfUj5QqQHxu9F+AKTrw15QOg==
X-Received: by 2002:a05:6820:5701:20b0:6a3:825d:bf57 with SMTP id
 006d021491bc7-6aaffd5b3fdmr4400779eaf.59.1785159331029; Mon, 27 Jul 2026
 06:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727124757.787026-1-jsegitz@suse.de>
In-Reply-To: <20260727124757.787026-1-jsegitz@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 09:35:19 -0400
X-Gm-Features: AUfX_mzFCbUA1iGj3USxwYYSp7AALXsFzE5su7blslrG2rYBTShfRS4mS7c3qZY
Message-ID: <CAEjxPJ5GOSRAKiSi5Je0b_Us6tJrDZ8dfRhgpJLp5MjzJjYGtw@mail.gmail.com>
Subject: Re: [PATCH v3] selinux_restorecon: Do not exit on directory cycles
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 8:53=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> w=
rote:
>
> All other failures are handled gracefully. Directory cycles can e.g.
> happen on BTRFS filesystems with subvolumes. Skip them and continue
> instead of exiting
>
> Signed-off-by: Johannes Segitz <jsegitz@suse.de>
> ---
>  libselinux/src/selinux_restorecon.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 30f1b836..fdefc92c 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -1393,15 +1393,14 @@ static void *selinux_restorecon_thread(void *arg)
>                 if (is_dir) {
>                         if (descend && walk_is_cycle(state, ent_sb.st_dev=
,
>                                                      ent_sb.st_ino)) {
> -                               selinux_log(SELINUX_ERROR,
> +                               selinux_log(SELINUX_WARNING,
>                                             "Directory cycle on %s.\n",
>                                             ent_path);
>                                 close(ent_fd);
> -                               close(rd_fd);
> -                               errno =3D ELOOP;
> -                               state->error =3D -1;
> -                               state->abort =3D true;
> -                               goto finish;
> +                               if (rd_fd >=3D 0)
> +                                       close(rd_fd);

As before, you don't need the if (rd_fd >=3D 0) test here because this
is under an if (descend...)
so it is a tautology. And i thought you were going to explicitly note
the change in behavior via
e.g. a man page update or similar?

> +                               prune_pathbuf(state);
> +                               continue;
>                         }
>
>                         if (state->sfsb.f_type =3D=3D SYSFS_MAGIC &&
> --
> 2.55.0
>
>
