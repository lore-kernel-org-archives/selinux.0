Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A972E0902
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229467; cv=pass; b=fqyLHGbbLwGnotrUFTgwatwV7fA5u6NqSqqZswzTrS0KmxEcyehW5Zj83iKRY9NPF8faGr6MjP6tSZiGl6DzwlgTsSXOYXtywOzDY9M99UvURYufoMYLiAKdsAzRlTpnhTzIdHEmcAEftrtJDW8qZkDJFM3ekOlliwpMYkp4XZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229467; c=relaxed/simple;
	bh=Tb57MPjfb2C6uNsjtZA4P5frkXtcoJow0Xe8sV3gfxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBZgrWDBL80+Wch6Lh3qq4ltqXQbGvPlW8qc5Qj3LB1C4Uc+MlmCNowVPRwvAiYKyeI942WxQr5ZqhMUnQlSegWewEagqbL/CFMsd/QKD+RYnFMb5Cy0iFaMOw62Z/cjR3usVpw8Mo4KWx8QwJBp3eJP6BOYBaau2RFbVquGXvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+kJ2uGX; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+kJ2uGX"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so48803a91.3
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782229465; cv=none;
        d=google.com; s=arc-20240605;
        b=TEBCkEIio2hdus8PALFu6pbSUcQ0PEILFnDzYiuwCrP/Z2O7joGDVYofJCKHbnZLfe
         8vxWJtQlFjQSMIXx6+0hOtlcT19RGY+BvwR0q85OCf6EPDirNwCAOSLh1xx2ConjL67E
         6NQlBixThZEP8tENXASZZlFJQs/j7hUWRVGgJvObic6rV3ssX+M06hU2WlgDZq8CXX3v
         TYDG/ftPIVu/KZbUioA8AyuNjucJeMkJSHXnw7Ltpig6ddTJ+ijEW0jBmGSqAerLuruO
         1R0xVkMdmjhNSh8xCT3oWJ+WEW2GHbYbQ8vNfgB2RsrdW1qLyeumVE5wuwT0FznD5iWB
         tsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Ug4DJgx3zCZZ2NMQqhlEvsI1RKWJdxw2VAYsS4EHo0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=aPKJ9A4xDp6WzDP9UcAcuJ9AMxJaWMTZhbAiib1CBScKsPcF+hPPQKSH6khR9/GgQ2
         pANqWwdT5LbvbdlYOjNo4hBMPeLHCDA6rg/HleCMpDB6NuiGTD+jKUMItGdG0hl6rH44
         NmYUvLdnC2o7dPVhTUgE2yAUUoAMc3U09oXBF3qEnyu8km7+RYzhZwTcHsCdPQ3JX+bZ
         ZloTM0VDgbC7gA1qOBeBqvD+NLNeAUppIoyOjDhCL62+OtsJzf9O+qG+U4Mbg4nACEll
         jnSd6k+KxOTtEC42as4dgwcn6YQwStwld1xmNbEhxfeYyLB/XK4XdQle1neuAbBNnseF
         zG1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782229465; x=1782834265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ug4DJgx3zCZZ2NMQqhlEvsI1RKWJdxw2VAYsS4EHo0=;
        b=k+kJ2uGXo9Ip+1S9qrB2pvikW7CGeXEZ9PUoS5RO0WMMRteOdiu7w/b8S94SAjI4cA
         3vbwk2uvJXoKnS0VUhNNPGD1/8pf3KGKMqaPqp5Ppbb4YR+f9YFpWTvAisj0LR4CvxvT
         8Z6BWe9jYOrp+K1HJ/WO3fKOIclGY57/w+m2Ngkn0jQdb4tyi4dQkp2feg4PpjsjQGHR
         CcPCt5zRD/aPW0IakZm9s7V65I7xkGFSf2bWtOibIPO3JaN35bBMuuwDxL846LToiAMg
         8AYDbCh+/qLsfBAWyk7j2do9AeAuTXnu0fZdBrB9gEpRKZRwVIz6HYM8ezw0Lg7w420Q
         KFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229465; x=1782834265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Ug4DJgx3zCZZ2NMQqhlEvsI1RKWJdxw2VAYsS4EHo0=;
        b=VpWxFN5tIexKYhP/NlJY4CKMPDSMOEZFY8IpctujIVYbgRRTqeuzf1GiGBuBJ5g59s
         DEJwsuxdjebHFeJpT+wNe1clVC+mB+d+fbx8knNgYvAqlXknFJKTR62pEB7nsV9WszPZ
         ls4U766kl3amW85nnjoI9apQPGUI2J9zRlYX4RvHkaPYQDrt+X6FiiUOEBAke4aIk6Je
         U3cWGhvhuxWuhdm3PCrQuCM+JvZFU9OvpzCmnyJ9aUZVT6MFIdtvx3mMoUEgu4ZyO2vM
         A+YESv7fgUoaZ9NQ7xHw2M/uvc8OxCR4B36EhIoE4WWu+QP3t+m4M8yrxbT/VACprM2p
         rB5Q==
