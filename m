Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088040E8F5
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780666014; cv=pass; b=P9DH/fnrLlS6K/rGM1vlzPMRu2HwZwdj9Ee9uB/cQDAOhcrxhhKJycq53pwH3s/QbiBZ8VL1EQNy92FLSq8rRSw/+9JEyV2sGP0S6M0JZY4BUNHnUb7L675FuRuqglz+3T67qzkuGF8Dam+aj3ZN3iQxLridVpG6x4bDbmv3JY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780666014; c=relaxed/simple;
	bh=RDGciAVdas5z64qeoTrP+qH0djgzcLaOlLkzgXoK5gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBP5YuNUS6xdrb9rqTGN8EhmHe/UZUFqbwvnkNxKo3mCpMfY08vTgnfbYctxCiW5veFHuj18+LycnrjXQGh5kwR6T6i17/E9y78gpBAGgrj3uEbJwdg6t8JiFrJgbnuc7Z/nA/c72MAdJsbb8NbPUbKfG+lakt4qCW+6tMXZyB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeh+gxfY; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeh+gxfY"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39677c80386so21656361fa.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780666011; cv=none;
        d=google.com; s=arc-20240605;
        b=e+GAr1TrPh+N6WDAd9e1lzgrxXopLzdHJZXzAzP3ckw2A3ZNmfEe+osC1qqPUWq9oA
         MhzXVnZ4m6IEXLj+HOwazC5P4f7HQguwi5MK4WMtty1rhn7LgibwR9liG7S2s3JO+Rvk
         5IIwnhAFsJ7x+fHsiT+gPFaPCR0pqfwT9hTYT83R9nXx79EuqUSHlGGdsxSY9/ov+6nv
         aaxozqABQW89QIopW3LWyCI7fXb+vEvE3HKuWWGyZnipVqsMRIDPIPzDvjngGgHee30M
         urAlDkwADRiJ6atSeQ8tdZVx9HgT2MctHDCrzIhYcxWd7sNgC8PaeAotGmC4XNY1pulI
         lHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K2v1KyPfK1CoC9Af9F8yUOErhKj7xaC3e+SfxZM6eKM=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=VzIsztaOGLdPWf75uKN3hkMoqo28sxiSpoVXM7fWyDLl3TJkaZT3JyuPaumbJNFwZF
         Ym7OFgy0Up4sox92pZmYhaLs5W/Hnh8YgJ4VDOPuzHQYIQXLIzdnvNDs06EVjykOzZvB
         gPCLkAdeIQX2At76HA3ZC7HjcfCuG5TysvpYPDKseGZ5xCpOcqvFb/1xdXD6576fe0/o
         r2MHnyl60/dU3edEqojssB4pwNxMGREj+E1Wbtam36fidkpDktxEU/G70DYGUV0nD4h1
         sNgFVGw/+UpCMlfAbYkfwkjRmDp4oawora2xP2POk6ypahanWZf0EQ7tbrj4gsnAc+Vm
         ZKew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780666011; x=1781270811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2v1KyPfK1CoC9Af9F8yUOErhKj7xaC3e+SfxZM6eKM=;
        b=jeh+gxfY1LrlO1py3OsA2onTRJRFNHScNVRshqUosp7K+c4k7hptfW0TpzTbhxS0rf
         OpLn28JVJEZPRMU3qeZvtIrtCIvzjfZ/ws0PDKNWpiUka5MdGtIdkjP1trUah3oZ64Nm
         17ioVdLufMhzK8R+PWppue60Qh2xVvzmtP1F4zGHPER9ylTNFIMfLCFPgAD8DYO8/9oE
         LX9qeMiG5OHe7Efo61JlJkGUTyHk3RsCKGF757BWCsrCEt0z1MrHmuu9rHxoIG2b4sL1
         G16IIeppMaYaSeDdDbU+/hX8LaKdC58bJ7IoJkSiViPDZHIUJbZPTBDeiO5sppt8Yak7
         u1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780666011; x=1781270811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2v1KyPfK1CoC9Af9F8yUOErhKj7xaC3e+SfxZM6eKM=;
        b=gTe5fOV3xqDrN3VqV+aiSZ8yethnbdfKfosYkJaEPqggDw9y4K6W5p7JGjzmjN8ud0
         XUAIhMN9YkoEycSrLQXLSQ3SRgeXq6Z09zUor9t108v3SWXi4mbQpKrduremDb+aiS0w
         5O9YHxJ95KgqGKDBztPKfd3W6y16WKtfimELDqO1SjULVtQ7w7RwGzcVrVnA5V5c/F4x
         WqumfbFM2FXWuL1OS3i/M7hDF8vgcDB84Xx++v9Iv2sbV5DcN6T4Fln5ur70F9tmGyEN
         beQhYSLx7d4pbbX8wnQffyNV0eR0wKgL1LwJAu/J7v+rOl5JZvI8WB7ERANzLxd/XoJP
         Tsbw==
