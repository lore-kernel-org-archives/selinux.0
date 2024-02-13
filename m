Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E060B85
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856695; cv=none; b=tchTmh9/TkOSrAB/4bEgMEC3eMj3l3FFVnc1TJXuPYyOT6qvEyAu31crUxJZ8AWPNa0Hfi6awO3pdq8k2apdpzAca2tJ9eb7qL7lUe31EqtinKxY/s/eQtQwvTSFizRTrdr2gtAcMtYjpT5A1clqlLL/wNy4saR/phNFBeo5/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856695; c=relaxed/simple;
	bh=2HjPH1L6nXVmnlyTCyrtk7ynMLg/XhRN+50VqKK68mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irBJzOYU8VAEGadUfS1wTnXVY1C84DBKRlHj1CSN9tKp96ylyXmTmT9ttPENHpoVEtqYk1tl8DXMgb9bPVaSXYknCch53H9mCq+JE+QeqgLYLYKKNQUy3zzjCS+OVtGNMEUYYzEuo8/w5nROVTvaJfkXpxxjOFfP/wyTvRdewQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTCmAhEN; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTCmAhEN"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d5c257452dso1453802241.0
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856693; x=1708461493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF6YcwVxllR0SUhRsKPHMjy5AGjYPJlm+IxKPVvIoFE=;
        b=QTCmAhENQ5qGn0EBRc3h4AQ0bjoJWVbuEyDdl/fgKknRjRPOG8lf9f0IuF3e2z4Ztw
         Psnk+zHpTgThgD7DElKp8F/cZ+o504hwvGWnCm2lB1tIVHzZHmP7DKuLe+20qC4UtYl+
         eCJMq0JfC7SZt2Waig5riGU15y5KNSgrAxjaUNR94zlWzw+fjb/MVIIzV3S2KJPlqfmE
         AMN4lUWw9qYHLELZM2lhHFUWSfBb3bTPwLKQQaAEp9n8j5duV1AlPUSlcjMw37zQeFaU
         SRmhKO1DXD9WcP0PA14JqYqprxykZ9U/3C41DRhxOLIt+wUSwqSIxDFWZ4b9d11AErS0
         5zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856693; x=1708461493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF6YcwVxllR0SUhRsKPHMjy5AGjYPJlm+IxKPVvIoFE=;
        b=w+XoQ89EAH/wP4OxrETeihaBpkTWbZusUaY1uPRoX2pvALq5KhQmZW6rJX3z6Kvapy
         byNk5PrwKcV6WhBHh1KW6QvET3KEj4+oQ2ULKBAk06iQu0dvB3957uVmWUDf1rDjqbbo
         vT0S1+7rn2Swfj/BYaMn+e7msENyhpqraq6IbRIU2FE5Ukg3MLq98Vyht8F11+clYE3I
         diB3d1Nin+XI0LebjTS5sbHTpQLruSCAGEItetbpFQbkYM9RQPP2jJMQ9JOBP0gbPW+t
         fJkefG8lq+bLQubCxvrkAlyVoDsaSA9mskbDkvduHcZgwyDAQqkAQpQHU2ye3SkTFVYs
         iLKw==
X-Gm-Message-State: AOJu0YwBKixTctxS+aEDQ3YnJMwHxBQC/H7Kv5JrJ/lqpCSGg0nnK1YQ
	urxc5u/zVWivdDLHfk2dI5XpFkxbp60341NIT/ilP33qtO8VaHlHK3LIxUuBvi52rlG/W57vE8Y
	1SjKTwWwZRNubFFsPgOGvHKxeyE4=
X-Google-Smtp-Source: AGHT+IHEC18RbTRxZEZDJNkSSqApcL2PowR/+7aWYPAkI2seJHalEHFZMjQ7Ptx0RMjFbAkSeG/gzll6BwPEkMQIm88=
X-Received: by 2002:a05:6102:67b:b0:46b:457f:c081 with SMTP id
 z27-20020a056102067b00b0046b457fc081mr565064vsf.10.1707856692994; Tue, 13 Feb
 2024 12:38:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <20240122135507.63506-13-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-13-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Feb 2024 15:38:02 -0500
Message-ID: <CAP+JOzSD6eZcsP-EcnCdb9aJEm=9Qi1b_rt-WT=HJ8fNL4V62w@mail.gmail.com>
Subject: Re: [PATCH 13/15] checkpolicy: free temporary bounds type
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:02=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Free the temporary bounds type in the error branches.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/module_compiler.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.=
c
> index 119b7e36..464897cc 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -234,6 +234,7 @@ static int role_implicit_bounds(hashtab_t roles_tab,
>         if (!bounds) {
>                 yyerror2("role %s doesn't exist, is implicit bounds of %s=
",
>                          bounds_id, role_id);
> +               free(bounds_id);
>                 return -1;
>         }
>
> @@ -243,6 +244,7 @@ static int role_implicit_bounds(hashtab_t roles_tab,
>                 yyerror2("role %s has inconsistent bounds %s/%s",
>                          role_id, bounds_id,
>                          policydbp->p_role_val_to_name[role->bounds - 1])=
;
> +               free(bounds_id);
>                 return -1;
>         }
>         free(bounds_id);
> @@ -479,6 +481,7 @@ static int user_implicit_bounds(hashtab_t users_tab,
>         if (!bounds) {
>                 yyerror2("user %s doesn't exist, is implicit bounds of %s=
",
>                          bounds_id, user_id);
> +               free(bounds_id);
>                 return -1;
>         }
>
> @@ -488,6 +491,7 @@ static int user_implicit_bounds(hashtab_t users_tab,
>                 yyerror2("user %s has inconsistent bounds %s/%s",
>                          user_id, bounds_id,
>                          policydbp->p_role_val_to_name[user->bounds - 1])=
;
> +               free(bounds_id);
>                 return -1;
>         }
>         free(bounds_id);
> --
> 2.43.0
>
>
