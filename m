Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B211367
	for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740097032; cv=none; b=ZNfz3UUbSTDVzNkpXuCjE9wDy1I+QKHgA4aFoNcjxIgHZ6WwNEv0XxgX6MaL4Q7Ka41q9e/ePlQOMltQNZzT71IRzi36Kb1fc3r12hM9X9J/NmihUPahYHR+vIpYDFzTLAO9iLUCVsOIxptlntSVhaM718r7e1POiRCiRY88QpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740097032; c=relaxed/simple;
	bh=sRnGwmjBsa1rYymbyRJuPWAp2OXRyyMtpZSrU8eSu8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPsrxRHR8NN4QSTEZsXciqnDp1Uve1nSdPqtp5FwbQMXSP0iG1WriGdrhiwbb0Xb1ht9qlFemCDpQp8vYg6NDV9XgMdhyTMp/HyU8Hvw0r6S62pU9G0hW//Eo4uLXX1zVitL7ttwc87q8dI4YbEK0v9K1NS7OiL9Tuyf4zdNA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KffgwoHw; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KffgwoHw"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-543d8badc30so1834584e87.0
        for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 16:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740097029; x=1740701829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifcoCOoDnDDEXbfgzRZkwZY31Z7XolaJokt22PmyIeI=;
        b=KffgwoHwQuJWEvE57fGFqtRFLhh28VTMSzS68+7abq4JlUx3YqBBPhb9vR2X+B7KOp
         /njRfWRfx3r4Zk25KpNC1H+cX+TP88ZQhLT6qmdKX1OBch6Sk0+M9ATSM4xixqeNJaun
         fNd7ujT/pICJ6ymBTHVWKw9IRrwR9n2H+XAwsvhSbAHf2MWz+hLi1J777XBIIIsiQOgg
         rjvwxtIlo0m/xssvnAlPpAHZuhOvxE4NCM0t4hCDkh9jU8qnW/FE6voqDdI21KweuX8T
         0ssHUSMn8oQPAwCSRCN1DZdBzf6lSVeDd5uPpWepIh2cl/xhNsUJQ4TPT2ubDHJMRT8U
         ibUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740097029; x=1740701829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifcoCOoDnDDEXbfgzRZkwZY31Z7XolaJokt22PmyIeI=;
        b=dxpeZMhyDakdZQwVJkb1mqRKfqtbILBl6RWGIcCi94E1POyHWA1UY5i0l5MwS5bP5L
         riJYOvpBlYWcDIYobIFlMsVgD9Qm5G9Rblyh8+2WXOeYNa1Kkj8j+iQHxQUgqYQ4JGKZ
         RYinunIPSVWho9EbT38d3MdfIfmBfnBgf/l876lJ1ldw/i2O8+JHeToeaD8cM5bgCFpR
         xsuo6WaFy+6uaDw4IweHLvOby83O4i6FdKCgSsaJ0/YhF9JiAAq6lyW+1Q50yXZxiS2W
         AZsEYPAuMwxhazM1tJVqvvO5+sSWYsxGB9brr1HexPzkdkOCsriFQy9w8TPL8duGghMb
         SRqw==
X-Gm-Message-State: AOJu0Ywi+aD3sfEY1BZhIW+77F9fP4KjpCYAceiLW8Uydi0KsaResyMn
	xb722TlYpepY7LBq7m8vn9L7MErVarfbZylA7Y0H9bVF1As3Aiju2VgmEw5rF5KbPJIO/8qRZ9r
	T3m7Ts1wQR0X/VHxTCg/++8KyGr/pxTP5
X-Gm-Gg: ASbGncv8YylFUKjHixPS0IbBlnatDmLLzBzkGAdEki6A2MAfLiZbpTleW6l5j2V5A49
	OM7LaJhJXrzzq7OZIPtZdnQh1HJ5YDrKa42pdRQcW2irq4Stpvs28XW+ZcvzUhhWih+zB86p0Mg
	==
X-Google-Smtp-Source: AGHT+IGMFOAM71JGX4kLmFz67y28cScNFW/ENYJaeqRKlItoZJ+3LleBgj6SiwZuhgMOiodUkwxfJl4VrpevoHFc8jA=
X-Received: by 2002:a05:6512:239b:b0:545:d27:e375 with SMTP id
 2adb3069b0e04-54838f590b3mr330018e87.42.1740097028738; Thu, 20 Feb 2025
 16:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220211249.574456-1-nvraxn@gmail.com>
In-Reply-To: <20250220211249.574456-1-nvraxn@gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 20 Feb 2025 18:16:57 -0600
X-Gm-Features: AWEUYZkNUusVxPIeTH1MAA9zAphO2_RJyEiu8X8xjjLB1uxWEYKD5BB1Aa7Pa58
Message-ID: <CAFftDdo6SvOE9+XZY3bKidFGz_So6_N6jNxxSyB0OPR8thSY=Q@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: define basename macro for non-glibc systems
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:13=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Passing a const char *path to basename(3) is a glibc specific
> extension.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  libsemanage/src/conf-parse.y | 3 +++
>  libsemanage/src/direct_api.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index 6cb8a598..97cc5438 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -50,6 +50,9 @@ static external_prog_t *new_external;
>  static int parse_errors;
>
>  #define PASSIGN(p1,p2) { free(p1); p1 =3D p2; }
> +#if !defined(__GLIBC__)
> +#define basename(src) (strrchr(src, '/') ? strrchr(src, '/') + 1 : src)
> +#endif
>
>  %}
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 99cba7f7..4459a7d7 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -63,6 +63,9 @@
>  #define PIPE_READ 0
>  #define PIPE_WRITE 1
>  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +#if !defined(__GLIBC__)
> +#define basename(src) (strrchr(src, '/') ? strrchr(src, '/') + 1 : src)
> +#endif
>
>  static void semanage_direct_destroy(semanage_handle_t * sh);
>  static int semanage_direct_disconnect(semanage_handle_t * sh);
> --
> 2.48.1
>

What system are you on where you run libsemange without glibc, just curious=
?

I am not opposed to adding an implementation for basename where the
input can be read only for non-glibc, but this patch doesn't work:
Per the man page, https://man7.org/linux/man-pages/man3/basename.3.html,
basename("/") should return "/", this one return "\0"
basename("/usr/"); should return "usr", this returns "\0".

There are two ways you could approach this:
1. If you wanted to do an implementation, I would add it to
utilities.c/h and call it something other than basename so we don't
get any odd issues with it choosing the one from the headers over the
macro. Perhaps libsemange_basename(). On glibc systems this would just
call basename directly and on non-glibc systems do the implementation
with your own logic.
2. Just copy the path into a modifiable buffer on non-glibc systems

I would do both approaches. Create a utility routine that calls
basename for glibc and for non-glibc just copies it to a modifiable
buffer and then calls basename over rolling our own and the bugs
associated with it, also add a unit test for this. This would keep the
logic in one place and be dirt simple.

Bill
