Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323DD35AC10
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226910; cv=pass; b=Oyd4Vd2qN0M92HzgsECtpEsJmjf4vwMSsp0T9DNiHz6UtJ/GJ8RUVvpaEMlIG3evMGP4KqV/Tiq9UCdZmTPZL7nRMw54yAQOTRB2bTiskXA/DFOpwGBiV0Oze8PpFYnTntejezkVay4ghWUBNsTtyT/56ZnkNqsHsjHEAtx2WME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226910; c=relaxed/simple;
	bh=MCYBy2A6eSaHcA0HsY61Dz0tlYE97Cr+5XFCMqK+8J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZP1PhTZtzhouYyvFjuyDJ+DfzuzGzU/Beod7rQnktjAFReK+B8tb9OuXqvYVwQ92tvJWk6ur7/sHnD6ztQ3s7+YW5/ViLgjUnxiHwIdcwdJNv1XAflWbBGBNB9j7P+9DJ9qweTnZxSsXDdeSWr+mRKK3VHM7gqi4mP3t59h1vjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgxqCgel; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgxqCgel"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c88b8fe9059so2162295a12.3
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226908; cv=none;
        d=google.com; s=arc-20240605;
        b=cmGonpIjGEioP1bLlA+XHfU9Jb3q/mlUUVKRBvAExXElrJF5AsiYACkNApSjp4OJtM
         YVQ/dZHw03mbElMkukBoNGVSglwfGILtBfsRNqZsADkaO9uWJINHnvQoaSfGnPcvR2xx
         eGJMbT/IOSZ3w0k/iWWiaH6Sxj1OA4SKud7QGspCS2lTKyVQ9AMfIJSwjV5hV5nzK359
         hwi7O/bclLS5p5/JzBAcDUqo4lhkOJPZJJbexKJouzJMEnbZRvb0N7JbA+p78I9Q9zH/
         Olf5Yk4GSjvsc5MBzhUc+WZJ4FSBbkMKoOjKn1ddG8BoxFC+RpnvOMpTMYX/XZwRDUA0
         VabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a1II2szNtoR2uYyVFW/hk23+TPfNPULsIpurwqA9XEU=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=cb4Bj2zWp4vjaI9RzN1QsmN2fHiJXd0RFC1ARC2GCpiMwSVw8nomQ7Mh6uQP8bgR1v
         cBzkgZg2VJSWC44udhrbEqd68HXiCkaUwA6sYT4JuuUMG+4G2IHbUGij512/bO+hNo8b
         I8ogsigATXIE/lXvfsdcjWReMEK23eSTMtWF2LpiBO08QjHFVLYa9ewhgRd5UETwNN5V
         woVtEZiSLhov1MlLxGj22WTY6W0dX5RdMPzXBRobHfbqtfaYCmfvQG6LWDIIMEJQ3+vK
         xbwBrG0a9cRUcp7hHL9ONLS0RXslF2BeSF8pYFWse9AZ4R+sYdw3vxfDebsR8A2GPJfH
         iL3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782226908; x=1782831708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1II2szNtoR2uYyVFW/hk23+TPfNPULsIpurwqA9XEU=;
        b=bgxqCgelon+6WoZlMGstZt31xGtnfnXw8+iLtR+BXPkjePFoyhhzRLuW7KKj6I+A8+
         0FJg6dTgkoI7hhhrWlcr46AP25q6NoYszWSk+XqQjawhefl5In9VGMewB/LMl2F1h1Yo
         vdJFEuLZFDPTJ4sDPCl5XWAnrJ4FnUwGKjmq7fu3AxKkIX9Ii8GJueBlfeFbfT8hfKb4
         8HLbJsBgI3njWuk1pAkauNt1WBuqdA6sHjjT7/tCicucU6DABV8qe+wH6ZSG5fWs43Ep
         KsFMcJC5j5D8vJOZbkmYFk6jaICJbJsU4/nkc1V7iGF6x1ottvUMGUDW1sBjilUUPU2t
         tvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226908; x=1782831708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a1II2szNtoR2uYyVFW/hk23+TPfNPULsIpurwqA9XEU=;
        b=RdynvxweJ7efQLzd3s5narLGA9vEXhQD/ojsE84kCO1PlhRLw80NlGJGHJgS9NyGQV
         okdpvaMKJQKEwtQN7ujGV4e+8ZganIIj2LF+jkNnEyXm1OXhC+Arr1dukbyEFPQ8EwyY
         4tCcpbfIlhkNOFKbEeDyefgqNdMz6+SvdqqHt7Y8/gmI9yB1TkLG7Q9wjXh3JNTwIMLH
         Gpky3g68AigSy9IC2J2PXO/s8+3eAs/RqInMX8jwdECvHsyrCPCzNJ5mRA6DKzAYDut2
         rw7SN9sKn0CXwIsmeXUOUMFiMJWSniFEFt9HoJzNIAXCg8dik4VVEwIMmk82ba/0douW
         dGvQ==
