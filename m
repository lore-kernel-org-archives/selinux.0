Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59F38237F
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669631; cv=pass; b=bUlVhjp7k0HWotRDYAI9XdMj/SaQKUjGrQ9TqhxJKfa7YUErhR0HiGVK1CMPqMhp/uCy4M4e/zuK8Kja9692LDK1N1LZK9T97Pyifsoe4dS+tslcoiPDPRRaoGS6tJQwTyhoo6asouuFF6PnJLFsgagPErCBc0KtdrJeFZ3rW0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669631; c=relaxed/simple;
	bh=02GFVLJn5WdbLUXiJrbYidNyTAxfNIufDsfZKaVzeRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UICmQjDOA5oe+tc9gXGFZCFvG4afe+n+IutVoh7pIKVLgazhWB/fdUioziK5pBvdLzTs5Vk583BAcI98jF4K8QnTNwGsj7yx+UvFue/R+4mnBEEaYPE+TrAOmEOJBsI/YXxlSxCJMZ6VJMJp29qwujdP7uSir38GSL7aI4gclJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwtG3GQe; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwtG3GQe"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3966c0d5ac9so19938401fa.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 07:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780669628; cv=none;
        d=google.com; s=arc-20240605;
        b=I5eAWRAxgUex4JA/X++1lHICsVGk3aMYh89xpysVGPIljxRUwUKOWbg7RCwkmSAXxu
         E+39/UjARUgv+FhvfQWxljfCgCKBEiApN+FRQt86vYo386Yp6aOSZ8NBbKk1GcAlSIJ8
         15kIuqdw9RcxqY+feGIIy3JVgFo0ojxs6APsJT26Q1YnvhTAMddmP3H6c1cqgZXsSf96
         xwJjkmUcmbjbrEJVHN6gbWG7Dhe8VIb6zKg6jTMODNk4nVrDi5rZvTLSh++VPMjURIWj
         URW2m1o/I/270YH6aqTCgCMX/3X0hUvDXp8mKt1jTGpm/RWEeuwEKP7KXLXsuAcMOwUz
         5jiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iPcLWWitZD4TJlYVgvuR0UnLYx4QwG6H2/PyZQZePJw=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=WvTT7133RaTf4ZXNXE8wWJKVYL+CLt3eCv5UcFvYq+jaN0Y/Y/+jac38oU5+OhOoAG
         9/j5Q7BsvrhKnpaWORXxRXWtEgosMgCxlhEtBqHZbSC1gT2IeDmq2G39vtJuhULv6DId
         vASvHIQluqr+MIwbqLBdFZYQN5fcZ2+Gf/yj9BocEIVMNZeIaTPzG34Ketvzogf+AYLf
         A4nLJHn2HlLw53PYngdIgdaEUND50jnCSDc60cEPJFjNG4Fl20RPUGpYXEWBkwekiD6G
         l9cFnVLTTOB2ew+FIQQLbqjVDkttXr6uTfvPNcnfFCiuHcgmEWy6082PdQ+WnBYK8nOI
         IopA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780669628; x=1781274428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPcLWWitZD4TJlYVgvuR0UnLYx4QwG6H2/PyZQZePJw=;
        b=qwtG3GQey0Hw5ZOjCwM64o2N5Pr+ytTt+/soAvJ49/pOI8eR8RAPMp9094QWYh/2YQ
         Qrc/KFqje6VpiDB9nt/7RBe4Fy8YDswfm1PBUQNiDZUg1m4WLrhvor2mJuaxU51OIyzW
         okdDXferb7JiESyJ/dyAeGr42VY+yxX+Ph5cNWlt88EwUz8fmthMksRYYBDkjzTE4Bhu
         Cn9IiKllF/3E7yecsL6h8j2oxuLJpsg+3XvbGlm8PNkLrI6fKcRtg0CE4fTuYOKEyxh9
         9aV1P0222FTFNf8+3Vxn2YHsubwQGl5mVmQL/dvSAeu8jiE5MvFw7KfsDr1VEWFzlAa7
         2aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780669628; x=1781274428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iPcLWWitZD4TJlYVgvuR0UnLYx4QwG6H2/PyZQZePJw=;
        b=FQXwbjpoPyRKuRtFpecVxWXuXAJwTEFHBGWKtDzgDrFKimp7FsYXpvY6MnIGdb5vfv
         kxNJp76BTcMQk1yKPwyF0Xqrg4LllB/U8EpnneGxk0snBOqY5CgfceabGKV3WQ72TAui
         it6d17F0SYv2ES8KDU6tYQOeXkhGCoQCBdIMC5byzvdsD5ReX/Hr8rK0SynXg8Nc+Q5u
         f0Pr4MHRTh4cfFkokxHremNYeiy5zF4JsRZ4cb4B37rEoi3XrpyzR8C/KxZnrFOPs0SK
         noE/C0hnac8hpCACiJRdvWq7dvb176CVU/9rtNSAdQmeHgELqtkK2gYOkFS7nOUWoPoA
         kbDA==
