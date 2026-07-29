Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114C1A6831
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329231; cv=pass; b=c95axNyKzz+5E4W3PPVCI2nvtn5VSU8BD1opgPVLseImAWjmuq3PAk3PVFlvYo7ozajlUxs5LsmwRhabqmnA68R7s9AWazGQbkO/PWxVqTbLC6lsP/yYdzGxwsRwsWXhm0f+QTFizVGDCGFIOsQWuMGAnr8ou40rSbttWVgTmK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329231; c=relaxed/simple;
	bh=z+cHfTkC40oqI3tJtXzhDEsl6mEExQUlJheVkUyzCUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ty7xyH141A6OhtFKeXrG82LIYAEOldJglOJYG9o97cbP0UFkCJOdGJzQoQ33sXE/YcuT+d1ZTO4fBU3ZjbRfiiNzo02v6rluSutvNHh28/O1ek6vlTMMH6WKhK6nvKGHPQpYcJXFctJsp/7Z5jGtHFTA43W1z+4PKotWj3fL3U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpZy/QP1; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpZy/QP1"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6b554044fso853813a34.0
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 05:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785329229; cv=none;
        d=google.com; s=arc-20260327;
        b=VX+4Wi31gXfCQ9YOjomQlExN0kMo3/E8IhaVRjsrH7PsERBRIpCAMQEvKUWZVIbqw5
         oFtHKKt/gJMMtZBIiq/w4IAdbeRvQNCJ+qjgTcZB9EtrU4x6g9v19ulJPSi45umsKMsI
         sRll2ifz2tHr/4MPeKPsOzHL/cbtaoBOV5eiPSv7+ztEamgyjzA0H+2ULwBHowcigPzv
         YGjahXHC1K+Wsw5vTih6e4YWd5u2r5u7wwMc0ROufoxosf1y0Sxmu/hC+V4YXZc0Ux4f
         46MwggCuA5UepXaUsGReQXA5VKujknfx3QjTARu4nJdEZJfWp54v16eaXjZTUG2BDr2x
         E6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Exr0s8qxJDgcWaqEjZLlB0NnIy7SL7C4gnbxRyl+qwQ=;
        fh=ctNnd7rEgrNGVRcNYAD2iHPqnd+GFVudQHEzcgGqyZE=;
        b=KPEZeySpdSJ+DXGVfzoJ/KSs3ImHB0n1M68lAVC1H5MY2/D1YE8K/tqeEWt3618C74
         DpJQn56HsI2Y+S96Ugmyt1C2wJsC41DQ1cZ6XnTzMll0Y9O2+UT+1G6ZD3qC0z7/Y68d
         t7k3UESDGJ3eSRt2q90eu2HcdZY5WIXfxACFubgPXWM0NTDyVLJuAfTjxK04ssPQKyYI
         /DJ6eOPdIXXDRmoBhyEsvyzeC7dxAOmQZrF50TnyARCdql/Kehoowmwh3m5ZtMll3UUI
         0WXX86II3cruHnJ3cDIyqfgH2THR1EcamOdXzVtQafHsPXgz9rBfRfwe0Fp3PCzCriXW
         ovFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785329229; x=1785934029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Exr0s8qxJDgcWaqEjZLlB0NnIy7SL7C4gnbxRyl+qwQ=;
        b=IpZy/QP1VCjgh971qASmZsCMl6+9yKiMpqKOSOtk1Su47J1drCUmPgw2WuAmmuj4Ky
         /L4M/dQEQCiW8hsYSOKddmc+FweJ0lEAq7xpUpuu1SjqKtu+FRv8NXPRCeFvGEy03hR8
         Ac5TuCCyBQAGFF5KiRvtQa5DV+07bjKpN45cV1fTkWOfPEpqKn4YNkANZAXFjnPmjI5B
         H7fflaRddf9cqVXZKAHFa9iXz1n2YrD3CfRJvZm10TgbN/n37GfTUtqv1mJE7CTzjCz7
         Z0YD8HmK8lJlxmHjlk9UypbkfAwmspCCT+GaNLZsfau84lx1JwOsIAhVl1x4Ogrv8dv8
         TQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785329229; x=1785934029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Exr0s8qxJDgcWaqEjZLlB0NnIy7SL7C4gnbxRyl+qwQ=;
        b=DxYZ66edR3zrpKd8OBRneSE9azdLrP6rv8hMoEz7E/ySIYbyDHnTDRbQ6Mx8AgAQ4V
         2AKzpAnMPF16ibRmRm/cIFLLkNJEUMjXI5ZTmSUAJJRwQTfr2bSgG28norYeKuWU75Sr
         lg08KMjxFssC1m0DR/UUmLwOip/ZZ2G2vg4eVoqNJTGrjiWNboCRoJJg+G3VJZAkdj+i
         FsZ+V1+Xr9W8TaxwOmbNhAwmFydEmWIwIK3k7jjI4m4dmSY0xgMUJfTEGfExMhQZqW8a
         gmcQ05SaZSfkXYZVkfRLDvByl1dAHsfyiE6e4XzjCEWpMzsYZ+G799gK9y/oDFW0bKVX
         1d9A==
