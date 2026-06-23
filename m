Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7B7081A
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227221; cv=pass; b=ZfRxIsVCrZE+s/xia4g3u/Mp5zN4UKs9dnxHj94EncnIcRNY+vxGRrZNw8G4tN/+mqHgibbnomb/D+beW33RcjMzhbe7cCnfyxz8M6KDESRTnRVvw03E+BOsNkmyYTim7yfm6jImGaMeA12r4Ep8Zgl1l4/Ls5I3fheqiytKC0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227221; c=relaxed/simple;
	bh=+hej6H7Rg5VhNP/DVbn6wAIygbR/chz5zpN6gKVgVj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aA5KTET8DQ5EnY2BgrmaxiVIlWRfXHNV4W8vyRpjgxnE7j2k8PFZvJko3NhvVfMBfbWjnY8auW3pL6iSok7C3qAxfAYDVyplOpSEN/crdCTay5i6pwmucSUTzvuQh12lUQd7YomwLEFo5ZnMzmXnp4RKo3UQARaVXjmIfeqHLC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNIdbz5P; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNIdbz5P"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so14341a91.3
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782227219; cv=none;
        d=google.com; s=arc-20240605;
        b=OsZM5blzncXjV486lO+YMMuvP0/SbSx5plUW1IMZS3ZerN578u33rPqYyZZsNTWqnD
         DzbhRZUM29jeNVx4bbKDZjLTofaCY/SanDBWbRuEWUBDtVvvQxfqRXZzcLQlME1wS8R3
         tosEULBuRZjdH3eA/zA349HXHibigqISr/OwGy1OPQbkMaB6C5op/1qpG0oIjMhfmDd7
         BkJXlfV7INsq2SgUrYgdt/VPMdVFhMPfwIYygybnUIJXwDwq6eyZK/wiya4tNmBMHJRR
         c3G9qxiTZJ/zuznZIv1TCLowe6RSNDfFPd4S8whkjlKMt95VCVpTnNW0J3OXPM/tR87P
         KjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1woCOpqmZ9Ax0wIYLDBCSM8+lE57HklpiJnUkC6jbSQ=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Puj7qPwirhDziBjRX8j7towALflgqvfGiwH9FYENIsC2ykD33Pjv7mkNABZKv6Wjfa
         b/p9LjAfONRbInyDoVYUM/iAgX3DIbicyK3MV/XUM4dnBjdVWhjWm2qpIGegtAUY3vaj
         fMAUnmQkn9D+XihfrDC0pl3eaqIatOQ2Sr3DYEXZ0mfWH88V3t+p3UpnwrNXMOgsPEa2
         DgsGR6o9sttbEGvTXu6iU0YrfW6s6QK8L7PV9X27ADacqEhbMi538VRmtgedB1smZ/Yx
         3E5IYTytxkjz+45FoisOIJdMfEWyEk9LBP87Z8wlnDKtRtq2Wnt9RRfhm5PxzkiojFnc
         Dl2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227219; x=1782832019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1woCOpqmZ9Ax0wIYLDBCSM8+lE57HklpiJnUkC6jbSQ=;
        b=rNIdbz5PQoAJXY/SY2/CRSV8e79GTRnVfZ2B5TdjRgJWRH7j5ew9u0cF9AdbkcBC/X
         2mJtGYeMEXgwSDGPt6FGFtksimUQZazgj0Cr/JEp7PsX6bRMCzi/hKlnMwL9mvGLiD/V
         y4oCZTTPwDvTbgli0jY8aUp+SvQduTIC8somG74qRSEoYdzUJ00gnVmzNvd7gK1DBgu/
         MPTJIQd3JuIc5AOYhs3ERyljQk8JBeroY3Pf+xJ9vaAjplcA7VMSN1avcGvy4lZNTYzh
         tA4dPyyEuuPNiqK44H1m5wZockXLa3V8Gj0Hky3gePWC7PPyV31O2RlhMAkX1bub6Ttp
         C8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227219; x=1782832019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1woCOpqmZ9Ax0wIYLDBCSM8+lE57HklpiJnUkC6jbSQ=;
        b=MAXhrDdU+aLa3xGCyO44wcUfikoeAkbJdHX+PBIWRatlEAE+A5XrsLXAkLlEjTT3co
         JUgQjheFytPqPVep0P5YnsL0Qb0Is+UCM0TQM7Ts3njp5unUXmDANQzlJ4kXyvPDna/o
         k8YmOAJz5UaqKOn3uZIrMYSov60ULivq8FCeStVh6iwu9rij0ND7Ef5ie2WTr52+219z
         33rueNDUL7wSaTzNe+W3IuJTJ7JIim0HG4QYj+i1Djluuuwm174P7R6cg3eykoS3+eTX
         0muGprjVCrSYByautbrc2dLwtlIpJC8qGvgcvS2dOIHF6RPeRxC0cL20XalS0oiyFRoK
         HXZA==