X-Gm-Message-State: AOJu0YwVKrbXOWN4u0zwvFBBEznQU2V2kNqzijzCMlqVGxgXx3szHqL4
	Il0jHvnYjBII9DRJyaNTdQR411Ug6X1fMqN+Td2TJNUrioyMpedgGbBRP/6Nxb0DqusS48M4deu
	2Rqp6Xzs6XrFjhBNAIMyEc66G0Iq6mmY=
X-Gm-Gg: Acq92OFWmigwjECcvcZ1N7kC9oCw0YRkxkoJ2X6h1uTZDvkahveQIC2d14ZsQYlQWGV
	iF07Zrpau4CXvaWo+/4OECWXrlBt9lJqUqA5VdtBzwF7ejQINr5YWnoyCw5VP+u8K+GtCeQzroX
	+GJj0j9jckVoX6Q/lw/TNy6aQ7woY02thgsTa21ZGlgkAF2LkJjpi4jI9jg9yy5tyh9Ga18RzEl
	r6jbYquk9283MvQoJkiMQ3FUZONxL2ONn8kc5F8RUjMNX5FuHOcu5OmeS//w2+auLGWpxLBM19h
	BeDDO+4NZiu1BcEwc+qz5P9lTw==
X-Received: by 2002:a2e:bd0d:0:b0:38b:f0f0:e3a8 with SMTP id
 38308e7fff4ca-396d08baf9fmr12191271fa.3.1780666011041; Fri, 05 Jun 2026
 06:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604125715.255605-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604125715.255605-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 09:26:40 -0400
X-Gm-Features: AVVi8CcGSZMhXrEWOOxbKXoh7G_Ixt4rAVhle2lNeEemCLAnGbPCAoNd4ahujJE
Message-ID: <CAP+JOzTeGLEvZ0yWNr8oueObe+k97QZe2f=sRBZA1MMDA_X66w@mail.gmail.com>
Subject: Re: [PATCH] restorecond: avoid busy-loop when watch list is empty
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 8:57=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> If nothing in the original config exists or every inotify_add_watch()
> fails for some other reason, firstDir will be NULL, watch() will
> return 0, and main() will busy-loop. Just fall through to blocking
> on the read() on the inotify fd, which correctly will wait
> until the config or utmp is updated and further watches are added.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  restorecond/watch.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/restorecond/watch.c b/restorecond/watch.c
> index 86dbc77a..333f0af0 100644
> --- a/restorecond/watch.c
> +++ b/restorecond/watch.c
> @@ -313,8 +313,6 @@ int watch(int fd, const char *watch_file)
>  {
>         char buf[BUF_LEN];
>         int len, i =3D 0;
> -       if (firstDir =3D=3D NULL)
> -               return 0;
>
>         len =3D read(fd, buf, BUF_LEN);
>         if (len < 0) {
> --
> 2.54.0
>
