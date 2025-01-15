Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D7C24A7CC
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971475; cv=none; b=a3hDY5XXUvVkHuMv6MHO762erSB8Pa8izfqKsWtDU3O++QB2jVoHYUfcrI44zqfiWiIAkehUmpQVOySv9YxUs93UP5azecsGVhwJ9QUXUeOU0prfM8k8AlgG4G6tv5Q1bXxpiONEkfzULhrfd/2snk/8mATDg6thw2eXdnDqt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971475; c=relaxed/simple;
	bh=onjnAG9v6CiGyCK70yHxyot2YcGW7mzuuU9LuCSsW3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amQoG1PBmT70dH0Bw5xsHkpNYRJY7FLXzA9X1o6qfFAdmiGis9tKJxX/IKMmSCqM9YdEKRr8bj8YsIG8duM8rNyzjD7WVomoN8JpiXVJpdHbGSAbDxanHwKaTjyt3qt5AOT4Tg8ViWn6aU7e60hJDGe5h5yRHexmRxQ5NW5XLUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCC//ZQt; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCC//ZQt"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467a8d2d7f1so1717051cf.1
        for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736971473; x=1737576273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0O719WU+baboDG9ql3FPY5C6TfCnKRkc/bFiQYYBpI=;
        b=YCC//ZQt7KmWSf92iCPTSoRKJWBI1XIaHZP2XSJRiAkK46MgB562XHy/Tc0CHi6Ikj
         bXjcZwoT/tL89nXef0nlPbkA9CkSxvfVpUDoeniEGti7MOEERq4XQLYIj/MYnOI0TKFf
         L7GVMvumPkm67d0J/3WVzj19+7ru0DpukT7fFrHv/hlBPGBL4rme6AA01s8psMJtzUt/
         vh/grOvg2oR1ADKFjUBsRXfK4DshYqOPGHPQVz1yP76aLr04deFdnnrnCOtkUSZUiSf+
         TRBiqASfbEv6j4nF/IQN24sYwDvxsoMweqH3MMrxpPPcwWdjPRD6C6Pq2d7pzHLVXW9Z
         Jjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736971473; x=1737576273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0O719WU+baboDG9ql3FPY5C6TfCnKRkc/bFiQYYBpI=;
        b=XbESEZx43qaSFCI9rF1fJwnU8YQR0A8K0hZ4uPdwyXd+MJGKEwkM49CFQIKlzDrMKF
         xOkF2TXhc/e9UTlW1+2RABCYfv2Ie9w97dwNQ44C4Vq+FFx7y4SCXMjLd3yDowqywQjD
         Zl0G3acrg7ACfoDf9ur8xemozpaHVhIjD28XK/W4WrubfHtfKkZuexEUzeNmbU6qEa4Y
         1MalAOhGRpd/a356j7thD0aHjN8ME5rtyEN2BeHuRhd40Mo+5/yRO8praNC4tZ7GWlmM
         gSFg7XEeQtioKR1Ir9d/oT909I4I3SDLco9vPf3gpwYmI8Urv0IpyEJtNyJ/JHMZr7SS
         3iaQ==
X-Gm-Message-State: AOJu0YzXZdPzJS0FHIlYtMjokrkzEbhNlsphPGXmoPRCLQADJqNJ6632
	Taj7GCUzFBjSNSR9XLjyC5C492cu30pymLi/6/NHr7XcZjWEOi3tsJu2l4S3jGjNZLBXeAyoA4P
	+c1T6fX+oPAQLc/5rgn6RdqgeCReBexcQ
X-Gm-Gg: ASbGncvoGGAOSJ69gJ8nQWGnaivTwPlQpg5SlgYG6+w1BucZZelVCjG9Kxu88hB+ySP
	2yAf813CXh09kyS3+uHIteQi0ixab2nXwGw0OGQ==
X-Google-Smtp-Source: AGHT+IGr61mksOEp2EGYj+fhhw3SQlUK34WY61v9QmJ3HPq2dHnj+qfpFGPs3AlOhC++YXCoXQgArL6sC2NTd1o7RlI=
X-Received: by 2002:ac8:5a53:0:b0:467:5a0b:de08 with SMTP id
 d75a77b69052e-46c70fd071cmr436649081cf.8.1736971472944; Wed, 15 Jan 2025
 12:04:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115131329.132477-1-cgoettsche@seltendoof.de> <20250115131329.132477-5-cgoettsche@seltendoof.de>
In-Reply-To: <20250115131329.132477-5-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 15 Jan 2025 15:04:22 -0500
X-Gm-Features: AbW1kvahbCH6SHASiZL6Nh70eclrhPW2SNRTVU2W_Q0vx3ktvEcORR5nLgwWk_s
Message-ID: <CAP+JOzSiqjUJ1yVft_fmgU_8HoJUdRhnvxFPSwxQeNcmUxbP3A@mail.gmail.com>
Subject: Re: [PATCH 1/5] libselinux: set errno in failure case
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 8:13=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> In case an entry read from a textual fcontext definition is too long set
> errno and the error string accordingly.
>
> Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
> Reported-by: oss-fuzz (issue 389974971)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these five patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label_support.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_suppor=
t.c
> index 978ba828..57e191c8 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -45,8 +45,11 @@ static inline int read_spec_entry(char **entry, const =
char **ptr, size_t *len, c
>         }
>
>         if (*len) {
> -               if (*len >=3D UINT16_MAX)
> +               if (*len >=3D UINT16_MAX) {
> +                       errno =3D EINVAL;
> +                       *errbuf =3D "Spec entry too long";
>                         return -1;
> +               }
>
>                 *entry =3D strndup(tmp_buf, *len);
>                 if (!*entry)
> --
> 2.47.1
>
>
