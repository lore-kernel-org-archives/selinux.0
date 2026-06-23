Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07391318EC1
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232989; cv=pass; b=BxpFxVckVIxGk3VAfidlrvnPOLclVoDDyRFfXJ99WAEUt5ipddIFWkRGZ6AFGImK3q4UJWNGRvvwhsTG/IeGeMq9LX2DCqA7gPETUXUGZR8vqbjvIWox8l2NK4nzouh5azC5sjGmpZXlx77n1M8FuE3bmYGBB3yjlV8LOmJlHic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232989; c=relaxed/simple;
	bh=47hM7uzt++Lgp61VwzMuAudPDyRzrMDdsM1D3zCdWpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2fhBvc6uJwcVbUGu4JIRFAbtvpBJx+SxTBedRUgibdzWOqAhhJO0tzZeeUZnwx4HCshjPvu/ZL6cX0+/6jzvLaeMjfy3zgk6FreGY483lrYvsDu87JycW7QL6FL4dKPuAK8rC3aF7zzfD6U8ay0bFLNH0UrnmasObt6E7fQ1Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErjP2K6Q; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErjP2K6Q"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so7250a12.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 09:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782232987; cv=none;
        d=google.com; s=arc-20240605;
        b=NEEuAD1VKl6JAr4zccNxUgojWIr1rtYOhQ3ELMhiEeYuLURI3iIJy2sTFqUkGOwwez
         Zvep5UahGM8WeriLk2EgjOBQoADJ+rbpdPqP/tBxR9jl7r0n0IhX4+xshmyq2GIL6ZL2
         syx1OZIJBRnHAICIHUBRWmmmzq/K3bUbXc3AyC70Acp0w/HJxihhCj/ab5Yd7vdHUn5o
         +LDEIqq9iu4zD9rNRDLoqSQjaepBtlRoeDw7x8VitDE0aTBHY9/ZYR0BzH4LKZC/mX0r
         gydSRtPH+L7oMe2BGkCr7kqkT0nmS/zMEfpMdKdhPRHXntuA/IcRYZ/cH/3++wVBcdtk
         5Cdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nWI3WCgP9z38EoOLJvdm+RE8mtv1BWxV7rxTy8dtFsg=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=WVv1xK/b20RpXR9ddfytXxZfMUogyCzcts2welMw+irr0oUlv7t3ywBSf+WbBRZAK6
         neBg89u00YFUQzCNDJb8xELHfInsfUbltpYr3jrWvFjOOxR4VqNZkimYoXJrCAOpy22U
         u9hyuAXMcorgeMWMgWhoRx7XCfhewJo5bWV1K2Sf/dqnEmjw6fEgiXfBJ1xXuedclImU
         GQ4DKiygFz2KDotRAv29x0wfodC23cWebGov803eUKhemThGBro+fNuKXhWPutYLMt6v
         iUSRU9f4dL3ty8uSGa4VPZANAZDWcPbCTUBP27EAnA/YBnyDFAXkLCPNa+54692XG/8c
         ocxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782232987; x=1782837787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWI3WCgP9z38EoOLJvdm+RE8mtv1BWxV7rxTy8dtFsg=;
        b=ErjP2K6QrapcIzAnbIfYZVYyp63sHwch1UiZoBwpUi9+JIjLRt7207UhFH/iUWhDFa
         TOcgxUcSpLoBDb9zsp+79r06zZ7ez9TYbLjCaXJN3nsdvWPSNHWLvUDLhekutYBPUNso
         y9wJo0o2gYD/Tt0MHxF8O20EK9kKZDATVEDcaPISjTu1YWliBxMa34CXJQl8T0wlUPIk
         RG9u65FzrggahO7odKxPm2JNKB4Ix0VHtZXUBECra+enJw7kdUBhUgfzd8jS4j4Vz0hQ
         yLWU+BtPfgSIh5/49sDeckp8PMDMPfSpoXNMM33pv8sbj14SDyGpJWGU78Fn48eztBPF
         rn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782232987; x=1782837787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nWI3WCgP9z38EoOLJvdm+RE8mtv1BWxV7rxTy8dtFsg=;
        b=HCfgUIr32y8Gb3oz86dglwh6V5syUjLeBGDjMdbFywrO0Kthpb4B0VUGQtSvrp3Fy5
         6LdZVtPFeotWlJO+Uc80EgtPUKYIRu0eTd9Iow4Yj+rRlhQX3KeXndYSUdvDaYJS1c37
         yBJx5mFjLyjzStArvRNsqVqgT97aYWaFhFnSsmd7jvv7pXwmjIqtpROhu6QE6yxkxje2
         x2eEvZ8K9aBR/9Rc111VRYAqkGeyeZ3b9403jh2OHAs1zDJlmn2wJa630S4hKIHWaLpt
         nJT7nk5yiq8WtCafoif1PohvpU/YcaHOnsswhAQCugpJ97Dt5wuwopCnM+tsTeC1M2Hl
         tjQg==
