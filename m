Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C43CBE98
	for <selinux@vger.kernel.org>; Fri, 20 Mar 2026 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022274; cv=pass; b=ulr297yAEPuXJi3d7PWiwqnLyrCdzP1NvxXSKO4GpFdkrgBcOUbeyLR9Sg++VgI82TCK6+SrIcRRRvQ5QYQTtNQAhtgPNqBCYWyMsiWrqFQR6dYoB+rQFRyaRrUlPnRwh9IPNMa+oeFSt3lqsEleuiE7D+OmG+FbgN1nlUfd8Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022274; c=relaxed/simple;
	bh=Ixwoi24qbOWabf87YDh4cU17cCYKAlDwgUmE9bKttHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqAyfBjwCehKXXGmgEkDYxUn4Z3am6z4ScrYE/XKP5wuM2YWmp2tt+968Td24kYeQyrwRwjyT95YuS0yil+3cx+C0yGVAb0FcJ0atwGJ79RYJx4SMDMJ45vb6Df7i3rAXeUjoaLlMx3nsIDiXFIYsZjBkgHV8dDCX5c3o8dTP9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nc8YraLd; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nc8YraLd"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64c31ca77b4so906538d50.2
        for <selinux@vger.kernel.org>; Fri, 20 Mar 2026 08:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774022272; cv=none;
        d=google.com; s=arc-20240605;
        b=CPfjEH+k2DFjb3GD3S8BBb+XUbfF5ivapv5P4tmgnnu89bYl7PS0mkk/FyMmxzuih7
         4P8XXkK+0BDtQGLR8YnCgCBlxBbSU5/XPbSS1BGVWohlcZjXWbrKuIlUwGZahJaiw3OW
         S3E2ka8jwXhDHg5MKq3mMyAmmW+lMuAAr08D1e3UHb5K/vPkwqw1g2kVuZnRsB4N3UiI
         tOgaHQrqyPMnSstChGAJepCOrvKgb7oYxphYwjCYwTEcwctNKvNecY/XkzQgbROvI5tC
         GHbtIMaTEAP3ydR9cY6KRxn7otBNHWYIvq9OcCdUq49EROsHZ2kiGNKc0xpj50KdWji+
         2g+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kpS2MN4inOpug4KktNMxWZhEzpjnIeaTvbJPo8fimS4=;
        fh=8+t9IPeQTqyGiWySCZ7zSKsVGC0IZExJx19zfd5jlQs=;
        b=kzT7X6A4YIREtQD4v2VpB+AYVJfItSMpHLfIXHAZYh+1NvIAuUeNjwPUcG1Qodb6NG
         kjprx9LMxGwdj96no+Nmj7urh7vGMxIC8NlCvGuM06sN4o0t25NssMWWx8TG19iDbgif
         blTNoRYc3OJsYQdT5oK6a0Gd5Xsk8zi6bgT61U09/cVug0nGzztGnTf0BF9Wt5RDPeIj
         lAWIZSsgqom2nsAcsDpyESZY7msrl2cN9HAU5ABvE+sWaErjxu6sabsgZV+gjULm2VS1
         u3sOASHnM2ozWj3eQxL2LXMveweQa+cg1ATSGuz60g0VM6Eg0FI1ILMEl8Zig9C1Pth2
         jGMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1774022272; x=1774627072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpS2MN4inOpug4KktNMxWZhEzpjnIeaTvbJPo8fimS4=;
        b=nc8YraLdIeXox2Gc7OUnR93A7SP/Ce2o789wr1DM2bP+WazGr4iZgcWJnB9iJQc0m7
         hS/cZv6y5QW9WY9vgnsQwkYn5Oaye05VagMMk5NBW8Tp/yfgwfMeAruiyCeUrla/Xva7
         WPlbpyjYFA/2nmaVD1yeker8HSSacdTorms2n9LlyCGw4R0MpnVZ7rOKOPgnDlpemV54
         OIyCdr4iHsMX7H/Tm9SnP2ZwU0okO50XBAKEuHnx8StmeF9+MeGeDoUEYsQDzonizuJY
         VO1+0VaJ6ASoGH42TXzcBKeTP7yBOpvS4hI0ZFEJa2cSom+Lw78JFpe0KNbi+FOdib7x
         tpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774022272; x=1774627072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpS2MN4inOpug4KktNMxWZhEzpjnIeaTvbJPo8fimS4=;
        b=VTlLLYOWeVWhhWYMYcNaYiw501NSVD7l+dXZnxNp6VPvAebl/yDev1vFO6d2wJ8Nzw
         sNNzaQkYk9v7FR61KFKbNUUnOY+bBN+YRerqQE6/1T/4WpEhdJKMv/HrnolcCxGQeVvH
         fvDL8PP9L6QZ5Dej0A0R67mRwtgChYGaQmK4ixyJWlAxlh1DVbiW9Fj6mib1cj8kXGc3
         HK/lPxioC+DwVKsrVaS6kODi0n4gLjoLwDKfpO50xOOYlfEHA0i6WzCVSCppO/EcsmXa
         E3DAJl9z7lbP14W/bp3SOqXrCTc3v+7ghHqVWiHkd9tIBkW8pwJdZubm1SqPh98Qcz3K
         uvYg==
