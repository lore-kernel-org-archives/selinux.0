Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9701799F
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782153930; cv=pass; b=Ua6p81dcJA7KYXCwEo8eJmF3O9WOYrChgNr2LGInT/S8PEItwr5u5hZbpcL5Fw6vznDmPrbyxo1YZxGSEweWLewrmcOxVmXY21Gl0ukGhM2gY5/teIow8aU6e4faSu2hE8w1D8JTVAVPgcgx5FUO+gV7iQB8P5jtpO35cHyQZ9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782153930; c=relaxed/simple;
	bh=9IpgFgNNq1r7ze+PS+qfAZGFDH+b9V/8hD0D0zk2Y/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7KYeE+KZRCSfUzQCz/5sV+17fK1XgmI8osd4obbbdlPmgf3M1csUUaNhizr+upnIYutb6He3wJ/raN8kaKdQ/Zq/vWciw15Dnhoa8teKw3gWMtNzirsNYxwP2/p3cEuFX6F+/LMHkVmC1pn5rZuB0XFGe52MWQ/F0ul42PfLzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE1CPsJq; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE1CPsJq"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69775980397so4413073a12.2
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 11:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782153928; cv=none;
        d=google.com; s=arc-20240605;
        b=BbfBHrBycFR7QodzQ9XVN56LXUVjhJ6GiYsTCGMoeky4iS5AGC5IT/0LJJQU4NRcDU
         QoxHxrs3OHa8VfR2mtIK/S5KDgOACT4HRNin0f/i3ZNlocOT4JhAaS62FTFyli2jCAjD
         Ek/CQ9O1PXe9RJLUtTfnDjF7pHhuqL/rVpL7AVH+sNEIE1EF738ONj5etx2Vj1k4TcMW
         kqafiWTz/3/mH09XD9WYRjnWN8yp4R7k/QX8Dq9QcTKQCRpS2HypmxkMktcdimBn280b
         w4lyK5dWiZ9wYkfm1raJgXm0ROgNaQPvHgcpKDCMBLFrkUkAQ5+/T9jEEDQFreH5bthO
         /5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9/wfRdEy7j5FL0M0paRP6/0ZbtXx0D8Bf05gko1VsQc=;
        fh=X5vnZCWuErBCX3HK8iUwBuHD6/CaNbIp7PYXEJ+WOF4=;
        b=BUgW1hVKCOi2ga6r4GNaUDqSIp3eBX/tlfFtMrh3rmMEeGAC7/cjmX24WxnDqL3/ZB
         WdhtEotJh1jE0SBDcuMyhqNxU7tyWtJIyOeRm/OBtPVwgmDLFDEkkbG5OaShlJgouig7
         Xi3LZ48cCWnKQJAO9TnOgW73szMdlmU6Y9TXttSnUGVjELk2CqzhKT9bDXUVSYfarjfH
         swbLCpbFVzg9cqj/lcl13X6C7+FtiSD5p/x8rGnNd23Q7EwntT+FiU0Hxe8uaH4iZTOt
         UAS3MKxeVM8ilQwU5NaezUA3pxB0RYgkgMI9seihgYxPrNHTo2RAY1MiNtMbAIwZQCYF
         ySTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782153928; x=1782758728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/wfRdEy7j5FL0M0paRP6/0ZbtXx0D8Bf05gko1VsQc=;
        b=FE1CPsJq1HYa2yFrzMY9KEaTZntTwMCn0o70sxN34P84wEwDJTYubadqkPBtmDScKd
         wJ7BpsbP7pA3YprYOnJHI6Tk9QltkndNHFRwGCMYsMScpYp1+dPIZOowGjVvsHBru0gZ
         J/uh436g7gbSc6YC0n2OJTds/Nsb4hgtEItufRbqiyHJE+u9DP/kVll4lFHsvSSKtlZs
         o3xdBrQYKMqD1s+uM4rA9XIMcDi7zl8I59MjAdG/P9jraJ3t/6l2AbRje7Hex/fGKnKc
         B4g8c3G8uXx9xUz6HscdpbM16p1Xz2DZyXFKkBUGNXPuatJmJhwWPLZwapSKkIUecKsF
         DZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782153928; x=1782758728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9/wfRdEy7j5FL0M0paRP6/0ZbtXx0D8Bf05gko1VsQc=;
        b=dIBq7c6r/+w7VKT2fYssLEGIGhBG2O/sBBtFIcDCG1RGgkmQiXksekjboepw7HhxqE
         uR8yHxfDzEBLFqOUQqoynE4stG+mJSXnGLuMGrJsoWz4vX8QxVTVf7C8s4qPtg0LzdJO
         x7oxKqYqD77qAgK2EA7XE0dIIejmNSH8JtN4O652KD75wczLU0Uj0+wO3He52uAHpy/b
         ZbjSFT0ZUmlbGdhoNddH0Z1OInp6OJJG56TF2exTPLVTuaijJ0grp9DQ8IcngY+idLzV
         Jyl1NKF636uZER5rgZRMoqIC0oRMqSdEg1f/2WvbU+i4b5hUNnHHq9hCMu7EvHxgmhnj
         mnTQ==