X-Gm-Message-State: AOJu0YyKF/JavTj0EXDiFCSMvOe/BVxAy7ZimHc8knOxiZ9ihgLGYIlv
	8/bkmGv5PbwXX9OGQicc+qne/T70jnXfSUYYfd76L9rG1Vi3vyjVuOsSm2RCVs2kHiyhonmT24U
	iR0SJQcl/ZJxgfGjY6LoSGia5cq7f9d48DXbJ
X-Gm-Gg: Acq92OGJgfDVPQLwCWrbcOHS7C/XzaJ7TWkhcH0FHOomWHWnrQzBL/3U8MgMzcFugx/
	ECcNJGag2nepq72wEmyymbfGRXHrLE81e9hJr4YSLC5PoWO1knoRIdTvunxcYI+hczzrqTwXYO5
	XhPRGq7r2luXeUqLanRDxuTmwVBMkVNjqk2BD+1KOKvTwfiL4lfRZ7AuVLmnR1XRgvcR171wVT9
	VCYcSoGT57oENQc9UrsR5WDDVWSFiNC37BpoN2ObdRoW/SJnZHcCAw8yWyg1ErFkUUSQO45whKp
	rZQyxiDsKlQGctY=
X-Received: by 2002:a2e:2203:0:b0:396:9967:cd69 with SMTP id
 38308e7fff4ca-396d08aa2d8mr7895591fa.13.1780669628373; Fri, 05 Jun 2026
 07:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604171746.263416-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604171746.263416-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 10:26:56 -0400
X-Gm-Features: AVVi8CdFLXYMTCPcIbe3mmCeZFxxXvUIhE1MT1zmuJC-6Si-WNmSVu6tZJIvHvE
Message-ID: <CAP+JOzQ0bkw9M18SfeBWJz3i8qnr_q_Q0U=JtL=GuQzcpx+SUA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix selinux_status_updated() for MAP_FAILED case
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 1:18=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> If the status page could not be mapped but the seqno has changed since
> the last call to selinux_status_updated(), we can just update the last
> seqno and return 1/true to reflect that fact.  We must not continue
> further in the function and try to dereference selinux_status.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/sestatus.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> index 2022b23d..bb69fe90 100644
> --- a/libselinux/src/sestatus.c
> +++ b/libselinux/src/sestatus.c
> @@ -120,6 +120,11 @@ int selinux_status_updated(void)
>         if (last_seqno =3D=3D curr_seqno)
>                 return 0;
>
> +       if (selinux_status =3D=3D MAP_FAILED) {
> +               last_seqno =3D curr_seqno;
> +               return 1;
> +       }
> +
>         /* sequence must not be changed during references */
>         do {
>                 enforcing =3D selinux_status->enforcing;
> --
> 2.54.0
>