X-Gm-Message-State: AOJu0YxKMWY1fewhX2lgCriAInXU20AGv7+Zgu9TfH4jrL/hteJevfpI
	/Dg3puX6elVFh4PhBSmyKreerhTZv2uLaEzULfq8SNDoH9Kk3lNETgMmK9I9OjH3bv/MV380uLx
	FPvPh+40vl/resw0eB2pYbZ6gnw+mF0TRJsUZ
X-Gm-Gg: ATEYQzzTUquCn/fQcoN0C8MB9APl/VoYQ1JJF4+dw3+CvpDxVr5MDmyoHLApxqxglLm
	zFs/xYoQ1sr+7zqzVVuaH6Kw6Ic+nUCzcxOaC60ks1JloTNh5JuFAgGwnnDvKtzFf5z5aGq09Kq
	8OkiduzlmvMtsgCviAoI8tTcERqpWP803nm7ZAbZcyFspbVeHHhwOTwRp8RVgx7CUPqltTC0dtx
	BZ/STrRRVa0xYYqJVNQg81gltbgWMYRxcHjNupMV9iFT3AlLLOYSJ++eGLbfczqv9m9FCrDotfz
	Qps=
X-Received: by 2002:a05:690e:e18:b0:646:e648:cc7f with SMTP id
 956f58d0204a3-64eaa69eb7amr3113979d50.10.1774022271754; Fri, 20 Mar 2026
 08:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311042511.2975567-1-tweek@google.com>
In-Reply-To: <20260311042511.2975567-1-tweek@google.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Fri, 20 Mar 2026 16:57:40 +0100
X-Gm-Features: AaiRm53Q4WLQYa6fz58pQpsbWcywac0GUsxxQtL2LLO7G4QDZnXQkMLkht5VbGg
Message-ID: <CAJ2a_Dd5JT14okamnSXq20pooM66RZ0HxmO97d1X2bZXJLXBGw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: do not log on unexpected escaped character
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2026 at 05:25, Thi=C3=A9baud Weksteen <tweek@google.com> wro=
te:
>
> For file_contexts entries relying on PCRE2, there are multiple escaped
> characters that are valid (e.g., \d). If such a character is identified,
> a log message is emitted. While this may have been useful for debugging,
> there is nothing actionable from that info message. Remove it.
>
> Fixes: 92306daf521 ("libselinux: rework selabel_file(5) database")
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

> ---
>  libselinux/src/label_file.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 8fcf74e3..13451680 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -231,7 +231,7 @@ static inline const char* file_kind_to_string(uint8_t=
 file_kind)
>   * Determine whether the regular expression specification has any meta c=
haracters
>   * or any unsupported escape sequence.
>   */
> -static bool regex_has_meta_chars(const char *regex, size_t *prefix_len, =
const char *path, unsigned int lineno)
> +static bool regex_has_meta_chars(const char *regex, size_t *prefix_len)
>  {
>         const char *p =3D regex;
>         size_t plen =3D 0;
> @@ -275,8 +275,7 @@ static bool regex_has_meta_chars(const char *regex, s=
ize_t *prefix_len, const ch
>                         case ',':
>                                 continue;
>                         default:
> -                               COMPAT_LOG(SELINUX_INFO, "%s:  line %u ha=
s unsupported escaped character %c (%#x) for literal matching, continuing u=
sing regex\n",
> -                                          path, lineno, isprint((unsigne=
d char)*p) ? *p : '?', *p);
> +                               /* Unsupported escaped character, continu=
ing using regex */
>                                 *prefix_len =3D plen;
>                                 return true;
>                         }
> @@ -343,7 +342,6 @@ static int regex_simplify(const char *regex, size_t l=
en, char **out, const char
>                                 *p++ =3D regex[i++];
>                                 break;
>                         default:
> -                               /* regex_has_meta_chars() reported alread=
y the notable occurrences */
>                                 free(result);
>                                 return 0;
>                         }
> @@ -523,7 +521,7 @@ static int insert_spec(const struct selabel_handle *r=
ec, struct saved_data *data
>                 return -1;
>         }
>
> -       has_meta =3D regex_has_meta_chars(regex, &prefix_len, path, linen=
o);
> +       has_meta =3D regex_has_meta_chars(regex, &prefix_len);
>
>         /* Ensured by read_spec_entry() */
>         assert(prefix_len < UINT16_MAX);
> --
> 2.53.0.473.g4a7958ca14-goog
>