X-Gm-Message-State: AOJu0YxK6mxauxjQ2TAxyZPdYZhvO6JocEEb0H6L32dMyWgdl6OFxcX9
	fCbTBOqRqC4bDqIMTj1SG1vnJzuwZYkZIZdoch5DlYBB2RDnCpnyJEH/d/i33V2c5sfuh2QIibx
	1Ht7kaeyKLqFm1Td+eYGGlWqm+rn9CEMD6koD
X-Gm-Gg: AfdE7clKxz+djeUaD8Le1IUkOYf9RXFN9M0gSqYWfKntOUlTcd3qjZpLzyWqP0t3Zgp
	SHjBKQhD/TkWgW7dZ6lZblVoQOLeAW/6wzyRbyBbrNM+zLmDqzPCF/yDdqbWBlOcZ6fWgEJJPIo
	dRh9sSh7QdyTLOcGDAe8oVyd7swTo5jAmx7dRZD27AUB4DwrDquNvE0I1SzhG5qP+dXSPTgEpFY
	dySJ1eX8RowY2azQT4oS47N+4AR1z3eAQHCYnZa3iDmgu5EmLMOnSXd8UQTw1o6UKslVdCJ
X-Received: by 2002:a17:90b:57ee:b0:36b:bbee:fb28 with SMTP id
 98e67ed59e1d1-37d160bd6dcmr19836446a91.2.1782227219237; Tue, 23 Jun 2026
 08:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-8-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-8-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:06:47 -0400
X-Gm-Features: AVVi8CfI8TdJY44dwESzEPn4mb-Z1CH63gvqeMqeLYL1KCxJcQ-yoPqFczzn7m4
Message-ID: <CAEjxPJ5kG8QEuXBdhfJXd1i2KPKdHZRLFMdmy_wrnO7eLkD6Fg@mail.gmail.com>
Subject: Re: [PATCH 09/24] libselinux: add missing newline to label_db
 invalid-format warning
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Every other diagnostic in the file ends with '\n'; the invalid-format
> warning did not, so it ran into the following output. The longer string
> pushes the call past the column limit, so reflow it to satisfy
> clang-format.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/label_db.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
> index bd22198c..bafa9328 100644
> --- a/libselinux/src/label_db.c
> +++ b/libselinux/src/label_db.c
> @@ -108,9 +108,10 @@ static int process_line(const char *path, char *line=
_buf, unsigned int line_num,
>                        &temp);
>         if (items !=3D 3) {
>                 if (items > 0)
> -                       selinux_log(SELINUX_WARNING,
> -                                   "%s:  line %u has invalid format, ski=
pped",
> -                                   path, line_num);
> +                       selinux_log(
> +                               SELINUX_WARNING,
> +                               "%s:  line %u has invalid format, skipped=
\n",
> +                               path, line_num);
>                 goto skip;
>         }
>
> --
> 2.53.0
>
>
