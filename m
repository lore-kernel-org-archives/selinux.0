Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0F231A23
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676177; cv=none; b=aM/UoIeYVpigcailb+HsISAHQ59LHe3Pv8ObB8rXtbLa6KdA6CH8iVJgTDhYnD33i9z3hxip+61vJ/H7tia9Ot35AEbOPSERduTOkhNuWRfJpHNkQzpg4l2Jsxd1KoDpc9fZNJ+tLNaZZ+rkMvBujrm11hSU4stOfwO15hEiOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676177; c=relaxed/simple;
	bh=OFAuf0FDXs5OVq+C4xgZT29QOOqX4TqzgqZm4+uVGtM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bO2HEWWLBcOUTUg5ew9feuZHcWxPOjpYRzReowU6Apf4z3ZL8RYeyTPGgpXgDRI2b8V9KaRAK/hJ91sHgLmPaBSwvHo3KQkpoi8U71m0CJV/FmrXvYG3mahXCcxM5xH69AhTwD001NYVNmUjL5/gBk0sW6St28VDOMzGFvZ7suk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DPv3F5vM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DPv3F5vM"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad574992fcaso684290266b.1
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 03:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750676174; x=1751280974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFAuf0FDXs5OVq+C4xgZT29QOOqX4TqzgqZm4+uVGtM=;
        b=DPv3F5vMFUTD4ZxYYiGyh967f2T4/gY1PzXbXEKZ9s247E0jfWjzvV6Kw0RWLYr5b8
         HA5W7NDwi4030paMvtPmUFp660i9xemzHLy6zldUuDEiDprs7yyHBIc9aUYROdrmUOU9
         nsIKNMi3hAOfZkm2zYk2pmraBre+XATWLEvfmam3qZJRHZQ3NFbLekeFKXkna12efqsd
         XgFgIerykT4YzSxlxcIaivq+8pnuMazkOTicbGM2tL99xYP5CVx9+KDgNNHHTHvGCWyZ
         N+U+nbD3AoitoCWtL51a0KkfuIANaFQusvrMLvvT9D/8+u+NbCDzTTYsgByepM2I7N/D
         DrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750676174; x=1751280974;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OFAuf0FDXs5OVq+C4xgZT29QOOqX4TqzgqZm4+uVGtM=;
        b=BXqc65c3lpEj0yuYrZTaGmJuvK8EkHEcRk8njFZ5WzjrYqAhhrWnh6nJzUNW8HlhFu
         0ErYabDo67NoLx+lYhEmHukKlkskSGTt1oA6Xc9564pqNb7KBKblKCQW5tzsCpl2RFQQ
         rscdYzuNHoHmjwfmlT3Tyc1ykH86M4zvc4YKLf0nqBK6yeF5eE8PB9of014qvb6LzLIj
         JGvBIJRlPfIYYgMFmmiEtHzLFqCudlHqaqMZ+EfJzyu49QLwzGztZ0JD1u6d+ryC1mT7
         C4q/DJgblI+JC91VbJs1w5TshfnUrVIZu5rEVr2Wth5a9fOopOpMX/2NMPINUumq0mKc
         4SPw==
X-Gm-Message-State: AOJu0YwFJm8giHcmk+o+cU8czlpXu6MtLN3gqW9F19ein4zxI5QHFz7T
	02BkWM/a4BNDi4ubEPaye26sk9kZGRa2Ts4gEUT1JBrj2oZP7YNvpbzX6TNsh0Md
X-Gm-Gg: ASbGncv1/SeJwwrLtwqXqpr4ssuZ5yTIEFNRzQGACmI69F0LoC0M/6j/KXv1oVCUrz7
	tkwSpgI9KItsSvnWTchmoCHs0URiCm1cptBVCE8iB1PP2vPpaIHCAcwom+1YIeYFAbf27ed6z9j
	kfxj0qUxdwN/0dKFwG8GT2oDZA8PGicD+4rr1ev8NjcQCTs6HLKK1+wQbwU7xqH/ImxQ5Jy8ETJ
	uQCivdTdFYwcLEfBeeNHHHiCl/OlvS9FRaHgow0Q5rVjSX78gjhdMy30jPUT5809iLtQVprdl7L
	KEBs7cwJNUslZ0GHRWy2+sFR8aNI0frqFqJwv8ZVb8wD5duFGln/BEe/Ma4xrQxP