X-Gm-Message-State: AOJu0Yz4rL14YlCJdKYOFNdKwhR45WxkPMHn5K6TEVu83hcVcj1i/Idk
	dfqtsuoyUaqPPNaOZ10xPNC6If8Lqa3XK7ORUkXlf1o2BxCqTP0RnySrLjG5wjOCkqSqv5zmOtc
	LJCjgrTliohWL4sDM33jJPxgXFnsJ2xI=
X-Gm-Gg: AR+sD10SKiV0H66YBP6M9Gjg11xa46G0bUNiwTHY7sXFargjRcFXdR/zlE1FnOkwNtV
	14mN8nlt2tmeRit/AwCvxDlO7oXrO+JzCRm37FYTq9E1iNFYtFIRyHfoUfZ3xMUFjVhzj4yvDAd
	+QS8TF42rSEeNFZouRNXI9ACv0svIiynK8nW+HO6ByZ4S02dcfhd7NnLhAuEQ7zPjzupAzpR2Uo
	2pgUmq3hudGupcGqELUa/VTaxQObP3zGakfb42skJ3HaFj6aevSuNibNSoTAoYkVgQEMa5Snk3P
	qhIorQu+YB5+LhUPxXUgIG4FevC4m1De183YIFGvhmIi
X-Received: by 2002:a05:6820:4d09:b0:69d:6bfd:5a3f with SMTP id
 006d021491bc7-6ac96d0aaa4mr3103709eaf.51.1785329228682; Wed, 29 Jul 2026
 05:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729124138.941391-1-omosnace@redhat.com>
In-Reply-To: <20260729124138.941391-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 08:46:57 -0400
X-Gm-Features: AUfX_mz9A8Ghung4IEoRXZDdXsUC_Zs3GIOV6broz9pDwkM9FkroHdcWRJxplAc
Message-ID: <CAEjxPJ58DKCRDWbkEMKb9C0yNMdVWpmT7zCQ4xOo0KnjogDftQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/file_contexts: add test_multiple to .gitignore
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 8:43=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The new binary target was added in a recent commit, but it wasn't added
> to .gitignore. Fix that.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Looks like our messages crossed, and I already merged the same fix.

> ---
>  tests/file_contexts/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/file_contexts/.gitignore b/tests/file_contexts/.gitign=
ore
> index dd877b4..8b95fcb 100644
> --- a/tests/file_contexts/.gitignore
> +++ b/tests/file_contexts/.gitignore
> @@ -3,3 +3,4 @@ test_lookup
>  test_open
>  test_open_base
>  test_validate
> +test_multiple
> --
> 2.55.0
>
>
