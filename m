Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DE5C611
	for <selinux@vger.kernel.org>; Thu, 14 Mar 2024 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432383; cv=none; b=mRSLztoZdj5nsJiS5mMAjae0QOOpOCs7ocUd1+PF6kvMw/NGLGtMJzTAYlk2tGVAoQx3XkL002By+mJIL+Jc38eIa3vVVFl8CfJCldBnAUOkbhfGYER8SC5gqb+QMSDwC0ZrL1aaxsAcrDhdaFueeF59Jbarr4lktC/z2cvarSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432383; c=relaxed/simple;
	bh=lcieb4z21BBGDUcVVHu8A4xphYc29J/IN9KzGo8y0iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7CX7hIsWiN8iDWhkjENQfD3fPN6juTHCYtgBYinAaRapzAuzyBVGZzhQqL7RDAksF/62pyXbhjbKVZolWD1XLpwyrkY/niGCvCHOfgvScbzMYERmugteLqBzuiDpGCwR+9tfD7W3JFPDizOpAZMXNJwHx43iPDRzH3sopBcpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgWAwlMi; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgWAwlMi"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7887649cc6cso180931385a.1
        for <selinux@vger.kernel.org>; Thu, 14 Mar 2024 09:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710432380; x=1711037180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJYz4ohIRcs0f5/1O/EsOIgaBDwiQLoyjNUgQYS4NMI=;
        b=BgWAwlMiO6acc2VTAPfnO+Nzunf8TmI9Jr+yj8cTpa5y6bR45ADtNW9Q6HoJQ/zSBH
         Kn5WXRCBD9G/o6dfClY+gtUfP73F5qdnuyZDqTlz1l57EZ83yLONZkPv1eXUEtvIwAHQ
         fK14JD65A5SXlxmtWJz2hgjzn8LiWJWYNFWkSS9jJ4mb2euddYELR9enC8lrVoi9lnRh
         WdxNrGPcietg7oGsxXXQdPF39yAFcJ7NKMH5hOlFiX2SIulFY3f0pGKvGEQAXa47zs77
         pv3cXR5SYRxyFgTbG+kQJyxAMHDdcXLIM3CYZ9Wpc8B8BCXa1VFzaYARf5XTG+eWpvXS
         nU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710432380; x=1711037180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJYz4ohIRcs0f5/1O/EsOIgaBDwiQLoyjNUgQYS4NMI=;
        b=HfF7HUeK/yF1KM2HatxKvwkc+es0fcJJP9c9Lt32L1QrHFwDTSCu69GxQOANFYH5EN
         Hv7WzTyjSE51E0kAGdSSkcII4ly43doCmDrZop2GTvPwyeShBajrGSplBY2BB50nJ9cr
         w7COp/A6m19HFmSIcR/KCez7NXLfknEKffFZpWWJgzb/xjvmBcodXDUs+/BO7xN8x357
         cvf6F6IPhadDGcYSgaBo7Kp3ieYmIfoh8DSpQXuMxXiMKp1ZJhVHTXzXr9HHCfqpD8R2
         oJ0zVk3vBCZmwMO50m5jFBcdfCLZSBdiHJBiAlV0dtv5aFYDdFqnVsSh3tJuDNod/5dU
         Tvpw==
X-Gm-Message-State: AOJu0YyJWzmRRMvvhZWB2O3rHaShQKCGzKms6XG/Bp0Mi5QmrroYE8ux
	Eg8P3c20h/ABdf3C9K1NacN3nm5YFY+zP0AYhHO2BXeYUoRNfP2jLW7gw0Bj4bDRh+ZPbVU50xd
	1nBHrUgO8q42lvCk6wwpCRx8unE1lDZzfepQ=
X-Google-Smtp-Source: AGHT+IFpRQ00PqBST8Azi90Mx5Im9MS1MFQm0xZ5N2A+3b+jg5YmKMiVAjjkJIGixmrmWUCuJWlAQQWpReJ+4Bcc/1Q=
X-Received: by 2002:a05:620a:40c5:b0:787:ad37:4a0 with SMTP id
 g5-20020a05620a40c500b00787ad3704a0mr5724139qko.22.1710432380356; Thu, 14 Mar
 2024 09:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313111025.43720-1-cgzones@googlemail.com>
In-Reply-To: <20240313111025.43720-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 14 Mar 2024 12:06:09 -0400
Message-ID: <CAP+JOzRWQRtnR56bkLNmCB0F3fGR-2v-DRyTg8Jd=wxFMUv=hg@mail.gmail.com>
Subject: Re: [PATCH 1/5] libselinux/utils/selabel_digest: drop unsupported
 option -d
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 7:12=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The command line option -d is not supported, drop from usage message.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these 5 patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/utils/selabel_digest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel=
_digest.c
> index bf22b472..50f55311 100644
> --- a/libselinux/utils/selabel_digest.c
> +++ b/libselinux/utils/selabel_digest.c
> @@ -11,7 +11,7 @@ static size_t digest_len;
>  static __attribute__ ((__noreturn__)) void usage(const char *progname)
>  {
>         fprintf(stderr,
> -               "usage: %s -b backend [-d] [-v] [-B] [-i] [-f file]\n\n"
> +               "usage: %s -b backend [-v] [-B] [-i] [-f file]\n\n"
>                 "Where:\n\t"
>                 "-b  The backend - \"file\", \"media\", \"x\", \"db\" or =
"
>                         "\"prop\"\n\t"
> --
> 2.43.0
>
>