X-Google-Smtp-Source: AGHT+IGmuo3YGfG0b2RdQXLrCEq7wu+eIKZbbXP3Qeu636n4ueqLLaze1I7ei4WGZrQg+pybgXnNyA==
X-Received: by 2002:a17:907:c28:b0:ad8:87ae:3f66 with SMTP id a640c23a62f3a-ae057f3f38amr1113188166b.60.1750676173889;
        Mon, 23 Jun 2025 03:56:13 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.240.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e8082fsm690375066b.8.2025.06.23.03.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 03:56:13 -0700 (PDT)
Date: Mon, 23 Jun 2025 12:56:11 +0200 (GMT+02:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Message-ID: <f20586e8-cf08-4d17-8ebc-3b2cf2dd2eb8@googlemail.com>
In-Reply-To: <20250623102726.3818713-1-vmojzis@redhat.com>
References: <20250623102726.3818713-1-vmojzis@redhat.com>
Subject: Re: [PATCH] checkpolicy: Allow attribute assignment to attributes
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <f20586e8-cf08-4d17-8ebc-3b2cf2dd2eb8@googlemail.com>

Jun 23, 2025 12:27:47 Vit Mojzis <vmojzis@redhat.com>:

> Allow "typeattribute <attribute> <attribute>" to pass checkpolicy,
> since (typeattributeset <attribute> <attribute>) is valid in CIL.
>
> Fixes:
> =C2=A0 $ cat myattributetest.te
> =C2=A0 policy_module(attributetest, 1.0.0)
>
> =C2=A0 gen_require(`
> =C2=A0=C2=A0=C2=A0 attribute domain;
> =C2=A0 ')
>
> =C2=A0 attribute myattribute;
>
> =C2=A0 typeattribute myattribute domain;
>
> =C2=A0 $ make -f /usr/share/selinux/devel/Makefile attributetest.pp=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 =E2=86=B5
> =C2=A0 Compiling targeted attributetest module
> =C2=A0 attributetest.te:9:ERROR 'unknown type myattribute' at token ';' o=
n line 3418:
> =C2=A0 typeattribute myattribute domain;
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
> After some simple tests with CIL policies, it seems that attribute
> assignment works as expected. Is there a reason checkpolicy does not
> recognise it?

Did you test that all types associated with myattribute are the also associ=
ated with domain?

>
> $ cat a.cil
> (typeattribute a)
> (typeattribute b)
> (typeattribute c)
> (type mytype_t)
> (typeattributeset a b)
> (typeattributeset b c)
> (typeattributeset c mytype_t)
> (allow a user_home_t (dir (getattr open search)))
> (allow b tmp_t (dir (getattr open search)))
> (allow c etc_t (dir (getattr open search)))
>
> $semodule -i a.cil
>
> $sesearch -A -s mytype_t
> allow a user_home_t:dir { getattr open search };
> allow b tmp_t:dir { getattr open search };
> allow c etc_t:dir { getattr open search };
>
> $seinfo -xa a=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>
> Type Attributes: 1
> =C2=A0=C2=A0 attribute a;
> =C2=A0=C2=A0=C2=A0 mytype_t
>
>
> checkpolicy/policy_define.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 4e0ddcc6..be788e8e 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1440,7 +1440,7 @@ int define_typeattribute(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> =C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 t =3D hashtab_search(policydbp->p_types.table, id);
> -=C2=A0=C2=A0 if (!t || t->flavor =3D=3D TYPE_ATTRIB) {
> +=C2=A0=C2=A0 if (!t) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yyerror2("unknown type %s", id=
);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(id);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> --
> 2.49.0