X-Gm-Message-State: AOJu0YxPxj6u2Td8UkKQ5fXlrjKeotT9rAmMzJhpvxPvxtqd3pvue0Ro
	Mb61KlDBTkUeJJFIZYn0jOIn+9TZ1e72zGf8hqsK2KwK2gziH2WV5xxpenTQlZDDyFw+3REI8ki
	zKuHuRXNHbSHsT7PCdWqwKMX+ZlNa3mA=
X-Gm-Gg: AfdE7ckJrMbR3HqrKBWRlZYpWR22yxbCQBtxzrG081WFmRylLxIN6HHOEbBTRIzxFxT
	YKRY3uUE6XXBE1DpEUXmSa0+trX1QCZnk9t6jVjltg9DGcUTsaOH1JZNE204XcsOwSmfXO7T+Lw
	jied4VLJLCF1NExtqYr7Lr/mEJtKRvo00q3Dhr4+x5wn8m2l9OaryXCe39kwkiy6iR5am3pAkij
	R8dUainTXnFovIsoTXftddMzsfr/yxNYHjEKsHfq4pNOp2KFWJV5LjtSkTuacQCm9XWMst8qYfW
	mXJUZtw=
X-Received: by 2002:a05:6a20:c98b:b0:3b2:b1f8:c745 with SMTP id
 adf61e73a8af0-3bc5225ec7emr19616246637.20.1782232987080; Tue, 23 Jun 2026
 09:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623141023.114173-1-cgoettsche@seltendoof.de> <20260623141023.114173-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260623141023.114173-3-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 12:42:54 -0400
X-Gm-Features: AVVi8Cer7Rti62SCqa8ZSAvZZeBjO4bjSaDNxDKwbvNXB9w_9cC06pqiu2Hk2T0
Message-ID: <CAEjxPJ6B0nrBLWFT2mOxt5QRiHrbdLTdKnHOYiX=xDAvRiWt4w@mail.gmail.com>
Subject: Re: [PATCH 4/5] newrole: ensure the standard file descriptors are
 open on startup
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 10:11=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> If the caller invokes newrole with fd 0, 1 or 2 closed, a descriptor
> newrole subsequently opens (e.g. the tty) could be assigned one of these
> numbers and later be clobbered by stdio.  Attach /dev/null to any closed
> standard descriptor before doing anything else.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/newrole/newrole.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/=
newrole.c
> index 990ebc18..09b10b35 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -1049,6 +1049,28 @@ static int set_signal_handles(void)
>         return 0;
>  }
>
> +/**
> + * Ensure the standard file descriptors (stdin, stdout, stderr) are open=
.
> + * If the caller closed any of them, attach /dev/null so that a descript=
or
> + * newrole opens later cannot be silently assigned fd 0, 1 or 2 and then=
 be
> + * clobbered (or have its content disclosed) by stdio operations.
> + *
> + * Returns zero on success, non-zero otherwise.
> + */
> +static int sanitize_std_fds(void)
> +{
> +       int fd;
> +
> +       for (fd =3D STDIN_FILENO; fd <=3D STDERR_FILENO; fd++) {
> +               if (fcntl(fd, F_GETFD) !=3D -1 || errno !=3D EBADF)
> +                       continue;
> +               if (open("/dev/null", O_RDWR) !=3D fd)
> +                       return -1;
> +       }
> +
> +       return 0;
> +}
> +
>  /***********************************************************************=
*
>   *
>   * All code used for both PAM and shadow passwd goes in this section.
> @@ -1090,6 +1112,11 @@ int main(int argc, char *argv[])
>          * if it makes sense to continue to run newrole, and setting up
>          * a scrubbed environment.
>          */
> +       if (sanitize_std_fds()) {
> +               fprintf(stderr,
> +                       _("Failed to sanitize standard file descriptors\n=
"));
> +               return -1;
> +       }
>         if (drop_capabilities(FALSE)) {
>                 perror(_("Sorry, newrole failed to drop capabilities\n"))=
;
>                 return -1;
> --
> 2.53.0
>
>