X-Gm-Message-State: AOJu0YyD7kiB3j8UEKT1IjvqCg1GKU6ClVrUNrfwcrHiT9SgyaDNkxwG
	0DLlJRFp6s8mxLF8DDGghb6i0t+81zi9tgNuHiEhqRbX3g220NPkgnapKDkBQSXpjp6vqWH7mNg
	Tj9kF9b/UwLuat9SPo+Uo7rXmp0vu3QZBFEwD
X-Gm-Gg: AfdE7cn8lXt1LLUGsQzwxmgILwuqdFaGa71GtMss1z7tVjSIwVxnrG+Y2KwpOP0TscW
	ETQ9X23EOUKx/hDNPk+vVigJDwAK6ey2+6jiTLHIwB1/oQ9C4DiKEBVyLn7fZUMnzuj9j6lAnto
	T8lb2sEa/hEEdMfHET85dwDK8d+DaQt/mUXjwkARWcPsy4i1JlA3FVv0eNn2aas4YDOOWEJobdR
	23hAsGdjsAjVIrS8aOsxe1dVH+QadeMkV+WNaXHmEIzr1arUJxxx7HtAAgip1k/w+geIReK
X-Received: by 2002:a17:90a:c106:b0:366:2e1f:393 with SMTP id
 98e67ed59e1d1-37d161816e3mr18573776a91.21.1782229464826; Tue, 23 Jun 2026
 08:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-21-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-21-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:44:12 -0400
X-Gm-Features: AVVi8CeEk7EYro1hvmZDl9U7r_4zdlpXrKd5K2g6MoLNaWoVxSWlHJ0DcKkYm3s
Message-ID: <CAEjxPJ4OXyZwEnncHn-kKrHwAae8wiS6gv=RexsxhROEGov6Pg@mail.gmail.com>
Subject: Re: [PATCH 22/24] libselinux/audit2why: free boolean names returned
 by check_booleans()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> check_booleans() strdup()s each boolean name into the array it returns, b=
ut
> the BOOLEAN branch of analyze() only freed the array itself after copying=
 the
> names into the Python list, leaking every name on each call.  Add a helpe=
r
> that frees the names and the array.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Move before patch 19, then:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/audit2why.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index 2e1a98a9..b03ecc91 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -165,6 +165,17 @@ static int check_booleans(struct boolean_t **bools)
>         return fcnt;
>  }
>
> +static void free_bools(struct boolean_t *bools)
> +{
> +       struct boolean_t *b;
> +
> +       if (!bools)
> +               return;
> +       for (b =3D bools; b->name; b++)
> +               free(b->name);
> +       free(bools);
> +}
> +
>  static PyObject *finish(PyObject *self __attribute__((unused)), PyObject=
 *args)
>  {
>         PyObject *result =3D 0;
> @@ -331,7 +342,7 @@ static PyObject *analyze(PyObject *self __attribute__=
((unused)), PyObject *args)
>         PyObject *listObj;
>         PyObject *strObj;
>         Py_ssize_t numlines;
> -       struct boolean_t *bools;
> +       struct boolean_t *bools =3D NULL;
>         unsigned int reason;
>         sepol_security_id_t ssid, tsid;
>         sepol_security_class_t tclass;
> @@ -442,7 +453,7 @@ static PyObject *analyze(PyObject *self __attribute__=
((unused)), PyObject *args)
>                                 PyList_SetItem(outboollist, len++, bool_)=
;
>                                 b++;
>                         }
> -                       free(bools);
> +                       free_bools(bools);
>                         /* 'N' steals the reference to outboollist */
>                         return Py_BuildValue("iN", BOOLEAN, outboollist);
>                 }
> --
> 2.53.0
>
>
