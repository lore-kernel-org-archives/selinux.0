Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7113231836
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776112; cv=none; b=AfT6T+RJxL37CMbG5bHIYAKOs9rGgH3sExZkiEUqRQEse1ic29ORPdTdvz1UgTOFKrMynGK3vx5OGwgW8t3ceLpMwaL2yfvZtQX8IuCPyNM1x+sUhc8JTIcaSS57qXKogHqk8WjOjfbQGPufpSooWcI5vYcR+z/XFbXmhUQbpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776112; c=relaxed/simple;
	bh=LBJGL/nyY16szf0dJ3ghOi41a5AYx2XMpbG74refev4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlD4Ez8jIEoTH8gb+ln47j+2+JBTvEUOJd/SwPFopfs8Y/nmdYfoJTBrdPQGM8KkF97rBH760YlvpDN+jO4a0qys9u3QAjqPEt4QKgcGqWUT4+UoxbrWrcRx6AyibxnSasOcW9aqNf2rRgd82Rj2/TQpj+MZbMXGD+k/vRfSg5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSngByEI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSngByEI"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so4811464a91.3
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759776110; x=1760380910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MY2B1hDTp1bdxoRyaXtEZ5EXjHjpHhQMmRXBkM24XQ=;
        b=TSngByEIeB674BADFYHobLQPxLZet51BpAqZ5Fyl7NKEJVV10F0JRkEQZOnixdLN7o
         lhLCLPmdiJigq/gCynF9enTRBDllPuYJx1O/XgICMqdyaPGPIP0YKTUOn7dOPMNnVgqR
         lMpASqCroGvmadmTh+7as0m62ayn5WmP0hWbRWeomcRh69si/Qu0l18SaqVcR2kC80ar
         9yURZFOPPpOguNx9ViKyC7eV8Ux8jBZ3uHlQYmzgJ0gG6HgGtlhidcsg7Fqz79Gue5z0
         kjk3li5OBJfxmpyEiRF+yZFLgu6yQTA8eLvBn6flfpC2PKiOvU/2cCMy1BUzMnryskSe
         Xu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759776110; x=1760380910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MY2B1hDTp1bdxoRyaXtEZ5EXjHjpHhQMmRXBkM24XQ=;
        b=inJNQGsJZeyn7/KZkdVu9LglxpIET/BK8E3H9+Dg56OIJQ0M/eZ2vL/mm0l4DkQ/ww
         4e/JmsRRA3HlGoIwH5XaW+4tTStrxIOfEo6r7OYM1G+G4MUe6ThFfbKiPflrTbWRaFR7
         dQE36eQNwsHyXoXA2DQC9gQcDxLu7kcSNyYKZcyqQ0JvWel/5PmTSpR+/NvVC+PALQpp
         zQTOXwFGcDnBDDZhYzp/W14PDQcWnut92kB4vBZaJ9ymkZMThlPISyrddNRBtq2oQ+oi
         pJrSz8/rb8lAL0HlWPaWkj0xB8VTqD/uVkY1jQzRKS+cdNjgv4hQjjBsv3T8Dr7v62AF
         Fg0A==
X-Gm-Message-State: AOJu0YxFYevuUqX4Y0mq3WylSD1P1gX/uxMplXDYrAG5Fec/acrUzbtO
	X72/wnXmlkqj9NtUkdFntGD7UtexeIBrulzkZGt/BzkpX5Tz2O80HU3MU536dUppRF8zk8z/u1k
	bqxy8xUlcoDrkTyTtFczLflXcsQ93eITFzQ==
X-Gm-Gg: ASbGncvXoI3b7lZSmk2zXe1xDxZ1Rwq2VNQ4kI5JtRJhjzuptnbFKICtrMwUNYF6HVN
	tEmjI38DvrxmoXtNynEEroU3NMMuYgg9py8R2YQmKskuvPdIOPwETtArC4CHyh0lVNEgwfzywWb
	QSrg3wtp2RyU5iNpbCyr0KJHEkeMNE2Z2r41GWkM8xWAbEJFc/gzWUUVGJs61gS2w5ije4BRL7f
	fW6X/CBTvKMXc63V9ev1+9m884jlP16E6Hi9qu2Pw==
X-Google-Smtp-Source: AGHT+IGMS7yRpOwhmbfW6gIAWM3RNNsEFA0mX1UY/vT57VfbSmDvHtxdka0lbVYQcoGUxxHOm9XTcsMEZfzjTJ6YDlU=
X-Received: by 2002:a17:90b:4a8f:b0:330:852e:2bcc with SMTP id
 98e67ed59e1d1-339c27b94e9mr14879617a91.21.1759776109936; Mon, 06 Oct 2025
 11:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003190434.432154-1-nvraxn@gmail.com>
In-Reply-To: <20251003190434.432154-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 14:41:38 -0400
X-Gm-Features: AS18NWDTkb7JyFshlVGmaFLIkmFAicMJ0_lR4iEyE-AKoMn0rvZwNJ_njysNLMY
Message-ID: <CAEjxPJ6Wcv_SG7=ZsGuRyf-83f1G+ywTBCeeey7hfNyCqF-KJw@mail.gmail.com>
Subject: Re: [PATCH] docs: fix context_*_range (3) return value documentation
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 3:05=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wrot=
e:
>
> The context_*_range () family of functions return less than zero on
> failure[1][2].
>
> [1] https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/co=
ntext.c#L184
> [2] https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/co=
ntext.c#L190
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/man/man3/context_new.3 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/man/man3/context_new.3 b/libselinux/man/man3/cont=
ext_new.3
> index 3dabac3d..04522366 100644
> --- a/libselinux/man/man3/context_new.3
> +++ b/libselinux/man/man3/context_new.3
> @@ -71,7 +71,7 @@ set a context component.
>  .SH "RETURN VALUE"
>  On failure
>  .BR context_*_set ()
> -functions return non-zero and 0 on success.
> +functions return non-zero on failure and 0 on success.
>
>  The other functions return NULL on failure and non-NULL on success.
>
> --
> 2.50.1
>
>