X-Gm-Message-State: AOJu0YzrW+Vr+dW8ngPxKiPLTz/vEnoRVupFUyjUETEp6vTvcZAVhNIa
	LReN4DrqJDSrUov3FvmJYc4b9t5/60r6YGhit/BZHKF5evsaIMYajULmRSaeQvy3AbVtNLx2irD
	1tu56Q8Fo5PlcWXD392VWH/AUrs0ChDk=
X-Gm-Gg: AfdE7cmpoZ6uY6q76rptHvujW6u7vXsGqC56uyZjO63YPKUZ8EjeynhcSsZJVhIjjWW
	NmcL4FNS7bxQB6nTLj5iVnKMR2uzn6TT4atTFX8oMZ0aCZnVjRVuTPFCbZKgGtTvD+YGnncT0Mz
	qD5BPRtL4ipvI5NPoEYm3loay2SH28haDMcCjTzXJVkQQm0t1d6vmm/I2OpmEqxqIxyRWT3XFfe
	5OJInscGAxOu+mpEwueYO0wAoyM5L3a7tXstsIpI8GF+8Z0pBwRaC5xWxLy6ZjukXYkYFIOP/HD
	xxdROco=
X-Received: by 2002:a05:6a21:648c:b0:3b3:1c7b:ff9 with SMTP id
 adf61e73a8af0-3bd152914a0mr4359860637.46.1782226908289; Tue, 23 Jun 2026
 08:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-5-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:01:36 -0400
X-Gm-Features: AVVi8CeCJhx82Bed0oU0iDjdc65armklcFudC0Yr7JrieseXRatgCK5gfzkTmew
Message-ID: <CAEjxPJ5akoY-=Un6Kdvp=MKPw_JHU+ZQjPioqDZ66wm+6a8gpA@mail.gmail.com>
Subject: Re: [PATCH 06/24] libselinux: check buffer before pointer arithmetic
 in regex_format_error
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The error pointer was computed as &buffer[buf_size - the_end_length]
> before the !buffer/!buf_size guard, forming a pointer from a possibly
> NULL base (undefined behavior). Move the guard ahead of the arithmetic.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/regex.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index bd7f2188..80b01692 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -560,12 +560,16 @@ static struct regex_data *regex_data_create(void)
>  void regex_format_error(struct regex_error_data const *error_data, char =
*buffer,
>                         size_t buf_size)
>  {
> -       unsigned the_end_length =3D buf_size > 4 ? 4 : buf_size;
> -       char *ptr =3D &buffer[buf_size - the_end_length];
> +       unsigned the_end_length;
> +       char *ptr;
>         int rc =3D 0;
>         size_t pos =3D 0;
> +
>         if (!buffer || !buf_size)
>                 return;
> +
> +       the_end_length =3D buf_size > 4 ? 4 : buf_size;
> +       ptr =3D &buffer[buf_size - the_end_length];
>         rc =3D snprintf(buffer, buf_size, "REGEX back-end error: ");
>         if (rc < 0)
>                 /*
> --
> 2.53.0
>
>