X-Gm-Message-State: AOJu0YzTqmj0k8iknpBpXyDZ7/0V4n7vF+KmIsDgYIfzhnrKGJEuirsd
	1x3IvPL1FFXb1vRyDNkcN/uRC4mQIfloSbR4PLaX9e3f+fPZ/Qubq1D9mSJsGSb4YbbdBI8rrav
	1O5urqm1eDdhCDNhP4l4yY7r9Pidpc9Y=
X-Gm-Gg: AfdE7ckcg1jn56YCl8yY4I5wPTLlmxbHenRrVDjj8Ggg4ZsqOdOqXT1sljgSyrpiJmf
	BKotNAsB4NgLhe+GF6Qlhuq442qhN8on5W3CvrZ/HCvWulQbVbvn1fF7+w12bFMwEL/bRTTkroi
	ZHa/w7ncOLR67XIFhkDVpCBEZ2NApAh0pFQd+DAUkKkqcyJPNx98AEddHrubXPnFVkhhuOJjpq3
	Uqo3YTsPChvOpqjmq5b2vIEgUbe2fEO6YYkqHrg6nbP6Hb1mGSeIFHEyu9NtHS0YNBFYg==
X-Received: by 2002:a05:6402:240c:b0:68b:31c5:86f7 with SMTP id
 4fb4d7f45d1cf-69702e5181fmr6869335a12.16.1782153927353; Mon, 22 Jun 2026
 11:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622124251.31555-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260622124251.31555-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 22 Jun 2026 14:45:15 -0400
X-Gm-Features: AVVi8CdJdEMqonUyvuXWIenTSz-h_N8iqWgE2m_XMMXhlMbmojxAxxxbziflba8
Message-ID: <CAP+JOzQ-121aE=2wmxZj2zEfUhO8NFWL577LTU51xqXy_dRcxQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: fix double free of borrowed type datum on
 error path
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 8:43=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: netliomax25-code <netliomax25@gmail.com>
>
> cil_typepermissive_to_policydb() and cil_typeneveraudit_to_policydb()
> get sepol_type from __cil_get_sepol_type_datum(), a borrowed
> hashtab_search() result owned by pdb->p_types. Their error path ran
> type_datum_destroy() and free() on that borrowed pointer, so
> type_destroy() freed the same type again when the policydb was
> destroyed.
>
> Drop the destroy and free of the borrowed datum from both error paths,
> matching the sibling alias converters that only release their own
> allocation. With nothing left under the exit label, the gotos are
> replaced with direct returns and the now-empty label removed.
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/534
> Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index db3eb0be..caf2d987 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -611,18 +611,13 @@ int cil_typepermissive_to_policydb(policydb_t *pdb,
>         rc =3D __cil_get_sepol_type_datum(pdb, DATUM(cil_typeperm->type),
>                                         &sepol_type);
>         if (rc !=3D SEPOL_OK)
> -               goto exit;
> +               return rc;
>
>         if (ebitmap_set_bit(&pdb->permissive_map, sepol_type->s.value, 1)=
) {
> -               goto exit;
> +               return rc;
>         }
>
>         return SEPOL_OK;
> -
> -exit:
> -       type_datum_destroy(sepol_type);
> -       free(sepol_type);
> -       return rc;
>  }
>
>  int cil_typeneveraudit_to_policydb(policydb_t *pdb,
> @@ -634,18 +629,13 @@ int cil_typeneveraudit_to_policydb(policydb_t *pdb,
>         rc =3D __cil_get_sepol_type_datum(pdb, DATUM(cil_typeperm->type),
>                                         &sepol_type);
>         if (rc !=3D SEPOL_OK)
> -               goto exit;
> +               return rc;
>
>         if (ebitmap_set_bit(&pdb->neveraudit_map, sepol_type->s.value, 1)=
) {
> -               goto exit;
> +               return rc;
>         }
>
>         return SEPOL_OK;
> -
> -exit:
> -       type_datum_destroy(sepol_type);
> -       free(sepol_type);
> -       return rc;
>  }
>
>  int cil_typeattribute_to_policydb(policydb_t *pdb,
> --
> 2.54.0
>
