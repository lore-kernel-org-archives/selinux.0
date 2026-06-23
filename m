Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B93D75C2
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227136; cv=pass; b=CvjONRIBD95w2t1PFzSAAlPScsUDmo+uEYXAZGwpAhO4e5lq6ydX5LZDAEHaa2FMla6Xl5V4V6J49IKHlGLAj3L/BYQyvybiVE9SYqIqLGLe5/84p0XQXTUp+6za5WxuqjxfiyNNERRkMOOe3vUxni3XzFmg/D/Q+UOmVX6AYBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227136; c=relaxed/simple;
	bh=gvaHTW9J9ippixbK0RrYKH8x9nafiJ8YiLYyvwpOeGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7Jj3tqolX2cWYOCAFlyDUVjjXJebIgs8jUQB2+AvT8vEU8xMl3T75ZE4RaWWepxaQvQcnG2v6oYzKw6aYqDQ/5hu/E/aPcvSwZhNbxFH49T/KrK9yt1TzBWMZ4fE3FSj5PrqOZvdwOKoo+dnFcNCtPHx0XAhkUVvXLPyZnB3v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZmOAW7I; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZmOAW7I"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c88d4606ec8so2167779a12.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782227135; cv=none;
        d=google.com; s=arc-20240605;
        b=eV5JaJ28IjjOngAO+/cPguNtd/1xsAb9eL/qXVy3fyidvRq//O6HsDLP3Q8dpXfKlJ
         f1tTiUOJemY8hcclLFv/HppLsmkflFH7HcUh6uZW/DpZpoaLuoWRDZoNNKgl9Ao1tNem
         s70efw3m9+qhsE06eQvS7taBR/oKceD+tUx9kOIUykj/IwRvnQD1Xk/45aaM+XBooHrb
         kXeO2KOe1czIrP4JhOz9gCYEm4jE2hk39ImlMxiiA7w6yWuLkHz3+MD1vY87lWvA8H42
         lN5YODFhgGHxBe7sOGEJ8I7A30ZraoPeCmVhSfHPis6EPbDOHtIL5YPe3gsVvbXAr/Np
         pZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rQHEtV/SwGTzvGFRUcwnmn0GtE33fgHWATqM7DwRrs8=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=I3RLmX7t9s6/STXE5KnwcTeKyn2w7ozrE9KNqm71SbN/ruKkZASx2Id1g5Su0Jpw0f
         AHcsel/rHGbSZrmZR14XV26Qbg51k0z0f3PsenA9N11dPuTdPTw3f6cza1HqXN/B1+ss
         FqBHiUCMqjrE7/bst0IbnCw8yH4eHWizdwFK5VUDkMHvi50ZUNTxxLF4mg4EJnhZb/as
         AeWPqn2xrFyutAOPBGPifQnKbtgT3H+0FwA9CUjhn/Cst3d9o2lqCpyn2ZFOXxPcNhnz
         jhoPDg/KJYuzjrsSMigHSWQJmKkd8YxhB7oRSWji3/CHZZShLosPEyMfLf/Ho3AjeTJx
         c/fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227135; x=1782831935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQHEtV/SwGTzvGFRUcwnmn0GtE33fgHWATqM7DwRrs8=;
        b=VZmOAW7IMkvvvO6cOj+WqCIFJX924qLGQ3zGqapfyy3WKLfhZy8fF59F0PRDUdYqGy
         46ps8lsU19cgrrAU108UWffjvPIFdrENiTs0r3s8QNN1kyiQ1A9940yuIStB7drAHbZp
         fm9P7PXyqqFaQDhnZXKY7Nh8YrMS0cPq9TAnSiFd0g+PUgPGTuM6b1dzAZt8sCOCSui7
         DRyTna7hcevZ3NTCPvJo1hrj+fo7zdEPWx12L7sijjiWlpL10xcL/ur2FqdpGCZAeyNz
         bm0V/M2YBS6vImJOaF6Bu1WhyXzlbaIYvY1H71Lq1PPu1XYlMaLD2Uijv6TghbaOK9c4
         sIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227135; x=1782831935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rQHEtV/SwGTzvGFRUcwnmn0GtE33fgHWATqM7DwRrs8=;
        b=s/vZi94JTKonIy0hI2rWXlFCMLSWK/uh4o/91ShDYPTDU23YcCzpvW5oqh3tWj4aWd
         RffQmQPJwTskzrBmJdfeXr6kzDJemIQbuwAnXkd5XfGvu+hq4JdwypUfO1wlg92tGYka
         ghDHJcAz5w1fwu+vSXaakEDlfWsvqnFiyUnIjgz9S6Yf3vj+RJgcz4k7kDbSTFqPB36C
         SLjcwvGkP8jktCFjnJLO+ZopikYj/0w4i5mejQgdyzkAsbH9LmjI4d1W04cdjRtV5U9N
         rrElB0uZpOK3l4hvThNktmYtxseRpsCcdpvdBBKzuAVdiiaamMvCaZuixs3TtcqBEUNR
         zm5g==
X-Gm-Message-State: AOJu0YyOzzDQ5r6E0zRXbh5UryuICYhWCPY3ZVK24O8f0HVS1+U2P6kK
	wSI77tS8B4T+iBsOiyRzFDGhiMPpD44oTIS7ZQzNAS/Y6rLgH5gkwIRdW6mKMFkCF2ZiFIMsSvw
	HN8xWB7m11GJIspfUhB+fn3jgfaDs+ohU54hn
X-Gm-Gg: AfdE7ckHUBquz4l1jdS/Nefb8OkZfhwHs4z8mX1JrK81aohNChfNAVQn3/7GSnhRc3g
	cnX/mBQW1Zc0uwIIHHDgsFyDkfkb4kj4IxLv+saToWgnDhRU0ds/k2oWxGZxc18LYzYvJ1nlEiz
	xJDo4Ou13bisXMiiVbvHNSsKl3NgK9uOB8I7mn6mxp00ESqTiXfXI+vTvL8x4d+gN8pvd5vpTfj
	MQZHDpp38NBAyaPaQsTfLOvdwYhDGixXU2c8SyWA62KOObpL7XlUZGZNoMYvQv9jqmbqBH5
X-Received: by 2002:a05:6a21:33a3:b0:39b:d937:8020 with SMTP id
 adf61e73a8af0-3bd192b3608mr3437808637.42.1782227134630; Tue, 23 Jun 2026
 08:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-7-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-7-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:05:23 -0400
X-Gm-Features: AVVi8CfBjSgyutNLX2gf4oNpLCzlSdUA_Ne_pqsIca-8WTNLZxsjnPqKfZbzDY0
Message-ID: <CAEjxPJ4UMy4T4uJctwuacBKS1YDo00hRUEnOsHo6K2fhkr0BUQ@mail.gmail.com>
Subject: Re: [PATCH 08/24] libselinux: assert avc_running in avc_compute_create
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Match its siblings (avc_compute_member, avc_compute_av, ...), which all
> assert the AVC has been initialized before taking the lock.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Could move the assert() to first thing in the function but regardless:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/avc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index ae988729..779ce8ab 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -850,6 +850,9 @@ int avc_compute_create(security_id_t ssid, security_i=
d_t tsid,
>         *newsid =3D NULL;
>         avc_entry_ref_init(&aeref);
>
> +       /* avc_init needs to be called before this function */
> +       assert(avc_running);
> +
>         avc_get_lock(avc_lock);
>
>         /* check for a cached entry */
> --
> 2.53.0
>
>
